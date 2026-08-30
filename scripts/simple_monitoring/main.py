"""
모니터링 할 것 들

메트릭:
1. 시스템 전체 CPU 사용량
2. 시스템 파일 디스크별 전체 용량, 사용 용량 (가상 파일 여부 제외)
3. 메모리 사용량, 파일 스왑 사용
4. caddy http 호스트별 누적 사용량
5. 측정 시작 시간 KST

기타:

그냥 systemd로 3분마다 조사하고 해당 metric을 logfile에 jsonl 방식으로 append하기.
logfile은 14880 라인 유지하고 넘어갈 시 제일 윗 부분 제거하고 밑에 append하는 큐 방식으로 사용

이상치 탐지

1. 시스템 전체 CPU 사용량이 90% 이상.
2. 시스템 전체 현재 디스크 남은 용량이 15% 미만
3. 시스템 전체 메모리 사용량이 90% 이상.

=> webhook 보내기

모니터링 전체 과정에서 logfile lock 걸기
의도적으로 데이터 수집 때부터 락 걸기
그리고 모든 과정이 끝나고 프로세스 종료할 때 락 제거

락 자체가 걸려있으면 이번 모니터링 건너뛰기
의도적인 설계임

webhook cooldown = 1시간 (메트릭별, 마지막 전송 성공 시각 기준 = cooldown/ 마커 파일 mtime)
"""

import fcntl
import json
import os
import re
import statistics
import time
import urllib.request
from dataclasses import asdict, dataclass
from datetime import datetime
from pathlib import Path

import psutil

LOG_FILE = Path(__file__).parent / "monitoring.jsonl"
LOCK_FILE = Path(__file__).parent / "monitoring.lock"
COOLDOWN_DIR = Path(__file__).parent / "cooldown"
COOLDOWN_SECONDS = 3600
MAX_LOG_LINES = 14880
CPU_WARNING_PERCENT = 90
DISK_WARNING_FREE_PERCENT = 15
MEMORY_WARNING_PERCENT = 90
WEBHOOK_URL = os.environ.get("DISCORD_WEBHOOK_URL")
CADDY_METRICS_URL = "http://127.0.0.1:2021/metrics"


@dataclass
class CpuMetric:
  percent: float


def get_metric_cpu(measure_seconds: int = 5) -> CpuMetric:
  """measure_seconds 동안 1초 간격으로 CPU 사용률을 샘플링하고 중간값을 반환."""
  samples = [
    psutil.cpu_percent(interval=1, percpu=False) for _ in range(measure_seconds)
  ]

  return CpuMetric(percent=statistics.median(samples))


@dataclass
class DiskMetric:
  name: str
  total: int
  used: int


def get_metric_disk() -> list[DiskMetric]:
  """가상 파일시스템 제외한 물리 디스크별 (마운트명, 전체 용량, 사용량) 목록 반환."""
  return [
    DiskMetric(name=part.mountpoint, total=usage.total, used=usage.used)
    for part in psutil.disk_partitions(all=False)
    if (usage := psutil.disk_usage(part.mountpoint))
  ]


@dataclass
class MemoryMetric:
  total: int
  used: int
  percent: float
  swap: int


def get_metric_memory() -> MemoryMetric:
  """메모리 사용량(전체/사용/백분율)과 스왑 사용량을 반환."""
  mem = psutil.virtual_memory()
  swap = psutil.swap_memory()

  return MemoryMetric(
    total=mem.total, used=mem.used, percent=mem.percent, swap=swap.used
  )


CADDY_COUNTER_NAMES = (
  "caddy_http_requests_total",
  "caddy_http_request_size_bytes_sum",
  "caddy_http_response_size_bytes_sum",
)
HOST_LABEL_RE = re.compile(r'host="([^"]*)"')


@dataclass
class CaddyHostTraffic:
  requests_total: int
  request_bytes_total: int
  response_bytes_total: int


@dataclass
class CaddyMetric:
  hosts: dict[str, CaddyHostTraffic]


def get_metric_caddy_httptraffic() -> CaddyMetric | None:
  """호스트별 caddy http 누적 카운터 반환. Caddy 조회 실패 시 None."""
  try:
    return CaddyMetric(
      hosts={
        host: CaddyHostTraffic(
          requests_total=counters["caddy_http_requests_total"],
          request_bytes_total=counters["caddy_http_request_size_bytes_sum"],
          response_bytes_total=counters["caddy_http_response_size_bytes_sum"],
        )
        for host, counters in _fetch_caddy_counters().items()
      }
    )
  except Exception:
    return None


