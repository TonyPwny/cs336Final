USE DB1;

DROP TABLE IF EXISTS reserves;
DROP TABLE IF EXISTS buys;
DROP TABLE IF EXISTS `User`;
DROP TABLE IF EXISTS trip;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Seat;
DROP TABLE IF EXISTS owns;
DROP TABLE IF EXISTS operates;
DROP TABLE IF EXISTS FlightDate;
DROP TABLE IF EXISTS Flight;
DROP TABLE IF EXISTS Aircraft;
DROP TABLE IF EXISTS Airline;
DROP TABLE IF EXISTS Airport;

CREATE TABLE `User` (
username VARCHAR(25) NOT NULL,
password VARCHAR(25) NOT NULL,
name_user VARCHAR(25) NOT NULL,
usertype VARCHAR(9) NOT NULL,
PRIMARY KEY(username)
);

CREATE TABLE Airline (
airline_name CHAR(30) NOT NULL,
airline_id CHAR(2) NOT NULL,
PRIMARY KEY(airline_id)
);

CREATE Table Airport (
airport_id CHAR(3) NOT NULL,
name CHAR(50) NOT NULL,
city VARCHAR(20) NOT NULL,
state CHAR(20) NOT NULL,
country VARCHAR(20) NOT NULL,
PRIMARY KEY(airport_id)
);

CREATE Table Aircraft (
aircraft_id VARCHAR(8) NOT NULL,
airline_id CHAR(2) NOT NULL,
capacity INT NOT NULL,
first_class_capacity INT NOT NULL,
business_capacity INT NOT NULL,
economy_capacity INT NOT NULL,
PRIMARY KEY(aircraft_id, airline_id),
FOREIGN KEY(airline_id) REFERENCES Airline(airline_id)
	on delete cascade
    on update cascade
);




CREATE TABLE owns (
airline_id CHAR(2) NOT NULL,
aircraft_id VARCHAR(8) NOT NULL,
PRIMARY KEY(airline_id, aircraft_id),
FOREIGN KEY(airline_id) REFERENCES Airline(airline_id)
	on delete cascade
    on update cascade,
FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id)
	on delete cascade
    on update cascade
);



CREATE Table Flight (
flight_id VARCHAR(6) NOT NULL,
airline_id VARCHAR(2) NOT NULL,
aircraft_id VARCHAR(8) NOT NULL,
depart_aid char(3) NOT NULL,
arrive_aid char(3) NOT NULL,
depart_time time NOT NULL,
arrive_time time NOT NULL,
flight_days VARCHAR(11) NOT NULL,
flight_type VARCHAR(15) NOT NULL,
fare_econ DECIMAL(6, 2) NOT NULL,
fare_first DECIMAL(7, 2) NOT NULL,
fare_bus DECIMAL(7, 2) NOT NULL,
PRIMARY KEY(flight_id),
FOREIGN KEY(depart_aid) REFERENCES Airport(airport_id)
	on delete cascade
    on update cascade,
FOREIGN KEY(arrive_aid) REFERENCES Airport(airport_id)
	on delete cascade
    on update cascade,
FOREIGN KEY(airline_id) REFERENCES Airline(airline_id)
	on delete cascade
    on update cascade,
FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id)
	on delete cascade
    on update cascade
);

CREATE Table FlightDate (
depart_date date NOT NULL,
arrive_date date NOT NULL,
flight_id VARCHAR(6) NOT NULL,
PRIMARY KEY (depart_date, arrive_date, flight_id),
FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
	on delete cascade
    on update cascade
);

CREATE Table operates (
flight_id VARCHAR(6) NOT NULL,
airline_id CHAR(2) NOT NULL,
aircraft_id VARCHAR(6) NOT NULL,
PRIMARY KEY(flight_id, airline_id, aircraft_id),
FOREIGN KEY(flight_id) REFERENCES Flight(flight_id)
	on delete cascade
    on update cascade,
FOREIGN KEY(airline_id) REFERENCES Airline(airline_id)
	on delete cascade
    on update cascade,
FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id)
	on delete cascade
    on update cascade
);

