USE Library;

CREATE VIEW BookArticles AS
	SELECT *
	FROM Books NATURAL JOIN Article;

SELECT * FROM BookArticles;

#Find all the books lend out (at any time), by a user with user id 5003, 
#and gives the period for the loan. This sorted by the loans start date:
SELECT Title, PeriodStart, ReturnDate
FROM BookArticles NATURAL JOIN Loans
WHERE LoanerID = 5003
ORDER BY PeriodStart;

#Find the count of the total number of books lend out by that user:
SELECT count(*) AS NumberOfLendBooks
FROM BookArticles NATURAL JOIN Loans
WHERE LoanerID = 5003;

#Finds all the loaners that currently have a book that is overdue.
#Selects the Loaners name and ID, and the articles ID as well as the books title.
SELECT LoanerID, CONCAT(FirstName, " ", MiddleName, " ", LastName) as LoanerName, ArticleID, Title
FROM (BookArticles NATURAL JOIN Loans) NATURAL JOIN Loaners
WHERE PeriodEnd < CURDATE() AND ReturnDate IS NULL
ORDER BY LoanerName;



#Find all articles that is lend out at a given date, with their title and who have lent it, 
#at a given date, here taken as'2017-02-25':
SELECT Title, ArticleID, LoanerID
FROM BookArticles NATURAL JOIN Loans
WHERE (('2017-02-20' BETWEEN PeriodStart AND ReturnDate) AND ReturnDate IS NOT NULL) OR  # In the case that it haven't been returned yet.
	  ((PeriodStart <= '2017-02-20' ) AND ReturnDate IS NULL)
ORDER BY Title;


#A variant of the query above: 
#Gives the count of the number of a given book that is lend out at a given date:
SELECT Title, ISBN, SUM(IF(('2017-02-20' BETWEEN PeriodStart and ReturnDate) OR  # In the case that it haven't been returned yet.
						   ((PeriodStart <= '2017-02-20' ) AND ReturnDate IS NULL),1,0)) AS NumberLendOut #All the books that have been lend out in the period
FROM BookArticles NATURAL LEFT OUTER JOIN Loans
GROUP BY ISBN
ORDER BY Title;

#Tests:
SELECT * FROM Loans;
SELECT Title, ISBN, PeriodStart, IF( ('2017-02-20' BETWEEN PeriodStart and ReturnDate) OR ((PeriodStart <= '2017-02-20' ) AND ReturnDate IS NULL),1,0) AS M
FROM BookArticles NATURAL LEFT OUTER JOIN Loans;
      


Select * from Loans NATURAL JOIN Loaners;

#Gives a sorted list of loaners by there name, 
#and how many books they have loaned out throughout the years:
SELECT CONCAT(FirstName, ", ", LastName) AS LoanerName, count(*) AS LoanCount
FROM Loaners NATURAL JOIN Loans #For every loaner, one gets the loan of a book.
GROUP BY LoanerID #
ORDER BY LoanCount;

#Find all the books (name) written by an auther an auther with a given name, here "Jueles verne"(*)
#Also gives the auther name, in the case that there are more authers with the same name
SELECT CONCAT(Authers.FirstName, ' ', Authers.MiddleName, ' ', Authers.LastName) AS AutherName, AuthersID, Title 
FROM (Books NATURAL JOIN WrittenBy) NATURAL JOIN Authers
WHERE CONCAT(Authers.FirstName, ' ', Authers.MiddleName, ' ', Authers.LastName) = 'Jesper Samsø Birch'; 
	#Can't reference AutherName, as it is an alias.
#(*) Write function for getting the autherName


#Find all the authers that a certain person has lend books from.
SELECT DISTINCT CONCAT(Authers.FirstName, ' ', Authers.MiddleName, ' ', Authers.LastName) AS AutherName, AuthersID
FROM  (SELECT ISBN 
	   FROM (Loaners NATURAL JOIN Loans) NATURAL JOIN Article
       WHERE Loaners.FirstName = "Terkel") AS readBooks, #Splitting it up, for better readability.
      (Books NATURAL JOIN WrittenBy) NATURAL JOIN Authers
WHERE (Books.ISBN = readBooks.ISBN);


#Finds all the books owned by AND not placed at a given library:
SELECT Title, ArticleID,Name, PlacementID
FROM Libraries JOIN BookArticles ON BelongsToID = LibraryID
WHERE LibraryID = 1001 AND PlacementID != 1001
ORDER BY Title;

SELECT * FROM Article;

#Lav noget natural left outer join (*)
#(*) Læs op på cascade