<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!-- Thomas Fiorilla, cs336 Final Project, Group 4 -->
<!-- This page is a confirmation page for a customer to place a reservation and select certain options -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Place a Reservation</title>
</head>
<body>
	<br>
	<h3>Place a reservation:</h3>
	<%
		String username = (String) session.getAttribute("username");
		String flightID1 = request.getParameter("flight1id");
		String departDate1 = request.getParameter("depdate1");
		//String flightID1 = (String) session.getAttribute("flight1id");
		//String departDate1 = (String) session.getAttribute("depdate1");
		String str1, str2, str3, str4 = null;
		
		out.print("<tr>");
		out.print(username);
		out.print(flightID1);
		out.print(departDate1);
		out.print("</tr>");
		
		//We're guaranteed at least one flight_id, so make it into a query
		str1 = "SELECT * FROM DB1.FlightDate fd, DB1.Flight f "
			+ "WHERE fd.flight_id = f.flight_id AND f.flight_id LIKE '" + flightID1 + "' "
			+ "AND fd.depart_date LIKE '" + departDate1 + "';";
				
		try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str1);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Airline ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Flight ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Departure Date");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Arrival Date");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Departure Time");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Arrival Time");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Departing From");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Arriving At");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Class");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Meal");
			out.print("</td>");
			
			out.print("</tr>");
			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//begin form to update Airline Info
				out.print("<form method='post' action='reservationMake.jsp'>");
				//make a column
				out.print("<td>");
				//Print out current airline_id:
				out.print(result.getString("airline_id"));
				out.print("</td>");
				out.print("<td>");
				//Print out flight_id:
				out.print(result.getString("flight_id"));
				out.print("</td>");
				out.print("<td>");
				//Print out departure date:
				out.print(result.getString("depart_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out departure date:
				out.print(result.getString("arrive_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out departure time:
				out.print(result.getString("depart_time"));
				out.print("</td>");
				out.print("<td>");
				//Print out departure time:
				out.print(result.getString("arrive_time"));
				out.print("</td>");
				out.print("<td>");
				//Print out departure time:
				out.print(result.getString("depart_aid"));
				out.print("</td>");
				out.print("<td>");
				//Print out departure time:
				out.print(result.getString("arrive_aid"));
				out.print("</td>");
				out.print("<td>");
				//Print class selection
				out.print("<select>");
				out.print("<option value='Economy'>Economy</option>");
				out.print("<option value='Business'>Business</option>");
				out.print("<option value='First'>First</option>");
				out.print("</select>");
				out.print("</td>");
				out.print("<td>");
				//Print meal selection
				out.print("<select>");
				out.print("<option value='0'>No meal</option>");
				out.print("<option value='1'>Meal (+$15)</option>");
				out.print("</select>");
				out.print("</td>");
				
				out.print("</tr>");
				out.print("</form>");
			}
			out.print("</table>");

			//close the connection.
			con.close();
		} catch(Exception e){
		}
	%>
</body>
</html>