#!/usr/bin/env python3
"""
현재 인프라에서 키퍼 홈페이지 디비와 유저 업로드 자료를 백업하는 파이썬 스크립트 입니다.
"""

import argparse
import datetime
import json
import os
import shlex
import shutil
import socket
import subprocess
import sys
from pathlib import Path

MIN_AWS_CLI = (2, 33, 0)


def upload(args, key, source=None, data=None, expected_size=None):
    aws_cp = [
        "aws", "s3", "cp", "-", f"s3://{args.bucket}/{key}",
        "--no-overwrite",
        "--storage-class", args.storage_class,
        "--region", args.region,
        "--only-show-errors",
    ]
    if expected_size is not None:
        aws_cp += ["--expected-size", str(expected_size)]

    if source is not None:
        pipeline = f"{source} | {shlex.join(aws_cp)}"
        subprocess.run(["bash", "-o", "pipefail", "-c", pipeline], check=True)
    else:
        subprocess.run(aws_cp, input=data, check=True)


def main():
    parser = argparse.ArgumentParser(
        description="keeper DB 덤프와 keeper_files를 S3로 백업하는 CLI 도구",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "--keeper-files", metavar="PATH", default="/var/lib/keeper_files",
        help="업로드 파일 디렉터리 (compose의 backend 볼륨 경로)",
    )
    parser.add_argument(
        "--bucket", metavar="NAME", default="<BUCKET>",
        help="S3 버킷 이름",
    )
    parser.add_argument(
        "--region", metavar="REGION", default="ap-northeast-2",
        help="버킷 리전",
    )
    parser.add_argument(
        "--key-prefix", metavar="PREFIX", default="backups/",
        help="객체 키 앞부분. /로 끝나지 않으면 붙인다",
    )
    parser.add_argument(
        "--storage-class", metavar="CLASS", default="STANDARD_IA",
        help="업로드할 때 지정하는 스토리지 클래스",
    )
    parser.add_argument(
        "--db-container", metavar="NAME", default="db",
        help="MySQL 컨테이너 이름",
    )
    parser.add_argument(
        "--expected-role", metavar="NAME", default="keeper-backup-role",
        help="사전 점검에서 확인할 IAM Role 이름",
    )
    args = parser.parse_args()

    step = "[1/7] 인자 확인"
    print(step, flush=True)

    if not args.key_prefix.endswith("/"):
        args.key_prefix += "/"

    # 디렉터리 심볼릭 링크를 그대로 넘기면 tar가 링크 자체만 저장하므로 실제 경로로 풀어야 함.
    try:
        keeper_files = Path(args.keeper_files).resolve(strict=True)
    except (OSError, RuntimeError) as e:
        sys.exit(f"ERROR: keeper_files 경로를 확인할 수 없습니다: {args.keeper_files} ({e})")

    manifest_step = "[6/7] manifest.json 업로드"

    try:
        step = "[2/7] 사전 점검"
        print(step, flush=True)

        if os.geteuid() != 0:
            sys.exit("ERROR: root 권한이 필요합니다. sudo로 실행하세요.")

        missing = [
            cmd for cmd in ("aws", "bash", "docker", "tar", "gzip", "du")
            if shutil.which(cmd) is None
        ]
        if missing:
            sys.exit(f"ERROR: 필요한 명령이 없습니다: {', '.join(missing)}")

        # 출력 예: aws-cli/2.33.0 Python/3.13.7 Linux/6.8.0 exe/x86_64.ubuntu.24
        version_text = subprocess.run(
            ["aws", "--version"],
            check=True, capture_output=True, text=True,
        ).stdout.strip()

        try:
            aws_cli_version = version_text.split()[0].split("/")[1]
            version_ok = tuple(int(n) for n in aws_cli_version.split(".")) >= MIN_AWS_CLI
        except (IndexError, ValueError):
            sys.exit(f"ERROR: aws --version 출력을 해석할 수 없습니다: {version_text!r}")

        if not version_ok:
            sys.exit(
                f"ERROR: AWS CLI {'.'.join(map(str, MIN_AWS_CLI))} 이상이 필요합니다 "
                f"(현재 {aws_cli_version}). --no-overwrite가 이 버전에서 추가됐습니다."
            )

        if not keeper_files.is_dir():
            sys.exit(f"ERROR: keeper_files가 디렉터리가 아닙니다: {keeper_files}")

        running = subprocess.run(
            ["docker", "inspect", "-f", "{{.State.Running}}", args.db_container],
            check=True, capture_output=True, text=True,
        ).stdout.strip()

        if running != "true":
            sys.exit(f"ERROR: DB 컨테이너가 실행 중이 아닙니다: {args.db_container}")

        identity_json = subprocess.run(
            ["aws", "sts", "get-caller-identity", "--region", args.region, "--output", "json"],
            check=True, capture_output=True, text=True,
        ).stdout

        identity = json.loads(identity_json)

        if f":assumed-role/{args.expected_role}/" not in identity["Arn"]:
            sys.exit(
                f"ERROR: 자격 증명이 {args.expected_role} Role이 아닙니다: {identity['Arn']} "
                "(root의 ~/.aws 설정이나 AWS_* 환경 변수를 확인하세요)"
            )

        step = "[3/7] 준비"
        print(step, flush=True)

        kst = datetime.timezone(datetime.timedelta(hours=9))
        started_at = datetime.datetime.now(kst)
        prefix = f"{args.key_prefix}{started_at:%Y-%m-%d_%H%M%S}_KST/"

        db_key = prefix + "db.sql.gz"
        tar_key = prefix + "keeper_files.tar"
        manifest_key = prefix + "manifest.json"

        du_output = subprocess.run(
            ["du", "-sb", str(keeper_files)],
            check=True, capture_output=True, text=True,
        ).stdout
        keeper_files_bytes = int(du_output.split()[0])

        print(f"  {prefix} (keeper_files {keeper_files_bytes} bytes)", flush=True)

        step = "[4/7] DB 덤프 업로드"
        print(step, flush=True)

        # 작은따옴표 안의 $MYSQL_*는 호스트 bash가 아니라 컨테이너 안의 sh가 확장함.
        # 비밀번호가 호스트 명령줄과 출력에 나타나지 않음.
        dump = (
            f"docker exec {shlex.quote(args.db_container)} sh -c "
            "'exec mysqldump -uroot -p\"$MYSQL_ROOT_PASSWORD\""
            " --single-transaction --quick --routines --triggers --events --hex-blob"
            " --default-character-set=utf8mb4 --set-gtid-purged=OFF"
            " --databases \"$MYSQL_DATABASE\"'"
            " | gzip -c"
        )
        upload(args, db_key, source=dump)

        step = "[5/7] keeper_files tar 업로드"
        print(step, flush=True)

        # tar 종료 코드 1(읽는 중 파일 변경)도 pipefail로 실패 처리.
        tar = (
            f"tar -C {shlex.quote(str(keeper_files.parent))} -cf -"
            f" -- {shlex.quote(keeper_files.name)}"
        )
        # --expected-size: 표준 입력 업로드의 조각 수 한도(10,000개)를 넘지 않게 du 크기에 10%를 추가
        upload(args, tar_key, source=tar, expected_size=int(keeper_files_bytes * 1.1))

        step = manifest_step
        print(step, flush=True)

        manifest = {
            "format": 1,
            "started_at": started_at.isoformat(timespec="seconds"),
            "finished_at": datetime.datetime.now(kst).isoformat(timespec="seconds"),
            "host": socket.gethostname(),
            "prefix": prefix,
            "keeper_files_path": str(keeper_files),
            "keeper_files_bytes": keeper_files_bytes,
            "aws_cli_version": aws_cli_version,
            "files": [db_key, tar_key],
        }

        upload(args, manifest_key, data=json.dumps(manifest, indent=2).encode())

    except subprocess.CalledProcessError as e:
        if e.stderr:
            print(e.stderr.strip(), file=sys.stderr)

        if step == manifest_step:
            # S3에 저장된 뒤 응답만 유실됐을 수 있음(재시도하면 412).
            sys.exit(
                f"ERROR: {step} 결과 불명 (종료 코드 {e.returncode}). "
                f"콘솔에서 s3://{args.bucket}/{manifest_key} 가 있는지 확인하세요."
            )

        sys.exit(f"ERROR: {step} 실패 (종료 코드 {e.returncode})")

    print("[7/7] 완료. 업로드한 객체:", flush=True)
    for key in (db_key, tar_key, manifest_key):
        print(f"  s3://{args.bucket}/{key}")


if __name__ == "__main__":
    main()
