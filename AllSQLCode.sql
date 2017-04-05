#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
#-------------------------Table initialization----------------------------
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Library
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Library` ;

-- -----------------------------------------------------
-- Schema Library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Library` DEFAULT CHARACTER SET utf8 ;
USE `Library` ;

-- -----------------------------------------------------
-- Table `Library`.`Libraries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Libraries` ;
CREATE TABLE IF NOT EXISTS `Library`.`Libraries` (
  `LibraryID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `StreetNumber` VARCHAR(45) NOT NULL,
  `ZipCode` DECIMAL(4,0) NOT NULL,
  `StreetName` VARCHAR(45) NOT NULL,
  `Capacity` INT NOT NULL,
  PRIMARY KEY (`LibraryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Publisher` ;
CREATE TABLE IF NOT EXISTS `Library`.`Publisher` (
  `PublisherID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `StreetNumber` VARCHAR(45) NOT NULL,
  `StreetName` VARCHAR(45) NOT NULL,
  `ZipCode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PublisherID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Books` ;
CREATE TABLE IF NOT EXISTS `Library`.`Books` (
  `ISBN` DECIMAL(13,0) NOT NULL,
  `PublisherID` INT NOT NULL,
  `DatePublish` DATE NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  `LiteratureCategory` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ISBN`),
  INDEX `fk_Books_Publisher1_idx` (`PublisherID` ASC),
  CONSTRAINT `fk_Books_Publisher1`
    FOREIGN KEY (`PublisherID`)
    REFERENCES `Library`.`Publisher` (`PublisherID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Article` ;
CREATE TABLE IF NOT EXISTS `Library`.`Article` (
  `ArticleID` INT NOT NULL,
  `DateBought` DATE NOT NULL,
  `PlacementID` INT NOT NULL,
  `BelongsToID` INT NOT NULL,
  `ISBN` DECIMAL(13,0) NOT NULL,
  PRIMARY KEY (`ArticleID`),
  INDEX `fk_Article_Libraries_idx` (`PlacementID` ASC),
  INDEX `fk_Article_Libraries1_idx` (`BelongsToID` ASC),
  INDEX `fk_Article_Books1_idx` (`ISBN` ASC),
  CONSTRAINT `fk_Article_Libraries`
    FOREIGN KEY (`PlacementID`)
    REFERENCES `Library`.`Libraries` (`LibraryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Article_Libraries1`
    FOREIGN KEY (`BelongsToID`)
    REFERENCES `Library`.`Libraries` (`LibraryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Article_Books1`
    FOREIGN KEY (`ISBN`)
    REFERENCES `Library`.`Books` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Librarian`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Librarian` ;
CREATE TABLE IF NOT EXISTS `Library`.`Librarian` (
  `LibrarianID` INT NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `MiddleName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `StreetNumber` VARCHAR(45) NOT NULL,
  `StreetName` VARCHAR(45) NOT NULL,
  `ZipCode` VARCHAR(45) NOT NULL,
  `DateOfBirth` DATE NOT NULL,
  `Salary` INT NULL,
  `LibraryID` INT NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NULL,
  PRIMARY KEY (`LibrarianID`),
  INDEX `fk_Librarian_Libraries1_idx` (`LibraryID` ASC),
  CONSTRAINT `fk_Librarian_Libraries1`
    FOREIGN KEY (`LibraryID`)
    REFERENCES `Library`.`Libraries` (`LibraryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Loaners`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Loaners` ;
CREATE TABLE IF NOT EXISTS `Library`.`Loaners` (
  `LoanerID` INT NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `MiddleName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `StreetName` VARCHAR(45) NOT NULL,
  `ZipCode` VARCHAR(45) NOT NULL,
  `StreetNumber` VARCHAR(45) NOT NULL,
  `DateOfBirth` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`LoanerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Authers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Authers` ;
CREATE TABLE IF NOT EXISTS `Library`.`Authers` (
  `AuthersID` INT NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `MiddleName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `DateOfBirth` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AuthersID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`WrittenBy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`WrittenBy` ;
CREATE TABLE IF NOT EXISTS `Library`.`WrittenBy` (
  `AuthersID` INT NOT NULL,
  `ISBN` DECIMAL(13,0) NOT NULL,
  PRIMARY KEY (`AuthersID`, `ISBN`),
  INDEX `fk_Authers_has_Books_Books1_idx` (`ISBN` ASC),
  INDEX `fk_Authers_has_Books_Authers1_idx` (`AuthersID` ASC),
  CONSTRAINT `fk_Authers_has_Books_Authers1`
    FOREIGN KEY (`AuthersID`)
    REFERENCES `Library`.`Authers` (`AuthersID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Authers_has_Books_Books1`
    FOREIGN KEY (`ISBN`)
    REFERENCES `Library`.`Books` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`RegisteredAt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`RegisteredAt` ;
CREATE TABLE IF NOT EXISTS `Library`.`RegisteredAt` (
  `LibraryID` INT NOT NULL,
  `LoanerID` INT NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`LibraryID`, `LoanerID`),
  INDEX `fk_Libraries_has_Loaners_Loaners1_idx` (`LoanerID` ASC),
  INDEX `fk_Libraries_has_Loaners_Libraries1_idx` (`LibraryID` ASC),
  CONSTRAINT `fk_Libraries_has_Loaners_Libraries1`
    FOREIGN KEY (`LibraryID`)
    REFERENCES `Library`.`Libraries` (`LibraryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Libraries_has_Loaners_Loaners1`
    FOREIGN KEY (`LoanerID`)
    REFERENCES `Library`.`Loaners` (`LoanerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Loans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Loans` ;
CREATE TABLE IF NOT EXISTS `Library`.`Loans` (
  `LoanID` INT NOT NULL,
  `LoanerID` INT NOT NULL,
  `LibrarianID` INT NOT NULL,
  `PeriodStart` DATE NOT NULL,
  `PeriodEnd` DATE NOT NULL,
  INDEX `fk_Loans_Loaners1_idx` (`LoanerID` ASC),
  INDEX `fk_Loans_Librarian1_idx` (`LibrarianID` ASC),
  PRIMARY KEY (`LoanID`),
  CONSTRAINT `fk_Loans_Loaners1`
    FOREIGN KEY (`LoanerID`)
    REFERENCES `Library`.`Loaners` (`LoanerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Loans_Librarian1`
    FOREIGN KEY (`LibrarianID`)
    REFERENCES `Library`.`Librarian` (`LibrarianID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`LibraryOpeningHours`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`LibraryOpeningHours` ;
CREATE TABLE IF NOT EXISTS `Library`.`LibraryOpeningHours` (
  `OpeningTime` ENUM('Monday', 'Tuesday', 'Wedensday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
  `LibraryID` INT NOT NULL,
  `TimeStart` TIME(0) NOT NULL,
  `TimeEnd` TIME(0) NOT NULL,
  PRIMARY KEY (`LibraryID`, `OpeningTime`),
  INDEX `fk_LibraryOpeningHours_Libraries1_idx` (`LibraryID` ASC),
  CONSTRAINT `fk_LibraryOpeningHours_Libraries1`
    FOREIGN KEY (`LibraryID`)
    REFERENCES `Library`.`Libraries` (`LibraryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`PhoneNumbers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`PhoneNumbers` ;
CREATE TABLE IF NOT EXISTS `Library`.`PhoneNumbers` (
  `PhoneNumbers` DECIMAL(8,0) NOT NULL,
  `PublisherID` INT NOT NULL,
  INDEX `fk_PhoneNumbers_Publisher1_idx` (`PublisherID` ASC),
  PRIMARY KEY (`PublisherID`, `PhoneNumbers`),
  CONSTRAINT `fk_PhoneNumbers_Publisher1`
    FOREIGN KEY (`PublisherID`)
    REFERENCES `Library`.`Publisher` (`PublisherID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`ArticleToLoans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`ArticleToLoans` ;
CREATE TABLE IF NOT EXISTS `Library`.`ArticleToLoans` (
  `ArticleID` INT NOT NULL,
  `LoanID` INT NOT NULL,
  `ReturnedDate` DATE NULL,
  INDEX `fk_ArticleToLoans_Article1_idx` (`ArticleID` ASC),
  INDEX `fk_ArticleToLoans_Loans1_idx` (`LoanID` ASC),
  CONSTRAINT `fk_ArticleToLoans_Article1`
    FOREIGN KEY (`ArticleID`)
    REFERENCES `Library`.`Article` (`ArticleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ArticleToLoans_Loans1`
    FOREIGN KEY (`LoanID`)
    REFERENCES `Library`.`Loans` (`LoanID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;









#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
#--------------------------------SQL Views--------------------------------
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------


CREATE VIEW BookArticles AS
	SELECT *
	FROM Books NATURAL JOIN Article;

CREATE VIEW LoanedBookArticles AS
	SELECT *
	FROM (Loans  NATURAL JOIN ArticleToLoans) NATURAL JOIN BookArticles;

CREATE VIEW WrittenbyInfo AS
    SELECT Title, Price, PublisherID,
        (SELECT ISBN FROM WrittenBy 
         WHERE WrittenBy.ISBN = Books.ISBN) 
        AS ISBN,
        (SELECT AuthersID FROM WrittenBy 
         WHERE WrittenBy.ISBN = Books.ISBN) 
        AS AuthersID
FROM Books;

CREATE VIEW AutherInfo AS
    SELECT *,
    (SELECT FirstName FROM Authers WHERE 
    Authers.AuthersID=WrittenbyInfo.AuthersID) AS FirstName,
    (SELECT MiddleName FROM Authers WHERE 
    Authers.AuthersID=WrittenbyInfo.AuthersID) AS MiddleName,
    (SELECT LastName FROM Authers WHERE 
    Authers.AuthersID=WrittenbyInfo.AuthersID) AS LastName
    FROM WrittenbyInfo;















#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
#---------Functions, Procedures, Transaction, Triggers and Events---------
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------

Use Library;

#--Procedues--

#loan book to loaner
#CAN'T BE DONE YET BECAUSE LOAN NEEDS TO BE VERIFIED TO WORK CORRECTLY

#return article that a loaner loaned
#CAN'T BE DONE YET BECAUSE LOAN NEEDS TO BE VERIFIED TO WORK CORRECTLY


#(*) need more test data so this one can be tested
#get the articles that a loaner is currently borrowing
DROP PROCEDURE IF EXISTS GetCurrentBooksLoanedByLoaner;
DELIMITER //
CREATE PROCEDURE GetCurrentBooksLoanedByLoaner
(IN vLoanerID INT)
BEGIN
SELECT Books.* FROM ((Loans NATURAL JOIN ArticleToLoans) 
                            NATURAL JOIN Article) 
                            NATURAL JOIN Books
WHERE LoanerID = vLoanerID AND ReturnedDate IS NULL;
END; //
DELIMITER ;
#CALL GetCurrentBooksLoanedByLoaner(5004);

#get a loaners loaning history
DROP PROCEDURE IF EXISTS GetLoanerHistory;
DELIMITER //
CREATE PROCEDURE GetLoanerHistory
(IN vLoanerID INT)
BEGIN
select * from Loans
where LoanerID = vLoanerID;
END; //
DELIMITER ;
#call GetLoanerHistory(5001);

#(*) for some reason this one doesn't seem to work
#get all loans that a loaner returned on time
DROP PROCEDURE IF EXISTS GetLoanersArticlesReturnedOnTime;
DELIMITER //
CREATE PROCEDURE GetLoanersArticlesReturnedOnTime
(IN vLoanerID INT)
BEGIN
select Article.* from (ArticleToLoans natural join Loans) natural join Article
where LoanerID = vLoanerID AND DATE(ReturnedDate) is not NULL AND DATE(PeriodEnd) >= DATE(ReturnedDate);
END; //
DELIMITER ;
#call GetLoanersArticlesReturnedOnTime(5001);

#get all loans that a loaner returned too late
DROP PROCEDURE IF EXISTS GetLoanersArticlesReturnedTooLate;
DELIMITER //
CREATE PROCEDURE GetLoanersArticlesReturnedTooLate
(IN vLoanerID INT)
BEGIN
SELECT Article.* FROM (ArticleToLoans NATURAL JOIN Loans) 
                                      NATURAL JOIN Article
WHERE LoanerID = vLoanerID AND 
      ((DATE(ReturnedDate) IS NULL AND 
        DATE(PeriodEnd) > CURDATE()) OR 
       (DATE(ReturnedDate) IS NOT NULL AND 
        DATE(PeriodEnd) < DATE(ReturnedDate)));
END; //
DELIMITER ;
#CALL GetLoanersArticlesReturnedTooLate(5002);

#get all articles that a librarian is currently resposible for
DROP PROCEDURE IF EXISTS GetLibrarianArticlesResponsibleFor;
DELIMITER //
CREATE PROCEDURE GetLibrarianArticlesResponsibleFor
(IN vLibrarianID INT)
BEGIN
select Article.* from (ArticleToLoans natural join Loans) natural join Article
where LibrarianID = vLibrarianID AND ReturnedDate is null;
END; //
DELIMITER ;
#call GetLibrarianArticlesResponsibleFor(4003);

#get all articles a librarian has loaned out
DROP PROCEDURE IF EXISTS GetLibrarianLoanedOutArticlesHistory;
DELIMITER //
CREATE PROCEDURE GetLibrarianLoanedOutArticlesHistory
(IN vLibrarianID INT)
BEGIN
select Article.* from (ArticleToLoans natural join Loans) natural join Article
where LibrarianID = vLibrarianID;
END; //
DELIMITER ;
#call GetLibrarianLoanedOutArticlesHistory(4003);

#get a librarys books
DROP PROCEDURE IF EXISTS GetLibraryBooks;
DELIMITER //
CREATE PROCEDURE GetLibraryBooks
(IN vLibraryID INT)
BEGIN
#(*) filter selected columns so they make more sense
select * from Article
where BelongsToID = vLibraryID;
END; //
DELIMITER ;
#call GetLibraryBooks(1001);

#get librarians that work for a specific library
DROP PROCEDURE IF EXISTS GetLibrariansWorkingForLibrary;
DELIMITER //
CREATE PROCEDURE GetLibrariansWorkingForLibrary
(IN vLibraryID INT)
BEGIN
select * from Librarian
where LibraryID = vLibraryID;
END; //
DELIMITER ;
#call GetLibrariansWorkingForLibrary(1001);

#get all loaners that currently loan an article from that library
DROP PROCEDURE IF EXISTS GetLibrarysCurrentlyLoanedOutArticles;
DELIMITER //
CREATE PROCEDURE GetLibrarysCurrentlyLoanedOutArticles
(IN vLibraryID INT)
BEGIN
select Article.* from (ArticleToLoans natural join Loans) natural join Article
where BelongsToID = vLibraryID AND ReturnedDate is null;
END; //
DELIMITER ;
#call GetLibrarysCurrentlyLoanedOutArticles(1002);

#procedure to check if article is already loaned
DROP PROCEDURE IF EXISTS articleTestDate;
DELIMITER //
CREATE PROCEDURE articleTestDate(vArticle INT)
BEGIN
DECLARE article_loaned VARCHAR(15);
DECLARE counter INT;
DECLARE counterArt INT;

(SELECT COUNT(*) INTO counterArt FROM article 
WHERE article.ArticleID = vArticle);

(SELECT COUNT(*) INTO counter FROM articletoloans 
WHERE (ArticleToLoans.ArticleID = vArticle AND 
       ArticleToLoans.ReturnedDate IS NULL));
       
IF (counter = 0 AND counterArt = 1) THEN 
    SET article_loaned = 'Avaiable';
ELSEIF (counter = 1 AND counterArt = 1) THEN 
    SET article_loaned = 'Loaned out';
ELSE 
    SET article_loaned = 'Invalid article';
END IF;
SELECT article_loaned;
end;//
DELIMITER ;



#--transactions--
#move article from one library to another
DROP PROCEDURE IF EXISTS ChangeArticleOwnerLibrary;
DELIMITER //
CREATE PROCEDURE ChangeArticleOwnerLibrary
(IN vArticleID INT ,IN vnewOwnerLibraryID INT)
BEGIN
DECLARE newLibraryID INT DEFAULT NULL;
START TRANSACTION;
UPDATE Article SET BelongsToID = vnewOwnerLibraryID 
               WHERE ArticleID = vArticleID;

#verify that the value changed
SET newLibraryID = (SELECT BelongsToID FROM Article 
                    WHERE ArticleID = vArticleID);
IF newLibraryID = vnewOwnerLibraryID THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF;
END; //
DELIMITER ;  
#CALL ChangeArticleOwnerLibrary(3130, 1001);

#move librarian from one library to another
DROP PROCEDURE IF EXISTS ChangeLibrarianWorkLibrary;
DELIMITER //
CREATE PROCEDURE ChangeLibrarianWorkLibrary
(IN vLibrarianID INT ,IN vnewOwnerLibraryID INT)
BEGIN
DECLARE newLibraryID INT DEFAULT NULL;
START TRANSACTION;
UPDATE Librarian SET LibraryID = vnewOwnerLibraryID WHERE LibrarianID = vLibrarianID;

#verify that the value changed
SET newLibraryID = (SELECT LibraryID FROM Librarian WHERE LibrarianID = vLibrarianID);
IF newLibraryID = vnewOwnerLibraryID THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF;
END; //
DELIMITER ;
#call ChangeLibrarianWorkLibrary(4001, 1001);

#add a book and article from an already existing publisher and auther to the library
DROP PROCEDURE IF EXISTS addBook;
DELIMITER //
CREATE procedure addBook(Visbn        DECIMAL(13,0),
                         VPublisherID INT, 
                         VDatePublish DATE,
                         VTitle       VARCHAR(45), 
                         VPrice       DECIMAL(6,2), 
                         VArticleID   INT, 
                         VDateBought  DATE, 
                         VPlacementID INT, 
                         VBelongsToID INT, 
                         VAuthersID   INT, 
                         Vcategory    VARCHAR(45))
BEGIN 
DECLARE ISBNtester DECIMAL(13,0);

START TRANSACTION;
INSERT INTO `Books` VALUES (Visbn,VPublisherID,VDatePublish,VTitle,VPrice,Vcategory);
INSERT INTO `Article`   VALUES (VArticleID,VDateBought,VPlacementID,VBelongsToID,Visbn);
INSERT INTO `Writtenby` VALUES (VAuthersID,Visbn);

SET ISBNtester = (SELECT ISBN FROM Books WHERE Books.ISBN=Visbn);
IF ISBNtester IS NULL OR ISBNtester != Visbn THEN
	rollback;
END IF;
SET ISBNtester = (SELECT ISBN FROM Article WHERE Article.ISBN=Visbn);
IF ISBNtester IS NULL OR ISBNtester != Visbn THEN
	rollback;
END IF;
SET ISBNtester = (SELECT ISBN FROM WrittenBy WHERE Writtenby.ISBN=Visbn);
IF ISBNtester IS NULL OR ISBNtester != Visbn THEN
	rollback;
END IF;
COMMIT;

END; //
DELIMITER ;


#--functions--
DROP FUNCTION IF EXISTS ConcatName;
DELIMITER //
CREATE FUNCTION ConcatName (vFirstName VARCHAR(45), vMiddleName VARCHAR(45), vLastName VARCHAR(45))
RETURNS VARCHAR(140)
BEGIN
RETURN CONCAT(COALESCE(vFirstName,''),' ',COALESCE(CONCAT(vMiddleName, ' '), ''),COALESCE(vLastName,''));
END; //
DELIMITER ;
#SELECT ConcatName(FirstName, MiddleName, LastName) FROM Loaners;



#--triggers--
#verify ISBN before inserting it
DROP TRIGGER IF EXISTS Books_Before_Insert;
DELIMITER //
CREATE TRIGGER Books_Before_Insert
BEFORE INSERT ON Books FOR EACH ROW
BEGIN
DECLARE ISBNString CHAR(13);
DECLARE d1  INT;
DECLARE d2  INT;
DECLARE d3  INT;
DECLARE d4  INT;
DECLARE d5  INT;
DECLARE d6  INT;
DECLARE d7  INT;
DECLARE d8  INT;
DECLARE d9  INT;
DECLARE d10 INT;
DECLARE d11 INT;
DECLARE d12 INT;
DECLARE d13 INT;
DECLARE ISBNSum INT;

IF New.ISBN IS NULL THEN SIGNAL SQLSTATE 'HY000'
	SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'ISBN can not be NULL';
END IF;

set ISBNString = CAST(New.ISBN AS CHAR);

IF CHAR_LENGTH(ISBNString) != 13 THEN SIGNAL SQLSTATE 'HY000'
	SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'Invalid ISBN';
END IF;

#get every digit in ISBN
SET d1  = CONVERT((SUBSTRING(ISBNString,  1, 1)), SIGNED INTEGER);
SET d2  = CONVERT((SUBSTRING(ISBNString,  2, 1)), SIGNED INTEGER);
SET d3  = CONVERT((SUBSTRING(ISBNString,  3, 1)), SIGNED INTEGER);
SET d4  = CONVERT((SUBSTRING(ISBNString,  4, 1)), SIGNED INTEGER);
SET d5  = CONVERT((SUBSTRING(ISBNString,  5, 1)), SIGNED INTEGER);
SET d6  = CONVERT((SUBSTRING(ISBNString,  6, 1)), SIGNED INTEGER);
SET d7  = CONVERT((SUBSTRING(ISBNString,  7, 1)), SIGNED INTEGER);
SET d8  = CONVERT((SUBSTRING(ISBNString,  8, 1)), SIGNED INTEGER);
SET d9  = CONVERT((SUBSTRING(ISBNString,  9, 1)), SIGNED INTEGER);
SET d10 = CONVERT((SUBSTRING(ISBNString, 10, 1)), SIGNED INTEGER);
SET d11 = CONVERT((SUBSTRING(ISBNString, 11, 1)), SIGNED INTEGER);
SET d12 = CONVERT((SUBSTRING(ISBNString, 12, 1)), SIGNED INTEGER);
SET d13 = CONVERT((SUBSTRING(ISBNString, 13, 1)), SIGNED INTEGER);

SET ISBNSum = d1 + 3 * d2 + d3 + 3 * d4 + d5 + 3 * d6 + d7 + 3 * d8 + d9 + 3 * d10 + d11 + 3 * d12 + d13;

IF MOD(ISBNSum, 10) <> 0 THEN SIGNAL SQLSTATE 'HY000'
	SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'Invalid ISBN';
END IF;
END; //
DELIMITER ;

#verify ReturnedDate
DROP TRIGGER IF EXISTS ArticleToLoans_Before_Update;
DELIMITER //
CREATE TRIGGER ArticleToLoans_Before_Update
BEFORE UPDATE ON ArticleToLoans FOR EACH ROW
BEGIN
DECLARE periodStart DATE;
SET periodStart = (select PeriodStart from ArticleToLoans natural join Loans
				   where LoanID = New.LoanID);
IF New.ReturnedDate < periodStart THEN SIGNAL SQLSTATE 'HY000'
	SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'The return date can not be before the book was loaned out';
END IF;
END; //
DELIMITER ;

#make sure article isn't already loaned out
DROP TRIGGER IF EXISTS ArticleToLoans_Before_Insert;
DELIMITER //
CREATE TRIGGER ArticleToLoans_Before_Insert
BEFORE INSERT ON ArticleToLoans FOR EACH ROW
BEGIN
DECLARE isAlreadyLoanedOut INT;
SET isAlreadyLoanedOut = (SELECT COUNT(*) FROM ArticleToLoans NATURAL JOIN Loans
						  WHERE New.ArticleID = ArticleID AND ReturnedDate IS NULL);
IF isAlreadyLoanedOut = 1 THEN SIGNAL SQLSTATE 'HY000'
	SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'This article is already loaned out';
END IF;
END; //
DELIMITER ;



#--Events--
DROP PROCEDURE IF EXISTS BackupLoans;
DELIMITER //
CREATE PROCEDURE BackupLoans()
BEGIN
DECLARE backupRowCount INT;
DECLARE loansRowCount INT;

START TRANSACTION;
#create backup table first
DROP TABLE IF EXISTS `Library`.`BackupLoans` ;
CREATE TABLE IF NOT EXISTS `Library`.`BackupLoans` (
  `LoanID` INT NOT NULL,
  `LoanerID` INT NOT NULL,
  `LibrarianID` INT NOT NULL,
  `PeriodStart` DATE NOT NULL,
  `PeriodEnd` DATE NOT NULL,
  PRIMARY KEY (`LoanID`))
ENGINE = InnoDB;

#then copy to backup
INSERT INTO BackupLoans SELECT * FROM Loans;

SET backupRowCount = (SELECT COUNT(*) FROM BackupLoans);
SET loansRowCount = (SELECT COUNT(*) FROM Loans);

IF backupRowCount = loansRowCount THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF;
END; //
DELIMITER ;
#CALL BackupLoans();

#make update of loans table
DROP EVENT IF EXISTS UpdateLoansBackup;
CREATE EVENT UpdateLoansBackup
ON SCHEDULE EVERY 1 DAY
DO CALL BackupLoans();

SET GLOBAL event_scheduler = 1; 







#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
#------------------------------Test data----------------------------------
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------

/* Test data for libraries*/
#id starts at 1000
insert into `Libraries` values 
(1001,'Egedal Bibliotek','34H',3850,'Træhusevej',40000),
(1002,'Birkerød Bibliotek','12J',3450,'Træhusevej',12000),
(1003,'Thisted Bibliotek','42G',7000,'Pipedrejervej',20000);


/* Test data for publisher*/
#id starts at 2000
insert into `Publisher` values 
(2001,'Matematik Forlaget','78Q','Matricevej',9999),
(2002,'Computer Forlaget','13A','Databasevej',5555),
(2003,'Awesome Forlaget','Rytterkær','139',2765);

/*Test data for Books */  
insert into `Books` values 
(9781861978769,2001,'2003-07-07','Crazy Horse and Custer',000300.00,'Faglitteratur'),
(9783161484100,2002,'1989-07-07','Solitons in Optical fibers',000700.00,'Faglitteratur'),
(9780125041904,2003,'2015-03-02','Livet som Jesper',000666.00,'Awesomelitteratur');


/*Test data for Article */
#id starts at 3000
insert into `Article` values 
(3001,'2004-09-12',1001,1001,9781861978769),
(3022,'1995-01-03',1003,1001,9783161484100),
(3072,'2015-01-03',1002,1001,9780125041904),
(3002,'2004-09-18',1002,1002,9781861978769),
(3003,'1995-01-09',1002,1002,9783161484100),
(3004,'2015-02-23',1002,1002,9780125041904),
(3005,'2006-02-27',1003,1003,9781861978769),
(3006,'1999-02-04',1003,1003,9783161484100),
(3007,'2016-04-25',1003,1003,9780125041904),
(3008,'2004-09-18',1002,1003,9781861978769),
(3009,'1995-01-09',1003,1002,9783161484100),
(3010,'2015-02-23',1001,1001,9780125041904);

/*Test data for Librarian */
#id starts at 4000
insert into `Librarian` values 
(4001,'Beate','Stenstrøm','Habberbug','S69','Edderkoppedal',3850,'1970-08-12',26000,1001,'1995-12-12',null),
(4002,'Per',null,'Jensen','84V','Saturnvej',3450,'1980-11-01',27000,1002,'2005-12-12',null),
(4003,'Anders','Samsø','Birch','139','Rytterkær',7000,'1996-03-30',30000,1003,'2016-01-05',null);

/*Test data for Loaners */
#id starts at 5000
insert into `Loaners` values
(5001,'Terkel'   , 'Stenstrøm','Hansen'    ,'Edderkoppedal'     ,3850,'S69','2000-02-10'),
(5002,'Susanne'  , null       ,'Jensen'    ,'Saturnvej'         ,3450,'84V','1981-07-13'),
(5003,'Legolas'  , 'Den'      ,'Mægtige'   ,'Rytterkær'         ,7000,'139','2018-03-13'),
(5004,'Lars'     , null       ,'Larsen'    , 'Kæbhøjvej'        ,9001,'-3V','1013-06-21'),
(5005,'Legolas'  , null       ,'Erobreren' ,'Storkevej'         ,4111,'259','2018-03-31'),
(5006,'Normie'   , null       ,'Norman'    ,'Lolvej'            ,6624,'479','2018-06-12'),
(5007,'Peter'    , null       ,'Pip'       ,'Sauronvej'         ,8266,'539','2018-05-12'),
(5008,'Jack'     , 'The'      ,'Ripper'    ,'Lortevej'          ,0685,'799','2018-07-31'),
(5009,'John'     , null       ,'Olesen'    ,'Ministervej'       ,2843,'21V','2018-02-01'),
(5010,'Barry'    , null       ,'Allen'     ,'Trollvej'          ,1377,'769','2018-01-02'),
(5011,'Kasper'   , 'Houdini'  ,'Lassesen'  ,'Bordvej'           ,5199,'42S','2018-08-04'),
(5012,'Frederik' , null       ,'Knast'     ,'Pricevej'          ,5706,'053','2018-04-27'),
(5013,'Jack'     , null       ,'Sparrow'   ,'Chipsvej'          ,2985,'148','2018-03-19'),
(5014,'Covariant', null       ,'Vector'    ,'Banandistriktet'   ,1854,'494','2018-08-17'),
(5015,'Angus'    , 'mc'       ,'five'      ,'Tortila bugten'    ,6625,'33V','2018-02-17');

/*Test data for Authers */
#id starts at 6000
insert into `Authers` values 
(6001,'Karsten' ,  null   , 'Schmidt' ,'1940-07-26'),
(6002,'Flemming',  null   , 'Schmidt' ,'1960-05-13'),
(6003,'Jesper'  , 'Birch' , 'Samsø'   ,'1996-03-30'),
(6004,'J.'      , 'R. R.' , 'Tolkien' ,'3996-03-30'),
(6005,'J'       , 'K'     , 'Rowlings','0996-03-30');

/*Test data for WrittenBy */
insert into `WrittenBy` values 
(6001,9781861978769),
(6002,9783161484100),
(6003,9780125041904);

/*Test data for RegisteredAt */
insert into `RegisteredAt` values 
(1001,5001,'2007-04-17'),
(1002,5002,'2000-01-19'),
(1003,5003,'2025-07-13'),
(1001,5004,'2019-06-21'),
(1003,5005,'2025-07-31'),
(1002,5006,'2020-09-12'),
(1001,5007,'2021-10-11'),
(1003,5008,'2022-03-04'),
(1002,5009,'2027-05-17'),
(1001,5010,'2029-12-13'),
(1002,5011,'2030-08-21'),
(1003,5012,'2030-03-12'),
(1003,5013,'2029-04-14'),
(1001,5014,'2028-09-09'),
(1002,5015,'2029-10-10');


/*Test data for Loans */
#id starts at 7000

insert into `Loans` values 
(7001,5001,4001,'2017-02-12','2017-02-26'),
(7002,5002,4002,'2016-08-01','2016-08-15'),
(7004,5001,4002,'2017-02-01','2017-06-01'),
(7003,5003,4003,'2025-09-14','2025-09-28');


/*Test data for ArticleToLoans */

insert into `ArticleToLoans` values 
(3001,7001,'2017-02-25'),
(3022,7001,'2017-02-25'),
(3022,7002,'2016-08-27'),
(3001,7002,'2016-08-30'),
(3001,7004,NULL),
(3072,7003,'2025-09-26');


/*Test data for LibraryOpeningHours */
insert into `LibraryOpeningHours` values 
('Monday'   ,1001,'08:00:00','16:00:00'),
('Tuesday'  ,1001,'08:00:00','16:00:00'),
('Wedensday',1001,'08:00:00','16:00:00'),
('Thursday' ,1001,'08:00:00','16:00:00'),
('Friday'   ,1001,'08:00:00','16:00:00'),
('Monday'   ,1002,'08:00:00','16:00:00'),
('Tuesday'  ,1002,'08:00:00','16:00:00'),
('Wedensday',1002,'08:00:00','16:00:00'),
('Thursday' ,1002,'08:00:00','17:00:00'),
('Friday'   ,1002,'08:00:00','16:00:00'),
('Monday'   ,1003,'08:00:00','16:00:00'),
('Tuesday'  ,1003,'08:00:00','18:00:00'),
('Wedensday',1003,'08:00:00','16:00:00'),
('Thursday' ,1003,'08:00:00','16:00:00'),
('Friday'   ,1003,'08:00:00','16:00:00');

/*Test data for PhoneNumbers */
insert into `PhoneNumbers` values 
(11223344,2001),
(13223344,2001),
(98345455,2002),
(12434555,2003);


drop procedure if exists addBook;
DELIMITER //
CREATE procedure addBook(Visbn        DECIMAL(13,0),
                         VPublisherID INT, 
                         VDatePublish DATE,
                         VTitle       VARCHAR(45), 
                         VPrice       DECIMAL(6,2), 
                         VArticleID   INT, 
                         VDateBought  DATE, 
                         VPlacementID INT, 
                         VBelongsToID INT, 
                         VAuthersID   INT, 
                         Vcategory    VARCHAR(45))
BEGIN 
DECLARE ISBNtester DECIMAL(13,0);

START TRANSACTION;
INSERT INTO `books`     VALUES (Visbn,
                                VPublisherID,
                                VDatePublish,
                                VTitle,
                                VPrice, 
                                Vcategory);
INSERT INTO `article`   VALUES (VArticleID,
                                VDateBought,
                                VPlacementID,
                                VBelongsToID,
                                Visbn);
INSERT INTO `writtenby` VALUES (VAuthersID,
                                Visbn);

SET ISBNtester = (SELECT ISBN FROM Books 
                  WHERE books.ISBN=Visbn);
IF ISBNtester IS NULL OR ISBNtester != Visbn THEN
	rollback;
END IF;
SET ISBNtester = (SELECT ISBN FROM Article 
                  WHERE article.ISBN=Visbn);
IF ISBNtester IS NULL OR ISBNtester != Visbn THEN
	rollback;
END IF;
SET ISBNtester = (SELECT ISBN FROM WrittenBy 
                  WHERE writtenby.ISBN=Visbn);
IF ISBNtester IS NULL OR ISBNtester != Visbn THEN
	rollback;
END IF;
COMMIT;

END; //
DELIMITER ;


#create Books and articles for all things J.R.R. Tolkien
call addBook(9780547928210, 2003, '2012-11-6' , 'The Fellowship of the Ring'               , 2.50, 3100, '2012-11-6' , 1001, 1001, 6004, 'Skønlitteratur');
call addBook(9780547928203, 2003, '2005-2-6'  , 'The Two Towers'                           ,   50, 3101, '2005-2-6'  , 1001, 1001, 6004, 'Skønlitteratur');
call addBook(9780547928197, 2003, '2017-11-6' , 'The Return of the King'                   , 1337, 3102, '2017-11-6' , 1001, 1001, 6004, 'Skønlitteratur');
call addBook(9780544338012, 2003, '2014-8-7'  , 'The Silmarillion'                         ,   42, 3103, '2014-8-7'  , 1001, 1001, 6004, 'Skønlitteratur');
call addBook(9780547928227, 2003, '2012-10-18', 'The Hobbit'                               ,  420, 3104, '2012-10-18', 1001, 1001, 6004, 'Skønlitteratur');
#and harry potter
call addBook(9780439708180, 2003, '1999-9-8'  , 'Harry Potter and the Sorcerer\'s Stone'   ,   23, 3105, '1999-9-8'  , 1002, 1002, 6005, 'Skønlitteratur');
call addBook(9780439064873, 2003, '2000-6-15' , 'Harry Potter And The Chamber Of Secrets'  ,   53, 3106, '2000-6-15' , 1002, 1002, 6005, 'Skønlitteratur');
call addBook(9780439136365, 2003, '2001-9-11' , 'Harry Potter and the Prisoner of Azkaban' ,   13, 3107, '2001-9-11' , 1002, 1002, 6005, 'Skønlitteratur');
call addBook(9780439139601, 2003, '2002-5-30' , 'Harry Potter And The Goblet Of Fire'      ,   74, 3108, '2002-5-30' , 1002, 1002, 6005, 'Skønlitteratur');
call addBook(9780439358071, 2003, '2004-6-10' , 'Harry Potter And The Order Of The Phoenix',   24, 3109, '2004-6-10' , 1002, 1002, 6005, 'Skønlitteratur');
call addBook(9780439785969, 2003, '2006-5-25' , 'Harry Potter and the Half-Blood Prince'   ,   46, 3110, '2006-5-25' , 1002, 1002, 6005, 'Skønlitteratur');
call addBook(9780545139700, 2003, '2009-5-7'  , 'Harry Potter and the Deathly Hallows'     ,   67, 3111, '2009-5-7'  , 1002, 1002, 6005, 'Skønlitteratur');

drop procedure if exists copyArticle;
delimiter //
create procedure copyArticle(In vNewArticleID INT, IN vArticleID INT)
begin 
declare vDateBought  DATE   default '1111-11-11';
declare vPlacementID INT    default 0;
declare vBelongsToID INT    default 0;
declare vISBN decimal(13,0) default 0;

(select DateBought  into vDateBought  from Article where ArticleID = vArticleID);
(select PlacementID into vPlacementID from Article where ArticleID = vArticleID);
(select BelongsToID into vBelongsToID from Article where ArticleID = vArticleID);
(select ISBN        into vISBN        from Article where ArticleID = vArticleID);

insert into Article values (vNewArticleID, vDateBought, vPlacementID, vBelongsToID, vISBN);
end; //
delimiter ;

call copyArticle(3130, 3100);
call copyArticle(3122, 3100);
call copyArticle(3114, 3100);

call copyArticle(3115, 3101);
call copyArticle(3116, 3101);
call copyArticle(3117, 3101);

call copyArticle(3118, 3102);
call copyArticle(3119, 3102);
call copyArticle(3120, 3102);

call copyArticle(3143, 3103);
call copyArticle(3113, 3103);
call copyArticle(3123, 3103);

call copyArticle(3124, 3104);
call copyArticle(3145, 3104);
call copyArticle(3126, 3104);

call copyArticle(3136, 3105);
call copyArticle(3128, 3105);
call copyArticle(3129, 3105);

call copyArticle(3112, 3106);
call copyArticle(3131, 3106);
call copyArticle(3132, 3106);

call copyArticle(3133, 3107);
call copyArticle(3134, 3107);
call copyArticle(3135, 3107);

call copyArticle(3127, 3108);
call copyArticle(3137, 3108);
call copyArticle(3138, 3108);

call copyArticle(3139, 3109);
call copyArticle(3140, 3109);
call copyArticle(3141, 3109);

call copyArticle(3142, 3110);
call copyArticle(3121, 3110);
call copyArticle(3144, 3110);

call copyArticle(3125, 3111);
call copyArticle(3146, 3111);
call copyArticle(3147, 3111);



drop procedure if exists addLoan;
delimiter //
create procedure addLoan(In vLoanID INT, IN vLoanerID INT, IN vLibrarianID INT, IN vStartDate DATE, IN vArticleID INT, IN vReturnedDate DATE)
begin 
insert into Loans values (vLoanID, vLoanerID, vLibrarianID, vStartDate, ADDDATE(vStartDate, 21));
insert into ArticleToLoans values (vArticleID, vLoanID, vReturnedDate);
end; //
delimiter ;

call addLoan(7034, 5001, 4001, '2012-12-30', 3100, '2013-01-12');
call addLoan(7005, 5001, 4001, '2011-08-16', 3101, null);
call addLoan(7006, 5001, 4001, '2012-02-27', 3102, '2012-03-15');
call addLoan(7007, 5003, 4001, '2012-10-23', 3103, '2012-11-04');
call addLoan(7008, 5004, 4001, '2012-07-19', 3131, null);
call addLoan(7009, 5005, 4001, '2013-04-15', 3105, '2013-04-24');
call addLoan(7010, 5006, 4001, '2017-02-06', 3106, '2017-02-20');
call addLoan(7011, 5006, 4001, '2012-12-23', 3107, '2012-12-27');
call addLoan(7012, 5006, 4002, '2015-09-29', 3133, null);
call addLoan(7013, 5007, 4002, '2013-12-30', 3109, '2014-01-06');
call addLoan(7014, 5007, 4002, '2013-11-01', 3110, '2013-11-13');
call addLoan(7015, 5008, 4002, '2015-01-03', 3111, '2015-01-06');
call addLoan(7016, 5008, 4002, '2019-01-12', 3135, null);
call addLoan(7017, 5008, 4002, '2019-03-10', 3113, '2019-03-20');
call addLoan(7018, 5008, 4002, '2023-04-07', 3114, '2023-04-30');
call addLoan(7019, 5008, 4002, '2003-06-22', 3137, '2003-06-30');
call addLoan(7020, 5009, 4002, '2012-07-28', 3138, '2012-08-05');
call addLoan(7021, 5011, 4002, '2002-01-19', 3117, '2002-01-25');
call addLoan(7022, 5011, 4003, '2002-09-02', 3118, null);
call addLoan(7023, 5011, 4003, '2004-09-17', 3140, null);
call addLoan(7024, 5011, 4003, '2002-01-25', 3120, '2002-02-07');
call addLoan(7025, 5012, 4003, '1969-02-21', 3121, '1969-03-04');
call addLoan(7026, 5012, 4003, '1989-02-16', 3143, '1989-03-17');
call addLoan(7027, 5014, 4003, '1959-03-20', 3123, '1959-03-29');
call addLoan(7028, 5014, 4003, '1968-05-06', 3124, '1968-05-17');
call addLoan(7029, 5015, 4003, '1971-03-11', 3147, null);
call addLoan(7030, 5015, 4003, '1977-08-28', 3126, '1977-09-09');
call addLoan(7031, 5015, 4003, '1979-11-27', 3127, null);
call addLoan(7032, 5015, 4003, '2015-12-12', 3128, '2015-12-25');
call addLoan(7033, 5015, 4003, '2016-10-13', 3129, '2016-10-18');










#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
#------------------------------SQL Queries--------------------------------
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------


USE Library;


#Is in the initilization file
#CREATE VIEW BookArticles AS
#	SELECT *
#	FROM Books NATURAL JOIN Article;

#CREATE VIEW LoanedBookArticles AS
#	SELECT *
#	FROM (Loans  NATURAL JOIN ArticleToLoans) NATURAL JOIN BookArticles;

#TotalLoanInformation:
SELECT *
FROM (LoanedBookArticles) NATURAL JOIN Loaners;

SELECT * FROM BookArticles;

#Check if article is already reserved;
SELECT PeriodStart, PeriodEnd
FROM LoanedBookArticles
WHERE (ReturnedDate IS NULL) AND
      (ArticleID = 3001);


#Find all the books lend out (at any time), by a user with user id 5003, 
#and gives the period for the loan. This sorted by the loans start date:
SELECT Title, PeriodStart, ReturnedDate
FROM LoanedBookArticles
WHERE LoanerID = 5001
ORDER BY PeriodStart;

#Find the count of the total number of books lend out by that user:
SELECT COUNT(*) AS NumberOfLendBooks
FROM LoanedBookArticles
WHERE LoanerID = 5003;

#Finds all the loaners that currently have a book that is overdue.
#Selects the Loaners name and ID, and the articles ID as well as the books title.
SELECT LoanerID, ConcatName(FirstName, MiddleName, LastName) as LoanerName, ArticleID, Title
FROM (LoanedBookArticles) NATURAL JOIN Loaners
WHERE PeriodEnd < CURDATE() AND ReturnedDate IS NULL
ORDER BY LoanerName;

#Find all articles that is lend out at a given date, with their title and who have lent it, 
#at a given date, here taken as'2017-02-25':
SELECT Title, ArticleID, LoanerID
FROM LoanedBookArticles
WHERE (ReturnedDate IS NOT NULL AND ('2017-02-20' BETWEEN PeriodStart AND ReturnedDate) ) OR  # In the case that it haven't been returned yet.
	  ((PeriodStart <= '2017-02-20' ) AND ReturnedDate IS NULL)
ORDER BY Title;

SELECT * FROM BookArticles;
#A variant of the query above: 
#Gives the count of the number of a given book that is lend out at a given date:
SELECT Title, ISBN, SUM(IF(('2017-02-20' BETWEEN PeriodStart and ReturnedDate) OR  # In the case that it haven't been returned yet.
					   ((PeriodStart <= '2017-02-20' ) AND ReturnedDate IS NULL),1,0)) AS NumberLendOut #All the books that have been lend out in the period
FROM BookArticles NATURAL LEFT OUTER JOIN (Loans NATURAL JOIN ArticleToLoans)
GROUP BY ISBN
ORDER BY Title;

#Gives a sorted list of loaners by there name, 
#and how many books they have loaned out throughout the years:
SELECT ConcatName(FirstName, MiddleName, LastName) AS LoanerName, count(*) AS LoanCount
FROM LoanedBookArticles NATURAL JOIN Loaners #For every loaner and loan, one gets the loaners loan of a book.
GROUP BY LoanerID #
ORDER BY LoanCount;

#Finds the loaners that have lent the largest number of books over the years:
SELECT LoanerName, LoanerID, LentCount
FROM (SELECT ConcatName(FirstName, MiddleName, LastName) AS LoanerName,
             LoanerID, COUNT(ArticleID) AS LentCount
      FROM   LoanedBookArticles NATURAL RIGHT OUTER JOIN Loaners 
      GROUP BY LoanerID) AS LoanerWithCount,
      
     (SELECT MAX(LentCount) AS MaxLent
      FROM (SELECT count(ArticleID) AS LentCount, LoanerID
            FROM LoanedBookArticles NATURAL RIGHT OUTER JOIN Loaners 
            GROUP BY LoanerID) AS numberOfLentBooks)
      AS MaxLentCount
      
WHERE LoanerWithCount.LentCount = MaxLentCount.MaxLent
ORDER BY LoanerName;

#Find all the books (name) written by an auther an auther with a given name, here "Jesper Samsø Birch"
#Also gives the auther name, in the case that there are more authers with the same name
SELECT ConcatName(Authers.FirstName, Authers.MiddleName, Authers.LastName) AS AutherName, AuthersID, Title 
FROM (Books NATURAL JOIN WrittenBy) NATURAL JOIN Authers
WHERE ConcatName(Authers.FirstName, Authers.MiddleName, Authers.LastName) = 'Jesper Samsø Birch'; 
	#Can't reference AutherName, as it is an alias.


#Find all the authers that a certain person has lend books from.
SELECT DISTINCT ConcatName(Authers.FirstName, Authers.MiddleName,  Authers.LastName) AS AutherName, AuthersID
FROM  (SELECT ISBN 
	   FROM Loaners NATURAL JOIN LoanedBookArticles
       WHERE ConcatName(Loaners.FirstName, Loaners.MiddleName,Loaners.LastName) =
       'Terkel Stenstrøm Hansen') AS readBooks, #Splitting it up, for better readability.
      (Books NATURAL JOIN WrittenBy) NATURAL JOIN Authers
WHERE (Books.ISBN = readBooks.ISBN);



#Finds all the books owned by AND not placed at a given library:
SELECT Title, ArticleID,Name, PlacementID
FROM Libraries JOIN BookArticles ON BelongsToID = LibraryID
WHERE LibraryID = 1001 AND PlacementID != 1001
ORDER BY Title;

SELECT * FROM Article;

#Division: Finding all the loaners that have lent all the works of a given author, here the one with autherID = 6001
SELECT LoanerID
FROM (SELECT ISBN FROM WrittenBy WHERE AuthersID = 6001) AS AuthersBooks,
	 (SELECT DISTINCT LoanerID,ISBN FROM LoanedBookArticles NATURAL JOIN WrittenBy) AS ReadBooksByAuthors
WHERE ReadBooksByAuthors.ISBN = AuthersBooks.ISBN
GROUP BY LoanerID 
HAVING COUNT(ReadBooksByAuthors.ISBN) = COUNT(AuthersBooks.ISBN);
       
       
SELECT FirstName, Title FROM Loaners NATURAL JOIN LoanedBookArticles ORDER BY FirstName;

#see how many articles each loaner have loaned
SELECT LoanerID, COUNT(LoanID) as loans FROM loans GROUP BY LoanerID;

#Now it's time for a salary raise of 5%, however on person Anders Samsø Birch earns too much
#when comparing the other librarians that has a lot more work experience, and should lose 25%
#Furthermore one would like to see the changes to the salaries of the librarians
select * from librarian;
update librarian set Salary=Salary*1.05 where Salary<28500;
update librarian set Salary=Salary*0.75 where Salary>=30000;
select * from librarian;

#we now wish to update the middle name of Flemming Schimidt as he got married with fru Hansen
select MiddleName, FirstName from Authers where FirstName='Flemming';
update Authers set MiddleName='Hansen' where FirstName='Flemming';
select MiddleName, FirstName from Authers where FirstName='Flemming';