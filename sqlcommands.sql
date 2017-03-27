Use library;

#--Procedues--
#create new loaner
DROP PROCEDURE IF EXISTS CreateLoaner;
DELIMITER //
CREATE PROCEDURE CreateLoaner
(IN vLoanerID INT, IN vFirstName VARCHAR(45), IN vMiddleName VARCHAR(45), IN vLastName VARCHAR(45), IN vStreetName VARCHAR(45),IN vZipCode VARCHAR(45), IN vStreetNumber VARCHAR(45), IN vDateOfBirth VARCHAR(45))
BEGIN
INSERT Loaners(LoanerID, FirstName, MiddleName, LastName, StreetName, ZipCode, StreetNumber, DateOfBirth)
VALUES (vLoanerID, vFirstName, vMiddleName, vLastName, vStreetName, vZipCode, vStreetNumber, vDateOfBirth);
END; //
DELIMITER ;

#create new librarian
DROP PROCEDURE IF EXISTS CreateLibrarian;
DELIMITER //
CREATE PROCEDURE CreateLibrarian
(IN vLibrarianID INT, IN vFirstName VARCHAR(45), IN vMiddleName VARCHAR(45), IN vLastName VARCHAR(45), IN vStreetNumber VARCHAR(45), IN vStreetName VARCHAR(45), IN vZipCode VARCHAR(45), IN vDateOfBirth DATE, IN vSalary INT, IN vLibraryID INT, IN vStartDate DATE, IN vEndDate DATE)
BEGIN
INSERT Librarian(LibrarianID, FirstName, MiddleName, LastName, StreetNumber, StreetName, ZipCode, DateOfBirth, Salary, LibraryID, StartDate, EndDate)
VALUES (vLibrarianID, vFirstName, vMiddleName, vLastName, vStreetNumber, vStreetName, vZipCode, vDateOfBirth, vSalary, vLibraryID, vStartDate, vEndDate);
END; //
DELIMITER ;

#loan book to loaner
#CAN'T BE DONE YET BECAUSE LOAN NEEDS TO BE VERIFIED TO WORK CORRECTLY

#return article that a loaner loaned
#CAN'T BE DONE YET BECAUSE LOAN NEEDS TO BE VERIFIED TO WORK CORRECTLY

#create new book
DROP PROCEDURE IF EXISTS CreateBook;
DELIMITER //
CREATE PROCEDURE CreateBook
(IN vISBN DECIMAL(13,0), IN vPublisherID INT, IN vDatePublish DATE, IN vTitle VARCHAR(45), IN vPrice DECIMAL(6,2))
BEGIN
INSERT Books(ISBN, PublisherID, DatePublish, Title, Price)
VALUES (vISBN, vPublisherID, vDatePublish, vTitle, vPrice);
END; //
DELIMITER ;

#create new article
DROP PROCEDURE IF EXISTS CreateArticle;
DELIMITER //
CREATE PROCEDURE CreateArticle
(IN vArticleID INT, IN vDateBought DATE, IN vPlacementID INT, IN vBelongsToID INT, IN vPlacement VARCHAR(45), IN vISBN DECIMAL(13,0))
BEGIN
INSERT Article(ArticleID, DateBought, PlacementID, BelongsToID, Placement, ISBN)
VALUES (vArticleID, vDateBought, vPlacementID, vBelongsToID, vPlacement, vISBN);
END; //
DELIMITER ;

#create new book and article
DROP PROCEDURE IF EXISTS CreateTestBookAndArticle;
DELIMITER //
CREATE PROCEDURE CreateTestBookAndArticle
(IN vISBN DECIMAL(13,0), IN vPublisherID INT, IN vTitle VARCHAR(45), IN vPrice DECIMAL(6,2), IN vArticleID INT, IN vDatePublish DATE, IN vPlacementID INT)
BEGIN
call CreateBook(vISBN, vPublisherID, vDatePublish, vTitle, vPrice);
call CreateArticle(vArticleID, vDatePublish, vPlacementID, vPlacementID, "Testlitteratur", vISBN);
END; //
DELIMITER ;

select * from Article;


#(*) need more test data so this one can be tested
#get the articles that a loaner is currently borrowing
DROP PROCEDURE IF EXISTS GetCurrentArticlesLoanedByLoaner;
DELIMITER //
CREATE PROCEDURE GetCurrentArticlesLoanedByLoaner
(IN vLoanerID INT)
BEGIN
#(*) filter selected columns so they make more sense
select * from Loaners natural join Loans
where LoanerID = vLoanerID AND PeriodEnd = NULL;
END; //
DELIMITER ;

#get a loaners loaning history
DROP PROCEDURE IF EXISTS GetLoanerHistory;
DELIMITER //
CREATE PROCEDURE GetLoanerHistory
(IN vLoanerID INT)
BEGIN
#(*) filter selected columns so they make more sense
select * from Loaners natural join Loans
where LoanerID = vLoanerID;
END; //
DELIMITER ;