CREATE TABLE Ticket (
ticket_num INT8 NOT NULL,
round_trip BOOLEAN NOT NULL,
booking_fee DECIMAL(5,2) NOT NULL,
total_fare DECIMAL(7,2) NOT NULL,
issue_date DATETIME NOT NULL,
PRIMARY KEY(ticket_num)
);


CREATE TABLE reserves (
username VARCHAR(25) NOT NULL,
ticket_num INT8 NOT NULL, 
PRIMARY KEY(username, ticket_num),
FOREIGN KEY(username) REFERENCES `User`(username)
	on delete cascade
    on update cascade,
FOREIGN KEY(ticket_num) REFERENCES Ticket(ticket_num)
	on delete cascade
    on update cascade
);

CREATE TABLE buys (
username VARCHAR(25) NOT NULL,
ticket_num INT8 NOT NULL, 
PRIMARY KEY(username, ticket_num),
FOREIGN KEY(username) REFERENCES `User`(username)
	on delete cascade
    on update cascade,
FOREIGN KEY(ticket_num) REFERENCES Ticket(ticket_num)
	on delete cascade
    on update cascade
);


CREATE Table trip (
ticket_num INT8 NOT NULL,
flight_id VARCHAR(6) NOT NULL,
class VARCHAR(15) NOT NULL,
meal BOOLEAN NOT NULL,
depart_date date NOT NULL,
arrive_date date NOT NULL,
PRIMARY KEY(ticket_num, flight_id),
FOREIGN KEY(ticket_num) REFERENCES Ticket(ticket_num)
	on delete cascade
    on update cascade,
FOREIGN KEY (depart_date) REFERENCES FlightDate(depart_date)
	on delete cascade
    on update cascade,
FOREIGN KEY(flight_id) REFERENCES Flight(flight_id)
	on delete cascade
    on update cascade
);


INSERT INTO `User` VALUES('tony', '123', 'Anthony', 'Admin');
INSERT INTO `User` VALUES('utony', '123', 'Utony', 'User');
INSERT INTO `User` VALUES('ssteven', 'Greens', 'Steven', 'Admin');
INSERT INTO `User` VALUES('nicky', 'pass', 'Nicky','User');
INSERT INTO `User` VALUES('stony', 'Greens', 'Stony', 'SalesRep');
INSERT INTO `User` VALUES('tsarah', 'Captains', 'Sarah', 'Admin');
INSERT INTO `User` VALUES('tregina', 'Lateness12', 'Regina', 'User');
INSERT INTO `User` VALUES('eddy', 'okok', 'Eddie', 'User');


/*Domestic*/
INSERT INTO Airport VALUES('EWR', 'Newark Liberty International Airport', 'Newark', 'New Jersey', 'United States');
INSERT INTO Airport VALUES('JFK', 'John F. Kennedy International Airport', 'New York City', 'New York', 'United States');
INSERT INTO Airport VALUES('MIA', 'Miami International Airport', 'Miami', 'Florida', 'United States');
INSERT INTO Airport VALUES('SFO', 'San Francisco International Airport', 'San Franciso', 'California', 'United States');
INSERT INTO Airport VALUES('MDW', 'Midway International Airport', 'Chicago', 'Illinois', 'United States');
INSERT INTO Airport VALUES ('LAX', 'Los Angeles International Airport', 'Los Angeles', 'California', 'United States');

/*International*/
INSERT INTO Airport VALUES('LCY','London City Airport', 'London', 'Greater London', 'England');
INSERT INTO Airport VALUES('DUB', 'Dublin Airport', 'Dublin', 'Leinster', 'Ireland');
INSERT INTO Airport VALUES('PEK', 'Beijing Capital International Airport', 'Beijing', 'Hebei', 'China');
INSERT INTO Airport VALUES('SYD', 'Sydney Airport', 'Sydney', 'New South Wales', 'Australia');
INSERT INTO Airport VALUES('YTZ', 'Billy Bishop Toronto City Airport', 'Toronto', 'Ontario', 'Cananda');


