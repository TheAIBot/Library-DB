Use library;

/* Test data for libraries*/
#id starts at 1000
insert into `libraries` values 
(1001,'Egedal Bibliotek','34H',3850,'Træhusevej',40000),
(1002,'Birkerød Bibliotek','12J',3450,'Træhusevej',12000),
(1003,'Thisted Bibliotek','42G',7000,'Pipedrejervej',20000);


/* Test data for publisher*/
#id starts at 2000
insert into `Publisher` values 
(2001,'Matematik Forlaget','78Q','Matricevej',9999),
(2002,'Computer Forlaget','13A','Databasevej',5555),
(2003,'Awesome Forlaget','Rytterkær','139',2765);

/*Test data for Books */  
insert into `Books` values 
(9781861978769,2001,'2003-07-07','Crazy Horse and Custer',000300.00,'Faglitteratur'),
(9783161484100,2002,'1989-07-07','Solitons in Optical fibers',000700.00,'Faglitteratur'),
(9780125041904,2003,'2015-03-02','Livet som Jesper',000666.00,'Awesomelitteratur');


/*Test data for Article */
#id starts at 3000
insert into `Article` values 
(3001,'2004-09-12',1001,1001,9781861978769),
(3022,'1995-01-03',1003,1001,9783161484100),
(3072,'2015-01-03',1002,1001,9780125041904),
(3002,'2004-09-18',1002,1002,9781861978769),
(3003,'1995-01-09',1002,1002,9783161484100),
(3004,'2015-02-23',1002,1002,9780125041904),
(3005,'2006-02-27',1003,1003,9781861978769),
(3006,'1999-02-04',1003,1003,9783161484100),
(3007,'2016-04-25',1003,1003,9780125041904),
(3008,'2004-09-18',1002,1003,9781861978769),
(3009,'1995-01-09',1003,1002,9783161484100),
(3010,'2015-02-23',1001,1001,9780125041904);

/*Test data for Librarian */
#id starts at 4000
insert into `librarian` values 
(4001,'Beate','Stenstrøm','Habberbug','S69','Edderkoppedal',3850,'1970-08-12',26000,1001,'1995-12-12',null),
(4002,'Per',null,'Jensen','84V','Saturnvej',3450,'1980-11-01',27000,1002,'2005-12-12',null),
(4003,'Anders','Samsø','Birch','139','Rytterkær',7000,'1996-03-30',30000,1003,'2016-01-05',null);

/*Test data for Loaners */
#id starts at 5000
insert into `loaners` values
(5001,'Terkel'   , 'Stenstrøm','Hansen'    ,'Edderkoppedal'     ,3850,'S69','2000-02-10'),
(5002,'Susanne'  , null       ,'Jensen'    ,'Saturnvej'         ,3450,'84V','1981-07-13'),
(5003,'Legolas'  , 'Den'      ,'Mægtige'   ,'Rytterkær'         ,7000,'139','2018-03-13'),
(5004,'Lars'     , null       ,'Larsen'    , 'Kæbhøjvej'        ,9001,'-3V','1013-06-21'),
(5005,'Legolas'  , null       ,'Erobreren' ,'Storkevej'         ,4111,'259','2018-03-31'),
(5006,'Normie'   , null       ,'Norman'    ,'Lolvej'            ,6624,'479','2018-06-12'),
(5007,'Peter'    , null       ,'Pip'       ,'Sauronvej'         ,8266,'539','2018-05-12'),
(5008,'Jack'     , 'The'      ,'Ripper'    ,'Lortevej'          ,0685,'799','2018-07-31'),
(5009,'John'     , null       ,'Olesen'    ,'Ministervej'       ,2843,'21V','2018-02-01'),
(5010,'Barry'    , null       ,'Allen'     ,'Trollvej'          ,1377,'769','2018-01-02'),
(5011,'Kasper'   , 'Houdini'  ,'Lassesen'  ,'Bordvej'           ,5199,'42S','2018-08-04'),
(5012,'Frederik' , null       ,'Knast'     ,'Pricevej'          ,5706,'053','2018-04-27'),
(5013,'Jack'     , null       ,'Sparrow'   ,'Chipsvej'          ,2985,'148','2018-03-19'),
(5014,'Covariant', null       ,'Vector'    ,'Banandistriktet'   ,1854,'494','2018-08-17'),
(5015,'Angus'    , 'mc'       ,'five'      ,'Tortila bugten'    ,6625,'33V','2018-02-17');

