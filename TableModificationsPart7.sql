Use library;
#Delete from Article where ISBN =1000743468643;
#might not work as the book is already being loaned by someone!

#Create a new book with the exsisting auther with id 2003
#Show all possible articles
insert into `books` values (1000777777777,2003,'2007-05-22','Ebert and his errors',000180.00);
insert into `article` values (3004,'2008-04-28',1003,1003,'Faglitteratur',1000777777777);
insert into `writtenby` values (6003,1000777777777);

select * from Article;
#Delete the article again and look at the number of books that is offered (or at one point has been)
#Delete from Article where ISBN =1000777777777;
#select * from Books;

#Now it's time for a salary raise of 5%, however on person Anders Samsø Birch earns too much
#when comparing the other librarians that has a lot more work experience, and should lose 25%
#Furthermore one would like to see the changes to the salaries of the librarians
select * from librarian;
update librarian set Salary=Salary*1.05 where Salary<29000;
update librarian set Salary=Salary*0.75 where Salary>=30000;
select * from librarian;

#Title Price and ISBN view
CREATE view WrittenbyInfo as
select Title, Price,PublisherID,
(select ISBN from writtenby where writtenby.ISBN=books.ISBN) as ISBN,
(select AuthersID from writtenby where Writtenby.ISBN=books.ISBN) as AuthersID
from books;
select * from WrittenbyInfo;

#create a view of which books the authers have made, their title and their price
#Here it should be noted that whenever we use nested query it is basically
#the same as when using group by (see powp 3, pp57) 
create view AutherInfo as
select *,
(select FirstName from authers where authers.AuthersID=WrittenbyInfo.AuthersID) as FirstName,
(select MiddleName from authers where authers.AuthersID=WrittenbyInfo.AuthersID) as MiddleName,
(select LastName from authers where authers.AuthersID=WrittenbyInfo.AuthersID) as LastName
from WrittenbyInfo;
select * from AutherInfo;



#case with fagliteratur and price of books



#procedure to add a whole new book, article, authour,writtenby, new publisher in one go
#to reduce redundancy (i.e writtenby, book and article share ISBN...)
#DELIMITER //
#create procedure AddCompleteBook(IN vISBN)
#DELIMITER ;