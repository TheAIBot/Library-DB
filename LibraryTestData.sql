Use library;

/* Test data for libraries*/
insert into `libraries` values (1001,'Egedal Bibliotek','34H',3850,'Træhusevej',40000),
(1002,'Birkerød Bibliotek','12J',3450,'Træhusevej',12000),
(1003,'Thisted Bibliotek','42G',7000,'Pipedrejervej',20000);

/* Test data for libraries*/
insert into `publisher` values (2001,'Matematik Forlaget','78Q','Matricevej',9999,NULL),
(2002,'Computer Forlaget','13A','Databasevej',5555, NULL),
(2003,'Awesome Forlaget','Rytterkær','139',2765,'666');

/*Test data for Books */
insert into `books` values (1000743468643,2001,'2003-07-07','Crazy Horse and Custer',000300.00),
(1000863668841,2002,'1989-07-07','Solitons in Optical fibers',000700.00),
(1001234567123,2003,'2015-03-02','Livet som Jesper',000666.00);

/*Test data for Article */
insert into `article` values (3001,'2004-09-12',1001,1001,'Faglitteratur',1000743468643),
(3022,'1995-01-03',1003,1001,'Faglitteratur',1000863668841),
(3072,'2015-01-03',1002,1001,'Awesomelitteratur',1001234567123);

/*Test data for Librarian */
insert into `librarian` values (4001,'Beate','Stenstrøm','Habberbug','S69','Edderkoppedal',3850,'1970-08-12',26000,1001,'1995-12-12',null),
(4002,'Per',null,'Jensen','84V','Saturnvej',3450,'1980-11-01',27000,1002,'2005-12-12',null),
(4003,'Anders','Samsø','Birch','139','Rytterkær',7000,'1996-03-30',30000,1003,'2016-01-05',null);

/*Test data for Loaners */
insert into `loaners` values (5001,'Terkel','Stenstrøm','Hansen','Edderkoppedal',3850,'S69','2000-02-10'),
(5002,'Susanne',null,'Jensen','Saturnvej',3450,'84V','1981-07-13'),
(5003,'Legolas','Den','mægtige','Rytterkær',7000,'139','2018-03-30');

/*Test data for Authers */
insert into `authers` values (6001,'Karsten',null, 'Schmidt','1940-07-26'),
(6002,'Flemming',null,'Schmidt','1960-05-13'),
(6003,'Jesper', 'Birch', 'Samsø','1996-03-30');
