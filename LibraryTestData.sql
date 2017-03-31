Use Library;

/* Test data for libraries*/
#id starts at 1000
insert into `Libraries` values 
(1001,'Egedal Bibliotek','34H',3850,'Træhusevej',40000),
(1002,'Birkerød Bibliotek','12J',3450,'Træhusevej',12000),
(1003,'Thisted Bibliotek','42G',7000,'Pipedrejervej',20000);


/* Test data for publisher*/
#id starts at 2000
insert into `Publisher` values
(2001,'Matematik Forlaget','78Q','Matricevej',9999,NULL),
(2002,'Computer Forlaget','13A','Databasevej',5555, NULL),
(2003,'Awesome Forlaget','Rytterkær','139',2765,'666');

/*Test data for Books */
insert into `Books` values 
(1000743468643,2001,'2003-07-07','Crazy Horse and Custer',000300.00),
(1000863668841,2002,'1989-07-07','Solitons in Optical fibers',000700.00),
(1000000000000,2003,'2014-03-02','Livet som Anders',000666.00),
(1001234567123,2003,'2015-03-02','Livet som Jesper',000666.00);

/* Test data for Litterature*/
insert into `Litterature` values(1000743468643,'Faglitteratur'),
(1000863668841,'Faglitteratur'),
(1001234567123,'Awesomelitteratur');

/*Test data for Article */
#id starts at 3000
DELETE FROM Article;
insert into `Article` values 
(3001,'2004-09-12',1001,1001,1000743468643),
(3022,'1995-01-03',1003,1001,1000863668841),
(3072,'2015-01-03',1002,1001,1001234567123),
(3002,'2004-09-18',1002,1002,1000743468643),
(3003,'1995-01-09',1002,1002,1000863668841),
(3004,'2015-02-23',1002,1002,1001234567123),
(3005,'2006-02-27',1003,1003,1000743468643),
(3006,'1999-02-04',1003,1003,1000863668841),
(3007,'2016-04-25',1003,1003,1001234567123),
(3008,'2004-09-18',1002,1003,1000743468643),
(3009,'1995-01-09',1003,1002,1000863668841),
(3010,'2015-02-23',1001,1001,1001234567123),
(3011,'2015-02-23',1001,1001,1000000000000);
/*Test data for Librarian */
#id starts at 4000
insert into `Librarian` values 
(4001,'Beate','Stenstrøm','Habberbug','S69','Edderkoppedal',3850,'1970-08-12',26000,1001,'1995-12-12',null),
(4002,'Per',null,'Jensen','84V','Saturnvej',3450,'1980-11-01',27000,1002,'2005-12-12',null),
(4003,'Anders','Samsø','Birch','139','Rytterkær',7000,'1996-03-30',30000,1003,'2016-01-05',null);

/*Test data for Loaners */
#id starts at 5000
insert into `Loaners` values
(5001,'Terkel','Stenstrøm','Hansen','Edderkoppedal',3850,'S69','2000-02-10'),
(5002,'Susanne',null,'Jensen','Saturnvej',3450,'84V','1981-07-13'),
(5003,'Legolas','Den','Mægtige','Rytterkær',7000,'139','2018-03-30');

/*Test data for Authers */
#id starts at 6000
insert into `Authers` values 
(6001,'Karsten',null, 'Schmidt','1940-07-26'),
(6002,'Flemming',null,'Schmidt','1960-05-13'),
(6003,'Jesper', 'Samsø', 'Birch','1996-03-30');

/*Test data for WrittenBy */
insert into `WrittenBy` values 
(6001,1000743468643),
(6002,1000863668841),
(6003,1001234567123),
(6003,1000000000000);

DELETE FROM RegisteredAt;
/*Test data for RegisteredAt */
insert into `RegisteredAt` values 
(1001,5001,'2007-04-17'),
(1002,5002,'2000-01-19'),
(1003,5003,'2025-07-13');


DELETE FROM Loans;
/*Test data for Loans */
#id starts at 7000
insert into `Loans` values 
(7001,5001,4001,'2017-02-12','2017-02-26'),
(7002,5002,4002,'2016-08-01','2016-08-15'),
(7004,5001,4002,'2017-02-01','2017-06-01'),
(7003,5003,4003,'2025-09-14','2025-09-28');

DELETE FROM ArticleToLoans;
/*Test data for ArticleToLoans */
insert into `ArticleToLoans` values 
(3001,7001,'2017-02-25'),
(3022,7001,'2017-02-25'),
(3022,7002,'2016-08-27'),
(3001,7002,'2016-08-30'),
(3001,7004,NULL),
(3072,7003,'2025-09-26');

/*Test data for LibraryOpeningHours */
insert into `LibraryOpeningHours` values 
('Monday',1001,'08:00:00','16:00:00'),
('Tuesday',1001,'08:00:00','16:00:00'),
('Wedensday',1001,'08:00:00','16:00:00'),
('Thursday',1001,'08:00:00','16:00:00'),
('Friday',1001,'08:00:00','16:00:00'),
('Monday',1002,'08:00:00','16:00:00'),
('Tuesday',1002,'08:00:00','16:00:00'),
('Wedensday',1002,'08:00:00','16:00:00'),
('Thursday',1002,'08:00:00','17:00:00'),
('Friday',1002,'08:00:00','16:00:00'),
('Monday',1003,'08:00:00','16:00:00'),
('Tuesday',1003,'08:00:00','18:00:00'),
('Wedensday',1003,'08:00:00','16:00:00'),
('Thursday',1003,'08:00:00','16:00:00'),
('Friday',1003,'08:00:00','16:00:00');


#create books and articles for all things J.R.R. Tolkien
call CreateTestBookAndArticle(9780547928210, 2003, 'The Fellowship of the Ring', 2.50, 	3100, '2012-11-6', 	1001);
call CreateTestBookAndArticle(9780547928203, 2003, 'The Two Towers',               50, 	3101,  '2005-2-6', 	1001);
call CreateTestBookAndArticle(9780547928197, 2003, 'The Return of the King',     1337,  3102, '2017-11-6', 	1001);
call CreateTestBookAndArticle(9780544338012, 2003, 'The Silmarillion',             42,  3103,  '2014-8-7', 	1001);
call CreateTestBookAndArticle(9780547928227, 2003, 'The Hobbit',                  420,  3104,'2012-10-18', 	1001);

call CreateTestBookAndArticle(9780439708180, 2003, 'Harry Potter and the Sorcerer\'s Stone',    23, 3105, '1999-9-8' , 1002);
call CreateTestBookAndArticle(9780439064873, 2003, 'Harry Potter And The Chamber Of Secrets',   53, 3106, '2000-6-15', 1002);
call CreateTestBookAndArticle(9780439136365, 2003, 'Harry Potter and the Prisoner of Azkaban',  13, 3107, '2001-9-11', 1002);
call CreateTestBookAndArticle(9780439139601, 2003, 'Harry Potter And The Goblet Of Fire',       74, 3108, '2002-5-30', 1002);
call CreateTestBookAndArticle(9780439358071, 2003, 'Harry Potter And The Order Of The Phoenix', 24, 3109, '2004-6-10', 1002);
call CreateTestBookAndArticle(9780439785969, 2003, 'Harry Potter and the Half-Blood Prince',    46, 3110, '2006-5-25', 1002);
call CreateTestBookAndArticle(9780545139700, 2003, 'Harry Potter and the Deathly Hallows',      67, 3111, '2009-5-7', 1002);

/*Test data for PhoneNumbers */
insert into `PhoneNumbers` values 
(11223344,2001),
(13223344,2001),
(98345455,2002),
(12434555,2003);
