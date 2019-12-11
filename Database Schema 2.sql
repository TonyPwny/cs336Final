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
user_type VARCHAR(9) NOT NULL,
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
);

CREATE TABLE owns (
airline_id CHAR(2) NOT NULL,
aircraft_id VARCHAR(8) NOT NULL,
PRIMARY KEY(airline_id, aircraft_id),
FOREIGN KEY(airline_id) REFERENCES Airline(airline_id),
FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id)
);

CREATE Table Flight (
flight_id VARCHAR(6) NOT NULL,
airline_id VARCHAR(2) NOT NULL,
aircraft_id VARCHAR(8) NOT NULL,
depart_time time NOT NULL,
arrive_time time NOT NULL,
flight_days VARCHAR(11) NOT NULL,
flight_type VARCHAR(15) NOT NULL,
fare_econ DECIMAL(6, 2) NOT NULL,
fare_first DECIMAL(7, 2) NOT NULL,
fare_bus DECIMAL(7, 2) NOT NULL,
PRIMARY KEY(flight_id),
FOREIGN KEY(airline_id) REFERENCES Airline(airline_id),
FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id)
);

CREATE Table FlightDate (
depart_date date NOT NULL,
arrive_date date NOT NULL,
flight_id VARCHAR(6) NOT NULL,
depart_aid VARCHAR(6) NOT NULL,
arrive_aid VARCHAR(6) NOT NULL,
PRIMARY KEY (depart_date, flight_id),
FOREIGN KEY (flight_id) REFERENCES Flight(flight_id),
FOREIGN KEY (depart_aid) REFERENCES Airport(airport_id),
FOREIGN KEY (arrive_aid) REFERENCES Airport(airport_id)
);

CREATE Table operates (
flight_id VARCHAR(6) NOT NULL,
airline_id CHAR(2) NOT NULL,
aircraft_id VARCHAR(6) NOT NULL,
PRIMARY KEY(flight_id, airline_id, aircraft_id),
FOREIGN KEY(flight_id) REFERENCES Flight(flight_id),
FOREIGN KEY(airline_id) REFERENCES Airline(airline_id),
FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id)
);

CREATE TABLE Ticket (
ticket_num INT8 NOT NULL,
flight_id VARCHAR(6) NOT NULL,
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
FOREIGN KEY(username) REFERENCES `User`(username),
FOREIGN KEY(ticket_num) REFERENCES Ticket(ticket_num)
);

CREATE TABLE buys (
username VARCHAR(25) NOT NULL,
ticket_num INT8 NOT NULL, 
PRIMARY KEY(username, ticket_num),
FOREIGN KEY(username) REFERENCES `User`(username),
FOREIGN KEY(ticket_num) REFERENCES Ticket(ticket_num)
);


CREATE Table trip (
ticket_num INT8 NOT NULL,
flight_id VARCHAR(6) NOT NULL,
class VARCHAR(15) NOT NULL,
meal BOOLEAN NOT NULL,
depart_date date NOT NULL,
arrive_date date NOT NULL,
PRIMARY KEY(ticket_num, depart_date),
FOREIGN KEY(ticket_num) REFERENCES Ticket(ticket_num),
FOREIGN KEY (flight_id) REFERENCES FlightDate(flight_id),
FOREIGN KEY (depart_date) REFERENCES FlightDate(depart_date)
);

INSERT INTO `User` VALUES('ssteven', 'Greens', 'Steven', 'Admin');
INSERT INTO `User` VALUES('jnickey', 'Time12', 'Nickey','User');
INSERT INTO `User` VALUES('tanthony', 'Greens', 'Anthony', 'SalesRep');
INSERT INTO `User` VALUES('tsarah', 'Captains', 'Sarah', 'Admin');
INSERT INTO `User` VALUES('tregina', 'Lateness12', 'Regina', 'User');

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
/*
aircraft_id VARCHAR(8) NOT NULL,
airline_id CHAR(2) NOT NULL,
capacity INT NOT NULL,
first_class_capacity INT NOT NULL,
business_capacity INT NOT NULL,
economy_capacity INT NOT NULL,
*/

