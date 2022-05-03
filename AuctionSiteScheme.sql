CREATE DATABASE IF NOT EXISTS `AuctionSiteScheme` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `AuctionSiteScheme`;

-- Customer Table 
CREATE TABLE IF NOT EXISTS `customer`(
	`email` varchar(50) NOT NULL DEFAULT '',
    `firstName` varchar(50) NOT NULL DEFAULT '',
    `lastName` varchar(50) NOT NULL DEFAULT '',
    `dob` date DEFAULT NULL,
    PRIMARY KEY (`email`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Employee Table
CREATE TABLE IF NOT EXISTS `employee` (
	`employeeID` int NOT NULL AUTO_INCREMENT,
	`firstName` varchar(50) NOT NULL DEFAULT '',
    `lastName` varchar(50) NOT NULL DEFAULT '',
    PRIMARY KEY(`employeeID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Admin staff table 
CREATE TABLE IF NOT EXISTS `adminStaff` (
	`employeeID` int DEFAULT 0,
	`firstName` varchar(50) DEFAULT NULL,
	`lastName` varchar(50) DEFAULT NULL,
    PRIMARY KEY (`employeeID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Account Table
CREATE TABLE IF NOT EXISTS `account`(
	`username` varchar(50) NOT NULL DEFAULT '',
    `password` varchar(50) DEFAULT NULL,
    PRIMARY KEY (`username`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table for Customer Creating Account
CREATE TABLE IF NOT EXISTS `customerHas`(
	`email` varchar(50) NOT NULL DEFAULT '',
    `username` varchar(50) NOT NULL DEFAULT '',
    Primary Key(`email`,`username`),
    INDEX(`email`),
    INDEX(`username`),
    FOREIGN KEY (`email`) REFERENCES customer(`email`) ON DELETE CASCADE,
    FOREIGN KEY (`username`) REFERENCES account(`username`) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `employeeHas` (
	`employeeID` int NOT NULL DEFAULT 0,
    `username` varchar(50) NOT NULL DEFAULT '',
	Primary Key(`employeeID`,`username`),
    INDEX(`employeeID`),
    INDEX(`username`),
    FOREIGN KEY (`employeeID`) REFERENCES employee(`employeeID`) ON DELETE CASCADE,
    FOREIGN KEY (`username`) REFERENCES account(`username`) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `adminHas` (
	`employeeID` int NOT NULL DEFAULT 0,
    `username` varchar(50) NOT NULL DEFAULT '',
	Primary Key(`employeeID`,`username`),
    INDEX(`employeeID`),
    INDEX(`username`),
    FOREIGN KEY (`employeeID`) REFERENCES adminStaff(`employeeID`) ON DELETE CASCADE,
    FOREIGN KEY (`username`) REFERENCES account(`username`) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;




CREATE TABLE IF NOT EXISTS `sale`(
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
    `validBidIncr` float DEFAULT 0,
    `minimumPrice` float DEFAULT 0,
    `status` int DEFAULT 0,
    PRIMARY KEY(`saleNumber`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `bids` (
	`email` varchar(50) NOT NULL DEFAULT '',
    `saleNumber` int NOT NULL DEFAULT 0,
    `currentBid` float DEFAULT 0,
    `maxBid` float DEFAULT 0,
    PRIMARY KEY(`email`,`saleNumber`),
    INDEX(`email`),
    INDEX(`saleNumber`),
    FOREIGN KEY (`email`) REFERENCES customer(`email`) ON DELETE CASCADE,
    FOREIGN KEY (`saleNumber`) REFERENCES sale(`saleNumber`) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `bidsHistory` (
	`email` varchar(50) NOT NULL DEFAULT '',
    `saleNumber` int NOT NULL DEFAULT 0,
    `currentBid` float DEFAULT 0,
    `bidDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`email`,`saleNumber`,`bidDateTime`),
    INDEX(`email`),
    INDEX(`saleNumber`),
    FOREIGN KEY (`email`) REFERENCES customer(`email`) ON DELETE CASCADE,
    FOREIGN KEY (`saleNumber`) REFERENCES sale(`saleNumber`) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `sells` (
	`email` varchar(50) NOT NULL DEFAULT '',
    `saleNumber` int NOT NULL DEFAULT 0,
    `saleStatus` int NOT NULL DEFAULT 0,
    `soldPrice` float NOT NULL DEFAULT 0,
    INDEX(`email`),
    INDEX(`saleNumber`),
    PRIMARY KEY(`email`,`saleNumber`),
    FOREIGN KEY (`email`) REFERENCES customer(`email`) ON DELETE CASCADE,
    FOREIGN KEY (`saleNumber`) REFERENCES sale(`saleNumber`) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `won` (
	`email` varchar(50) NOT NULL DEFAULT '',
    `saleNumber` int NOT NULL DEFAULT 0,
    `bidPrice` float NOT NULL DEFAULT 0,
    INDEX(`email`),
    INDEX(`saleNumber`),
    PRIMARY KEY(`email`,`saleNumber`),
    FOREIGN KEY (`email`) REFERENCES customer(`email`) ON DELETE CASCADE,
    FOREIGN KEY (`saleNumber`) REFERENCES sale(`saleNumber`) ON DELETE CASCADE 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;





-- DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
	`questionID` int NOT NULL AUTO_INCREMENT,
    `topic` varchar(100) DEFAULT NULL,
    `userResponse` varchar(1000) DEFAULT NULL,
    `employeeResponse` varchar(1000) DEFAULT NULL,
    `status` int DEFAULT 0,
    PRIMARY KEY (`questionID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `faqs`(
	`faqID` int NOT NULL AUTO_INCREMENT,
    `topic` varchar(100) DEFAULT NULL,
    `content` varchar(1000) DEFAULT NULL,
    `response` varchar(1000) DEFAULT NULL,
    PRIMARY KEY (`faqID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `asksQuestion`(
	`email` varchar(50) NOT NULL DEFAULT '',
    `questionID` int NOT NULL DEFAULT 0,
	PRIMARY KEY(`email`,`questionID`),
    INDEX(`email`),
    INDEX(`questionID`),
    FOREIGN KEY (`email`) REFERENCES customer(`email`) ON DELETE CASCADE,
    FOREIGN KEY (`questionID`) REFERENCES questions(`questionID`) ON DELETE CASCADE    
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `answersQuestion`(
	`employeeID` int DEFAULT NULL,
    `questionID` int DEFAULT NULL,
    INDEX(`employeeID`),
    INDEX(`questionID`),
    FOREIGN KEY (`employeeID`) REFERENCES employee(`employeeID`) ON DELETE CASCADE,
    FOREIGN KEY (`questionID`) REFERENCES questions(`questionID`) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- CREATE ALERTS 
DROP TABLE customerHasAlerts;
DROP TABLE alerts;

CREATE TABLE IF NOT EXISTS `alerts`(
	`alertID` int NOT NULL AUTO_INCREMENT,
    `alertContent` varchar(1000) DEFAULT NULL,
    `carName` varchar(100) DEFAULT NULL,
    `vehicleType` varchar(50) DEFAULT NULL,
    `manufacturer` varchar(50) DEFAULT NULL,
    `year` varchar(50) DEFAULT NULL,
    `color` varchar(50) DEFAULT NULL,
    `mileage` varchar(50) DEFAULT NULL,
    `trim` varchar(50) DEFAULT NULL,
    `showAlert` int DEFAULT 0,
    `setBy` int DEFAULT 0,
    `acknowledged` int DEFAULT 0,
	PRIMARY KEY(`alertId`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `customerHasAlerts`(
	`alertID` int NOT NULL DEFAULT 0,
    `email` varchar(50) NOT NULL DEFAULT '',
    INDEX(`alertID`),
    INDEX(`email`),
    FOREIGN KEY (`alertID`) REFERENCES alerts(`alertID`) ON DELETE CASCADE,
    FOREIGN KEY (`email`) REFERENCES customer(`email`) ON DELETE CASCADE    
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- INSERT INTO account(username,password) VALUES("admin1","$336Admin1$");
-- INSERT INTO adminStaff(employeeID,firstName,lastName) VALUES(0,"Bob","Jones");
-- INSERT INTO adminHas(employeeID,username) VALUES(0,"admin1");


