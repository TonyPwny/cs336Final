<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!-- Thomas Fiorilla, cs336 Final Project, Group 4 -->
<!-- This page shows only reservations that occur after the current date -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
	String username = (String) session.getAttribute("username");
	String str = "SELECT * FROM DB1.reserves r, DB1.trip t WHERE r.ticket_num = t.ticket_num " + 
				 "AND t.depart_date >= CURDATE() AND r.username LIKE '" + username + "%'";
	String str_query = "Hello, " + username + "! These are your upcoming reservations: ";
	
	List<String> list = new ArrayList<String>();
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);

		//Show what kind of query is being processed
		out.print(str_query);

		//Make an HTML table to show the results in:
		out.print("<table>");

		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("Ticket Number");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Flight ID");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Class");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Meal");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Departure Date");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Arrival Date");
		out.print("</td>");
		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out ticket number:
			out.print(result.getString("ticket_num"));
			out.print("</td>");
			out.print("<td>");
			//Print out flight id:
			out.print(result.getString("flight_id"));
			out.print("</td>");
			out.print("<td>");
			//Print out clss:
			out.print(result.getString("class"));
			out.print("</td>");
			out.print("<td>");
			//Print out if flier gets meals:
			out.print(result.getString("meal"));
			out.print("</td>");
			out.print("<td>");
			//Print out date of departure:
			out.print(result.getString("depart_date"));
			out.print("</td>");
			out.print("<td>");
			//Print out date of arrival:
			out.print(result.getString("arrive_date"));
			out.print("</td>");
			out.print("<td>");
		}
		out.print("</table>");

		//close the connection.
		con.close();

	} catch (Exception e) {
	}
%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Your Reservations</title>
	</head>
	<body>
		<form method="get" action="reservationAll.jsp" enctype=text/plain>
			<td><button type="submit" name="username" value="flight_id">View All Reservations</button></td>
		</form>
	</body>
</html>