/*
/*Domestic*/
INSERT INTO Flight VALUES('BB6543','BB','B33R3', '11:02', '14:10', 'SuFSa', 'domestic', 160, 600, 18);
INSERT INTO FlightDate VALUES('2020-01-29', '2020-01-29', 'BB6543', 'MIA', 'EWR');

INSERT INTO Flight VALUES('UG9863','UG','B33R3', '10:02', '13:15', 'SuFSa', 'domestic', 170, 500, 30);
INSERT INTO FlightDate VALUES('2020-01-13', '2020-01-13', 'UG9863', 'EWR', 'MIA');


INSERT INTO Flight VALUES('BB3579','BB','B33R3', '09:02', '11:20', 'SuFSa', 'domestic', 180, 630, 18);
INSERT INTO FlightDate VALUES('2020-01-30', '2020-01-30', 'BB3579', 'EWR', 'JFK');


INSERT INTO Flight VALUES('AL9873','AL','B33R3', '11:02', '13:22', 'SuFSa', 'domestic', 150, 620, 30);
INSERT INTO FlightDate VALUES('2020-06-28', '2020-06-28', 'AL9873', 'JFK', 'EWR');

/*Make flight from Newark-San Franciso, 3 seperates days and times (Arrrival and departure)
San Franciso-China-Connected flight */ 
INSERT INTO Flight VALUES('DL6781','DL','O30K0','13:01','19:46','MRFSa', 'domestic', 170, 206, 18);
INSERT INTO FlightDate VALUES('2020-07-05', '2020-07-05', 'DL6781', 'EWR', 'SFO');

INSERT INTO Flight VALUES('BA9872','BA','L12L1','20:46','12:35','WF', 'international', 180, 230, 30);
INSERT INTO FlightDate VALUES('2020-07-05', '2020-07-06', 'BA9872', 'SFO', 'PEK');


INSERT INTO Flight VALUES('SY9813','SY', 'F32R1', '10:10', '17:16', 'SuMWFSa', 'domestic', 190, 910, 18);
INSERT INTO FlightDate VALUES('2021-01-01', '2020-01-01', 'SY9813', 'MIA', 'SFO');

INSERT INTO Flight VALUES('AL9813','SY', 'F32R1', '10:10', '17:16', 'SuMWFSa', 'domestic', 190, 910, 18);
INSERT INTO FlightDate VALUES('2021-01-01', '2020-01-01', 'AL9813',  'SFO', 'MIA');


INSERT INTO Flight VALUES('AL0876', 'AL', 'Q46P2', '18:14', '21:26', 'TWR', 'domestic', 210, 820, 30);
INSERT INTO FlightDate VALUES('2021-02-01', '2020-02-01', 'AL0876',  'MDW', 'LAX');

INSERT INTO Flight VALUES('DL7680','DL', 'O30K0','9:00', '14:05', 'MRFSa','domestic', 170, 730, 18);
INSERT INTO FlightDate VALUES('2021-12-01', '2020-12-01', 'DL7680',  'LAX', 'MDW');


INSERT INTO Flight Values('AA9876','AA', 'E78P8', '12:17', '17:27', 'SuMTWR', 'domestic', 130, 700, 30);
INSERT INTO FlightDate VALUES('2021-12-19', '2020-12-19', 'AA9876',  'MDW', 'LAX');


INSERT INTO Flight Values('BB1233','BB', 'B33R3', '16:30', '21:30', 'SuFSa', 'domestic', 150, 800, 18);
INSERT INTO FlightDate VALUES('2021-02-06', '2020-02-06', 'BB1233',  'MDW', 'JFK');


INSERT INTO Flight Values('UG1233','UG', 'D54R2', '10:00', '12:20', 'MF', 'domestic', 190, 400, 30);
INSERT INTO FlightDate VALUES('2021-02-19', '2020-02-19', 'UG1233',  'JFK', 'MDW');


