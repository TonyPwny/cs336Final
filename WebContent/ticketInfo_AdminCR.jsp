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
	String ticketSearch = "ticketSearch_AdminCR.jsp";
	String ticketUpdate = "ticketUpdate_AdminCR.jsp";

	if (session.getAttribute("username") == null || logintype.equals("User")) {
		response.sendRedirect(loginURL);
	}

	if (request.getParameter("ticket_num") == null) {
		response.sendRedirect(ticketSearch);
	}

	//Get the more info parameter from ticketResults_AdminCR.jsp
	String ticketNum = request.getParameter("ticket_num");
	//Make a SELECT query to the Ticket table with ticket_num specified by the more info parameter from ticketResults_AdminCR.jsp
	String str, str_query, str_query_title;
	str = "SELECT * FROM Ticket t, trip tr WHERE t.ticket_num = '" + ticketNum + "' AND t.ticket_num = tr.ticket_num";
	str_query = "Ticket Number: " + ticketNum + "<br><br>";
	str_query_title = ticketNum;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Ticket Information - <%
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
			out.print("Round Trip");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Booking Fee");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Total Fare");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Issue Date");
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
				//begin form to update Ticket Info
				out.print("<form method='post' action='" + ticketUpdate + "'>");
				//make a column
				out.print("<td>");
				//Print out associated flight_id's:
				out.print(
						"<input type='text' name='flight_id' value='" + result.getString("flight_id") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current round_trip:
				out.print(
						"<input type='text' name='round_trip' value='" + result.getBoolean("round_trip") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current booking_fee:
				out.print("<input type='text' name='booking_fee' value='" + result.getString("booking_fee") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current total_fare:
				out.print("<input type='text' name='total_fare' value='" + result.getString("total_fare") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current issue_date:
				out.print("<input type='text' name='issue_date' value='" + result.getString("issue_date") + "'");
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