#(*) for some reason this one doesn't seem to work
#get all loans that a loaner returned on time
DROP PROCEDURE IF EXISTS GetLoanersArticlesReturnedOnTime;
DELIMITER //
CREATE PROCEDURE GetLoanersArticlesReturnedOnTime
(IN vLoanerID INT)
BEGIN
#(*) filter selected columns so they make more sense
select * from Loaners natural join Loans
where LoanerID = vLoanerID AND DATE(PeriodEnd) != NULL AND DATE(PeriodEnd) <= DATE(ReturnDate);
END; //
DELIMITER ;

#get all loans that a loaner returned too late
DROP PROCEDURE IF EXISTS GetLoanersArticlesReturnedTooLate;
DELIMITER //
CREATE PROCEDURE GetLoanersArticlesReturnedTooLate
(IN vLoanerID INT)
BEGIN
#(*) filter selected columns so they make more sense
select * from Loaners natural join Loans
where LoanerID = vLoanerID AND ((DATE(PeriodEnd) = NULL AND DATE(ReturnDate) > CURDATE()) OR DATE(PeriodEnd) > DATE(ReturnDate));
END; //
DELIMITER ;

#get all articles that a librarian is currently resposible for
DROP PROCEDURE IF EXISTS GetLibrarianArticlesResponsibleFor;
DELIMITER //
CREATE PROCEDURE GetLibrarianArticlesResponsibleFor
(IN vLibrarianID INT)
BEGIN
#(*) filter selected columns so they make more sense
select * from Loans
where LibrarianID = vLibrarianID AND PeriodEnd = NULL;
END; //
DELIMITER ;

#get all articles a librarian has loaned out
DROP PROCEDURE IF EXISTS GetLibrarianLoanedOutArticlesHistory;
DELIMITER //
CREATE PROCEDURE GetLibrarianLoanedOutArticlesHistory
(IN vLibrarianID INT)
BEGIN
#(*) filter selected columns so they make more sense
select * from Loans
where LibrarianID = vLibrarianID;
END; //
DELIMITER ;

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

#get librarians that work for a specific library
DROP PROCEDURE IF EXISTS GetLibrariansWorkingForLibrary;
DELIMITER //
CREATE PROCEDURE GetLibrariansWorkingForLibrary
(IN vLibraryID INT)
BEGIN
#(*) filter selected columns so they make more sense
select * from Librarian
where LibraryID = vLibraryID;
END; //
DELIMITER ;

#get all loaners that currently loan an article from that library
DROP PROCEDURE IF EXISTS GetLibrarysCurrentlyLoanedOutArticles;
DELIMITER //
CREATE PROCEDURE GetLibrarysCurrentlyLoanedOutArticles
(IN vLibraryID INT)
BEGIN
#(*) filter selected columns so they make more sense
select * from Librarian natural join Loans
where LibraryID = vLibraryID;
END; //
DELIMITER ;





#--transactions--
#move article from one library to another
DROP PROCEDURE IF EXISTS ChangeArticleOwnerLibrary;
DELIMITER //
CREATE PROCEDURE ChangeArticleOwnerLibrary
(IN vArticleID INT ,IN vnewOwnerLibraryID INT)
BEGIN
declare newLibraryID INT default NULL;
#need to fix that the below line doesnt' work properly
#SET TRANSACTION READ WRITE;
start transaction;
update Article set BelongsToID = vnewOwnerLibraryID where ArticleID = vArticleID;

#verify that the value changed
set newLibraryID = (select BelongsToID from Article where ArticleID = vArticleID);
if newLibraryID = vnewOwnerLibraryID then
	commit;
else
	rollback;
end if;
END; //
DELIMITER ;

#move librarian from one library to another
DROP PROCEDURE IF EXISTS ChangeLibrarianWorkLibrary;
DELIMITER //
CREATE PROCEDURE ChangeLibrarianWorkLibrary
(IN vLibrarianID INT ,IN vnewOwnerLibraryID INT)
BEGIN
declare newLibraryID INT default NULL;
#need to fix that the below line doesnt' work properly
#SET TRANSACTION READ WRITE;
start transaction;
update Librarian set LibraryID = vnewOwnerLibraryID where LibrarianID = vLibrarianID;

#verify that the value changed
set newLibraryID = (select LibraryID from Librarian where LibrarianID = vLibrarianID);
if newLibraryID = vnewOwnerLibraryID then
	commit;
else
	rollback;
end if;
END; //
DELIMITER ;

DROP FUNCTION IF EXISTS ConcatName;
DELIMITER //
CREATE FUNCTION ConcatName (vFirstName VARCHAR(45), vMiddleName VARCHAR(45), vLastName VARCHAR(45))
RETURNS VARCHAR(140)
BEGIN
RETURN CONCAT(COALESCE(vFirstName,''),' ',COALESCE(vMiddleName,''),' ',COALESCE(vLastName,''));
END; //
DELIMITER ;




call ChangeLibrarianWorkLibrary(4001, 1001);




select * from Librarian;