/*Test data for Authers */
#id starts at 6000
insert into `authers` values 
(6001,'Karsten' ,  null   , 'Schmidt' ,'1940-07-26'),
(6002,'Flemming',  null   , 'Schmidt' ,'1960-05-13'),
(6003,'Jesper'  , 'Birch' , 'Samsø'   ,'1996-03-30'),
(6004,'J.'      , 'R. R.' , 'Tolkien' ,'3996-03-30'),
(6005,'J'       , 'K'     , 'Rowlings','0996-03-30');

/*Test data for WrittenBy */
insert into `WrittenBy` values 
(6001,9781861978769),
(6002,9783161484100),
(6003,9780125041904);

/*Test data for RegisteredAt */
insert into `RegisteredAt` values 
(1001,5001,'2007-04-17'),
(1002,5002,'2000-01-19'),
(1003,5003,'2025-07-13');

/*Test data for Loans */
#id starts at 7000
insert into `Loans` values 
(7001,5001,4001,'2017-02-12','2017-02-26'),
(7002,5002,4002,'2016-08-01','2016-08-15'),
(7003,5003,4003,'2025-09-14','2025-09-28');

/*Test data for ArticleToLoans */
insert into `ArticleToLoans` values 
(3001,7001,'2017-02-25'),
(3022,7002,'2016-08-27'),
(3072,7003,'2025-09-26');

/*Test data for LibraryOpeningHours */
insert into `LibraryOpeningHours` values 
('Monday'   ,1001,'08:00:00','16:00:00'),
('Tuesday'  ,1001,'08:00:00','16:00:00'),
('Wedensday',1001,'08:00:00','16:00:00'),
('Thursday' ,1001,'08:00:00','16:00:00'),
('Friday'   ,1001,'08:00:00','16:00:00'),
('Monday'   ,1002,'08:00:00','16:00:00'),
('Tuesday'  ,1002,'08:00:00','16:00:00'),
('Wedensday',1002,'08:00:00','16:00:00'),
('Thursday' ,1002,'08:00:00','17:00:00'),
('Friday'   ,1002,'08:00:00','16:00:00'),
('Monday'   ,1003,'08:00:00','16:00:00'),
('Tuesday'  ,1003,'08:00:00','18:00:00'),
('Wedensday',1003,'08:00:00','16:00:00'),
('Thursday' ,1003,'08:00:00','16:00:00'),
('Friday'   ,1003,'08:00:00','16:00:00');

/*Test data for PhoneNumbers */
insert into `PhoneNumbers` values 
(11223344,2001),
(13223344,2001),
(98345455,2002),
(12434555,2003);


drop procedure if exists addBook;
DELIMITER //
CREATE procedure addBook(Visbn        DECIMAL(13,0),
                         VPublisherID INT, 
                         VDatePublish DATE,
                         VTitle       VARCHAR(45), 
                         VPrice       DECIMAL(6,2), 
                         VArticleID   INT, 
                         VDateBought  DATE, 
                         VPlacementID INT, 
                         VBelongsToID INT, 
                         VAuthersID   INT, 
                         Vcategory    VARCHAR(45))
BEGIN 
DECLARE ISBNtester DECIMAL(13,0);

START TRANSACTION;
INSERT INTO `books`     VALUES (Visbn,
                                VPublisherID,
                                VDatePublish,
                                VTitle,
                                VPrice, 
                                Vcategory);
INSERT INTO `article`   VALUES (VArticleID,
                                VDateBought,
                                VPlacementID,
                                VBelongsToID,
                                Visbn);
INSERT INTO `writtenby` VALUES (VAuthersID,
                                Visbn);

SET ISBNtester = (SELECT ISBN FROM Books 
                  WHERE books.ISBN=Visbn);
IF ISBNtester IS NULL OR ISBNtester != Visbn THEN
	rollback;
END IF;
SET ISBNtester = (SELECT ISBN FROM Article 
                  WHERE article.ISBN=Visbn);
