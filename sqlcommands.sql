#--Procedues--
	#--loaner--
		#create new loaner -- CreateLoaner
        #get the articles that a loaners is currently borrowing
		#get a loaners loaning history
        #get all loans that a loaner returned too soon
	#--librarian--
		#create new librarian -- CreateLibrarian
        #loan book to loaner -- Can't currently be made
        #return article that a loaner loaned -- Can't currently be made
        #get all articles that a librarian is currently resposible for
		#get all articles a librarian has loaned out
    #--library--
		#get a librarys books
		#get librarians that work for a specific library
        #get all loaners that currently loan an article from that library
    #--book--
		#create new book -- CreateBook
	#--article--
		#create new article -- CreateBook
    
        
#--transactions--
	#move article from one library to another
	#move librarian from one libraryto another

        
#--triggers--

using library

#--Procedues--
#create new loaner
DELIMITER //
CREATE PROCEDURE CreateLoaner
(IN vLoanerID INT, IN vFirstName VARCHAR(45), IN vMiddleName VARCHAR(45), IN vLastName VARCHAR(45), IN vStreetName VARCHAR(45),IN vZipCode VARCHAR(45), IN vStreetNumber VARCHAR(45), IN vDateOfBirth VARCHAR(45))
BEGIN
INSERT Loaners(LoanerID, FirstName, MiddleName, LastName, StreetName, ZipCode, StreetNumber, DateOfBirth)
VALUES (vLoanerID, vFirstName, vMiddleName, vLastName, vStreetName, vZipCode, vStreetNumber, vDateOfBirth);
END; //
DELIMITER ;

#create new librarian
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
DELIMITER //
CREATE PROCEDURE CreateBook
(IN vISBN DECIMAL(13,0), IN vPublisherID INT, IN vDatePublish DATE, IN vTitle DATETIME, IN vPrice DECIMAL(6,2))
BEGIN
INSERT Books(ISBN, PublisherID, DatePublish, Title, Price)
VALUES (vISBN, vPublisherID, vDatePublish, vTitle, vPrice);
END; //
DELIMITER ;

#create new article
DELIMITER //
CREATE PROCEDURE CreateArticle
(IN vArticleID INT, IN vDateBought DATE, IN vPlacementID INT, IN vBelongsToID INT, IN vPlacement VARCHAR(45), IN vISBN DECIMAL(13,0))
BEGIN
INSERT Article(ArticleID, DateBought, PlacementID, BelongsToID, Placement, ISBN)
VALUES (vArticleID, vDateBought, vPlacementID, vBelongsToID, vPlacement, vISBN);
END; //
DELIMITER ;








