Use library;

/* Test data for libraries*/
#id starts at 1000
insert into `Libraries` values (1001,'Egedal Bibliotek','34H',3850,'Træhusevej',40000),
(1002,'Birkerød Bibliotek','12J',3450,'Træhusevej',12000),
(1003,'Thisted Bibliotek','42G',7000,'Pipedrejervej',20000);


/* Test data for publisher*/
#id starts at 2000
insert into `Publisher` values (2001,'Matematik Forlaget','78Q','Matricevej',9999,NULL),
(2002,'Computer Forlaget','13A','Databasevej',5555, NULL),
(2003,'Awesome Forlaget','Rytterkær','139',2765,'666');

/*Test data for Books */  
insert into `Books` values (9781861978769,2001,'2003-07-07','Crazy Horse and Custer',000300.00,'Faglitteratur'),
(9783161484100,2002,'1989-07-07','Solitons in Optical fibers',000700.00,'Faglitteratur'),
(9780125041904,2003,'2015-03-02','Livet som Jesper',000666.00,'Awesomelitteratur');


/*Test data for Article */
#id starts at 3000
insert into `Article` values (3001,'2004-09-12',1001,1001,9781861978769),
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
insert into `Librarian` values (4001,'Beate','Stenstrøm','Habberbug','S69','Edderkoppedal',3850,'1970-08-12',26000,1001,'1995-12-12',null),
(4002,'Per',null,'Jensen','84V','Saturnvej',3450,'1980-11-01',27000,1002,'2005-12-12',null),
(4003,'Anders','Samsø','Birch','139','Rytterkær',7000,'1996-03-30',30000,1003,'2016-01-05',null);

/*Test data for Loaners */
#id starts at 5000
insert into `Loaners` values (5001,'Terkel','Stenstrøm','Hansen','Edderkoppedal',3850,'S69','2000-02-10'),
(5002,'Susanne',null,'Jensen','Saturnvej',3450,'84V','1981-07-13'),
(5003,'Legolas','Den','mægtige','Rytterkær',7000,'139','2018-03-30');

/*Test data for Authers */
#id starts at 6000
insert into `Authers` values (6001,'Karsten',null, 'Schmidt','1940-07-26'),
(6002,'Flemming',null,'Schmidt','1960-05-13'),
(6003,'Jesper', 'Birch', 'Samsø','1996-03-30');

/*Test data for WrittenBy */
insert into `WrittenBy` values (6001,9781861978769),
(6002,9783161484100),
(6003,9780125041904);

/*Test data for RegisteredAt */
insert into `RegisteredAt` values (1001,5001,'2007-04-17'),
(1002,5002,'2000-01-19'),
(1003,5003,'2025-07-13');


/*Test data for Loans */
#id starts at 7000
insert into `Loans` values (7001,5001,4001,'2017-02-12','2017-02-26'),
(7002,5002,4002,'2016-08-01','2016-08-15'),
(7003,5003,4003,'2025-09-14','2025-09-28');

/*Test data for ArticleToLoans */
insert into `ArticleToLoans` values (3001,7001,'2017-02-25'),
(3022,7002,'2016-08-27'),
(3072,7003,'2025-09-26');

/*Test data for LibraryOpeningHours */
insert into `LibraryOpeningHours` values ('Monday',1001,'08:00:00','16:00:00'),
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

/*Test data for PhoneNumbers */
insert into `PhoneNumbers` values (11223344,2001),
(13223344,2001),
(98345455,2002),
(12434555,2003);
