-- Seed data for KEEPER database
-- Generated on 2026-05-02 from containers/schema/real-data.sql.
-- Selection policy:
--   1. Start from deprecated_keeper_db_schema_with_info_2026-03-19.sql seed row ids.
--   2. Use real-data.sql values for those ids.
--   3. Add FK dependency rows required by the selected real rows.
--   4. Keep all real merit_type rows because the deprecated seed is stale there.
--   5. Add only the deprecated virtual member row because member data was removed from real-data.sql.
--
-- Usage: mysql <database> < containers/schema/recent/seed-data.sql

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS;
SET @OLD_SQL_MODE=@@SQL_MODE;
SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO';

START TRANSACTION;

-- -----------------------------------------------------
-- Data for table `file`
-- -----------------------------------------------------
INSERT INTO `file` (`id`, `file_name`, `file_path`, `file_size`, `upload_time`, `ip_address`, `file_uuid`) VALUES
(1,'default_thumbnail_member.png','keeper_files/thumbnail/default/default_thumbnail_member.png',33609,'2022-03-19 18:00:56','1.1.1.1',NULL),
(2,'default_thumbnail_posting.png','keeper_files/thumbnail/default/default_thumbnail_posting.png',33609,'2022-03-19 18:00:56','1.1.1.1',NULL),
(3,'profile_badge_grade_first.gif','keeper_files/thumbnail/badge/profile_badge_grade_first.gif',33609,'2022-03-19 18:00:56','1.1.1.1',NULL),
(4,'profile_badge_grade_second.gif','keeper_files/thumbnail/badge/profile_badge_grade_second.gif',33609,'2022-03-19 18:00:56','1.1.1.1',NULL),
(5,'profile_badge_state_graduate.gif','keeper_files/thumbnail/badge/profile_badge_state_graduate.gif',33609,'2022-03-19 18:00:56','1.1.1.1',NULL),
(6,'profile_badge_state_quit.png','keeper_files/thumbnail/badge/profile_badge_state_quit.png',33609,'2022-03-19 18:00:56','1.1.1.1',NULL),
(7,'profile_badge_state_sleep.gif','keeper_files/thumbnail/badge/profile_badge_state_sleep.gif',33609,'2022-03-19 18:00:56','1.1.1.1',NULL),
(8,'profile_badge_state_regular.gif','keeper_files/thumbnail/badge/profile_badge_state_regular.gif',33609,'2022-03-19 18:00:56','1.1.1.1',NULL),
(9,'default_thumbnail_intro.png','keeper_files/thumbnail/default/default_thumbnail_intro.png',33609,'2022-03-21 23:14:59','1.1.1.1',NULL),
(10,'default_thumbnail_book.png','keeper_files/thumbnail/default/default_thumbnail_book.png',33609,'2022-03-21 23:15:00','1.1.1.1',NULL),
(11,'profile_badge_role_chairman.gif','keeper_files/thumbnail/badge/profile_badge_role_chairman.gif',33609,'2022-03-21 23:08:25','1.1.1.1',NULL),
(12,'profile_badge_role_vice_chairman.gif','keeper_files/thumbnail/badge/profile_badge_role_vice_chairman.gif',33609,'2022-03-21 23:08:25','1.1.1.1',NULL),
(13,'profile_badge_role_external_manager.gif','keeper_files/thumbnail/badge/profile_badge_role_external_manager.gif',33609,'2022-03-21 23:08:25','1.1.1.1',NULL),
(14,'profile_badge_role_study_manager.gif','keeper_files/thumbnail/badge/profile_badge_role_study_manager.gif',33609,'2022-03-21 23:08:25','1.1.1.1',NULL),
(15,'profile_badge_role_it_manager.gif','keeper_files/thumbnail/badge/profile_badge_role_it_manager.gif',33609,'2022-03-21 23:08:25','1.1.1.1',NULL),
(16,'profile_badge_role_clerk.gif','keeper_files/thumbnail/badge/profile_badge_role_clerk.gif',33609,'2022-03-21 23:08:25','1.1.1.1',NULL),
(17,'profile_badge_role_general_affairs.gif','keeper_files/thumbnail/badge/profile_badge_role_general_affairs.gif',33609,'2022-03-21 23:08:25','1.1.1.1',NULL),
(18,'profile_badge_role_librarian.gif','keeper_files/thumbnail/badge/profile_badge_role_librarian.gif',33609,'2022-03-21 23:08:27','1.1.1.1',NULL),
(172487,'seminar.png','keeper_files/seminar.png',1,'2022-03-25 00:00:00','1.1.1.1',NULL),
(172488,'thesis.png','keeper_files/thesis.png',1,'2022-03-25 00:00:00','1.1.1.1',NULL),
(172489,'mentoring.png','keeper_files/mentoring.png',1,'2022-03-25 00:00:00','1.1.1.1',NULL);

