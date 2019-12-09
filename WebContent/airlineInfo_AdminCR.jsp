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
	String airlineSearch = "airlineSearch_AdminCR.jsp";
	String airlineUpdate = "airlineUpdate_AdminCR.jsp";

	if (session.getAttribute("username") == null || logintype.equals("User")) {
		response.sendRedirect(loginURL);
	}

	if (request.getParameter("airline_id") == null) {
		response.sendRedirect(airlineSearch);
	}

	//Get the more info parameter from airlineResults_AdminCR.jsp
	String airlineID = request.getParameter("airline_id");
	//Make a SELECT query to the Airline table with airlineID specified by the more info parameter from airlineResults_AdminCR.jsp
	String str, str_query, str_query_title;
	str = "SELECT * FROM DB1.Airline al WHERE al.airline_id = '" + airlineID + "'";
	str_query = "Result for " + airlineID + ":<br><br>";
	str_query_title = airlineID;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Airline Information - <%
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
			out.print("Airline ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Name");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Revenue Contribution");
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
				//begin form to update Airline Info
				out.print("<form method='post' action='" + airlineUpdate + "'>");
				//make a column
				out.print("<td>");
				//Print out current airline_id:
				out.print("<select name='airline_id'>");
				out.print("<option value='" + result.getString("airline_id") + "'>" + result.getString("airline_id")
						+ "</option>");
				out.print("</select>");
				out.print("</td>");
				out.print("<td>");
				//Print out current name:
				out.print("<input type='text' name='airline_name' value='" + result.getString("airline_name") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current revenue contribution:
				out.print("<input type='text' name='airline_revenue' value='revenue contributions'");
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