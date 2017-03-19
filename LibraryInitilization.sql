-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Libraries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Libraries` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Libraries` (
  `LibraryID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `StreetNumber` VARCHAR(45) NOT NULL,
  `ZipCode` DECIMAL(4,0) NOT NULL,
  `StreetName` VARCHAR(45) NOT NULL,
  `Capacity` INT NOT NULL,
  `Open` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`LibraryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Publisher` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Publisher` (
  `PublisherID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `StreetNumber` VARCHAR(45) NOT NULL,
  `StreetName` VARCHAR(45) NOT NULL,
  `ZipCode` VARCHAR(45) NOT NULL,
  `PhoneNumbers` VARCHAR(45) NULL,
  PRIMARY KEY (`PublisherID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Books` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Books` (
  `ISBN` DECIMAL(13,0) NOT NULL,
  `PublisherID` INT NOT NULL,
  `DatePublish` DATE NOT NULL,
  `Title` DATETIME NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`ISBN`),
  INDEX `fk_Books_Publisher1_idx` (`PublisherID` ASC),
  CONSTRAINT `fk_Books_Publisher1`
    FOREIGN KEY (`PublisherID`)
    REFERENCES `mydb`.`Publisher` (`PublisherID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Article` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Article` (
  `ArticleID` INT NOT NULL,
  `DateBought` DATE NOT NULL,
  `PlacementID` INT NOT NULL,
  `BelongsToID` INT NOT NULL,
  `Placement` VARCHAR(45) NOT NULL,
  `ISBN` DECIMAL(13,0) NOT NULL,
  PRIMARY KEY (`ArticleID`),
  INDEX `fk_Article_Libraries_idx` (`PlacementID` ASC),
  INDEX `fk_Article_Libraries1_idx` (`BelongsToID` ASC),
  INDEX `fk_Article_Books1_idx` (`ISBN` ASC),
  CONSTRAINT `fk_Article_Libraries`
    FOREIGN KEY (`PlacementID`)
    REFERENCES `mydb`.`Libraries` (`LibraryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Article_Libraries1`
    FOREIGN KEY (`BelongsToID`)
    REFERENCES `mydb`.`Libraries` (`LibraryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Article_Books1`
    FOREIGN KEY (`ISBN`)
    REFERENCES `mydb`.`Books` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Librarian`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Librarian` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Librarian` (
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
    REFERENCES `mydb`.`Libraries` (`LibraryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Loaners`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Loaners` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Loaners` (
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
-- Table `mydb`.`Authers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Authers` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Authers` (
  `AuthersID` INT NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `MiddleName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `DateOfBirth` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AuthersID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`WrittenBy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`WrittenBy` ;

CREATE TABLE IF NOT EXISTS `mydb`.`WrittenBy` (
  `AuthersID` INT NOT NULL,
  `ISBN` DECIMAL(13,0) NOT NULL,
  PRIMARY KEY (`AuthersID`, `ISBN`),
  INDEX `fk_Authers_has_Books_Books1_idx` (`ISBN` ASC),
  INDEX `fk_Authers_has_Books_Authers1_idx` (`AuthersID` ASC),
  CONSTRAINT `fk_Authers_has_Books_Authers1`
    FOREIGN KEY (`AuthersID`)
    REFERENCES `mydb`.`Authers` (`AuthersID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Authers_has_Books_Books1`
    FOREIGN KEY (`ISBN`)
    REFERENCES `mydb`.`Books` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RegisteredAt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`RegisteredAt` ;

CREATE TABLE IF NOT EXISTS `mydb`.`RegisteredAt` (
  `LibraryID` INT NOT NULL,
  `LoanerID` INT NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`LibraryID`, `LoanerID`),
  INDEX `fk_Libraries_has_Loaners_Loaners1_idx` (`LoanerID` ASC),
  INDEX `fk_Libraries_has_Loaners_Libraries1_idx` (`LibraryID` ASC),
  CONSTRAINT `fk_Libraries_has_Loaners_Libraries1`
    FOREIGN KEY (`LibraryID`)
    REFERENCES `mydb`.`Libraries` (`LibraryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Libraries_has_Loaners_Loaners1`
    FOREIGN KEY (`LoanerID`)
    REFERENCES `mydb`.`Loaners` (`LoanerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Loans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Loans` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Loans` (
  `LoanID` INT NOT NULL,
  `ArticleID` INT NOT NULL,
  `LoanerID` INT NOT NULL,
  `LibrarianID` INT NOT NULL,
  `PeriodStart` DATE NOT NULL,
  `PeriodEnd` DATE NOT NULL,
  `ReturnDate` DATE NULL,
  INDEX `fk_Loans_Article1_idx` (`ArticleID` ASC),
  INDEX `fk_Loans_Loaners1_idx` (`LoanerID` ASC),
  INDEX `fk_Loans_Librarian1_idx` (`LibrarianID` ASC),
  PRIMARY KEY (`LoanID`),
  CONSTRAINT `fk_Loans_Article1`
    FOREIGN KEY (`ArticleID`)
    REFERENCES `mydb`.`Article` (`ArticleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Loans_Loaners1`
    FOREIGN KEY (`LoanerID`)
    REFERENCES `mydb`.`Loaners` (`LoanerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Loans_Librarian1`
    FOREIGN KEY (`LibrarianID`)
    REFERENCES `mydb`.`Librarian` (`LibrarianID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
