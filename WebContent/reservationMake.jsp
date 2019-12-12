<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!-- Thomas Fiorilla, cs336 Final Project, Group 4 -->
<!-- This page is used to make a reservation -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
	
	//Information for Ticket
	//ticket_num and issue_date will be derived later through logic
	String roundTrip = (String) session.getAttribute("round_trip");
	String bookingFee = (String) session.getAttribute("booking_fee");
	String totalFare = (String) session.getAttribute("total_fare");
	
	//Information for reserves
	String username = (String) session.getAttribute("username");
			
	//Information for trip
	String flightID = (String) session.getAttribute("flight_id");
	String flightClass = (String) session.getAttribute("class");
	String meal = (String) session.getAttribute("meal");
	String departDate = (String) session.getAttribute("depart_date");
	String arriveDate = (String) session.getAttribute("arrive_date");
	
	/*
	//Hardcoded test
	//If you want to test this, comment out the declaration blocks above and un-comment this whole block
	//It will randomise the ticket_num while keeping everything else hard-coded just to prove it works
	//If you do use this test case, make sure to copy the ticket_num given and run these three queries in MySQL:
		//DELETE FROM DB1.trip WHERE ticket_num = <number you copied>;
		//DELETE FROM DB1.reserves WHERE ticket_num = <number you copied>;
		//DELETE FROM DB1.Ticket WHERE ticket_num = <number you copied>;
		//these queries are just to make sure, if this is run a bunch, the database isn't populated with a bunch of garbage data
		
	//ticket_num and issue_date will be derived later through logic
	String roundTrip = "0";
	String bookingFee = "5";
	String totalFare = "200";
	
	//Information for reserves
	String username = "utony";
			
	//Information for trip
	String flightID = "AA1237";
	String flightClass = "Economy";
	String meal = "0";
	String departDate = "2022-02-02";
	String arriveDate = "2022-02-02";
	*/
	
	
	List<String> list = new ArrayList<String>();
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		//Use Random to generate a random flight number
		Random rnd = new Random();
		int ticketNum = 100000000 + rnd.nextInt(899999999);
		
		//Create a while loop to make sure there are no duplicate flight numbers
		boolean duplicate = true;
		while(duplicate == true){
			//Create a query to check if the randomly generated flight number already exists
			String str = "SELECT ticket_num FROM DB1.Ticket WHERE ticket_num LIKE '" + ticketNum + "%'";
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Run the query to check if the randomly generated number already exists
			ResultSet result = stmt.executeQuery(str);
			
			//Logically check for existence; if not, exit the while loop, and if so, generate a new number
			if(!result.next()){
				duplicate = false;
			} else{
				rnd = new Random();
				ticketNum = 100000000 + rnd.nextInt(899999999);
			}
		}
		
		//Now that we know the ticket number generated is unique, we can make a query to insert data into the database
		//Populates the Ticket table
		String str1 = 
			"INSERT INTO DB1.Ticket VALUES ('" + ticketNum + "','" + roundTrip + "','" + bookingFee + "','" + totalFare + "',CURDATE());";
		
		//Populates the reserves table
		String str2 = 
			"INSERT INTO DB1.reserves VALUES ('" + username + "','" + ticketNum + "');";
			
		//Populates the trip table
		String str3 = 
			"INSERT INTO DB1.trip VALUES ('" + ticketNum + "','" + flightID + "','" + flightClass + "','" + meal + 
					"','" + departDate + "','" + arriveDate + "');";
			
		//Create a SQL statement
		PreparedStatement stmt = con.prepareStatement(str1);
		
		//Run the query against the database as all 3 statements
		stmt.executeUpdate();
		
		stmt = con.prepareStatement(str2);
		stmt.executeUpdate();
		
		stmt = con.prepareStatement(str3);
		stmt.executeUpdate();
		
		//Show a success message
		out.print("Congrats! You've made a reservation, and your ticket number is: " + ticketNum);

		//close the connection.
		con.close();

	} catch (Exception e) {
	}
%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Make A Reservation</title>
	</head>
</html>