-- -----------------------------------------------------
-- Data for table `thumbnail`
-- -----------------------------------------------------
INSERT INTO `thumbnail` (`id`, `path`, `file_id`) VALUES
(1,'keeper_files/thumbnail/default/default_thumbnail_member.png',1),
(2,'keeper_files/thumbnail/default/default_thumbnail_posting.png',2),
(3,'keeper_files/thumbnail/badge/profile_badge_grade_first.gif',3),
(4,'keeper_files/thumbnail/badge/profile_badge_grade_second.gif',4),
(5,'keeper_files/thumbnail/badge/profile_badge_state_graduate.gif',5),
(6,'keeper_files/thumbnail/badge/profile_badge_state_quit.png',6),
(7,'keeper_files/thumbnail/badge/profile_badge_state_sleep.gif',7),
(8,'keeper_files/thumbnail/badge/profile_badge_state_regular.gif',8),
(9,'keeper_files/thumbnail/default/default_thumbnail_intro.png',9),
(10,'keeper_files/thumbnail/default/default_thumbnail_book.png',10),
(11,'keeper_files/thumbnail/badge/profile_badge_role_chairman.gif',11),
(12,'keeper_files/thumbnail/badge/profile_badge_role_vice_chairman.gif',12),
(13,'keeper_files/thumbnail/badge/profile_badge_role_external_manager.gif',13),
(14,'keeper_files/thumbnail/badge/profile_badge_role_study_manager.gif',14),
(15,'keeper_files/thumbnail/badge/profile_badge_role_it_manager.gif',15),
(16,'keeper_files/thumbnail/badge/profile_badge_role_clerk.gif',16),
(17,'keeper_files/thumbnail/badge/profile_badge_role_general_affairs.gif',17),
(18,'keeper_files/thumbnail/badge/profile_badge_role_librarian.gif',18),
(19,'dummy',1),
(20,'dummy',1),
(21,'dummy',1),
(22,'dummy',1),
(23,'dummy',1),
(24,'dummy',1),
(25,'dummy',1),
(26,'dummy',1),
(27,'dummy',1),
(28,'dummy',1),
(29,'dummy',1),
(30,'dummy',1),
(37,'keeper_files/thumbnail/seminar.png',172487),
(38,'keeper_files/thumbnail/thesis.png',172488),
(39,'keeper_files/thumbnail/mentoring.png',172489);

-- -----------------------------------------------------
-- Data for table `book_department`
-- -----------------------------------------------------
INSERT INTO `book_department` (`id`, `name`) VALUES
(1,'language'),
(2,'security'),
(3,'textbook'),
(4,'certification'),
(5,'document'),
(6,'etc');

-- -----------------------------------------------------
-- Data for table `member_type`
-- -----------------------------------------------------
INSERT INTO `member_type` (`id`, `name`, `badge_thumbnail_id`) VALUES
(1,'비회원',NULL),
(2,'정회원',8),
(3,'휴면회원',7),
(4,'졸업',5);

-- -----------------------------------------------------
-- Data for table `member_rank`
-- -----------------------------------------------------
INSERT INTO `member_rank` (`id`, `name`, `badge_thumbnail_id`) VALUES
(1,'일반회원',4),
(2,'우수회원',3);

-- -----------------------------------------------------
-- Data for table `member`
-- -----------------------------------------------------
INSERT INTO `member` (`id`, `login_id`, `email_address`, `password`, `real_name`, `birthday`, `student_id`, `register_time`, `update_time`, `member_type_id`, `member_rank_id`, `point`, `level`, `thumbnail_id`, `generation`, `total_attendance`) VALUES
(1, 'virtual_member', 'virtual_email', 'virtual_password', '탈퇴회원', NULL, '000000000', '2022-01-01 00:00:00', DEFAULT, NULL, NULL, 0, 0, 6, NULL, DEFAULT);

-- -----------------------------------------------------
-- Data for table `book_borrow_status`
-- -----------------------------------------------------
INSERT INTO `book_borrow_status` (`id`, `status`) VALUES
(1,'대출 대기'),
(2,'대출 반려'),
(3,'대출 중'),
(4,'반납 대기'),
(5,'반납 완료');

