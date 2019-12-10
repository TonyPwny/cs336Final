<!-- 
Nicolas Gundersen
CS336
Professor Miranda
Project Final Group 4
 -->


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Here are your results!</title>
<h4>Filter by Price, Take off, Land time, Airline</h4>
</head>
<body>

	<%
		//Get arguments

		String button_flightid = request.getParameter("more_info");

		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();

		
String str = 		
	"SELECT DISTINCT Flight.flight_id, departure.airport_id, departure.depart_date, Flight.depart_time "  
		+ "arrival.airport_id, arrival.arrive_date, Flight.arrive_time, " 
		+ "Flight.airline_id, Airline.airline_name, " 
		+ "Flight.fare_econ, Flight.fare_bus, Flight.fare_first " 
		+ "FROM Flight, arrival, departure, Airline, Airport " 
		+ "WHERE Flight.flight_id = ? " 
		+ "AND Flight.flight_id = departure.flight_id " 
		+ "AND Flight.flight_id = arrival.flight_id " 
		+ "AND Flight.airline_id = Airline.airline_id";

		PreparedStatement stmt = conn.prepareStatement(str);
		stmt.setString(1, button_flightid);
		ResultSet flights = stmt.executeQuery();

		out.print("<table>");
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("flight id");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("departing port");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("departure time");
		out.print("</td>");
		//print out column header
		out.print("<td>");
		out.print("arrival port");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("arrival date");
		out.print("</td>");
		
		out.print("<td>");
		out.print("arrival time");
		out.print("</td>");
		
		out.print("<td>");
		out.print("airline ID");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Airline name");
		out.print("</td>");
		
		out.print("<td>");
		out.print("Econ price");
		out.print("</td>");
		
		out.print("<td>");
		out.print("business price");
		out.print("</td>");
		
		out.print("<td>");
		out.print("first-class price");
		out.print("</td>");
		
		
		//make a column
		out.print("");
		out.print("</td>");
		out.print("</tr>");

		//parse out the results
		while (flights.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current flightid:
			out.print(flights.getString("Flight.flight_id"));
			out.print("</td>");
			out.print("<td>");
			//Print out current beer name:
			out.print(flights.getString("departure.airport_id"));
			out.print("</td>");
			out.print("<td>");
			//Print out current price
			out.print(flights.getString("Flight.depart_time"));
			out.print("</td>");
			out.print("<td>");

			//Print out arrival date
			out.print(flights.getString("arrival.airport_Id"));
			out.print("</td>");
			out.print("<td>");

			//Print out arrival airport id
			out.print(flights.getString("arrival.arrive_time"));
			out.print("</td>");
			out.print("<td>");
			
			out.print(flights.getString("Flight.arrive_time"));
			out.print("</td>");
			out.print("<td>");
			
			out.print(flights.getString("Flight.airline_id"));
			out.print("</td>");
			out.print("<td>");
			
			out.print(flights.getString("Airline.airline_name"));
			out.print("</td>");
			out.print("<td>");
			
			out.print(flights.getString("Flight.fare_econ"));
			out.print("</td>");
			out.print("<td>");
			
			out.print(flights.getString("Flight.fare_bus"));
			out.print("</td>");
			out.print("<td>");
			
			out.print(flights.getString("Flight.fare_first"));
			out.print("</td>");
			out.print("<td>");
	%>

	<a href = "flight_Search.jsp""> Make a new search?</a>
	<a href = "flight_Search_result.jsp"> Go back to your search</a>
	<a href="success.jsp">Want to go back?</a>

</body>
</html>