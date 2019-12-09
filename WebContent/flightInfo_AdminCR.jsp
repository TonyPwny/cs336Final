<!--
Anthony Tiongson
CS336 Section 07
Professor Miranda
Project Final Group 4

Page was coded with aid from the project beer template and ProjectSETUP guide and ProjectSETUP guide.
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String login = (String) session.getAttribute("username");
	String logintype = (String) session.getAttribute("usertype");
	String loginURL = "login.jsp";
	String flightSearch = "flightSearch_AdminCR.jsp";
	String flightUpdate = "flightUpdate_AdminCR.jsp";

	if (session.getAttribute("username") == null || logintype.equals("User")) {
		response.sendRedirect(loginURL);
	}
	
	if (request.getParameter("flight_id") == null) {
		response.sendRedirect(flightSearch);
	}

	//Get the search from the flightSearch_AdminCR.jsp
	String flightID = request.getParameter("flight_id");
	//Make a SELECT query from the Airport table with flightID specified by the 'flight_id' parameter at the flightSearch_AdminCR.jsp
	String str, str_query, str_query_title;
	str = "SELECT * FROM DB1.Flight f, DB1.Airline al WHERE f.flight_id = '" + flightID + "AND f.airline_id = al.airline_id'";
	str_query = "Result for " + flightID + ":<br><br>";
	str_query_title = flightID;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Flight Information - <%
	out.println(str_query_title);
%></title>
</head>
<body>
	<br> Logged in as:
	<%
		out.println(" <b>" + login + "</b> - " + logintype);
	%>
	<br>
	<br>
	<%
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
			out.print("Flight ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Airline");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Aircraft");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Type");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("First Class Fare");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Business Class Fare");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Economy Class Fare");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//begin form to update Flight Info
				out.print("<form method='post' action='" + flightUpdate + "'>");
				//make a column
				out.print("<td>");
				//Print out current flight_id:
				out.print("<select name='flight_id'>");
				out.print("<option value='" + result.getString("flight_id") + "'>" + result.getString("flight_id")
						+ "</option>");
				out.print("</select>");
				out.print("</td>");
				out.print("<td>");
				//Print out current airline_name:
				out.print("<input type='text' name='airline_name' value='" + result.getString("airline_name") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current aircraft_id:
				out.print("<input type='text' name='aircraft_id' value='" + result.getString("aircraft_id") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current flight_type:
				out.print("<input type='text' name='flight_type' value='" + result.getString("flight_type") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current fare_first:
				out.print("<input type='text' name='fare_first' value='" + result.getString("fare_first") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current fare_bus:
				out.print("<input type='text' name='fare_bus' value='" + result.getString("fare_bus") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current fare_econ:
				out.print("<input type='text' name='fare_econ' value='" + result.getString("fare_econ") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out an update button:
				out.print("<input type='submit' value='update'>");
				out.print("</form>");
				out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
	<br>
	<br>
	<%
		// Try and get the current count from the session
		Integer count = (Integer) session.getAttribute("COUNT");
		// If COUNT is not found, create it and add it to the session
		if (count == null) {
			count = new Integer(1);
			session.setAttribute("COUNT", count);
		} else {
			count = new Integer(count.intValue() + 1);
			session.setAttribute("COUNT", count);
		}
		// Print the number of times the user has visited the site
		out.println("Current session site views: <b>" + count + "</b>");
	%>
</body>
</html>