<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!-- This page shows ALL reservations both past and present -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
	String username = (String) session.getAttribute("username");
	String str = "SELECT * FROM DB1.reserves r, DB1.Ticket t WHERE r.ticket_num = t.ticket_num AND r.username LIKE '" + username + "%'";
	String str_query = "Hello, " + username + "! Here are all of your reservations: ";
	
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
		out.print("Departure Date");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Round Trip");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Total Fare");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Date Reserved");
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
			//Print out departure date:
			out.print(result.getString("depart_date"));
			out.print("</td>");
			out.print("<td>");
			//Print out if it is a round trip:
			out.print(result.getString("round_trip"));
			out.print("</td>");
			out.print("<td>");
			//Print out total fare:
			out.print(result.getString("total_fare"));
			out.print("</td>");
			out.print("<td>");
			//Print out issue date:
			out.print(result.getString("issue_date"));
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
</html>