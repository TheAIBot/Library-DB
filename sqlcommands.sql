Use library;

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
select Books.* from ((Loans natural join ArticleToLoans) natural join Article) natural join Books
where LoanerID = vLoanerID AND ReturnedDate is NULL;
END; //
DELIMITER ;
#call GetCurrentBooksLoanedByLoaner(5004);

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
select Article.* from (ArticleToLoans natural join Loans) natural join Article
where LoanerID = vLoanerID AND ((DATE(ReturnedDate) is NULL AND DATE(PeriodEnd) > CURDATE()) OR (DATE(ReturnedDate) is not NULL AND DATE(PeriodEnd) < DATE(ReturnedDate)));
END; //
DELIMITER ;
#call GetLoanersArticlesReturnedTooLate(5002);

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
#call ChangeLibrarianWorkLibrary(3130, 1001);

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



#--functions--
DROP FUNCTION IF EXISTS ConcatName;
DELIMITER //
CREATE FUNCTION ConcatName (vFirstName VARCHAR(45), vMiddleName VARCHAR(45), vLastName VARCHAR(45))
RETURNS VARCHAR(140)
BEGIN
RETURN CONCAT(COALESCE(vFirstName,''),' ',COALESCE(CONCAT(vMiddleName, ' '), ''),COALESCE(vLastName,''));
END; //
DELIMITER ;



#--triggers--
#verify ISBN before inserting it
DROP TRIGGER IF EXISTS Books_Before_Insert;
DELIMITER //
CREATE TRIGGER Books_Before_Insert
BEFORE INSERT ON Books FOR EACH ROW
BEGIN
DECLARE ISBNString CHAR(13);
DECLARE d1 INT;
DECLARE d2 INT;
DECLARE d3 INT;
DECLARE d4 INT;
DECLARE d5 INT;
DECLARE d6 INT;
DECLARE d7 INT;
DECLARE d8 INT;
DECLARE d9 INT;
DECLARE d10 INT;
DECLARE d11 INT;
DECLARE d12 INT;
DECLARE d13 INT;
DECLARE ISBNSum INT;



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
#(*) can't test before isbn values are fixed
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
#(*) can't test before isbn values are fixed
DROP TRIGGER IF EXISTS ArticleToLoans_Before_Insert;
DELIMITER //
CREATE TRIGGER ArticleToLoans_Before_Insert
BEFORE INSERT ON ArticleToLoans FOR EACH ROW
BEGIN
DECLARE isAlreadyLoanedOut INT;
SET periodStart = (select PeriodStart from ArticleToLoans natural join Loans
				   where LoanID = New.LoanID AND );
IF New.ReturnedDate < periodStart THEN SIGNAL SQLSTATE 'HY000'
	SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'The return date can not be before the book was loaned out';
END IF;
END; //
DELIMITER ;



