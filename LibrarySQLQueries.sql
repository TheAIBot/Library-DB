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

#Find for all books the number of copies that is lend out of it, at a given date, here taken as'2017-02-25':
SELECT Title, ArticleID, LoanerID
FROM BookArticles JOIN Loans
WHERE ('2017-02-20' BETWEEN PeriodStart and ReturnDate) OR  # In the case that it haven't been returned yet.
	  ((PeriodStart <= '2017-02-20' ) AND ReturnDate IS NULL)
ORDER BY Title;


#A variant of the queri above: 
#Give the count of the number of a given book that is lend out at a given date:
SELECT Title, Count(*) AS NumberLendOut #(*) Check correct.
FROM BookArticles NATURAL RIGHT OUTER JOIN Loans
WHERE ('2017-02-20' BETWEEN PeriodStart and ReturnDate) OR  # In the case that it haven't been returned yet.
  ((PeriodStart <= '2017-02-20' ) AND ReturnDate IS NULL)
GROUP BY Title
ORDER BY Title;
      


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
#(*) Write functio for getting the autherName


#Find all the authers that a certain person has lend books from.
SELECT DISTINCT CONCAT(Authers.FirstName, ' ', Authers.MiddleName, ' ', Authers.LastName) AS AutherName, AuthersID
FROM  (SELECT ISBN 
	   FROM (Loaners NATURAL JOIN Loans) NATURAL JOIN Article
       WHERE Loaners.FirstName = "Terkel") AS readBooks, #Splitting it up, for better readability.
      (Books NATURAL JOIN WrittenBy) NATURAL JOIN Authers
WHERE (Books.ISBN = readBooks.ISBN);


#Finds all the books owned AND not placed at a given library:
SELECT Title,ArticleID
FROM Libraries JOIN BookArticles ON BelongsToID = LibraryID
WHERE LibraryID = 1001 AND PlacementID != 1001
ORDER BY Title;

SELECT * FROM Article;

#Lav noget natural left outer join (*)
#(*) Læs op på cascade