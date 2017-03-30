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
RETURN CONCAT(COALESCE(vFirstName,''),' ',COALESCE(CONCAT(vMiddleName, ' '), ''),COALESCE(vLastName,''));
END; //
DELIMITER ;




#call ChangeLibrarianWorkLibrary(4001, 1001);




#select * from Librarian;