INSERT INTO Flight Values('SY3290','SY', 'F32R1', '15:30', '22:10', 'SuMWFSa', 'domestic', 190, 400, 18);
INSERT INTO FlightDate VALUES('2021-03-19', '2020-02-19', 'SY3290',  'LAX', 'SFO');


INSERT INTO Flight Values('DL1980','AL', 'Q46P2', '8:30', '13:05', 'TWR', 'domestic', 190, 400, 30);
INSERT INTO FlightDate VALUES('2021-03-21', '2020-03-21', 'DL1980',  'SFO', 'LAX');

INSERT INTO Flight Values('DL0950','DL', 'O30K0', '17:30', '23:20', 'MRFSa', 'domestic', 180, 700, 18);
INSERT INTO FlightDate VALUES('2020-02-21', '2020-02-21', 'DL0950',  'SFO', 'LAX');

INSERT INTO Flight Values('AA1789','AA', 'E78P8', '11:30', '16:20', 'SuMTWR', 'domestic', 190, 600, 30);
INSERT INTO FlightDate VALUES('2021-12-19', '2020-12-19', 'AA1789',  'MDW', 'EWR');

INSERT INTO Flight Values('UG1237','UG', 'D54R2', '14:00', '19:40', 'MF', 'domestic', 180, 300, 18);
INSERT INTO FlightDate VALUES('2022-02-02', '2022-02-02', 'UG1237',  'EWR', 'MDW');

/*
International
INSERT INTO Flight VALUES('TP5432','TP','A23D3', '10:00', '22:10', 'SuMTWRFSa', 'international', 120, 500, 18);
INSERT INTO departure VALUES('LCY', 'TP5432', '2020-01-29');
INSERT INTO arrival VALUES('PEK', 'TP5432', '2020-01-30');

INSERT INTO Flight VALUES('EI1234','EI', 'R25D2', '11:30', '13:40', 'MWF', 'international', 200, 700, 30);
INSERT INTO departure VALUES('PEK', 'EI1234', '2019-12-28');
INSERT INTO arrival VALUES('SYD', 'EI1234', '2019-12-31');

INSERT INTO Flight VALUES('AF1567','AF', 'C31P0', '22:00', '16:00', 'SuSa', 'international', 160, 900, 18);
INSERT INTO departure VALUES('SYD', 'AF1567', '2021-05-25');
INSERT INTO arrival VALUES('YTZ', 'AF1567', '2021-05-26');

INSERT INTO Flight VALUES('BA9871', 'BA', 'L12L1', '14:00', '24:15', 'WF', 'international', 300, 800, 30);
INSERT INTO departure VALUES('JFK', 'BA9871', '2022-01-01');
INSERT INTO arrival VALUES('MIA', 'BA9871', '2022-01-01');
INSERT INTO departure VALUES('YTZ', 'BA9871', '2022-01-01'); 
INSERT INTO arrival VALUES('LCY', 'BA9871', '2021-12-30'); 

INSERT INTO Flight VALUES('VA8790','VA', 'P09K2','10:00', '2:00', 'MTW','international', 140, 710, 18);
INSERT INTO departure VALUES('DUB', 'VA8790', '2019-12-25');
INSERT INTO arrival VALUES('SYD', 'VA8790', '2019-12-26');

INSERT INTO Flight VALUES('TP9862','TP','A23D3', '10:00', '22:10', 'SuMTWRFSa', 'international', 120, 500, 18);
INSERT INTO departure VALUES('SYD', 'TP9862', '2019-11-28');
INSERT INTO arrival VALUES('PEK', 'TP9862', '2019-11-28');

INSERT INTO Flight VALUES('EI4561','EI', 'R25D2', '11:30', '13:40', 'MWF', 'international', 200, 700, 30);



INSERT INTO Flight VALUES('AF0970','AF', 'C31P0', '22:00', '16:00', 'SuSa', 'international', 160, 900, 18);
INSERT INTO departure VALUES('YTZ', 'AF0970', '2021-06-26');
INSERT INTO arrival VALUES('SYD', 'AF0970', '2021-06-27');
INSERT INTO Flight VALUES('AF9700','AF', 'C31P0', '23:00', '17:00', 'SuSa', 'international', 150, 800, 30);
INSERT INTO departure VALUES('SYD', 'AF9700', '2021-06-26');
INSERT INTO arrival VALUES('YTZ', 'AF9700', '2021-06-27');


INSERT INTO Flight VALUES('BA1021', 'BA','L12L1', '13:00', '23:15', 'WF', 'international', 300, 800, 30);
INSERT INTO departure VALUES('PEK', 'BA1021', '2020-03-28');
INSERT INTO arrival VALUES('LCY', 'BA1021', '2020-03-28');


INSERT INTO Flight VALUES('VA1234','VA', 'P09K2','10:00', '2:00', 'MTW','international', 140, 710, 18);
INSERT INTO departure VALUES('SYD', 'VA1234', '2019-12-25');
INSERT INTO arrival VALUES('DUB', 'VA1234', '2019-12-26');
INSERT INTO Flight VALUES('VA1439','VA', 'P09K2','2:00', '14:00', 'MTW','international', 140, 710, 18);
INSERT INTO departure VALUES('DUB', 'VA1439', '2019-01-03');
INSERT INTO arrival VALUES('SYD', 'VA1439', '2019-01-04');
*/