/*Domestic*/
INSERT INTO Airline Values('Seaborne','BB');
INSERT INTO Airline Values('Sevenair ','UG');
INSERT INTO Airline Values('Sun Country','SY');
INSERT INTO Airline Values('Skywalk Airlines','AL');
INSERT INTO Airline Values('Delta','DL');
INSERT INTO Airline Values ('American Airlines','AA');

/*International*/
INSERT INTO Airline Values('Tap Portugal','TP');
INSERT INTO Airline Values('Aer Lingus','EI');
INSERT INTO Airline Values('Airfrance','AF');
INSERT INTO Airline Values('British Airways','BA');
INSERT INTO Airline Values('Virgin Australia Regional Airlines','VA');


/*Domestic*/
INSERT INTO Aircraft Values('B33R3','BB', 280, 19, 24, 237);
INSERT INTO Aircraft Values('D54R2','UG', 400, 17, 33, 350);
INSERT INTO Aircraft Values('F32R1','SY', 335, 16, 34, 285);
INSERT INTO Aircraft Values('Q46P2','AL', 340, 17, 36, 287);
INSERT INTO Aircraft Values('O30K0','DL', 436, 19, 28, 389);
INSERT INTO Aircraft Values('E78P8','AA', 420, 20, 29, 371);



/*International*/
INSERT INTO Aircraft Values('A23D3','TP', 293, 20, 30, 243);
INSERT INTO Aircraft Values('R25D2','EI', 330, 23, 35, 272);
INSERT INTO Aircraft Values('C31P0','AF', 420, 15, 25, 380);
INSERT INTO Aircraft Values('L12L1','BA', 426, 18, 31, 377);
INSERT INTO Aircraft Values('P09K2','VA', 440, 25, 36, 379);



/*Domestic*/
INSERT INTO Flight VALUES('BB6543', 'BB', 'B33R3', 'MIA', 'EWR', '11:02', '14:10', 'SuFSa', 'domestic', 160, 600, 18);
INSERT INTO FlightDate VALUES('2020-01-29', '2020-01-29', 'BB6543');
INSERT INTO Flight VALUES('BB9863','BB','B33R3', 'EWR', 'MIA', '10:02', '13:15', 'SuFSa', 'domestic', 170, 500, 30);
INSERT INTO FlightDate VALUES('2020-01-13', '2020-01-13', 'BB9863');
INSERT INTO FlightDate VALUES('2020-01-29', '2020-01-29', 'BB9863');


/*Make flight from Newark-San Franciso, 3 seperates days and times (Arrrival and departure)
San Franciso-China-Connected flight */ 
INSERT INTO Flight VALUES('DL6781','DL','O30K0','EWR', 'SFO', '13:01','19:46','MRFSa', 'domestic', 170, 206, 18);
INSERT INTO FlightDate VALUES('2020-07-05', '2020-07-05', 'DL6781');
INSERT INTO Flight VALUES('DL7654','DL','O30K0', 'EWR', 'SFO', '12:00','18:47','MRFSa', 'domestic', 170, 296, 18);
INSERT INTO FlightDate VALUES('2020-07-06', '2020-07-06', 'DL7654');

INSERT INTO Flight VALUES('BA9872','BA','L12L1', 'SFO', 'PEK', '21:46','13:40','WF', 'international', 180, 230, 30);
INSERT INTO FlightDate VALUES('2020-07-05', '2020-07-06', 'BA9872');

#Test addition to connected flight for flexible date and time
INSERT INTO Flight VALUES('AL6781','AL','Q46P2', 'EWR', 'SFO', '1:01','19:46','SuSa', 'domestic', 140, 216, 18);
INSERT INTO FlightDate VALUES('2020-07-08', '2020-07-08', 'AL6781');
INSERT INTO Flight VALUES('AL7654','AL','Q46P2', 'EWR', 'SFO', '11:10','17:49','SuSa', 'domestic', 160, 209, 30);
INSERT INTO FlightDate VALUES('2020-07-09', '2020-07-09', 'AL7654');

