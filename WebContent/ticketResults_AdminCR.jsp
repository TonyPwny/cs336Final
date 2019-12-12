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
	String ticketInfo = "ticketInfo_AdminCR.jsp";

	if (session.getAttribute("username") == null || logintype.equals("User")) {
		response.sendRedirect(loginURL);
	}

	//Get the search from the flightSearch_AdminCR.jsp
	String ticketNum = request.getParameter("ticket_num");
	//Make a SELECT query from the Airport table with flightID specified by the 'flight_id' parameter at the flightSearch_AdminCR.jsp
	String str, str_query, str_query_title;
	if (ticketNum.isEmpty() || ticketNum.equals("getAll")) {
		str = "SELECT * FROM DB1.Ticket";
		if (ticketNum.isEmpty()) {
			str_query = "No ticket number given, press back to search again.<br><br>";
			str_query_title = "Empty Search";
		} else {
			str_query = "Querying for all Tickets:<br><br>";
			str_query_title = "Displaying All Tickets";
		}
	} else {
		str = "SELECT * FROM DB1.Ticket t WHERE t.ticket_num LIKE '" + ticketNum + "%'";
		str_query = "Result for " + ticketNum + ":<br><br>";
		str_query_title = ticketNum + " search results";
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Ticket Results - <%
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
		if (ticketNum.isEmpty()) {
			out.print(str_query);
		} else {
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
				out.print("Type");
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
					//make a column
					out.print("<td>");
					//Print out current ticket_num:
					out.print(result.getString("ticket_num"));
					out.print("</td>");
					out.print("<td>");
					//Print out current round_trip:
					String value;
					if (result.getBoolean("round_trip")) {
						value = "Round Trip";
					}
					else {
						value = "One-Way";
					}
					out.print(value);
					out.print("</td>");
					out.print("<td>");
					//Print out current booking_fee:
					out.print(result.getString("booking_fee"));
					out.print("</td>");
					out.print("<td>");
					//Print out current total_fare:
					out.print(result.getString("total_fare"));
					out.print("</td>");
					out.print("<td>");
					//Print out current issue_date:
					out.print(result.getString("issue_date"));
					out.print("</td>");
					out.print("<td>");
					//Print out an edit button:
					out.print("<form method='post' action='" + ticketInfo + "'>");
					out.print(
							"<button type='submit' name='ticket_num' value=" + result.getString("ticket_num") + ">");
					out.print("more info");
					out.print("</button>");
					out.print("</form>");
					out.print("</td>");
					out.print("</tr>");
				}
				out.print("</table>");

				//close the connection.
				con.close();

			} catch (Exception e) {
			}
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