def _fetch_caddy_counters() -> dict[str, dict[str, int]]:
  """/metrics를 파싱해 호스트별 카운터를 합산 반환."""
  counters: dict[str, dict[str, int]] = {}

  with urllib.request.urlopen(CADDY_METRICS_URL, timeout=3) as response:
    body = response.read().decode()

  for line in body.splitlines():
    tokens = line.split()
    if len(tokens) < 2 or line.startswith("#"):
      continue
    name = tokens[0].split("{", 1)[0]
    if name not in CADDY_COUNTER_NAMES:
      continue
    host = match.group(1) if (match := HOST_LABEL_RE.search(tokens[0])) else ""
    host_counters = counters.setdefault(host, dict.fromkeys(CADDY_COUNTER_NAMES, 0))
    host_counters[name] += int(float(tokens[-1]))

  return counters


@dataclass
class MonitoringWarning:
  metric: CpuMetric | DiskMetric | MemoryMetric
  reason: str


def detect_anomalies(
  cpu: CpuMetric, disks: list[DiskMetric], memory: MemoryMetric
) -> list[MonitoringWarning]:
  """임계치를 넘은 메트릭별로 MonitoringWarning 목록 반환. 없으면 빈 리스트."""
  warnings: list[MonitoringWarning] = []

  if cpu.percent >= CPU_WARNING_PERCENT:
    warnings.append(
      MonitoringWarning(cpu, f"CPU 사용량 {cpu.percent}% >= {CPU_WARNING_PERCENT}%")
    )

  for disk in disks:
    free_percent = (disk.total - disk.used) / disk.total * 100
    if free_percent < DISK_WARNING_FREE_PERCENT:
      warnings.append(
        MonitoringWarning(
          disk,
          f"디스크 {disk.name} 여유 {free_percent:.1f}% < {DISK_WARNING_FREE_PERCENT}%",
        )
      )

  if memory.percent >= MEMORY_WARNING_PERCENT:
    warnings.append(
      MonitoringWarning(
        memory, f"메모리 사용량 {memory.percent}% >= {MEMORY_WARNING_PERCENT}%"
      )
    )

  return warnings


def _alert_key(warning: MonitoringWarning) -> str:
  metric = warning.metric
  if isinstance(metric, DiskMetric):
    return "disk-" + metric.name.replace("/", "_")
  if isinstance(metric, CpuMetric):
    return "cpu"
  return "memory"


def send_webhook(warnings: list[MonitoringWarning]):
  """이상치 목록을 디스코드 웹훅으로 전송. 메트릭별 1시간 쿨다운, WEBHOOK_URL 없으면 스킵."""
  if not WEBHOOK_URL:
    return

  now = time.time()
  pending = []
  for warning in warnings:
    marker = COOLDOWN_DIR / _alert_key(warning)
    mtime = marker.stat().st_mtime if marker.exists() else 0
    if now - mtime >= COOLDOWN_SECONDS:
      pending.append((warning, marker))
  if not pending:
    return

  content = "\n".join(f":warning: {warning.reason}" for warning, _ in pending)
  payload = json.dumps({"content": content[:2000]}).encode()
  request = urllib.request.Request(
    WEBHOOK_URL,
    data=payload,
    headers={"Content-Type": "application/json"},
    method="POST",
  )
  with urllib.request.urlopen(request, timeout=10) as response:
    response.read()

  COOLDOWN_DIR.mkdir(exist_ok=True)
  for _, marker in pending:
    marker.touch()


def rotate_log():
  """로그파일이 MAX_LOG_LINES를 초과하면 제일 오래된 윗 부분을 제거."""
  lines = LOG_FILE.read_text().splitlines(keepends=True)
  if len(lines) > MAX_LOG_LINES:
    LOG_FILE.write_text("".join(lines[-MAX_LOG_LINES:]))


def main():
  with open(LOCK_FILE, "a") as lock:
    try:
      fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except BlockingIOError:
      return

    # 메트릭 수집
    cpu = get_metric_cpu()
    disks = get_metric_disk()
    memory = get_metric_memory()
    caddy_traffic = get_metric_caddy_httptraffic()

    # 레코드 조립 및 기록
    record = {
      "timestamp": datetime.now().astimezone().isoformat(),
      "cpu": asdict(cpu),
      "disk": [asdict(m) for m in disks],
      "memory": asdict(memory),
      "caddy_traffic": asdict(caddy_traffic) if caddy_traffic else None,
    }
    with open(LOG_FILE, "a") as log:
      log.write(json.dumps(record) + "\n")
    rotate_log()

    # 이상치 탐지 및 경보
    warnings = detect_anomalies(cpu, disks, memory)
    if warnings:
      send_webhook(warnings)


if __name__ == "__main__":
  main()