INSERT INTO Flight VALUES('AF8976','AF','C31P0', 'SFO', 'PEK', '20:46','12:35','SuSa', 'international', 180, 230, 30);
INSERT INTO FlightDate VALUES('2020-07-09', '2020-07-10', 'AF8976');


INSERT INTO Flight VALUES('UG6791','UG','D54R2', 'EWR', 'SFO', '2:02','20:50','SuMTWSa', 'domestic', 140, 216, 18);
INSERT INTO FlightDate VALUES('2020-07-10', '2020-07-10', 'UG6791');
INSERT INTO Flight VALUES('UG0987','UG','D54R2', 'EWR', 'SFO', '12:06','18:56','SuMTWSa', 'domestic', 160, 209, 30);
INSERT INTO FlightDate VALUES('2020-07-11', '2020-07-11', 'UG0987');

INSERT INTO Flight VALUES('TP4568','TP','A23D3', 'SFO', 'PEK', '20:46','12:35','SuMTWRFSa', 'international', 180, 230, 30);
INSERT INTO FlightDate VALUES('2020-08-12', '2020-08-13', 'TP4568');
INSERT INTO FlightDate VALUES('2020-08-13', '2020-08-14', 'TP4568');
INSERT INTO FlightDate VALUES('2020-08-11', '2020-08-12', 'TP4568');
INSERT INTO FlightDate VALUES('2020-07-11', '2020-07-12', 'TP4568');


#End test CASE

#TestCase-domestic airport to international, no intermediarries
INSERT INTO Flight VALUES('BA8765','BA','L12L1', 'EWR', 'PEK', '10:06','23:56','WF', 'international', 180, 230, 30);
INSERT INTO FlightDate VALUES('2020-07-14', '2020-07-14', 'BA8765');


#Test case-Connected Flights but reversed
INSERT INTO Flight VALUES('TP4561','TP','A23D3', 'PEK', 'SFO', '10:30','23:20','SuMTWRFSa', 'international', 170, 430, 15);
INSERT INTO FlightDate VALUES('2020-08-12', '2020-08-12', 'TP4561');

INSERT INTO Flight VALUES('UG5432','UG','D54R2', 'SFO', 'EWR', '12:00','16:45','SuMTWSa', 'domestic', 140, 216, 18);
INSERT INTO FlightDate VALUES('2020-08-13', '2020-08-13', 'UG5432');
#End of test case

/*Domestic*/
INSERT INTO Flight VALUES('SY9813','SY', 'F32R1', 'MIA', 'SFO', '10:10', '17:16', 'SuMWFSa', 'domestic', 190, 910, 18);
INSERT INTO FlightDate VALUES('2020-01-01', '2020-01-01', 'SY9813');
INSERT INTO Flight VALUES('SY9987','SY', 'F32R1', 'SFO', 'MIA', '10:10', '17:16', 'SuMWFSa', 'domestic', 190, 910, 18);
INSERT INTO FlightDate VALUES('2021-01-01', '2021-01-01', 'SY9987');


INSERT INTO Flight Values('AA9876','AA', 'E78P8', 'MDW', 'LAX', '12:17', '17:27', 'SuMTWR', 'domestic', 130, 700, 30);
INSERT INTO FlightDate VALUES('2020-12-19', '2020-12-19', 'AA9876');
INSERT INTO Flight VALUES('AL0876', 'AL', 'Q46P2', 'LAX', 'MDW', '18:14', '21:26', 'SuMTWR', 'domestic', 210, 820, 30);
INSERT INTO FlightDate VALUES('2022-02-01', '2022-02-01', 'AL0876');

INSERT INTO Flight Values('BB1233','BB', 'B33R3', 'MDW', 'JFK', '16:30', '21:30', 'SuFSa', 'domestic', 150, 800, 18);
INSERT INTO FlightDate VALUES('2020-02-06', '2020-02-06', 'BB1233');
INSERT INTO Flight Values('BB1232','UG', 'B33R3', 'JFK', 'MDW', '10:00', '12:20', 'MF', 'domestic', 190, 400, 30);
INSERT INTO FlightDate VALUES('2020-02-19', '2020-02-19', 'BB1232');