-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
INSERT INTO `category` (`id`, `name`) VALUES
(1,'virtual_category'),
(101,'공지사항'),
(102,'건의사항'),
(103,'정보게시판'),
(104,'자유게시판'),
(105,'익명게시판'),
(106,'졸업생게시판'),
(107,'시험게시판'),
(201,'스터디'),
(202,'발표자료'),
(203,'기술문서'),
(204,'회계부');

-- -----------------------------------------------------
-- Data for table `posting`
-- -----------------------------------------------------
INSERT INTO `posting` (`id`, `title`, `content`, `member_id`, `visit_count`, `register_time`, `update_time`, `ip_address`, `allow_comment`, `is_notice`, `is_secret`, `is_temp`, `password`, `category_id`, `thumbnail_id`) VALUES
(1,'virtual_posting','virtual_posting_content',1,5,'1970-01-01 00:00:00','1970-01-01 00:00:00','0.0.0.0',1,0,0,0,NULL,1,NULL);

-- -----------------------------------------------------
-- Data for table `member_job`
-- -----------------------------------------------------
INSERT INTO `member_job` (`id`, `name`) VALUES
(1,'ROLE_회장'),
(2,'ROLE_부회장'),
(3,'ROLE_대외부장'),
(4,'ROLE_학술부장'),
(5,'ROLE_FRONT_전산관리자'),
(6,'ROLE_서기'),
(7,'ROLE_총무'),
(8,'ROLE_사서'),
(9,'ROLE_회원'),
(10,'ROLE_출제자'),
(11,'ROLE_BACK_전산관리자'),
(12,'ROLE_INFRA_전산관리자');

-- -----------------------------------------------------
-- Data for table `static_write_title`
-- -----------------------------------------------------
INSERT INTO `static_write_title` (`id`, `title`, `type`) VALUES
(1,'키퍼(KEEPER) 소개글','intro'),
(2,'정기 활동','activity'),
(3,'동아리 자랑','excellence'),
(4,'동아리 연혁','history');

-- -----------------------------------------------------
-- Data for table `static_write_subtitle_image`
-- -----------------------------------------------------
INSERT INTO `static_write_subtitle_image` (`id`, `subtitle`, `static_write_title_id`, `thumbnail_id`, `display_order`) VALUES
(1,'NULL',1,NULL,1),
(2,'세미나',2,37,1),
(3,'스터디 & 멘토링',2,39,2),
(4,'기술문서',2,38,3),
(5,'동아리 지원',3,NULL,1),
(6,'이벤트',3,NULL,2),
(7,'대외활동',3,NULL,3),
(8,'2010',4,NULL,1),
(9,'2011',4,NULL,2),
(10,'2012',4,NULL,3),
(11,'2013',4,NULL,4),
(12,'2014',4,NULL,5),
(13,'2015',4,NULL,6),
(14,'2016',4,NULL,7),
(15,'2017',4,NULL,8),
(16,'2018',4,NULL,9),
(17,'2019',4,NULL,10),
(18,'2020',4,NULL,11),
(19,'2021',4,NULL,12),
(20,'2022',4,NULL,13);

