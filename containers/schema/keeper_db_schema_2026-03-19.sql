-- MySQL dump 10.13  Distrib 9.6.0, for macos14.8 (x86_64)
--
-- Host: 127.0.0.1    Database: keeper
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL DEFAULT (curtime()),
  `date` date NOT NULL DEFAULT (curdate()),
  `point` int NOT NULL DEFAULT '100',
  `random_point` int NOT NULL DEFAULT '0',
  `rank_point` int NOT NULL DEFAULT '0',
  `continuous_point` int NOT NULL DEFAULT '0',
  `ip_address` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `greetings` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `continuous_day` int NOT NULL,
  `member_id` int NOT NULL,
  `rank` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `is_duplicated` (`member_id`,`date`),
  KEY `fk_attendance_member1_idx` (`member_id`),
  CONSTRAINT `fk_attendance_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=199601 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `attendance_AFTER_INSERT` AFTER INSERT ON `attendance` FOR EACH ROW BEGIN
UPDATE member SET total_attendance = total_attendance + 1 WHERE id = NEW.member_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `author` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `book_department_id` int NOT NULL DEFAULT '6',
  `total_quantity` int NOT NULL DEFAULT '1',
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `thumbnail_id` int DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`id`),
  KEY `fk_book_thumbnail1_idx` (`thumbnail_id`),
  KEY `fk_book_book_department1_idx` (`book_department_id`),
  CONSTRAINT `fk_book_book_department1` FOREIGN KEY (`book_department_id`) REFERENCES `book_department` (`id`),
  CONSTRAINT `fk_book_thumbnail1` FOREIGN KEY (`thumbnail_id`) REFERENCES `thumbnail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=304 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `book_BEFORE_UPDATE` BEFORE UPDATE ON `book` FOR EACH ROW BEGIN
	SET NEW.update_time = CURRENT_TIME;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `book_borrow_info`
--

DROP TABLE IF EXISTS `book_borrow_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_borrow_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `book_id` int NOT NULL,
  `borrow_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  `status_id` int NOT NULL,
  `last_request_date` date DEFAULT (curdate()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_book_borrow_info_book1_idx` (`book_id`),
  KEY `fk_book_borrow_info_member1_idx` (`member_id`),
  KEY `fk_book_borrow_info_book_borrow_status1_idx` (`status_id`),
  CONSTRAINT `fk_book_borrow_info_book1` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`),
  CONSTRAINT `fk_book_borrow_info_book_borrow_status1` FOREIGN KEY (`status_id`) REFERENCES `book_borrow_status` (`id`),
  CONSTRAINT `fk_book_borrow_info_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `book_borrow_info_BEFORE_UPDATE` BEFORE UPDATE ON `book_borrow_info` FOR EACH ROW BEGIN
	SET NEW.update_time = CURRENT_TIME;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `book_borrow_log`
--

DROP TABLE IF EXISTS `book_borrow_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_borrow_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `borrow_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `reject_date` date DEFAULT NULL,
  `book_title` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `book_author` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `member_id` int NOT NULL,
  `member_realname` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `book_id` int NOT NULL,
  `borrow_id` int NOT NULL,
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `book_borrow_log_BEFORE_UPDATE` BEFORE UPDATE ON `book_borrow_log` FOR EACH ROW BEGIN
	SET NEW.update_time = CURRENT_TIME;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `book_borrow_status`
--

DROP TABLE IF EXISTS `book_borrow_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_borrow_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_department`
--

DROP TABLE IF EXISTS `book_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=168498 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  `ip_address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int DEFAULT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  `member_id` int NOT NULL,
  `posting_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comment_member1_idx` (`member_id`),
  KEY `fk_comment_posting1_idx` (`posting_id`),
  KEY `fk_comment_comment1_idx` (`parent_id`),
  CONSTRAINT `fk_comment_comment1` FOREIGN KEY (`parent_id`) REFERENCES `comment` (`id`),
  CONSTRAINT `fk_comment_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_comment_posting1` FOREIGN KEY (`posting_id`) REFERENCES `posting` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=176113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctf_challenge`
--