INSERT INTO Flight Values('DL0950','DL', 'Q46P2', 'LAX', 'SFO', '17:30', '23:20', 'TWR', 'domestic', 180, 700, 18);
INSERT INTO FlightDate VALUES('2021-02-21', '2021-02-21', 'DL0950');
INSERT INTO Flight Values('DL1980','DL', 'Q46P2', 'SFO', 'LAX', '8:30', '13:05', 'TWR', 'domestic', 190, 400, 30);
INSERT INTO FlightDate VALUES('2020-03-21', '2020-03-21', 'DL1980');


INSERT INTO Flight Values('AA1789','AA', 'E78P8', 'MDW', 'EWR', '11:30', '16:20', 'SuMTWR', 'domestic', 190, 600, 30);
INSERT INTO FlightDate VALUES('2020-12-19', '2020-12-19', 'AA1789');
INSERT INTO Flight Values('AA1237','AA', 'E78P8',  'EWR', 'MDW', '14:00', '19:40', 'SuMTWR', 'domestic', 180, 300, 18);
INSERT INTO FlightDate VALUES('2022-02-02', '2022-02-02', 'AA1237');
INSERT INTO FlightDate VALUES('2022-02-03', '2022-02-03', 'AA1237');
INSERT INTO FlightDate VALUES('2022-02-04', '2022-02-04', 'AA1237');

INSERT INTO Flight VALUES('BB3579','BB','B33R3', 'EWR', 'JFK', '09:02', '11:20', 'SuFSa', 'domestic', 180, 630, 18);
INSERT INTO FlightDate VALUES('2020-01-30', '2020-01-30', 'BB3579');
INSERT INTO Flight VALUES('BB3890','BB','B33R3', 'JFK', 'EWR', '11:02', '13:22', 'SuFSa', 'domestic', 150, 620, 30);
INSERT INTO FlightDate VALUES('2020-06-28', '2020-06-28', 'BB3890');



/*International*/
INSERT INTO Flight VALUES('TP5432','TP','A23D3', 'LCY', 'PEK', '10:00', '22:10', 'SuMTWRFSa', 'international', 120, 500, 18);
INSERT INTO FlightDate VALUES('2022-01-29', '2022-01-29', 'TP5432');
INSERT INTO Flight VALUES('TP1021', 'TP','A23D3', 'LCY', 'PEK', '13:00', '23:15', 'SuMTWRFSa', 'international', 300, 800, 30);
INSERT INTO FlightDate VALUES('2022-03-28', '2022-03-28', 'TP1021');


INSERT INTO Flight VALUES('EI1234','EI', 'R25D2', 'PEK', 'SYD', '11:30', '13:40', 'MWF', 'international', 200, 700, 30);
INSERT INTO FlightDate VALUES('2019-12-28', '2019-12-28', 'EI1234');
INSERT INTO Flight VALUES('EI9862','EI','R25D2', 'SYD', 'PEK', '10:00', '22:10', 'MWF', 'international', 120, 500, 18);
INSERT INTO FlightDate VALUES('2019-11-28', '2019-11-28', 'EI9862');

INSERT INTO Flight VALUES('AF1567','AF', 'C31P0', 'SYD', 'YTZ', '22:00', '16:00', 'SuSa', 'international', 160, 900, 18);
INSERT INTO FlightDate VALUES('2021-05-25', '2021-05-26', 'AF1567');
INSERT INTO Flight VALUES('AF0970','AF', 'C31P0', 'YTZ', 'SYD', '22:00', '16:00', 'SuSa', 'international', 160, 900, 18);
INSERT INTO FlightDate VALUES('2021-06-26', '2021-06-27', 'AF0970');


INSERT INTO Flight VALUES('BA9871', 'BA', 'L12L1', 'YTZ', 'LCY', '13:00', '23:15', 'WF', 'international', 300, 800, 30);
INSERT INTO FlightDate VALUES('2021-12-30', '2021-12-30', 'BA9871');
INSERT INTO Flight VALUES('BA4561','BA', 'L12L1', 'LCY', 'YTZ', '11:30', '13:40', 'WF', 'international', 200, 700, 30);
INSERT INTO FlightDate VALUES('2022-01-13', '2022-01-13', 'BA4561');

