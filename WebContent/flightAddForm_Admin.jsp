<!--
Anthony Tiongson
CS336 Section 07
Professor Miranda
Project Final Group 4

Page was coded with aid from the project beer template and ProjectSETUP guide.
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
	String flightAdd = "flightAdd_Admin.jsp";

	if (session.getAttribute("username") == null || !logintype.equals("Admin")) {
		response.sendRedirect(loginURL);
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Add Flight
</title>
</head>
<body>
	<br> Logged in as:
	<%
		out.println(" <b>" + login + "</b> - " + logintype);
	%>
	<br>
	<br>
	<br>
	<br>
	<%
		try {

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
			out.print("Airline ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Aircraft");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Departing From");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Arriving To");
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
			out.print("Flight Days");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Type");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Economy Fare");
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
			out.print("");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("");
			out.print("</td>");
			out.print("</tr>");

			//make a row
			out.print("<tr>");
			//begin form to add Flight Info
			out.print("<form method='post' action='" + flightAdd + "'>");
			//make a column
			out.print("<td>");
			//text box to enter in new flight_id
			out.print("<input type='text' name='flight_id' value='ID1234'>");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new airline_id
			out.print("<input type='text' name='airline_id' value='ID'>");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new aircraft_id
			out.print("<input type='text' name='aircraft_id' value='MODEL'>");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new depart_aid
			out.print("<input type='text' name='depart_aid' value='ID'>");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new arrive_aid
			out.print("<input type='text' name='arrive_aid' value='ID'>");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new depart_time
			out.print("<input type='text' name='depart_time' value='HH:MM:SS'>");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new arrive_time
			out.print("<input type='text' name='arrive_time' value='HH:MM:SS'>");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new flight_days
			out.print("<input type='text' name='flight_days' value='SuMTWRFSa'>");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new flight_type
			out.print("<input type='text' name='flight_type' value='domestic/international'>");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new fare_econ
			out.print("<input type='text' name='fare_econ' value='100.00'>");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new fare_first
			out.print("<input type='text' name='fare_first' value='400.00'>");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new fare_bus
			out.print("<input type='text' name='fare_bus' value='275.00'>");
			out.print("</td>");
			out.print("<td>");
			//Print out an add button:
			out.print("<input type='submit' value='add'>");
			out.print("</form>");
			out.print("</td>");
			out.print("</tr>");
			out.print("</table>");

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