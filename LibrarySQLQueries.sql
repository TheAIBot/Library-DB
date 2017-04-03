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