IF ISBNtester IS NULL OR ISBNtester != Visbn THEN
	rollback;
END IF;
SET ISBNtester = (SELECT ISBN FROM WrittenBy 
                  WHERE writtenby.ISBN=Visbn);
IF ISBNtester IS NULL OR ISBNtester != Visbn THEN
	rollback;
END IF;
COMMIT;

END; //
DELIMITER ;


#create books and articles for all things J.R.R. Tolkien
call addBook(9780547928210, 2003, '2012-11-6' , 'The Fellowship of the Ring'               , 2.50, 3100, '2012-11-6' , 1001, 1001, 6004, 'Skønlitteratur');
call addBook(9780547928203, 2003, '2005-2-6'  , 'The Two Towers'                           ,   50, 3101, '2005-2-6'  , 1001, 1001, 6004, 'Skønlitteratur');
call addBook(9780547928197, 2003, '2017-11-6' , 'The Return of the King'                   , 1337, 3102, '2017-11-6' , 1001, 1001, 6004, 'Skønlitteratur');
call addBook(9780544338012, 2003, '2014-8-7'  , 'The Silmarillion'                         ,   42, 3103, '2014-8-7'  , 1001, 1001, 6004, 'Skønlitteratur');
call addBook(9780547928227, 2003, '2012-10-18', 'The Hobbit'                               ,  420, 3104, '2012-10-18', 1001, 1001, 6004, 'Skønlitteratur');
#and harry potter
call addBook(9780439708180, 2003, '1999-9-8'  , 'Harry Potter and the Sorcerer\'s Stone'   ,   23, 3105, '1999-9-8'  , 1002, 1002, 6005, 'Skønlitteratur');
call addBook(9780439064873, 2003, '2000-6-15' , 'Harry Potter And The Chamber Of Secrets'  ,   53, 3106, '2000-6-15' , 1002, 1002, 6005, 'Skønlitteratur');
call addBook(9780439136365, 2003, '2001-9-11' , 'Harry Potter and the Prisoner of Azkaban' ,   13, 3107, '2001-9-11' , 1002, 1002, 6005, 'Skønlitteratur');
call addBook(9780439139601, 2003, '2002-5-30' , 'Harry Potter And The Goblet Of Fire'      ,   74, 3108, '2002-5-30' , 1002, 1002, 6005, 'Skønlitteratur');
call addBook(9780439358071, 2003, '2004-6-10' , 'Harry Potter And The Order Of The Phoenix',   24, 3109, '2004-6-10' , 1002, 1002, 6005, 'Skønlitteratur');
call addBook(9780439785969, 2003, '2006-5-25' , 'Harry Potter and the Half-Blood Prince'   ,   46, 3110, '2006-5-25' , 1002, 1002, 6005, 'Skønlitteratur');
call addBook(9780545139700, 2003, '2009-5-7'  , 'Harry Potter and the Deathly Hallows'     ,   67, 3111, '2009-5-7'  , 1002, 1002, 6005, 'Skønlitteratur');

drop procedure if exists copyArticle;
delimiter //
create procedure copyArticle(In vNewArticleID INT, IN vArticleID INT)
begin 
declare vDateBought  DATE   default '1111-11-11';
declare vPlacementID INT    default 0;
declare vBelongsToID INT    default 0;
declare vISBN decimal(13,0) default 0;

(select DateBought  into vDateBought  from Article where ArticleID = vArticleID);
(select PlacementID into vPlacementID from Article where ArticleID = vArticleID);
(select BelongsToID into vBelongsToID from Article where ArticleID = vArticleID);
(select ISBN        into vISBN        from Article where ArticleID = vArticleID);

insert into Article values (vNewArticleID, vDateBought, vPlacementID, vBelongsToID, vISBN);
end; //
delimiter ;

call copyArticle(3130, 3100);
call copyArticle(3122, 3100);
call copyArticle(3114, 3100);

call copyArticle(3115, 3101);
call copyArticle(3116, 3101);
call copyArticle(3117, 3101);

call copyArticle(3118, 3102);
call copyArticle(3119, 3102);
call copyArticle(3120, 3102);

call copyArticle(3143, 3103);
call copyArticle(3113, 3103);
call copyArticle(3123, 3103);

