USE DB1;

DROP TABLE IF EXISTS reserves;
DROP TABLE IF EXISTS buys;
DROP TABLE IF EXISTS `User`;
DROP TABLE IF EXISTS trip;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS seat;
DROP TABLE IF EXISTS owns;
DROP TABLE IF EXISTS operates;
DROP TABLE IF EXISTS departure;
DROP TABLE IF EXISTS arrival;
DROP TABLE IF EXISTS flies_on;
DROP TABLE IF EXISTS Days;
DROP TABLE IF EXISTS has;
DROP TABLE IF EXISTS Flight;
DROP TABLE IF EXISTS Aircraft;
DROP TABLE IF EXISTS Airline;
DROP TABLE IF EXISTS Airport;


CREATE TABLE `User` (
username VARCHAR(25) NOT NULL,
password VARCHAR(25) NOT NULL,
user_type VARCHAR(9) NOT NULL,
PRIMARY KEY(username)
);

CREATE TABLE Ticket (
ticket_num INT NOT NULL,
round_trip BOOLEAN NOT NULL,
booking_fee DECIMAL(5,2) NOT NULL,
issue_date DATETIME NOT NULL,
total_fare DECIMAL(7,2) NOT NULL,
PRIMARY KEY(ticket_num)
);


CREATE TABLE reserves (
username VARCHAR(25) NOT NULL,
ticket_num INT NOT NULL, 
PRIMARY KEY(username, ticket_num),
FOREIGN KEY(username) REFERENCES `User`(username),
FOREIGN KEY(ticket_num) REFERENCES Ticket(ticket_num)
);

CREATE TABLE buys (
username VARCHAR(25) NOT NULL,
ticket_num INT NOT NULL, 
PRIMARY KEY(username, ticket_num),
FOREIGN KEY(username) REFERENCES `User`(username),
FOREIGN KEY(ticket_num) REFERENCES Ticket(ticket_num)
);

CREATE TABLE Airline (
airline_id CHAR(2) NOT NULL,
PRIMARY KEY(airline_id)
);

CREATE Table Aircraft (
aircraft_id INT NOT NULL,
airline_id CHAR(2) NOT NULL,
capacity INT NOT NULL,
PRIMARY KEY(aircraft_id, airline_id),
FOREIGN KEY(airline_id) REFERENCES Airline(airline_id)
);

CREATE TABLE seat (
seat_num INT NOT NULL,
aircraft_id INT NOT NULL,
class VARCHAR(8) NOT NULL,
PRIMARY KEY(seat_num),
FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id)
);

CREATE Table Flight (
flight_id INT NOT NULL,
airline_id CHAR(2) NOT NULL,
aircraft_id INT NOT NULL,
flight_name VARCHAR(20) NOT NULL,
flight_type VARCHAR(15) NOT NULL,
fare_econ DECIMAL(6, 2) NOT NULL,
fare_first DECIMAL(7, 2) NOT NULL,
fare_bus DECIMAL(7, 2) NOT NULL,
PRIMARY KEY(flight_id),
FOREIGN KEY(airline_id) REFERENCES Airline(airline_id),
FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id)
);

CREATE Table trip (
ticket_num INT NOT NULL,
flight_id INT NOT NULL,
seat_num INT NOT NULL,
depart_time DATETIME NOT NULL,
arrival_time DATETIME NOT NULL,
meal BOOLEAN NOT NULL,
PRIMARY KEY(ticket_num, flight_id, seat_num),
FOREIGN KEY(ticket_num) REFERENCES Ticket(ticket_num),
FOREIGN KEY(flight_id) REFERENCES Flight(flight_id),
FOREIGN KEY(seat_num) REFERENCES seat(seat_num)
);

CREATE Table has (
seat_num INT NOT NULL,
aircraft_id INT NOT NULL,
PRIMARY KEY(aircraft_id, seat_num),
FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id)
);


CREATE TABLE owns (
airline_id CHAR(2) NOT NULL,
aircraft_id INT NOT NULL,
PRIMARY KEY(airline_id, aircraft_id),
FOREIGN KEY(airline_id) REFERENCES Airline(airline_id),
FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id)
);


CREATE Table operates (
id INT NOT NULL,
airline_id CHAR(2) NOT NULL,
aircraft_id INT NOT NULL,
PRIMARY KEY(airline_id, aircraft_id),
FOREIGN KEY(airline_id) REFERENCES Airline(airline_id),
FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id)
);

CREATE Table Airport (
airport_id CHAR(3) NOT NULL,
city VARCHAR(20) NOT NULL,
country VARCHAR(20) NOT NULL,
PRIMARY KEY(airport_id)
);

CREATE Table departure (
airport_id CHAR(3) NOT NULL,
flight_id INT NOT NULL,
depart_date date NOT NULL,
depart_time time NOT NULL,
FOREIGN KEY(airport_id) REFERENCES Airport(airport_id),
FOREIGN KEY(flight_id) REFERENCES Flight(flight_id)
);

CREATE Table arrival (
airport_id CHAR(3) NOT NULL,
flight_id INT NOT NULL,
depart_date date NOT NULL,
depart_time time NOT NULL,
FOREIGN KEY(airport_id) REFERENCES Airport(airport_id),
FOREIGN KEY(flight_id) REFERENCES Flight(flight_id)
);

CREATE Table Days (
day_num INT NOT NULL,  
`day` ENUM('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')  NOT NULL,
PRIMARY KEY (day_num)
);

CREATE Table flies_on (
day_num INT NOT NULL,
flight_id INT NOT NULL,
PRIMARY KEY(day_num, flight_id),
FOREIGN KEY(day_num) REFERENCES Days(day_num),
FOREIGN KEY(flight_id) REFERENCES Flight(flight_id)
);

INSERT INTO `User` VALUES('Steven', 'Greens', 'admin');

