INSERT INTO Flight VALUES('VA8790','VA', 'P09K2', 'DUB', 'SYD', '10:00', '2:00', 'MTW','international', 140, 710, 18);
INSERT INTO FlightDate VALUES('2021-12-25', '2021-12-26', 'VA8790');
INSERT INTO Flight VALUES('VA1234','VA', 'P09K2', 'SYD', 'DUB', '10:00', '2:00', 'MTW','international', 140, 710, 18);
INSERT INTO FlightDate VALUES('2022-01-23', '2022-01-24', 'VA1234');

INSERT INTO Ticket VALUES (212121212, 1, 2, 135,'2019-12-11');
/* INSERT INTO Ticket VALUES (212121212, 0, 3, 137,'2019-12-16'); duplicate? */
INSERT INTO Ticket VALUES (121212121, 1, 5,235,'2020-06-14');
/* INSERT INTO Ticket VALUES (121212121,0,3,238,'2020-06-15'); */
INSERT INTO Ticket VALUES (123456780, 1, 6, 140,'2019-12-12');
INSERT INTO Ticket Values(766828919, 1, 7, 166, '2022-01-11');
INSERT INTO Ticket Values(836789191, 0, 8, 139, '2021-01-15');
INSERT INTO Ticket Values(908898187, 1, 90, 195,'2020-06-19');
INSERT INTO Ticket Values(187563629, 1, 7, 141, '2020-06-11');
INSERT INTO Ticket Values(374782718, 0, 8, 130, '2020-06-11');
INSERT INTO Ticket Values(189383787, 1, 9, 136, 2020-07-05);
INSERT INTO Ticket Values(718776276, 0, 10, 139, 2020-07-05);
INSERT INTO Ticket Values(908987123, 0, 12, 134, '2019-12-20');
INSERT INTO Ticket Values(987654321, 1, 13, 131, '2020-06-09');
INSERT INTO Ticket Values(732444965, 0, 14, 151, '2020-06-06');
INSERT INTO Ticket Values(123565463, 1, 15, 152, '2020-06-15');
INSERT INTO Ticket Values(175680172, 0, 16, 154, '2020-06-04');
INSERT INTO Ticket Values(234767881, 1, 17, 155, '2020-06-01');
INSERT INTO Ticket Values(973456920, 0, 18, 132, '2020-11-01');
INSERT INTO Ticket Values(876527394, 1, 19, 120, '2022-01-02');
INSERT INTO Ticket Values(197284784, 0, 20, 154, '2020-01-20');
INSERT INTO Ticket Values(098274928, 1, 21, 155, '2020-01-03');
INSERT INTO Ticket Values(199965070, 0, 22, 142, '2021-1-20');
INSERT INTO Ticket Values(166678901, 1, 23, 140, '2020-02-02');
INSERT INTO Ticket Values(199765890, 0, 24, 156, '2020-11-19');
INSERT INTO Ticket Values(189074550, 1, 25, 157, '2022-01-04');
INSERT INTO Ticket Values(908532135, 0, 26, 149, '2019-12-20');
INSERT INTO Ticket Values(758362917, 1, 27, 170, '2020-05-15');
INSERT INTO Ticket Values(567893031, 0, 28, 156, '2021-12-03');
INSERT INTO Ticket Values(645838929, 1, 32, 157, '2022-02-04');
INSERT INTO Ticket Values(876657382, 0, 50, 149, '2019-11-02');
INSERT INTO Ticket Values(908765381, 1, 43, 170, '2021-12-13');
INSERT INTO Ticket Values(998389183, 0, 29, 143, '2021-11-18');
INSERT INTO Ticket Values(984847827, 1, 30, 155, '2021-05-05');
INSERT INTO Ticket Values(387583929, 0, 29, 143, '2021-11-18');
INSERT INTO Ticket Values(289484985, 1, 30, 159, '2021-12-18');
INSERT INTO Ticket Values(786853992, 0, 70, 163, '2021-11-25');
INSERT INTO Ticket Values(984872749, 1, 51, 160, '2021-12-26');


