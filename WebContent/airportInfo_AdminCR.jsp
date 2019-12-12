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
	String airportSearch = "airportSearch_AdminCR.jsp";
	String airportUpdate = "airportUpdate_AdminCR.jsp";
	String airportDelete = "airportDelete_Admin.jsp";

	if (session.getAttribute("username") == null || logintype.equals("User")) {
		response.sendRedirect(loginURL);
	}
	
	if (request.getParameter("airport_id") == null) {
		response.sendRedirect(airportSearch);
	}

	//Get the more info parameter from airportResults_AdminCR.jsp
	String airportID = request.getParameter("airport_id");
	//Make a SELECT query to the Airport table with airportID specified by the more info parameter from airportResults_AdminCR.jsp
	String str, str_query, str_query_title;
	str = "SELECT * FROM DB1.Airport ap WHERE ap.airport_id = '" + airportID + "'";
	str_query = "Result for " + airportID + ":<br><br>";
	str_query_title = airportID;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Airport Information - <%
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

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//begin form to update Airport Info
				out.print("<form method='post' action='" + airportUpdate + "'>");
				//make a column
				out.print("<td>");
				//Print out current airport_id:
				out.print("<input type='text' name='new_airport_id' value='" + result.getString("airport_id") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current name:
				out.print("<input type='text' name='name' value='" + result.getString("name") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current city:
				out.print("<input type='text' name='city' value='" + result.getString("city") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current state (if any):
				out.print("<input type='text' name='state' value='" + result.getString("state") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current country:
				out.print("<input type='text' name='country' value='" + result.getString("country") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out an update button:
				out.print("<input type='submit' value='update'>");
				out.print("</form>");
				out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");
			
			if (logintype.equals("Admin")) {
				out.print("<table><tr><td>[ADMIN MODE]: </td>");
				out.print("<td><form method='post' action='" + airportDelete + "'>");
				out.print("<button type='submit' name='airport_id' value='" + airportID + "'>");
				out.print("delete");
				out.print("</button>");
				out.print("</form></td></tr></table>");
			}


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