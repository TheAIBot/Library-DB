USE Library;

CREATE VIEW BookArticles AS
	SELECT *
	FROM Books NATURAL JOIN Article;

#Find all the books lend out (at any time), by a user with user id 666:
SELECT Title
FROM BookArticles NATURAL JOIN Loans
WHERE LoanerID = 5003;

#Find all the books lend out at a given date, chosen as '2017-02-25':
SELECT Title, ArticleID, LoanerID
FROM BookArticles NATURAL JOIN Loans
WHERE ('2017-02-25' BETWEEN PeriodStart and ReturnDate) OR  # In the case that it haven't been returned yet.
	  ((PeriodStart <= '2017-02-25' ) AND ReturnDate IS NULL);

#Gives a sorted list of loaners by there name, 
#and how many books they have loaned out throughout the years:
SELECT (FirstName + MiddleName + LastName) AS LoanerName, count(*) AS LoanCount
FROM Loaners NATURAL JOIN Loans #For every loaner, one gets the loan of a book.
GROUP BY LoanerID #
ORDER BY LoanCount;

#Find all the books (name) written by an auther an auther with a given name, here "Jueles verne"(*)
#Also gives the auther name, in the case that there are more authers with the same name
SELECT (Authers.FirstName + Authers.MiddleName + Authers.LastName) AS AutherName, AutherID, Title 
FROM (Books NATURAL JOIN WrittenBy) NATURAL JOIN Authers
WHERE AutherName

