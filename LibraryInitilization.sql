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
  `PhoneNumbers` VARCHAR(45) NULL,
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
  `OpeningTime` ENUM('Monday', 'Tuesday', 'Wedensday', 'Thursday', 'Friday') NOT NULL,
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


-- -----------------------------------------------------
-- Table `Library`.`Litterature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Litterature` ;

CREATE TABLE IF NOT EXISTS `Library`.`Litterature` (
  `ISBN` DECIMAL(13,0) NOT NULL,
  `LiteratureCategory` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ISBN`),
  CONSTRAINT `fk_Litterature_Books1`
    FOREIGN KEY (`ISBN`)
    REFERENCES `Library`.`Books` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