-- -----------------------------------------------------
-- Data for table `static_write_content`
-- -----------------------------------------------------
INSERT INTO `static_write_content` (`id`, `content`, `static_write_subtitle_image_id`, `display_order`) VALUES
(1,'\'지키다\'라는 의미를 가진 단어 \'KEEP\'에서 착안하여, 정보보호에 관한 연구를 진행하고\n그 성과를 공유하기 위해 만들어진 동아리입니다.\n\n전국의 많은 정보보안 동아리들과 교류하고 있으며,\n습득한 지식을 시험해 볼 수 있는 다양한 해킹방어대회에 참여하고 있습니다. \n\n정보보안은 학과 커리큘럼에서 굉장히 늦게, 조금 포함되어 있고\n인터넷에 자료도 많지 않아 혼자 공부하기 어려운 부분이 있습니다. \n\nKEEPER에 가입하시면 선배, 후배, 동기들과 다 같이 정보보안을 공부할 수 있습니다.\n1학기 초에 열리는 오픈 세미나에서 신입 회원을 모집합니다.\n특별한 재능이 있지 않아도, 성실하고 의지 넘치는 분이면 환영합니다!',1,1),
(2,'매주 금요일 마다 정기적으로 운영',2,1),
(3,'공지사항 전달 및 건의',2,2),
(4,'개인 발표 또는 팀 발표',2,3),
(5,'매학기 활동 시작 전 원하는 스터디 개설 및 스터디원 구성',3,4),
(6,'스터디원과의 시간 협의 후 가능한 시간에 매주 스터디 진행',3,5),
(7,'신입 회원의 경우 멘토링 진행 (기본적인 프로그래밍, 기초 보안 학습)',3,6),
(8,'여름/겨울 방학 기간에 원하는 주제로 사람을 모집하여 기술 문서 작성',4,1),
(9,'1년에 1건 이상 작성 요구',4,2),
(10,'제안서 발표, 중간 발표, 최종 발표로 진행상황 공유',4,3),
(11,'도서 및 기자재 지원',5,1),
(12,'스터디룸 비용 지원',5,2),
(13,'회식비 지원',5,3),
(14,'키퍼 내 CTF',6,1),
(15,'퀴즈 이벤트',6,2),
(16,'CTF 참가',7,1),
(17,'한국인터넷진흥원(KISA) 주관 대학 정보보호동아리 지원사업(KUCIS)에 대학 정보보호 동아리로서 참여',8,1),
(18,'본교 학생회관에서 KUCIS 영남권역 세미나를 개최하여 부산 외의 인접지역에 있는 정보보호동아리들과 지식을 공유하고 교류함',10,1),
(19,'정보보호동아리 및 정보보호 분야의 현업에 종사하고 있는 사람들까지 대상으로한 경남권 정보보호 세미나를 주최함',12,1),
(20,'경남권 동아리와 함께 청소년을 대상으로 정보보호의 입문을 돕기위한 Security One을 주최함',12,2),
(21,'KUCIS 사업 참여, MS(MicroSoft) Windows10 서포터즈 1등',13,1),
(22,'KUCIS 사업 참여',14,1),
(23,'교내 서비스 취약점 분석',15,1),
(24,'KUCIS, 시원포럼 경남지역 연합세미나 주최',16,1),
(25,'암호동아리 지원사업 참가',18,1),
(26,'코드게이트 본선 진출',20,1),
(27,'제6회 동서발전 정보보안 온라인 경진대회 우수상',18,2),
(28,'화이트해커 양성 프로젝트 참여',19,1),
(29,'전국 연합 동아리 CCA 가입',20,2),
(30,'영남권 연합 동아리 참여',20,3),
(31,'암호동아리 지원사업 참가',19,2);

-- -----------------------------------------------------
-- Data for table `non_absence`
-- -----------------------------------------------------
INSERT INTO `non_absence` (`id`, `term`, `day`, `point`) VALUES
(1,'YEAR',365,20000),
(2,'MONTH',28,5000),
(3,'WEEK',7,1000);

-- -----------------------------------------------------
-- Data for table `ctf_contest`
-- -----------------------------------------------------
INSERT INTO `ctf_contest` (`id`, `name`, `description`, `register_time`, `creator`, `is_joinable`, `update_time`) VALUES
(1,'virtual_ctf_contest','virtual_ctf_contest_description','2022-01-01 00:00:00',1,0,'2023-10-15 15:41:03');

-- -----------------------------------------------------
-- Data for table `ctf_team`
-- -----------------------------------------------------
INSERT INTO `ctf_team` (`id`, `name`, `description`, `register_time`, `creator`, `score`, `contest_id`, `last_solve_time`, `update_time`) VALUES
(1,'virtual_ctf_team','virtual_ctf_team_description','2022-01-01 00:00:00',1,0,1,'2022-01-01 00:00:00','2023-10-15 15:41:03');

-- -----------------------------------------------------
-- Data for table `ctf_challenge_type`
-- -----------------------------------------------------
INSERT INTO `ctf_challenge_type` (`id`, `name`) VALUES
(1,'STANDARD'),
(2,'DYNAMIC');

-- -----------------------------------------------------
-- Data for table `ctf_challenge`
-- -----------------------------------------------------
INSERT INTO `ctf_challenge` (`id`, `name`, `description`, `register_time`, `creator`, `is_solvable`, `type_id`, `score`, `contest_id`, `max_submit_count`, `update_time`) VALUES
(1,'virtual_ctf_challenge','virtual_ctf_challenge_description','2022-01-01 00:00:00',1,0,NULL,0,1,1,'2023-10-15 15:41:03');

