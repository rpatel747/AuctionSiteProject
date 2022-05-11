CREATE DATABASE  IF NOT EXISTS `site` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `site`;
-- MySQL dump 10.13  Distrib 8.0.28, for macos11 (x86_64)
--
-- Host: localhost    Database: site
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('admin1','$336Admin1$'),('bobjones','StayCuboard123!'),('buyme_jack','$!33WeR1W!'),('buyme_ron','fMe7_2W1!'),('eyefour','2!iRonJam146!'),('hollowrice','12PasswordStrong34'),('olympicScanner','$4321CoolMo'),('overlookRidge','password');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminHas`
--

DROP TABLE IF EXISTS `adminHas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminHas` (
  `employeeID` int NOT NULL DEFAULT '0',
  `username` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`employeeID`,`username`),
  KEY `employeeID` (`employeeID`),
  KEY `username` (`username`),
  CONSTRAINT `adminhas_ibfk_1` FOREIGN KEY (`employeeID`) REFERENCES `adminStaff` (`employeeID`) ON DELETE CASCADE,
  CONSTRAINT `adminhas_ibfk_2` FOREIGN KEY (`username`) REFERENCES `account` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminHas`
--

LOCK TABLES `adminHas` WRITE;
/*!40000 ALTER TABLE `adminHas` DISABLE KEYS */;
INSERT INTO `adminHas` VALUES (0,'admin1');
/*!40000 ALTER TABLE `adminHas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminStaff`
--

DROP TABLE IF EXISTS `adminStaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminStaff` (
  `employeeID` int NOT NULL DEFAULT '0',
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`employeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminStaff`
--

LOCK TABLES `adminStaff` WRITE;
/*!40000 ALTER TABLE `adminStaff` DISABLE KEYS */;
INSERT INTO `adminStaff` VALUES (0,'Bob','Jones');
/*!40000 ALTER TABLE `adminStaff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `alertID` int NOT NULL AUTO_INCREMENT,
  `alertContent` varchar(1000) DEFAULT NULL,
  `carName` varchar(100) DEFAULT NULL,
  `vehicleType` varchar(50) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `year` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `mileage` varchar(50) DEFAULT NULL,
  `trim` varchar(50) DEFAULT NULL,
  `showAlert` int DEFAULT '0',
  `setBy` int DEFAULT '0',
  `acknowledged` int DEFAULT '0',
  PRIMARY KEY (`alertID`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
INSERT INTO `alerts` VALUES (1,'A higher bid has been placed by another bidder for Auction #1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,3,0),(2,'A higher bid has been placed by another bidder for Auction #3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,3,1),(3,'A higher bid has been placed by another bidder for Auction #3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,3,1),(4,'A higher bid has been placed by another bidder for Auction #3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,3,0),(5,'A higher bid has been placed by another bidder for Auction #4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,3,0),(6,'A higher bid has been placed by another bidder for Auction #6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,3,1),(7,'A higher bid has been placed by another bidder for Auction #6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,3,1),(8,'A higher bid has been placed by another bidder for Auction #6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,3,0),(9,'A higher bid has been placed by another bidder for Auction #7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,3,1),(10,'You have won Auction #3','R8','Car','Audi','2015','Red','34874','Quattro',1,3,1),(11,'Auction #3 has sold','R8','Car','Audi','2015','Red','34874','Quattro',1,3,0),(12,'You have won Auction #4','Camry','Car','Toyota','2000','Silver','147412','CE',1,3,0),(13,'Auction #4 has sold','Camry','Car','Toyota','2000','Silver','147412','CE',1,3,0),(14,'You have won Auction #5','Corolla','Car','Toyota','2009','Blue','98180','LE',1,3,1),(15,'Auction #5 has sold','Corolla','Car','Toyota','2009','Blue','98180','LE',1,3,0),(16,'You have won Auction #6','4Runner','Truck','Toyota','2022','Green','26','SR5',1,3,0),(17,'Auction #6 has sold','4Runner','Truck','Toyota','2022','Green','26','SR5',1,3,0),(18,'You have won Auction #7','900 SS','Motorbike','Ducati','1995','Black','31100',NULL,1,3,1),(19,'Auction #7 has sold','900 SS','Motorbike','Ducati','1995','Black','31100',NULL,1,3,0),(20,'Auction #9 has not sold because no bids were above the minimum price','F-150','Truck','Ford','1979','Silver','84000','Explorer',1,3,0),(21,'Auction #1 has not sold because no bids were above the minimum price','i3','Car','BMW','2011','Black','52400','Mega World',1,3,1),(22,'Auction #2 has not sold because no bids were above the minimum price','280 SE','Car','Mercedes','1973','Blue','51000',NULL,1,3,1),(23,'Auction #8 has not sold because no bids were above the minimum price','Electra-Glide FLH 1200','Motorbike','Harley-Davidson','1968','Red','26705','FLH',1,3,0);
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answersQuestion`
--

DROP TABLE IF EXISTS `answersQuestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answersQuestion` (
  `employeeID` int DEFAULT NULL,
  `questionID` int DEFAULT NULL,
  KEY `employeeID` (`employeeID`),
  KEY `questionID` (`questionID`),
  CONSTRAINT `answersquestion_ibfk_1` FOREIGN KEY (`employeeID`) REFERENCES `employee` (`employeeID`) ON DELETE CASCADE,
  CONSTRAINT `answersquestion_ibfk_2` FOREIGN KEY (`questionID`) REFERENCES `questions` (`questionID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answersQuestion`
--

LOCK TABLES `answersQuestion` WRITE;
/*!40000 ALTER TABLE `answersQuestion` DISABLE KEYS */;
INSERT INTO `answersQuestion` VALUES (1,1);
/*!40000 ALTER TABLE `answersQuestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asksQuestion`
--

DROP TABLE IF EXISTS `asksQuestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asksQuestion` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `questionID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`email`,`questionID`),
  KEY `email` (`email`),
  KEY `questionID` (`questionID`),
  CONSTRAINT `asksquestion_ibfk_1` FOREIGN KEY (`email`) REFERENCES `customer` (`email`) ON DELETE CASCADE,
  CONSTRAINT `asksquestion_ibfk_2` FOREIGN KEY (`questionID`) REFERENCES `questions` (`questionID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asksQuestion`
--

LOCK TABLES `asksQuestion` WRITE;
/*!40000 ALTER TABLE `asksQuestion` DISABLE KEYS */;
INSERT INTO `asksQuestion` VALUES ('alberg632@gmail.com',1),('alberg632@gmail.com',2);
/*!40000 ALTER TABLE `asksQuestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bids`
--

DROP TABLE IF EXISTS `bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bids` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `saleNumber` int NOT NULL DEFAULT '0',
  `currentBid` float DEFAULT '0',
  `maxBid` float DEFAULT '0',
  PRIMARY KEY (`email`,`saleNumber`),
  KEY `email` (`email`),
  KEY `saleNumber` (`saleNumber`),
  CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`email`) REFERENCES `customer` (`email`) ON DELETE CASCADE,
  CONSTRAINT `bids_ibfk_2` FOREIGN KEY (`saleNumber`) REFERENCES `sale` (`saleNumber`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bids`
--

LOCK TABLES `bids` WRITE;
/*!40000 ALTER TABLE `bids` DISABLE KEYS */;
INSERT INTO `bids` VALUES ('alberg632@gmail.com',3,72000,72000),('alberg632@gmail.com',5,7000,7000),('alberg632@gmail.com',6,57400,58000),('alberg632@gmail.com',8,17000,17000),('bobjones@gmail.com',1,8000,8000),('bobjones@gmail.com',3,64500,65000),('bobjones@gmail.com',6,69400,70000),('hollowrice@yahoo.com',1,9000,9000),('hollowrice@yahoo.com',4,850,900),('hollowrice@yahoo.com',6,53000,56000),('theridge@gmail.com',3,59500,60000),('theridge@gmail.com',4,1200,1200);
/*!40000 ALTER TABLE `bids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bidsHistory`
--

DROP TABLE IF EXISTS `bidsHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bidsHistory` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `saleNumber` int NOT NULL DEFAULT '0',
  `currentBid` float DEFAULT '0',
  `bidDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`email`,`saleNumber`,`bidDateTime`),
  KEY `email` (`email`),
  KEY `saleNumber` (`saleNumber`),
  CONSTRAINT `bidshistory_ibfk_1` FOREIGN KEY (`email`) REFERENCES `customer` (`email`) ON DELETE CASCADE,
  CONSTRAINT `bidshistory_ibfk_2` FOREIGN KEY (`saleNumber`) REFERENCES `sale` (`saleNumber`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidsHistory`
--

LOCK TABLES `bidsHistory` WRITE;
/*!40000 ALTER TABLE `bidsHistory` DISABLE KEYS */;
INSERT INTO `bidsHistory` VALUES ('alberg632@gmail.com',3,49700,'2022-05-08 12:51:55'),('alberg632@gmail.com',3,55500,'2022-05-08 13:01:13'),('alberg632@gmail.com',3,57000,'2022-05-08 13:01:17'),('alberg632@gmail.com',3,58500,'2022-05-08 13:01:20'),('alberg632@gmail.com',3,60000,'2022-05-08 13:01:22'),('alberg632@gmail.com',3,61000,'2022-05-08 13:01:24'),('alberg632@gmail.com',3,62000,'2022-05-08 13:01:25'),('alberg632@gmail.com',3,63000,'2022-05-08 13:01:26'),('alberg632@gmail.com',3,64000,'2022-05-08 13:01:27'),('alberg632@gmail.com',3,65000,'2022-05-08 13:01:28'),('alberg632@gmail.com',3,65500,'2022-05-08 13:01:29'),('alberg632@gmail.com',3,66000,'2022-05-08 13:01:31'),('alberg632@gmail.com',3,66500,'2022-05-08 13:01:32'),('alberg632@gmail.com',3,67000,'2022-05-08 13:01:36'),('alberg632@gmail.com',3,67500,'2022-05-08 13:01:37'),('alberg632@gmail.com',3,68000,'2022-05-08 13:01:38'),('alberg632@gmail.com',3,68500,'2022-05-08 13:01:39'),('alberg632@gmail.com',3,69000,'2022-05-08 13:01:40'),('alberg632@gmail.com',3,69500,'2022-05-08 13:01:41'),('alberg632@gmail.com',3,70000,'2022-05-08 13:01:43'),('alberg632@gmail.com',3,70500,'2022-05-08 13:01:44'),('alberg632@gmail.com',3,71000,'2022-05-08 13:01:45'),('alberg632@gmail.com',3,71500,'2022-05-08 13:01:48'),('alberg632@gmail.com',3,72000,'2022-05-08 13:01:53'),('alberg632@gmail.com',5,4000,'2022-05-08 12:55:22'),('alberg632@gmail.com',5,4120,'2022-05-08 13:01:13'),('alberg632@gmail.com',5,4240,'2022-05-08 13:01:17'),('alberg632@gmail.com',5,4360,'2022-05-08 13:01:20'),('alberg632@gmail.com',5,4480,'2022-05-08 13:01:22'),('alberg632@gmail.com',5,4600,'2022-05-08 13:01:24'),('alberg632@gmail.com',5,4720,'2022-05-08 13:01:25'),('alberg632@gmail.com',5,4840,'2022-05-08 13:01:26'),('alberg632@gmail.com',5,4960,'2022-05-08 13:01:27'),('alberg632@gmail.com',5,5080,'2022-05-08 13:01:28'),('alberg632@gmail.com',5,5200,'2022-05-08 13:01:29'),('alberg632@gmail.com',5,5320,'2022-05-08 13:01:31'),('alberg632@gmail.com',5,5440,'2022-05-08 13:01:32'),('alberg632@gmail.com',5,5560,'2022-05-08 13:01:36'),('alberg632@gmail.com',5,5680,'2022-05-08 13:01:37'),('alberg632@gmail.com',5,5800,'2022-05-08 13:01:38'),('alberg632@gmail.com',5,5920,'2022-05-08 13:01:39'),('alberg632@gmail.com',5,6040,'2022-05-08 13:01:40'),('alberg632@gmail.com',5,6160,'2022-05-08 13:01:41'),('alberg632@gmail.com',5,6280,'2022-05-08 13:01:43'),('alberg632@gmail.com',5,6400,'2022-05-08 13:01:44'),('alberg632@gmail.com',5,6520,'2022-05-08 13:01:45'),('alberg632@gmail.com',5,6640,'2022-05-08 13:01:48'),('alberg632@gmail.com',5,6760,'2022-05-08 13:01:53'),('alberg632@gmail.com',5,6880,'2022-05-08 13:01:54'),('alberg632@gmail.com',5,7000,'2022-05-08 13:01:55'),('alberg632@gmail.com',6,50000,'2022-05-08 12:56:34'),('alberg632@gmail.com',6,55800,'2022-05-08 13:01:13'),('alberg632@gmail.com',6,57400,'2022-05-08 13:01:17'),('alberg632@gmail.com',8,15000,'2022-05-08 13:00:14'),('alberg632@gmail.com',8,15400,'2022-05-08 13:01:13'),('alberg632@gmail.com',8,15800,'2022-05-08 13:01:17'),('alberg632@gmail.com',8,16200,'2022-05-08 13:01:20'),('alberg632@gmail.com',8,16600,'2022-05-08 13:01:22'),('alberg632@gmail.com',8,17000,'2022-05-08 13:01:24'),('bobjones@gmail.com',1,5700,'2022-05-08 12:47:42'),('bobjones@gmail.com',1,6700,'2022-05-08 13:01:13'),('bobjones@gmail.com',1,6900,'2022-05-08 13:01:17'),('bobjones@gmail.com',1,7200,'2022-05-08 13:01:20'),('bobjones@gmail.com',1,7400,'2022-05-08 13:01:22'),('bobjones@gmail.com',1,7600,'2022-05-08 13:01:24'),('bobjones@gmail.com',1,7800,'2022-05-08 13:01:25'),('bobjones@gmail.com',1,8000,'2022-05-08 13:01:26'),('bobjones@gmail.com',3,53000,'2022-05-08 12:52:18'),('bobjones@gmail.com',3,56000,'2022-05-08 13:01:13'),('bobjones@gmail.com',3,57500,'2022-05-08 13:01:17'),('bobjones@gmail.com',3,59000,'2022-05-08 13:01:20'),('bobjones@gmail.com',3,60500,'2022-05-08 13:01:22'),('bobjones@gmail.com',3,61500,'2022-05-08 13:01:24'),('bobjones@gmail.com',3,62500,'2022-05-08 13:01:25'),('bobjones@gmail.com',3,63500,'2022-05-08 13:01:26'),('bobjones@gmail.com',3,64500,'2022-05-08 13:01:27'),('bobjones@gmail.com',6,55000,'2022-05-08 12:57:14'),('bobjones@gmail.com',6,56600,'2022-05-08 13:01:13'),('bobjones@gmail.com',6,58200,'2022-05-08 13:01:17'),('bobjones@gmail.com',6,59000,'2022-05-08 13:01:20'),('bobjones@gmail.com',6,59800,'2022-05-08 13:01:22'),('bobjones@gmail.com',6,60600,'2022-05-08 13:01:24'),('bobjones@gmail.com',6,61400,'2022-05-08 13:01:25'),('bobjones@gmail.com',6,62200,'2022-05-08 13:01:26'),('bobjones@gmail.com',6,63000,'2022-05-08 13:01:27'),('bobjones@gmail.com',6,63800,'2022-05-08 13:01:28'),('bobjones@gmail.com',6,64600,'2022-05-08 13:01:29'),('bobjones@gmail.com',6,65400,'2022-05-08 13:01:31'),('bobjones@gmail.com',6,66200,'2022-05-08 13:01:32'),('bobjones@gmail.com',6,67000,'2022-05-08 13:01:36'),('bobjones@gmail.com',6,67800,'2022-05-08 13:01:37'),('bobjones@gmail.com',6,68600,'2022-05-08 13:01:38'),('bobjones@gmail.com',6,69400,'2022-05-08 13:01:39'),('hollowrice@yahoo.com',1,6600,'2022-05-08 12:48:02'),('hollowrice@yahoo.com',1,6800,'2022-05-08 13:01:13'),('hollowrice@yahoo.com',1,7000,'2022-05-08 13:01:17'),('hollowrice@yahoo.com',1,7300,'2022-05-08 13:01:20'),('hollowrice@yahoo.com',1,7500,'2022-05-08 13:01:22'),('hollowrice@yahoo.com',1,7700,'2022-05-08 13:01:24'),('hollowrice@yahoo.com',1,7900,'2022-05-08 13:01:25'),('hollowrice@yahoo.com',1,8100,'2022-05-08 13:01:26'),('hollowrice@yahoo.com',1,8200,'2022-05-08 13:01:27'),('hollowrice@yahoo.com',1,8300,'2022-05-08 13:01:28'),('hollowrice@yahoo.com',1,8400,'2022-05-08 13:01:29'),('hollowrice@yahoo.com',1,8500,'2022-05-08 13:01:31'),('hollowrice@yahoo.com',1,8600,'2022-05-08 13:01:32'),('hollowrice@yahoo.com',1,8800,'2022-05-08 13:01:36'),('hollowrice@yahoo.com',1,8900,'2022-05-08 13:01:37'),('hollowrice@yahoo.com',1,9000,'2022-05-08 13:01:38'),('hollowrice@yahoo.com',4,700,'2022-05-08 12:54:08'),('hollowrice@yahoo.com',4,750,'2022-05-08 13:01:13'),('hollowrice@yahoo.com',4,850,'2022-05-08 13:01:17'),('hollowrice@yahoo.com',6,53000,'2022-05-08 12:56:54'),('theridge@gmail.com',3,55000,'2022-05-08 12:52:40'),('theridge@gmail.com',3,56500,'2022-05-08 13:01:13'),('theridge@gmail.com',3,58000,'2022-05-08 13:01:17'),('theridge@gmail.com',3,59500,'2022-05-08 13:01:20'),('theridge@gmail.com',4,500,'2022-05-08 12:53:50'),('theridge@gmail.com',4,800,'2022-05-08 13:01:13'),('theridge@gmail.com',4,900,'2022-05-08 13:01:17'),('theridge@gmail.com',4,950,'2022-05-08 13:01:20'),('theridge@gmail.com',4,1000,'2022-05-08 13:01:22'),('theridge@gmail.com',4,1050,'2022-05-08 13:01:24'),('theridge@gmail.com',4,1100,'2022-05-08 13:01:25'),('theridge@gmail.com',4,1150,'2022-05-08 13:01:26'),('theridge@gmail.com',4,1200,'2022-05-08 13:01:27');
/*!40000 ALTER TABLE `bidsHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `firstName` varchar(50) NOT NULL DEFAULT '',
  `lastName` varchar(50) NOT NULL DEFAULT '',
  `dob` date DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('alberg632@gmail.com','Christian','Horner','1968-12-29'),('bobjones@gmail.com','Bob','Jones','1975-06-12'),('hollowrice@yahoo.com','Dev','Patel','1997-03-13'),('jjackson@gmail.com','Jack','Jackson','1985-09-25'),('theridge@gmail.com','Lionel','Dangi','2000-01-19');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerHas`
--

DROP TABLE IF EXISTS `customerHas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerHas` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`email`,`username`),
  KEY `email` (`email`),
  KEY `username` (`username`),
  CONSTRAINT `customerhas_ibfk_1` FOREIGN KEY (`email`) REFERENCES `customer` (`email`) ON DELETE CASCADE,
  CONSTRAINT `customerhas_ibfk_2` FOREIGN KEY (`username`) REFERENCES `account` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerHas`
--

LOCK TABLES `customerHas` WRITE;
/*!40000 ALTER TABLE `customerHas` DISABLE KEYS */;
INSERT INTO `customerHas` VALUES ('alberg632@gmail.com','eyefour'),('bobjones@gmail.com','bobjones'),('hollowrice@yahoo.com','hollowrice'),('jjackson@gmail.com','olympicScanner'),('theridge@gmail.com','overlookRidge');
/*!40000 ALTER TABLE `customerHas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerHasAlerts`
--

DROP TABLE IF EXISTS `customerHasAlerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerHasAlerts` (
  `alertID` int NOT NULL DEFAULT '0',
  `email` varchar(50) NOT NULL DEFAULT '',
  KEY `alertID` (`alertID`),
  KEY `email` (`email`),
  CONSTRAINT `customerhasalerts_ibfk_1` FOREIGN KEY (`alertID`) REFERENCES `alerts` (`alertID`) ON DELETE CASCADE,
  CONSTRAINT `customerhasalerts_ibfk_2` FOREIGN KEY (`email`) REFERENCES `customer` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerHasAlerts`
--

LOCK TABLES `customerHasAlerts` WRITE;
/*!40000 ALTER TABLE `customerHasAlerts` DISABLE KEYS */;
INSERT INTO `customerHasAlerts` VALUES (1,'bobjones@gmail.com'),(2,'alberg632@gmail.com'),(3,'alberg632@gmail.com'),(4,'bobjones@gmail.com'),(5,'theridge@gmail.com'),(6,'alberg632@gmail.com'),(7,'alberg632@gmail.com'),(8,'hollowrice@yahoo.com'),(9,'alberg632@gmail.com'),(10,'alberg632@gmail.com'),(11,'hollowrice@yahoo.com'),(12,'theridge@gmail.com'),(13,'bobjones@gmail.com'),(14,'alberg632@gmail.com'),(15,'jjackson@gmail.com'),(16,'bobjones@gmail.com'),(17,'theridge@gmail.com'),(18,'alberg632@gmail.com'),(19,'bobjones@gmail.com'),(20,'bobjones@gmail.com'),(21,'alberg632@gmail.com'),(22,'alberg632@gmail.com'),(23,'jjackson@gmail.com');
/*!40000 ALTER TABLE `customerHasAlerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employeeID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) NOT NULL DEFAULT '',
  `lastName` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`employeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Jack','Jones'),(2,'Ronald','Smith');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employeeHas`
--

DROP TABLE IF EXISTS `employeeHas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employeeHas` (
  `employeeID` int NOT NULL DEFAULT '0',
  `username` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`employeeID`,`username`),
  KEY `employeeID` (`employeeID`),
  KEY `username` (`username`),
  CONSTRAINT `employeehas_ibfk_1` FOREIGN KEY (`employeeID`) REFERENCES `employee` (`employeeID`) ON DELETE CASCADE,
  CONSTRAINT `employeehas_ibfk_2` FOREIGN KEY (`username`) REFERENCES `account` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employeeHas`
--

LOCK TABLES `employeeHas` WRITE;
/*!40000 ALTER TABLE `employeeHas` DISABLE KEYS */;
INSERT INTO `employeeHas` VALUES (1,'buyme_jack'),(2,'buyme_ron');
/*!40000 ALTER TABLE `employeeHas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs` (
  `faqID` int NOT NULL AUTO_INCREMENT,
  `topic` varchar(100) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `response` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`faqID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs`
--

LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
INSERT INTO `faqs` VALUES (1,'Change Account Information','Can I change my email address?','Sorry, but email addresses cannot be changed after the account is created.'),(2,'Change Account Information','Change Password','If you would like to change your password please submit a question through the customer service portal. Please include the new password you would like to use'),(3,'Delete Auctions','I no longer want to auction an item, can the auction be deleted?','If the auction has not yet ended you can submit an auction deletion request through the system. A customer service rep will delete the auction and all bids for the auction.'),(4,'Change Account Information','How can I delete my account?','Please submit a request through the customer service tab, a customer service rep will process your account deletion for you.');
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `questionID` int NOT NULL AUTO_INCREMENT,
  `topic` varchar(100) DEFAULT NULL,
  `userResponse` varchar(1000) DEFAULT NULL,
  `employeeResponse` varchar(1000) DEFAULT NULL,
  `status` int DEFAULT '0',
  PRIMARY KEY (`questionID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'Other','I would like to change my email address from alberg632@gmail.com to eyefour@gmail.com','The email address associated with an account cannot be changed after the account is created. Please request account deletion, and create a new account.',1),(2,'Delete Auction','I would like to delete Auction #1.','',0);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale`
--

DROP TABLE IF EXISTS `sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale` (
  `saleNumber` int NOT NULL AUTO_INCREMENT,
  `carName` varchar(50) DEFAULT NULL,
  `manufactureYear` int DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `mileage` int DEFAULT NULL,
  `currentPrice` float DEFAULT NULL,
  `trim` varchar(20) NOT NULL DEFAULT '',
  `vehicleType` varchar(10) NOT NULL DEFAULT '',
  `color` varchar(20) DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `validBidIncr` float DEFAULT '0',
  `minimumPrice` float DEFAULT '0',
  `status` int DEFAULT '0',
  PRIMARY KEY (`saleNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale`
--

LOCK TABLES `sale` WRITE;
/*!40000 ALTER TABLE `sale` DISABLE KEYS */;
INSERT INTO `sale` VALUES (1,'i3',2011,'BMW',52400,10429.7,'Mega World','Car','Black','2022-05-08 13:10:00',100,10429.7,1),(3,'R8',2015,'Audi',34874,65100,'Quattro','Car','Red','2022-05-08 13:10:00',500,65100,1),(4,'Camry',2000,'Toyota',147412,1000,'CE','Car','Silver','2022-05-08 13:10:00',50,1000,1),(5,'Corolla',2009,'Toyota',98180,5700,'LE','Car','Blue','2022-05-08 13:10:00',120,5700,1),(6,'4Runner',2022,'Toyota',26,63000,'SR5','Truck','Green','2022-05-08 13:08:00',800,63000,1),(8,'Electra-Glide FLH 1200',1968,'Harley-Davidson',26705,20000,'FLH','Motorbike','Red','2022-05-08 13:07:00',400,20000,1),(9,'F-150',1979,'Ford',84000,6000,'Explorer','Truck','Silver','2022-05-08 13:08:00',65,6000,1);
/*!40000 ALTER TABLE `sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sells`
--

DROP TABLE IF EXISTS `sells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sells` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `saleNumber` int NOT NULL DEFAULT '0',
  `saleStatus` int NOT NULL DEFAULT '0',
  `soldPrice` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`email`,`saleNumber`),
  KEY `email` (`email`),
  KEY `saleNumber` (`saleNumber`),
  CONSTRAINT `sells_ibfk_1` FOREIGN KEY (`email`) REFERENCES `customer` (`email`) ON DELETE CASCADE,
  CONSTRAINT `sells_ibfk_2` FOREIGN KEY (`saleNumber`) REFERENCES `sale` (`saleNumber`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sells`
--

LOCK TABLES `sells` WRITE;
/*!40000 ALTER TABLE `sells` DISABLE KEYS */;
INSERT INTO `sells` VALUES ('alberg632@gmail.com',1,0,0),('bobjones@gmail.com',4,0,0),('bobjones@gmail.com',9,0,0),('hollowrice@yahoo.com',3,0,0),('jjackson@gmail.com',5,0,0),('jjackson@gmail.com',8,0,0),('theridge@gmail.com',6,0,0);
/*!40000 ALTER TABLE `sells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `won`
--

DROP TABLE IF EXISTS `won`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `won` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `saleNumber` int NOT NULL DEFAULT '0',
  `bidPrice` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`email`,`saleNumber`),
  KEY `email` (`email`),
  KEY `saleNumber` (`saleNumber`),
  CONSTRAINT `won_ibfk_1` FOREIGN KEY (`email`) REFERENCES `customer` (`email`) ON DELETE CASCADE,
  CONSTRAINT `won_ibfk_2` FOREIGN KEY (`saleNumber`) REFERENCES `sale` (`saleNumber`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `won`
--

LOCK TABLES `won` WRITE;
/*!40000 ALTER TABLE `won` DISABLE KEYS */;
INSERT INTO `won` VALUES ('alberg632@gmail.com',3,72000),('alberg632@gmail.com',5,7000),('bobjones@gmail.com',6,69400),('theridge@gmail.com',4,1200);
/*!40000 ALTER TABLE `won` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-08 16:46:24
