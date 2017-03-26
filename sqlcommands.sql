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


#get the articles that a loaner is currently borrowing
select * from Loaners natural join Loans;