DROP TABLE IF EXISTS `ctf_challenge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctf_challenge` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT_CHALLENGE_NAME',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `creator` int NOT NULL DEFAULT '1',
  `is_solvable` tinyint NOT NULL DEFAULT '0',
  `type_id` int DEFAULT NULL,
  `score` int NOT NULL DEFAULT '0',
  `contest_id` int NOT NULL DEFAULT '1',
  `max_submit_count` int NOT NULL DEFAULT '1',
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`id`),
  KEY `fk_ctf_challenge_ctf_challenge_type1_idx` (`type_id`),
  KEY `fk_ctf_challenge_ctf_contest1_idx` (`contest_id`),
  KEY `fk_ctf_challenge_member1_idx` (`creator`),
  CONSTRAINT `fk_ctf_challenge_ctf_challenge_type1` FOREIGN KEY (`type_id`) REFERENCES `ctf_challenge_type` (`id`),
  CONSTRAINT `fk_ctf_challenge_ctf_contest1` FOREIGN KEY (`contest_id`) REFERENCES `ctf_contest` (`id`),
  CONSTRAINT `fk_ctf_challenge_member1` FOREIGN KEY (`creator`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ctf_challenge_BEFORE_UPDATE` BEFORE UPDATE ON `ctf_challenge` FOR EACH ROW BEGIN
	SET NEW.update_time = CURRENT_TIME;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ctf_challenge_category`
--

DROP TABLE IF EXISTS `ctf_challenge_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctf_challenge_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctf_challenge_has_ctf_challenge_category`
--

DROP TABLE IF EXISTS `ctf_challenge_has_ctf_challenge_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctf_challenge_has_ctf_challenge_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ctf_challenge_id` int NOT NULL,
  `ctf_challenge_category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ctf_challenge_has_ctf_challenge_category_ctf_challenge_c_idx` (`ctf_challenge_category_id`),
  KEY `fk_ctf_challenge_has_ctf_challenge_category_ctf_challenge1_idx` (`ctf_challenge_id`),
  CONSTRAINT `fk_ctf_challenge_has_ctf_challenge_category_ctf_challenge1` FOREIGN KEY (`ctf_challenge_id`) REFERENCES `ctf_challenge` (`id`),
  CONSTRAINT `fk_ctf_challenge_has_ctf_challenge_category_ctf_challenge_cat1` FOREIGN KEY (`ctf_challenge_category_id`) REFERENCES `ctf_challenge_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctf_challenge_has_file`
--

DROP TABLE IF EXISTS `ctf_challenge_has_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctf_challenge_has_file` (
  `ctf_challenge_id` int NOT NULL,
  `file_id` int NOT NULL,
  PRIMARY KEY (`ctf_challenge_id`,`file_id`),
  KEY `fk_ctf_challenge_has_file_file1_idx` (`file_id`),
  KEY `fk_ctf_challenge_has_file_ctf_challenge1_idx` (`ctf_challenge_id`),
  CONSTRAINT `fk_ctf_challenge_has_file_ctf_challenge1` FOREIGN KEY (`ctf_challenge_id`) REFERENCES `ctf_challenge` (`id`),
  CONSTRAINT `fk_ctf_challenge_has_file_file1` FOREIGN KEY (`file_id`) REFERENCES `file` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctf_challenge_type`
--

DROP TABLE IF EXISTS `ctf_challenge_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctf_challenge_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctf_contest`
--

DROP TABLE IF EXISTS `ctf_contest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctf_contest` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT_CONTEST_NAME',
  `description` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `creator` int NOT NULL DEFAULT '1',
  `is_joinable` tinyint NOT NULL DEFAULT '0',
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`id`),
  KEY `fk_ctf_contest_member1_idx` (`creator`),
  CONSTRAINT `fk_ctf_contest_member1` FOREIGN KEY (`creator`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ctf_contest_BEFORE_UPDATE` BEFORE UPDATE ON `ctf_contest` FOR EACH ROW BEGIN
	SET NEW.update_time = CURRENT_TIME;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`keeper`@`%`*/ /*!50003 TRIGGER `ctf_contest_BEFORE_DELETE` BEFORE DELETE ON `ctf_contest` FOR EACH ROW BEGIN
	UPDATE ctf_submit_log SET ctf_contest_id = 1 WHERE ctf_contest_id = OLD.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ctf_dynamic_challenge_info`
--

DROP TABLE IF EXISTS `ctf_dynamic_challenge_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctf_dynamic_challenge_info` (
  `challenge_id` int NOT NULL DEFAULT '1',
  `min_score` int NOT NULL DEFAULT '1',
  `max_score` int NOT NULL DEFAULT '100',
  PRIMARY KEY (`challenge_id`),
  KEY `fk_ctf_dynamic_challenge_info_ctf_challenge1_idx` (`challenge_id`),
  CONSTRAINT `fk_ctf_dynamic_challenge_info_ctf_challenge1` FOREIGN KEY (`challenge_id`) REFERENCES `ctf_challenge` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctf_flag`
--

DROP TABLE IF EXISTS `ctf_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctf_flag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT_FLAG_CONTENT',
  `team_id` int NOT NULL DEFAULT '1',
  `challenge_id` int NOT NULL DEFAULT '1',
  `is_correct` tinyint NOT NULL DEFAULT '0',
  `solved_time` datetime DEFAULT NULL,
  `last_try_time` datetime DEFAULT NULL,
  `remained_submit_count` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_ctf_flag_ctf_team1_idx` (`team_id`),
  KEY `fk_ctf_flag_ctf_challenge1_idx` (`challenge_id`),
  CONSTRAINT `fk_ctf_flag_ctf_challenge1` FOREIGN KEY (`challenge_id`) REFERENCES `ctf_challenge` (`id`),
  CONSTRAINT `fk_ctf_flag_ctf_team1` FOREIGN KEY (`team_id`) REFERENCES `ctf_team` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3406 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctf_submit_log`
--

DROP TABLE IF EXISTS `ctf_submit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctf_submit_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `submit_time` datetime NOT NULL DEFAULT (curtime()),
  `flag_submitted` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'DEFAULT_FLAG_SUBMITTED',
  `is_correct` tinyint NOT NULL DEFAULT '0',
  `team_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT_TEAM_NAME',
  `submitter_login_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT_SUBMITTER_LOGIN_ID',
  `submitter_realname` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT_SUBMITTER_REALNAME',
  `challenge_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT_CHALLENGE_NAME',
  `contest_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT_CONTEST_NAME',
  `ctf_contest_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_ctf_submit_log_ctf_contest1_idx` (`ctf_contest_id`),
  CONSTRAINT `fk_ctf_submit_log_ctf_contest1` FOREIGN KEY (`ctf_contest_id`) REFERENCES `ctf_contest` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2321 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctf_team`
--

DROP TABLE IF EXISTS `ctf_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctf_team` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT_TEAM_NAME',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `creator` int NOT NULL DEFAULT '1',
  `score` int NOT NULL DEFAULT '0',
  `contest_id` int NOT NULL DEFAULT '1',
  `last_solve_time` datetime NOT NULL DEFAULT (curtime()),
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `is_duplicated` (`name`,`contest_id`),
  KEY `fk_ctf_team_member1_idx` (`creator`),
  KEY `fk_ctf_team_ctf_contest1_idx` (`contest_id`),
  CONSTRAINT `fk_ctf_team_ctf_contest1` FOREIGN KEY (`contest_id`) REFERENCES `ctf_contest` (`id`),
  CONSTRAINT `fk_ctf_team_member1` FOREIGN KEY (`creator`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ctf_team_BEFORE_UPDATE` BEFORE UPDATE ON `ctf_team` FOR EACH ROW BEGIN
	SET NEW.update_time = CURRENT_TIME;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ctf_team_has_member`
--

DROP TABLE IF EXISTS `ctf_team_has_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctf_team_has_member` (
  `ctf_team_id` int NOT NULL,
  `member_id` int NOT NULL,
  PRIMARY KEY (`ctf_team_id`,`member_id`),
  KEY `fk_ctf_team_has_member_member1_idx` (`member_id`),
  KEY `fk_ctf_team_has_member_ctf_team1_idx` (`ctf_team_id`),
  CONSTRAINT `fk_ctf_team_has_member_ctf_team1` FOREIGN KEY (`ctf_team_id`) REFERENCES `ctf_team` (`id`),
  CONSTRAINT `fk_ctf_team_has_member_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `election`
--

DROP TABLE IF EXISTS `election`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `election` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` int NOT NULL,
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `is_available` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_election_member1_idx` (`creator`),
  CONSTRAINT `fk_election_member1` FOREIGN KEY (`creator`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `election_candidate`
--

DROP TABLE IF EXISTS `election_candidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `election_candidate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `election_id` int NOT NULL DEFAULT '1',
  `candidate_id` int NOT NULL DEFAULT '1',
  `member_job_id` int NOT NULL DEFAULT '9',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `vote_count` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_election_candidate_member_job1_idx` (`member_job_id`),
  KEY `fk_election_candidate_member1_idx` (`candidate_id`),
  KEY `fk_election_candidate_election1_idx` (`election_id`),
  CONSTRAINT `fk_election_candidate_election1` FOREIGN KEY (`election_id`) REFERENCES `election` (`id`),
  CONSTRAINT `fk_election_candidate_member1` FOREIGN KEY (`candidate_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_election_candidate_member_job1` FOREIGN KEY (`member_job_id`) REFERENCES `member_job` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `election_chart_log`
--

DROP TABLE IF EXISTS `election_chart_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `election_chart_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vote_time` datetime NOT NULL DEFAULT (curtime()),
  `election_candidate_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_election_chart_log_election_candidate1_idx` (`election_candidate_id`),
  CONSTRAINT `fk_election_chart_log_election_candidate1` FOREIGN KEY (`election_candidate_id`) REFERENCES `election_candidate` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `election_voter`
--

DROP TABLE IF EXISTS `election_voter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `election_voter` (
  `voter_id` int NOT NULL DEFAULT '1',
  `election_id` int NOT NULL DEFAULT '1',
  `is_voted` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`election_id`,`voter_id`),
  KEY `fk_election_voter_election1_idx` (`election_id`),
  KEY `fk_election_voter_member1` (`voter_id`),
  CONSTRAINT `fk_election_voter_election1` FOREIGN KEY (`election_id`) REFERENCES `election` (`id`),
  CONSTRAINT `fk_election_voter_member1` FOREIGN KEY (`voter_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `information` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `total` int NOT NULL DEFAULT '1',
  `borrow` int NOT NULL DEFAULT '0',
  `enable` int NOT NULL DEFAULT '1',
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `thumbnail_id` int DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`id`),
  KEY `fk_equipment_thumbnail1_idx` (`thumbnail_id`),
  CONSTRAINT `fk_equipment_thumbnail1` FOREIGN KEY (`thumbnail_id`) REFERENCES `thumbnail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipment_BEFORE_UPDATE` BEFORE UPDATE ON `equipment` FOR EACH ROW BEGIN
	SET NEW.update_time = CURRENT_TIME;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `equipment_borrow_info`
--

DROP TABLE IF EXISTS `equipment_borrow_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment_borrow_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `borrow_date` date NOT NULL DEFAULT (curdate()),
  `expire_date` date NOT NULL DEFAULT (curdate()),
  `member_id` int NOT NULL,
  `equipment_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_equipment_borrow_info_equipment1_idx` (`equipment_id`),
  KEY `fk_equipment_borrow_info_member1_idx` (`member_id`),
  CONSTRAINT `fk_equipment_borrow_info_equipment1` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `fk_equipment_borrow_info_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_name` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `file_path` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `file_size` bigint NOT NULL,
  `upload_time` datetime NOT NULL DEFAULT (curtime()),
  `ip_address` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `file_uuid` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `file_uuid_index` (`file_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=173736 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `friend`
--

DROP TABLE IF EXISTS `friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend` (
  `id` int NOT NULL AUTO_INCREMENT,
  `follower` int NOT NULL,
  `followee` int NOT NULL,
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`id`),
  KEY `fk_friend_member1_idx` (`follower`),
  KEY `fk_friend_member2_idx` (`followee`),
  CONSTRAINT `fk_friend_member1` FOREIGN KEY (`follower`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_friend_member2` FOREIGN KEY (`followee`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_member_info`
--

DROP TABLE IF EXISTS `game_member_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_member_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `dice_per_day` int NOT NULL DEFAULT '0',
  `roulette_per_day` int NOT NULL DEFAULT '0',
  `lotto_per_day` int NOT NULL DEFAULT '0',
  `last_play_time` datetime DEFAULT (curtime()),
  `dice_day_point` int NOT NULL DEFAULT '0',
  `roulette_day_point` int NOT NULL DEFAULT '0',
  `lotto_day_point` int NOT NULL DEFAULT '0',
  `baseball_per_day` int NOT NULL DEFAULT '0',
  `baseball_day_point` int NOT NULL DEFAULT '0',
  `play_date` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `is_duplicated` (`member_id`,`play_date` DESC),
  KEY `fk_game_member_info_member1_idx` (`member_id`),
  CONSTRAINT `fk_game_member_info_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2577 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `level_standard`
--

DROP TABLE IF EXISTS `level_standard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `level_standard` (
  `level` int NOT NULL AUTO_INCREMENT,
  `minimum_point` int DEFAULT NULL,
  PRIMARY KEY (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login_id` varchar(80) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `email_address` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `password` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `real_name` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `birthday` date DEFAULT NULL,
  `student_id` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `member_type_id` int DEFAULT '1',
  `member_rank_id` int DEFAULT '1',
  `point` int NOT NULL DEFAULT '0',
  `level` int NOT NULL DEFAULT '0',
  `thumbnail_id` int DEFAULT NULL,
  `generation` float DEFAULT NULL,
  `total_attendance` int NOT NULL DEFAULT '0',
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_id_UNIQUE` (`login_id`),
  UNIQUE KEY `email_address_UNIQUE` (`email_address`),
  UNIQUE KEY `student_id_UNIQUE` (`student_id`),
  KEY `fk_member_member_type1_idx` (`member_type_id`),
  KEY `fk_member_member_rank1_idx` (`member_rank_id`),
  KEY `fk_member_thumbnail1_idx` (`thumbnail_id`),
  CONSTRAINT `fk_member_member_rank1` FOREIGN KEY (`member_rank_id`) REFERENCES `member_rank` (`id`),
  CONSTRAINT `fk_member_member_type1` FOREIGN KEY (`member_type_id`) REFERENCES `member_type` (`id`),
  CONSTRAINT `fk_member_thumbnail1` FOREIGN KEY (`thumbnail_id`) REFERENCES `thumbnail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=169215 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `member_BEFORE_UPDATE` BEFORE UPDATE ON `member` FOR EACH ROW BEGIN
	SET NEW.update_time = CURRENT_TIME;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `member_has_comment_dislike`
--

DROP TABLE IF EXISTS `member_has_comment_dislike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_has_comment_dislike` (
  `member_id` int NOT NULL,
  `comment_id` int NOT NULL,
  PRIMARY KEY (`member_id`,`comment_id`),
  KEY `fk_member_has_comment1_comment1_idx` (`comment_id`),
  KEY `fk_member_has_comment1_member1_idx` (`member_id`),
  CONSTRAINT `fk_member_has_comment1_comment1` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`),
  CONSTRAINT `fk_member_has_comment1_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_has_comment_like`
--

DROP TABLE IF EXISTS `member_has_comment_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_has_comment_like` (
  `member_id` int NOT NULL,
  `comment_id` int NOT NULL,
  PRIMARY KEY (`member_id`,`comment_id`),
  KEY `fk_member_has_comment_comment1_idx` (`comment_id`),
  KEY `fk_member_has_comment_member1_idx` (`member_id`),
  CONSTRAINT `fk_member_has_comment_comment1` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`),
  CONSTRAINT `fk_member_has_comment_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_has_member_job`
--

DROP TABLE IF EXISTS `member_has_member_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_has_member_job` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `member_job_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_member_has_member_job_member_job1_idx` (`member_job_id`),
  KEY `fk_member_has_member_job_member1_idx` (`member_id`),
  CONSTRAINT `fk_member_has_member_job_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_member_has_member_job_member_job1` FOREIGN KEY (`member_job_id`) REFERENCES `member_job` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=595 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_has_posting_dislike`
--

DROP TABLE IF EXISTS `member_has_posting_dislike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_has_posting_dislike` (
  `member_id` int NOT NULL,
  `posting_id` int NOT NULL,
  PRIMARY KEY (`member_id`,`posting_id`),
  KEY `fk_member_has_posting1_posting1_idx` (`posting_id`),
  KEY `fk_member_has_posting1_member1_idx` (`member_id`),
  CONSTRAINT `fk_member_has_posting1_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_member_has_posting1_posting1` FOREIGN KEY (`posting_id`) REFERENCES `posting` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_has_posting_like`
--

DROP TABLE IF EXISTS `member_has_posting_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_has_posting_like` (
  `member_id` int NOT NULL,
  `posting_id` int NOT NULL,
  PRIMARY KEY (`member_id`,`posting_id`),
  KEY `fk_member_has_posting_posting1_idx` (`posting_id`),
  KEY `fk_member_has_posting_member1_idx` (`member_id`),
  CONSTRAINT `fk_member_has_posting_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_member_has_posting_posting1` FOREIGN KEY (`posting_id`) REFERENCES `posting` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_job`
--

DROP TABLE IF EXISTS `member_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_job` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_rank`
--

DROP TABLE IF EXISTS `member_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_rank` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `badge_thumbnail_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_member_rank_thumbnail1_idx` (`badge_thumbnail_id`),
  CONSTRAINT `fk_member_rank_thumbnail1` FOREIGN KEY (`badge_thumbnail_id`) REFERENCES `thumbnail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_read_posting`
--

DROP TABLE IF EXISTS `member_read_posting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_read_posting` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `posting_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_member_read_posting_member1_idx` (`member_id`),
  KEY `fk_member_read_posting_posting1_idx` (`posting_id`),
  CONSTRAINT `fk_member_read_posting_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_member_read_posting_posting1` FOREIGN KEY (`posting_id`) REFERENCES `posting` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1466 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_type`
--

DROP TABLE IF EXISTS `member_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `badge_thumbnail_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_member_type_thumbnail1_idx` (`badge_thumbnail_id`),
  CONSTRAINT `fk_member_type_thumbnail1` FOREIGN KEY (`badge_thumbnail_id`) REFERENCES `thumbnail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merit_log`
--

DROP TABLE IF EXISTS `merit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merit_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL DEFAULT '1',
  `member_realname` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `member_generation` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` datetime NOT NULL DEFAULT (curtime()),
  `merit_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_merit_log_merit_type1_idx` (`merit_type_id`),
  CONSTRAINT `fk_merit_log_merit_type1` FOREIGN KEY (`merit_type_id`) REFERENCES `merit_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=383 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merit_type`
--

DROP TABLE IF EXISTS `merit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merit_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `merit` int NOT NULL DEFAULT '0',
  `is_merit` tinyint NOT NULL DEFAULT '1',
  `detail` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `non_absence`
--

DROP TABLE IF EXISTS `non_absence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `non_absence` (
  `id` int NOT NULL AUTO_INCREMENT,
  `term` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `day` int NOT NULL,
  `point` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `point_log`
--

DROP TABLE IF EXISTS `point_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `point_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL DEFAULT (curtime()),
  `member_id` int NOT NULL,
  `point` int NOT NULL DEFAULT '0',
  `detail` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `presented` int DEFAULT NULL,
  `is_spent` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_point_log_member1_idx` (`presented`),
  KEY `fk_point_log_member2_idx` (`member_id`),
  CONSTRAINT `fk_point_log_member1` FOREIGN KEY (`presented`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_point_log_member2` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63983 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `posting`
--

DROP TABLE IF EXISTS `posting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posting` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `member_id` int NOT NULL,
  `visit_count` int NOT NULL DEFAULT '0',
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  `ip_address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `allow_comment` tinyint NOT NULL DEFAULT '1',
  `is_notice` tinyint NOT NULL DEFAULT '0',
  `is_secret` tinyint NOT NULL DEFAULT '0',
  `is_temp` tinyint NOT NULL DEFAULT '0',
  `password` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int NOT NULL,
  `thumbnail_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_posting_member1_idx` (`member_id`),
  KEY `fk_posting_category1_idx` (`category_id`),
  KEY `fk_posting_thumbnail1_idx` (`thumbnail_id`),
  CONSTRAINT `fk_posting_category1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `fk_posting_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_posting_thumbnail1` FOREIGN KEY (`thumbnail_id`) REFERENCES `thumbnail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=173146 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `posting_has_file`
--

DROP TABLE IF EXISTS `posting_has_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posting_has_file` (
  `posting_id` int NOT NULL,
  `file_id` int NOT NULL,
  PRIMARY KEY (`posting_id`,`file_id`),
  KEY `fk_posting_has_file_file1_idx` (`file_id`),
  KEY `fk_posting_has_file_posting1_idx` (`posting_id`),
  CONSTRAINT `fk_posting_has_file_file1` FOREIGN KEY (`file_id`) REFERENCES `file` (`id`),
  CONSTRAINT `fk_posting_has_file_posting1` FOREIGN KEY (`posting_id`) REFERENCES `posting` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seminar`
--

DROP TABLE IF EXISTS `seminar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seminar` (
  `id` int NOT NULL AUTO_INCREMENT,
  `open_time` datetime NOT NULL DEFAULT (curtime()),
  `attendance_start_time` datetime DEFAULT NULL,
  `attendance_close_time` datetime DEFAULT NULL,
  `lateness_close_time` datetime DEFAULT NULL,
  `attendance_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  `starter_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seminar_member1_idx` (`starter_id`),
  CONSTRAINT `fk_seminar_member1` FOREIGN KEY (`starter_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`keeper`@`%`*/ /*!50003 TRIGGER `seminar_BEFORE_INSERT` BEFORE INSERT ON `seminar` FOR EACH ROW BEGIN
	IF NEW.name IS NULL THEN
        SET NEW.name = DATE_FORMAT(NEW.open_time,'%Y-%m-%d');
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `seminar_BEFORE_UPDATE` BEFORE UPDATE ON `seminar` FOR EACH ROW BEGIN
	SET NEW.update_time = CURRENT_TIME;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `seminar_attendance`
--

DROP TABLE IF EXISTS `seminar_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seminar_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seminar_id` int NOT NULL DEFAULT '1',
  `member_id` int NOT NULL DEFAULT '1',
  `status_id` int NOT NULL DEFAULT '1',
  `attend_time` datetime NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `is_seminar_attendance_duplicated` (`member_id`,`seminar_id`),
  KEY `fk_seminar_attendance_seminar1_idx` (`seminar_id`),
  KEY `fk_seminar_attendance_member1_idx` (`member_id`),
  KEY `fk_seminar_attendance_seminar_attendance_status1_idx` (`status_id`),
  CONSTRAINT `fk_seminar_attendance_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_seminar_attendance_seminar1` FOREIGN KEY (`seminar_id`) REFERENCES `seminar` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_seminar_attendance_seminar_attendance_status1` FOREIGN KEY (`status_id`) REFERENCES `seminar_attendance_status` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seminar_attendance_excuse`
--

DROP TABLE IF EXISTS `seminar_attendance_excuse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seminar_attendance_excuse` (
  `seminar_attendance_id` int NOT NULL,
  `absence_excuse` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`seminar_attendance_id`),
  CONSTRAINT `fk_seminar_attendance_excuse_seminar_attendance1` FOREIGN KEY (`seminar_attendance_id`) REFERENCES `seminar_attendance` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seminar_attendance_status`
--

DROP TABLE IF EXISTS `seminar_attendance_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seminar_attendance_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `static_write_content`
--

DROP TABLE IF EXISTS `static_write_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `static_write_content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `static_write_subtitle_image_id` int NOT NULL,
  `display_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_static_write_content_static_write_subtitle_image1_idx` (`static_write_subtitle_image_id`),
  CONSTRAINT `fk_static_write_content_static_write_subtitle_image1` FOREIGN KEY (`static_write_subtitle_image_id`) REFERENCES `static_write_subtitle_image` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `static_write_subtitle_image`
--

DROP TABLE IF EXISTS `static_write_subtitle_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `static_write_subtitle_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subtitle` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `static_write_title_id` int NOT NULL,
  `thumbnail_id` int DEFAULT NULL,
  `display_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_static_write_subtitle_image_static_write_title1_idx` (`static_write_title_id`),
  KEY `fk_static_write_subtitle_image_thumbnail1_idx` (`thumbnail_id`),
  CONSTRAINT `fk_static_write_subtitle_image_static_write_title1` FOREIGN KEY (`static_write_title_id`) REFERENCES `static_write_title` (`id`),
  CONSTRAINT `fk_static_write_subtitle_image_thumbnail1` FOREIGN KEY (`thumbnail_id`) REFERENCES `thumbnail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `static_write_title`
--

DROP TABLE IF EXISTS `static_write_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `static_write_title` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `type` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `study`
--

DROP TABLE IF EXISTS `study`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `information` varchar(256) COLLATE utf8mb3_bin NOT NULL,
  `head_member_id` int NOT NULL,
  `thumbnail_id` int DEFAULT NULL,
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `year` int DEFAULT NULL,
  `season` int DEFAULT NULL,
  `git_link` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `notion_link` varchar(256) COLLATE utf8mb3_bin DEFAULT NULL,
  `etc_link` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `etc_title` varchar(45) COLLATE utf8mb3_bin DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`id`),
  KEY `fk_study_thumbnail1_idx` (`thumbnail_id`),
  KEY `fk_study_member1_idx` (`head_member_id`),
  CONSTRAINT `fk_study_member1` FOREIGN KEY (`head_member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_study_thumbnail1` FOREIGN KEY (`thumbnail_id`) REFERENCES `thumbnail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `study_BEFORE_UPDATE` BEFORE UPDATE ON `study` FOR EACH ROW BEGIN
	SET NEW.update_time = CURRENT_TIME;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `study_has_member`
--

DROP TABLE IF EXISTS `study_has_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study_has_member` (
  `study_id` int NOT NULL,
  `member_id` int NOT NULL,
  `register_time` datetime(6) NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`study_id`,`member_id`),
  KEY `fk_study_has_member_member1_idx` (`member_id`),
  KEY `fk_study_has_member_study1_idx` (`study_id`),
  CONSTRAINT `fk_study_has_member_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_study_has_member_study1` FOREIGN KEY (`study_id`) REFERENCES `study` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `survey`
--

DROP TABLE IF EXISTS `survey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `survey` (
  `id` int NOT NULL AUTO_INCREMENT,
  `open_time` datetime NOT NULL DEFAULT (curtime()),
  `close_time` datetime DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_visible` tinyint NOT NULL DEFAULT '0',
  `register_time` datetime NOT NULL DEFAULT (curtime()),
  `update_time` datetime NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`keeper`@`%`*/ /*!50003 TRIGGER `survey_BEFORE_INSERT` BEFORE INSERT ON `survey` FOR EACH ROW BEGIN
	IF NEW.name IS NULL THEN
        SET NEW.name = DATE_FORMAT(CURRENT_TIME,'%Y%m%d_활동인원조사');
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `survey_BEFORE_UPDATE` BEFORE UPDATE ON `survey` FOR EACH ROW BEGIN
	SET NEW.update_time = CURRENT_TIME;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `survey_member_reply`
--

DROP TABLE IF EXISTS `survey_member_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `survey_member_reply` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL DEFAULT '1',
  `survey_id` int NOT NULL DEFAULT '1',
  `reply_id` int NOT NULL DEFAULT '1',
  `reply_time` datetime NOT NULL DEFAULT (curtime()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `is_reply_duplicated` (`member_id`,`survey_id`) /*!80000 INVISIBLE */,
  KEY `fk_survey_member_reply_member1_idx` (`member_id`),
  KEY `fk_survey_member_reply_survey1_idx` (`survey_id`),
  KEY `fk_survey_member_reply_survey_reply1_idx` (`reply_id`),
  CONSTRAINT `fk_survey_member_reply_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_survey_member_reply_survey1` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_survey_member_reply_survey_reply1` FOREIGN KEY (`reply_id`) REFERENCES `survey_reply` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `survey_reply`
--

DROP TABLE IF EXISTS `survey_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `survey_reply` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `survey_reply_excuse`
--

DROP TABLE IF EXISTS `survey_reply_excuse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `survey_reply_excuse` (
  `survey_member_reply_id` int NOT NULL DEFAULT '1',
  `rest_excuse` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`survey_member_reply_id`),
  CONSTRAINT `fk_survey_reply_excuse_survey_member_reply1` FOREIGN KEY (`survey_member_reply_id`) REFERENCES `survey_member_reply` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `thumbnail`
--

DROP TABLE IF EXISTS `thumbnail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thumbnail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `path` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `file_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_thumbnail_file1_idx` (`file_id`),
  CONSTRAINT `fk_thumbnail_file1` FOREIGN KEY (`file_id`) REFERENCES `file` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=316 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-19 17:12:17
