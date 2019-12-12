<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!-- Thomas Fiorilla, cs336 Final Project, Group 4 -->
<!-- This page shows all reservations for a user, to be used by an admin or sales rep -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
	String username = request.getParameter("username");
	String str = "SELECT * FROM DB1.reserves r, DB1.trip t, DB1.Ticket ti "
			+ "WHERE r.ticket_num = t.ticket_num AND "
			+ "r.ticket_num = ti.ticket_num AND "
			+ "r.username LIKE '" + username + "%';";
	
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
		out.print("Here are all the reservations for user " + username + ":");

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
		out.print("Date Issued");
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
		out.print("Fare Revenue");
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
			//Print out date ticket was issued:
			out.print(result.getString("issue_date"));
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
			//Print out fare revenue:
			out.print(result.getString("total_fare"));
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