Use Library;

/* Test data for libraries*/
insert into `Libraries` values 
(1001,'Egedal Bibliotek','34H',3850,'Træhusevej',40000),
(1002,'Birkerød Bibliotek','12J',3450,'Træhusevej',12000),
(1003,'Thisted Bibliotek','42G',7000,'Pipedrejervej',20000);

/* Test data for publisher*/
insert into `Publisher` values 
(2001,'Matematik Forlaget','78Q','Matricevej',9999,NULL),
(2002,'Computer Forlaget','13A','Databasevej',5555, NULL),
(2003,'Awesome Forlaget','Rytterkær','139',2765,'666');

/*Test data for Books */
insert into `Books` values 
(1000743468643,2001,'2003-07-07','Crazy Horse and Custer',000300.00),
(1000863668841,2002,'1989-07-07','Solitons in Optical fibers',000700.00),
(1001234567123,2003,'2015-03-02','Livet som Jesper',000666.00);

/*Test data for Article */
insert into `Article` values 
(3001,'2004-09-12',1001,1001,'Faglitteratur',1000743468643),
(3002,'2004-09-12',1001,1001,'Faglitteratur',1000743468643),
(3022,'1995-01-03',1003,1001,'Faglitteratur',1000863668841),
(3072,'2015-01-03',1002,1001,'Awesomelitteratur',1001234567123);

/*Test data for Librarian */
insert into `Librarian` values 
(4001,'Beate','Stenstrøm','Habberbug','S69','Edderkoppedal',3850,'1970-08-12',26000,1001,'1995-12-12',null),
(4002,'Per',null,'Jensen','84V','Saturnvej',3450,'1980-11-01',27000,1002,'2005-12-12',null),
(4003,'Anders','Samsø','Birch','139','Rytterkær',7000,'1996-03-30',30000,1003,'2016-01-05',null);

/*Test data for Loaners */
insert into `Loaners` values 
(5001,'Terkel','Stenstrøm','Hansen','Edderkoppedal',3850,'S69','2000-02-10'),
(5002,'Susanne',null,'Jensen','Saturnvej',3450,'84V','1981-07-13'),
(5003,'Legolas','Den','mægtige','Rytterkær',7000,'139','2018-03-30');

/*Test data for Authers */
insert into `Authers` values 
(6001,'Karsten',"", 'Schmidt','1940-07-26'),
(6002,'Flemming',"",'Schmidt','1960-05-13'),
(6003,'Jesper', 'Samsø', 'Birch','1996-03-30');

/*Test data for WrittenBy */
insert into `WrittenBy` values 
(6001,1000743468643),
(6002,1000863668841),
(6003,1001234567123);

/*Test data for RegisteredAt */
insert into `RegisteredAt` values 
(1001,5001,'2007-04-17'),
(1002,5002,'2000-01-19'),
(1003,5003,'2025-07-13');


/*Test data for Loans */
insert into `Loans` values 
(7001,3001,5001,4001,'2017-02-12','2017-02-26','2017-02-25'),
(7005,3002,5001,4001,'2017-02-12','2017-02-26',Null),
(7002,3022,5002,4002,'2016-08-01','2016-08-15','2016-08-27'),
(7003,3072,5003,4003,'2025-09-14','2025-09-28','2025-09-26'),
(7004,3072,5003,4003,'2026-09-14','2026-09-28','2026-09-26');

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