call copyArticle(3124, 3104);
call copyArticle(3145, 3104);
call copyArticle(3126, 3104);

call copyArticle(3136, 3105);
call copyArticle(3128, 3105);
call copyArticle(3129, 3105);

call copyArticle(3112, 3106);
call copyArticle(3131, 3106);
call copyArticle(3132, 3106);

call copyArticle(3133, 3107);
call copyArticle(3134, 3107);
call copyArticle(3135, 3107);

call copyArticle(3127, 3108);
call copyArticle(3137, 3108);
call copyArticle(3138, 3108);

call copyArticle(3139, 3109);
call copyArticle(3140, 3109);
call copyArticle(3141, 3109);

call copyArticle(3142, 3110);
call copyArticle(3121, 3110);
call copyArticle(3144, 3110);

call copyArticle(3125, 3111);
call copyArticle(3146, 3111);
call copyArticle(3147, 3111);



drop procedure if exists addLoan;
delimiter //
create procedure addLoan(In vLoanID INT, IN vLoanerID INT, IN vLibrarianID INT, IN vStartDate DATE, IN vArticleID INT, IN vReturnedDate DATE)
begin 
insert into Loans values (vLoanID, vLoanerID, vLibrarianID, vStartDate, ADDDATE(vStartDate, 21));
insert into ArticleToLoans values (vArticleID, vLoanID, vReturnedDate);
end; //
delimiter ;

call addLoan(7004, 5001, 4001, '2012-12-30', 3100, '2013-01-12');
call addLoan(7005, 5001, 4001, '2011-08-16', 3101, null);
call addLoan(7006, 5001, 4001, '2012-02-27', 3102, '2012-03-15');
call addLoan(7007, 5003, 4001, '2012-10-23', 3103, '2012-11-04');
call addLoan(7008, 5004, 4001, '2012-07-19', 3131, null);
call addLoan(7009, 5005, 4001, '2013-04-15', 3105, '2013-04-24');
call addLoan(7010, 5006, 4001, '2017-02-06', 3106, '2017-02-20');
call addLoan(7011, 5006, 4001, '2012-12-23', 3107, '2012-12-27');
call addLoan(7012, 5006, 4002, '2015-09-29', 3133, null);
call addLoan(7013, 5007, 4002, '2013-12-30', 3109, '2014-01-06');
call addLoan(7014, 5007, 4002, '2013-11-01', 3110, '2013-11-13');
call addLoan(7015, 5008, 4002, '2015-01-03', 3111, '2015-01-06');
call addLoan(7016, 5008, 4002, '2019-01-12', 3135, null);
call addLoan(7017, 5008, 4002, '2019-03-10', 3113, '2019-03-20');
call addLoan(7018, 5008, 4002, '2023-04-07', 3114, '2023-04-30');
call addLoan(7019, 5008, 4002, '2003-06-22', 3137, '2003-06-30');
call addLoan(7020, 5009, 4002, '2012-07-28', 3138, '2012-08-05');
call addLoan(7021, 5011, 4002, '2002-01-19', 3117, '2002-01-25');
call addLoan(7022, 5011, 4003, '2002-09-02', 3118, null);
call addLoan(7023, 5011, 4003, '2004-09-17', 3140, null);
call addLoan(7024, 5011, 4003, '2002-01-25', 3120, '2002-02-07');
call addLoan(7025, 5012, 4003, '1969-02-21', 3121, '1969-03-04');
call addLoan(7026, 5012, 4003, '1989-02-16', 3143, '1989-03-17');
call addLoan(7027, 5014, 4003, '1959-03-20', 3123, '1959-03-29');
call addLoan(7028, 5014, 4003, '1968-05-06', 3124, '1968-05-17');
call addLoan(7029, 5015, 4003, '1971-03-11', 3147, null);
call addLoan(7030, 5015, 4003, '1977-08-28', 3126, '1977-09-09');
call addLoan(7031, 5015, 4003, '1979-11-27', 3127, null);
call addLoan(7032, 5015, 4003, '2015-12-12', 3128, '2015-12-25');
call addLoan(7033, 5015, 4003, '2016-10-13', 3129, '2016-10-18');