/*Domestic*
INSERT INTO Ticket VALUES('908987123', 'Yes', 25, 18, '2019-12-01'); /
/*
INSERT INTO Ticket VALUES('123456789', 'No', 15, 19, '2019-11-10');
INSERT INTO Ticket VALUES('987654321', 'Yes', 16, 20, '2021-04-12');
INSERT INTO Ticket VALUES('732444965', 'No', 17, 21, '2021-12-01');
INSERT INTO Ticket VALUES('848229010', 'Yes', 13, 22, '2019-09-10');
INSERT INTO Ticket VALUES('123565463', 'No', 16, 21, '2019-10-15');

INSERT INTO Ticket VALUES('175680172', 'No', 14, 23, '2020-01-01');
INSERT INTO Ticket VALUES('234767881', 'Yes', 23, 30, '2019-10-01');
INSERT INTO Ticket VALUES('973456920', 'No', 19, 23, '2021-02-01');
INSERT INTO Ticket VALUES('876527394', 'Yes', 18, 27, '2021-11-28');
INSERT INTO Ticket VALUES('197284784', 'No', 21, 32, '2019-01-02');
INSERT INTO Ticket VALUES('615729830', 'Yes', 20, 31, '2019-01-02');
INSERT INTO Ticket VALUES('098274928', 'No', 25, 34, '2019-10-15');
*/

/*International
INSERT INTO Ticket VALUES('199965070', 'Yes', 25, 18, '2019-12-26');
INSERT INTO Ticket VALUES('166678901', 'No', 15, 19, '2019-10-28');
INSERT INTO Ticket VALUES('199765890', 'Yes', 16, 20, '2020-09-08');
INSERT INTO Ticket VALUES('189074550', 'No', 17, 21, '2021-07-21');
INSERT INTO Ticket VALUES('908532135', 'Yes', 13, 22, '2022-07-08');

INSERT INTO Ticket VALUES('758362917', 'Yes', 18, 29, '2020-02-08');
INSERT INTO Ticket VALUES('567893031', 'No', 16, 32, '2019-10-11');
INSERT INTO Ticket VALUES('645838929', 'No', 19, 22, '2021-05-08');
INSERT INTO Ticket VALUES('876657382', 'Yes', 21, 31, '2021-12-15');
INSERT INTO Ticket VALUES('908765381', 'Yes', 23, 39, '2019-10-08');
*/