-- -----------------------------------------------------
-- Data for table `ctf_challenge_category`
-- -----------------------------------------------------
INSERT INTO `ctf_challenge_category` (`id`, `name`) VALUES
(1,'Misc'),
(2,'System'),
(3,'Reversing'),
(4,'Forensic'),
(5,'Web'),
(6,'Crypto'),
(7,'OSINT');

-- -----------------------------------------------------
-- Data for table `ctf_flag`
-- -----------------------------------------------------
INSERT INTO `ctf_flag` (`id`, `content`, `team_id`, `challenge_id`, `is_correct`, `solved_time`, `last_try_time`, `remained_submit_count`) VALUES
(1,'virtual_ctf_flag',1,1,0,NULL,NULL,1);

-- -----------------------------------------------------
-- Data for table `ctf_submit_log`
-- -----------------------------------------------------
INSERT INTO `ctf_submit_log` (`id`, `submit_time`, `flag_submitted`, `is_correct`, `team_name`, `submitter_login_id`, `submitter_realname`, `challenge_name`, `contest_name`, `ctf_contest_id`) VALUES
(1,'2022-01-01 00:00:00','virtual_ctf_submit_log_flag_submitted',0,'virtual_ctf_submit_log_team_name','virtual_ctf_submit_log_submitter_login_id','virtual_ctf_submit_log_submitter_realname','virtual_ctf_submit_log_challenge_name','virtual_ctf_submit_log_contest_name',1);

-- -----------------------------------------------------
-- Data for table `election`
-- -----------------------------------------------------
INSERT INTO `election` (`id`, `name`, `description`, `creator`, `register_time`, `is_available`) VALUES
(1,'virtual_election',NULL,1,'2022-01-01 00:00:00',0);

-- -----------------------------------------------------
-- Data for table `election_candidate`
-- -----------------------------------------------------
INSERT INTO `election_candidate` (`id`, `election_id`, `candidate_id`, `member_job_id`, `description`, `register_time`, `vote_count`) VALUES
(1,1,1,9,NULL,'2022-01-01 00:00:00',0);

-- -----------------------------------------------------
-- Data for table `survey`
-- -----------------------------------------------------
INSERT INTO `survey` (`id`, `open_time`, `close_time`, `name`, `description`, `is_visible`, `register_time`, `update_time`) VALUES
(1,'2022-01-01 00:00:00','2022-01-01 00:00:00','virtual_survey',NULL,0,'2023-10-15 15:41:03','2023-10-15 15:41:03');

-- -----------------------------------------------------
-- Data for table `survey_reply`
-- -----------------------------------------------------
INSERT INTO `survey_reply` (`id`, `type`) VALUES
(1,'활동'),
(2,'휴면(군휴학)'),
(3,'휴면(기타)'),
(4,'졸업'),
(5,'탈퇴');

-- -----------------------------------------------------
-- Data for table `seminar`
-- -----------------------------------------------------
INSERT INTO `seminar` (`id`, `open_time`, `attendance_start_time`, `attendance_close_time`, `lateness_close_time`, `attendance_code`, `name`, `register_time`, `update_time`, `starter_id`) VALUES
(1,'2022-01-01 00:00:00',NULL,'2022-01-01 00:00:00','2022-01-01 00:00:00','000','virtual_seminar','2023-10-15 15:41:03','2023-10-15 15:41:03',NULL);

-- -----------------------------------------------------
-- Data for table `seminar_attendance_status`
-- -----------------------------------------------------
INSERT INTO `seminar_attendance_status` (`id`, `type`) VALUES
(1,'출석'),
(2,'지각'),
(3,'결석'),
(4,'개인사정'),
(5,'출석 전');

-- -----------------------------------------------------
-- Data for table `merit_type`
-- -----------------------------------------------------
INSERT INTO `merit_type` (`id`, `merit`, `is_merit`, `detail`) VALUES
(1,0,1,'virtual_merit'),
(2,3,0,'결석'),
(3,5,1,'전공관련 대회 입상'),
(4,2,1,'각종 대외발표'),
(5,3,1,'우수 기술 문서 작성'),
(6,3,1,'연 2개 이상의 기술 문서 작성'),
(7,3,1,'우수 스터디 진행'),
(8,3,1,'개근상'),
(9,1,1,'컨퍼런스 혹은 대외 세미나 참여'),
(10,-9,0,'기술문서 최종본 미완성');

COMMIT;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