INSERT INTO reserves Values('ssteven','984872749');
INSERT INTO reserves Values('nicky','166678901');
INSERT INTO reserves VALUES('utony','212121212');
INSERT INTO reserves Values('utony','199765890');
INSERT INTO reserves Values('tsarah','189074550');
INSERT INTO reserves Values('tregina','197284784');


INSERT INTO buys VALUES('ssteven', '197284784');
INSERT INTO buys Values('nicky','166678901');
INSERT INTO buys VALUES('utony','199965070');
INSERT INTO buys Values('tsarah','199765890');
INSERT INTO buys Values('tregina','189074550');

INSERT INTO buys VALUES('nicky', '187563629');
INSERT INTO buys VALUES('tregina', '374782718');
INSERT INTO buys VALUES('utony', '189383787');
INSERT INTO buys VALUES('eddy', '718776276');



INSERT INTO trip Values(766828919, 'AA1237', 'First', 1, '2022-02-03', '2022-02-03');
INSERT INTO trip Values(836789191, 'AA1237', 'Business', 0, '2022-02-04', '2022-02-04');

INSERT INTO trip Values(908898187,'BA8765','Economy', 1, '2020-07-14', '2020-07-14');
INSERT INTO trip Values(187563629, 'TP4568', 'First', 1, '2020-07-11', '2020-07-12');
INSERT INTO trip Values(374782718, 'TP4568', 'Business', 0, '2020-08-12', '2020-08-13');
INSERT INTO trip Values(189383787, 'TP4568', 'Economy', 0, '2020-08-13', '2020-08-14');

INSERT INTO trip Values(718776276, 'TP4568', 'Economy', 0, '2020-08-11', '2020-08-12');
INSERT INTO trip VALUES (212121212, 'BB9863', 'Economy', 0, '2020-01-13', '2020-01-13');
INSERT INTO trip VALUES (212121212, 'BB6543', 'Economy', 0, '2020-01-29', '2020-01-29');
INSERT INTO trip VALUES (121212121, 'DL6781', 'Economy', 0, '2020-07-05', '2020-07-05');

INSERT INTO trip VALUES (121212121, 'BA9872', 'Economy', 0, '2020-07-05', '2020-07-06');
INSERT INTO trip Values(123456780, 'BB6543', 'First', 1, '2020-01-29', '2020-01-29');
INSERT INTO trip Values(908987123, 'BB9863', 'Business', 1, '2020-01-13', '2020-01-13');
INSERT INTO trip Values(987654321, 'DL6781', 'Business', 1, '2020-07-05', '2020-07-05');

INSERT INTO trip Values(732444965, 'DL7654', 'Business', 1, '2020-07-06', '2020-07-06');
INSERT INTO trip Values(123565463,'BA9872', 'First', 1, '2020-07-05', '2020-07-06');
INSERT INTO trip Values(175680172, 'AL6781', 'First', 0, '2020-07-08', '2020-07-08');
INSERT INTO trip Values(234767881, 'AL7654', 'Business', 1, '2020-07-09', '2020-07-09');

INSERT INTO trip Values(973456920, 'AA9876', 'Business', 1, '2020-12-19', '2020-12-19');
INSERT INTO trip Values(876527394, 'AL0876', 'Business', 1, '2022-02-01', '2022-02-01');
INSERT INTO trip Values(197284784, 'BB1233', 'Economy', 0, '2020-02-06', '2020-02-06');
INSERT INTO trip Values(098274928,'BB1232', 'First', 1, '2020-02-19', '2020-02-19');

INSERT INTO trip Values(199965070,'DL0950', 'First', 0, '2021-02-21', '2021-02-21');
INSERT INTO trip Values(166678901,'DL1980', 'Business', 1, '2020-03-21', '2020-03-21');
INSERT INTO trip Values(199765890,'AA1789', 'Economy', 0, '2020-12-19', '2020-12-19');
INSERT INTO trip Values(189074550,'AA1237', 'Business', 1, '2022-02-02', '2022-02-02');

