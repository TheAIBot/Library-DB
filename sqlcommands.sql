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
#call ChangeLibrarianWorkLibrary(3130, 1001);

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
#call ChangeLibrarianWorkLibrary(4001, 1001);




DROP FUNCTION IF EXISTS ConcatName;
DELIMITER //
CREATE FUNCTION ConcatName (vFirstName VARCHAR(45), vMiddleName VARCHAR(45), vLastName VARCHAR(45))
RETURNS VARCHAR(140)
BEGIN
RETURN CONCAT(COALESCE(vFirstName,''),' ',COALESCE(CONCAT(vMiddleName, ' '), ''),COALESCE(vLastName,''));
END; //
DELIMITER ;





#select * from Librarian;


