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
	String airportAdd = "airportAdd_Admin.jsp";

	if (session.getAttribute("username") == null || !logintype.equals("Admin")) {
		response.sendRedirect(loginURL);
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Add Airport
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
			out.print("Airport ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Name");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("City");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("State");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Country");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("");
			out.print("</td>");
			out.print("</tr>");

			//make a row
			out.print("<tr>");
			//begin form to add Airport Info
			out.print("<form method='post' action='" + airportAdd + "'>");
			//make a column
			out.print("<td>");
			//text box to enter in new airport_id
			out.print("<input type='text' name='airport_id' value='NEW'");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new Airport name
			out.print("<input type='text' name='name' value='New Airport Name'");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new Airport city
			out.print("<input type='text' name='city' value='Airport City'");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new Airport state
			out.print("<input type='text' name='state' value='Airport State/Providence'");
			out.print("</td>");
			out.print("<td>");
			//text box to enter in new Airport country
			out.print("<input type='text' name='country' value='Airport Country'");
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