INSERT INTO reserves Values('ssteven','199965070');
INSERT INTO reserves Values('jnickey','166678901');
INSERT INTO reserves Values('tanthony','199765890');
INSERT INTO reserves Values('tsarah','189074550');
INSERT INTO reserves Values('tregina','848229010');

/*
INSERT INTO buys VALUES('ssteven', '848229010');
INSERT INTO buys Values('jnickey','166678901');
INSERT INTO buys VALUES('tanthony','199965070');
INSERT INTO buys Values('tsarah','199765890');
INSERT INTO buys Values('tregina','189074550');
*/

INSERT INTO trip VALUES ('199765890', 'UG9863', 'Economy', 'false', '2020-01-13', '2020-01-13');
/*
Domestic
INSERT INTO trip Values('848229010', 'BB6543', 'First', 'false');
INSERT INTO trip Values('908987123', 'UG6578', 'Business', 'true');
INSERT INTO trip Values('987654321', 'SY9813', 'Business', 'true');
INSERT INTO trip Values('732444965', 'BA9871', 'Business', 'true');
INSERT INTO trip Values('123565463','AA9876', 'First', 'true');

INSERT INTO trip Values('175680172', 'BB6543', 'First', 'false');
INSERT INTO trip Values('234767881', 'UG6578', 'Business', 'true');
INSERT INTO trip Values('973456920', 'SY9813', 'Business', 'true');
INSERT INTO trip Values('876527394', 'BA9871', 'Business', 'true');

INSERT INTO trip Values('197284784', 'DL7680', 'Economy', 'false');
INSERT INTO trip Values('098274928','AA9876', 'First', 'true');

International
INSERT INTO trip Values('199965070','TP5432', 'First', 'false');
INSERT INTO trip Values('166678901','EI1234', 'Business', 'true');
INSERT INTO trip Values('199765890','AF1567', 'Economy', 'false');
INSERT INTO trip Values('189074550','BA9871', 'Business', 'true');
INSERT INTO trip Values('908532135','VA8790', 'First', 'true');

INSERT INTO trip Values('758362917','TP9862', 'Economy', 'false');
INSERT INTO trip Values('567893031','EI4561', 'Business', 'true');
INSERT INTO trip Values('645838929','AF0970', 'First', 'true');
INSERT INTO trip Values('876657382','BA1021', 'First', 'false');
INSERT INTO trip Values('908765381','VA1234', 'Economy', 'true');
*/


/*Domestic*/
INSERT INTO operates Values('BB6543','BB','B33R3');
INSERT INTO operates Values('UG9863','UG','B33R3');
INSERT INTO operates Values('SY9813','SY','F32R1');

INSERT INTO operates Values('AL9813','AL','B33R3');
INSERT INTO operates Values('DL6781','DL','O30K0');
/*
INSERT INTO operates Values('AA9876','AA', 'E78P8');
*/
INSERT INTO operates Values('BB3579','BB', 'B33R3');

INSERT INTO operates Values('UG1233','UG', 'D54R2');
INSERT INTO operates Values('SY3290','SY', 'F32R1');
INSERT INTO operates Values('DL1980','AL', 'Q46P2');

INSERT INTO operates Values('AA1789','AA', 'E78P8');
INSERT INTO operates Values('UG1237','UG', 'D54R2');


/*International
INSERT INTO operates Values('TP5432','TP','A23D3');
INSERT INTO operates Values('EI1234','EI','R25D2');
INSERT INTO operates Values('AF1567','AF','C31P0');

INSERT INTO operates Values('BA9872','BA','L12L1');
INSERT INTO operates Values('VA8790','VA','P09K2');

INSERT INTO operates Values('TP9862','TP','A23D3');
INSERT INTO operates Values('EI4561','EI', 'R25D2');
INSERT INTO operates Values('AF0970','AF', 'C31P0');
INSERT INTO operates Values('BA1021', 'BA', 'L12L1');
INSERT INTO operates Values('VA1234','VA', 'P09K2');
*/

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