INSERT INTO trip Values(908532135,'BB3579', 'First', 1, '2020-01-30', '2020-01-30');
INSERT INTO trip Values(758362917,'BB3890', 'Economy', 0, '2020-06-28', '2020-06-28');
INSERT INTO trip Values(567893031,'TP5432', 'Business', 1, '2022-01-29', '2022-01-29');
INSERT INTO trip Values(645838929,'TP1021', 'First', 1, '2022-03-28', '2022-03-28');

INSERT INTO trip Values(876657382,'EI1234', 'First', 0, '2019-12-28', '2019-12-28');
INSERT INTO trip Values(908765381,'EI9862', 'Economy', 1, '2019-11-28', '2019-11-28');
INSERT INTO trip Values(998389183,'AF1567', 'Economy', 1, '2021-05-25', '2021-05-26');
INSERT INTO trip Values(984847827,'AF0970', 'First', 1, '2021-06-26', '2021-06-27');

INSERT INTO trip Values(387583929,'BA9871', 'First', 0, '2021-12-30', '2021-12-30');
INSERT INTO trip Values(289484985,'BA4561', 'Economy', 1, '2022-01-13', '2022-01-13');
INSERT INTO trip Values(786853992,'VA8790', 'Economy', 1, '2021-12-25', '2021-12-26');
INSERT INTO trip Values(984872749,'VA1234', 'Economy', 1, '2022-01-23', '2022-01-24');


INSERT INTO operates Values('BB6543','BB','B33R3');
INSERT INTO operates Values('BB9863','BB','B33R3');
INSERT INTO operates Values('DL6781','DL','O30K0');
INSERT INTO operates Values('DL7654','DL','O30K0');
INSERT INTO operates Values('BA9872','BA','L12L1');
INSERT INTO operates Values('AL6781','AL', 'Q46P2');
INSERT INTO operates Values('AL7654','AL', 'Q46P2');
INSERT INTO operates Values('AA9876','AA', 'E78P8');
INSERT INTO operates Values('AL0876','AL', 'E78P8');
INSERT INTO operates Values('BB1233','BB', 'B33R3');
INSERT INTO operates Values('BB1232','BB', 'B33R3');
INSERT INTO operates Values('DL0950','DL', 'O30K0');
INSERT INTO operates Values('DL1980','DL','O30K0');
INSERT INTO operates Values('AA1789','AA','E78P8');
INSERT INTO operates Values('AA1237','AA','E78P8');
INSERT INTO operates Values('BB3579','BB','B33R3');
INSERT INTO operates Values('BB3890','BB','B33R3');
INSERT INTO operates Values('TP5432','TP','A23D3');
INSERT INTO operates Values('TP1021','TP', 'A23D3');
INSERT INTO operates Values('EI1234','EI', 'R25D2');
INSERT INTO operates Values('EI9862', 'EI', 'R25D2');
INSERT INTO operates Values('AF1567','AF', 'C31P0');
INSERT INTO operates Values('AF0970','AF', 'C31P0');
INSERT INTO operates Values('BA9871','BA', 'L12L1');
INSERT INTO operates Values('BA4561','BA', 'L12L1');
INSERT INTO operates Values('VA8790','VA', 'P09K2');
INSERT INTO operates Values('VA1234','VA', 'P09K2');


/*Domestic*/
INSERT INTO owns Values('BB','B33R3');
INSERT INTO owns Values('UG','D54R2');
INSERT INTO owns Values('SY','F32R1');
INSERT INTO owns Values('AL','Q46P2');
INSERT INTO owns Values('DL','O30K0');
INSERT INTO owns Values('AA','E78P8');

/*International*/
INSERT INTO owns Values('TP','A23D3');
INSERT INTO owns Values('EI','R25D2');
INSERT INTO owns Values('AF','C31P0');
INSERT INTO owns Values('BA','L12L1');
INSERT INTO owns Values('VA','P09K2');











