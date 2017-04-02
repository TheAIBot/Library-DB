Use library;
#Delete from Article where ISBN =1000743468643;
#might not work as the book is already being loaned by someone!

#make a transaction

delimiter //
create procedure addBook(Visbn decimal(13,0),VPublisherID INT, VDatePublish DATE, VTitle varchar(45),VPrice DECIMAL(6,2),VArticleID INT,VDateBought DATE,VPlacementID int,VBelongsToID int,VAuthersID int,Vcategory varchar(45))
begin 
declare ISBNtester decimal(13,0);

start transaction;
insert into `books` values (Visbn,VPublisherID,VDatePublish,VTitle,VPrice,Vcategory);
insert into `article` values (VArticleID,VDateBought,VPlacementID,VBelongsToID,Visbn);
insert into `writtenby` values (VAuthersID,Visbn);

set ISBNtester = (select ISBN from books where books.ISBN=Visbn);
if ISBNtester != (Visbn) then
	rollback;
end if;
set ISBNtester = (select ISBN from article where article.ISBN=Visbn);
if ISBNtester != (Visbn) then
	rollback;
end if;
set ISBNtester = (select ISBN from writtenby where writtenby.ISBN=Visbn);
if ISBNtester != (Visbn) then
	rollback;
end if;
commit;

end; //
delimiter ;

#Create a new book with the exsisting auther with id 2003
#Show all possible articles
call addBook(1000777777777,2003,'2007-05-22','Ebert and his errors',000180.00,3011,'2008-04-28',1003,1003,6003,'Faglitteratur');
insert into `books` values (1000777777777,2003,'2007-05-22','Ebert and his errors',000180.00,'Faglitteratur');
insert into `article` values (3011,'2008-04-28',1003,1003,1000777777777);
insert into `writtenby` values (6003,1000777777777);
select * from books;

select * from articletoloans;
/* OBS DELETE BRUGES IKKE LIGE HER IDET VI GERNE VIL BEHOLDE DISSE ARTIKLER TIL ANDRE TING SOM PROCEDURES; VIEWS, osv. */ 
select * from Article;
#Delete the article again and look at the number of books that is offered (or at one point has been)
Delete from Article where ArticleID =1000777777777;
select * from Books;

#Now it's time for a salary raise of 5%, however on person Anders Samsø Birch earns too much
#when comparing the other librarians that has a lot more work experience, and should lose 25%
#Furthermore one would like to see the changes to the salaries of the librarians
select * from librarian;
update librarian set Salary=Salary*1.05 where Salary<29000;
update librarian set Salary=Salary*0.75 where Salary>=30000;
select * from librarian;

#we now wish to update the middle name of Flemming Schimidt as he got married with fru Hansen
select MiddleName, FirstName from Authers where FirstName='Flemming';
update Authers set MiddleName='Hansen' where FirstName='Flemming';
select MiddleName, FirstName from Authers where FirstName='Flemming';

#function to check if article is already loaned
drop procedure if exists articleTest;
delimiter //
create procedure articleTest(vArticle INT)
begin
declare article_loaned varchar(15);
declare counter int;
declare counterArt int;
(select count(*) into counterArt from article where article.ArticleID=vArticle);
(select count(*) into counter from articletoloans where articletoloans.ArticleID=vArticle);
if (counter=1 and counterArt=1) then set article_loaned='Loaned';
elseif (counter=0 and counterArt=1) then set article_loaned='Not Loaned';
else set article_loaned='Invalid article';
end if;
select article_loaned;
end;//
delimiter ;
#loaned
call articleTest(3001);
#not loaned
call articleTest(3002);
#bullshit
call articleTest(9999);

drop procedure if exists articleTestDate;

delimiter //
create procedure articleTestDate(vArticle INT)
begin
declare article_loaned varchar(15);
declare counter int;
declare counterArt int;
(select count(*) into counterArt from article where article.ArticleID=vArticle);
(select count(*) into counter from articletoloans where (articletoloans.ArticleID=vArticle and articletoloans.ReturnedDate is null));
if (counter=0 and counterArt=1) then set article_loaned='Avaiable';
elseif (counter=1 and counterArt=1) then set article_loaned='Loaned out';
else set article_loaned='Invalid article';
end if;
select article_loaned;
end;//
delimiter ;

#see how many articles each loaner have loaned
insert into `article` values(3099,'2015-01-03',1002,1001,1001234567123);
insert into `article` values(3199,'2015-01-03',1002,1001,1001234567123);
insert into `loans` values(7004,5003,4003,'2025-09-14','2025-09-28');
insert into `ArticleToLoans` values(3099,7004,null);
#2025-09-26
SELECT LoanerID, COUNT(LoanID) as loans FROM loans GROUP BY LoanerID;

call articleTestDate(3099);
(select * from articletoloans where (ReturnedDate is NULL));
select * from articletoloans ;

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