CREATE DATABASE IF NOT EXISTS `AuctionSiteScheme` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `AuctionSiteScheme`;

-- DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`(
	`email` varchar(50) NOT NULL DEFAULT '',
    `username` varchar(50) NOT NULL DEFAULT '',
    `dob` date DEFAULT NULL,
    PRIMARY KEY (`email`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
	`firstName` varchar(50) NOT NULL DEFAULT '',
    `lastName` varchar(50) NOT NULL DEFAULT '',
    `employeeID` int NOT NULL DEFAULT 0,
    PRIMARY KEY(`employeeID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
	`username` varchar(50) NOT NULL DEFAULT '',
    `password` varchar(50) DEFAULT NULL,
    PRIMARY KEY (`username`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;





-- DROP TABLE IF EXISTS `sale`;
CREATE TABLE `sale` (
	`manufacture year` int DEFAULT NULL,
    `price` int DEFAULT NULL,
    `saleNumber` int NOT NULL DEFAULT 0,
    `trim` varchar(20) NOT NULL DEFAULT '',
    `subcategory` varchar(10) NOT NULL DEFAULT '',
    `color` varchar(20) DEFAULT NULL,
    `end` datetime DEFAULT NULL,
    PRIMARY KEY(`saleNumber`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;



-- DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
	`questionID` int NOT NULL DEFAULT 0,
    `topic` varchar(100) DEFAULT NULL,
    `status` varchar(10) DEFAULT NULL,
    PRIMARY KEY (`questionID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;






