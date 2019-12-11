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

	if (session.getAttribute("username") == null || logintype.equals("User")) {
		response.sendRedirect(loginURL);
	}

	//Get the search from the ticketSearch_AdminCR.jsp
	String ticketNum = request.getParameter("ticket_num");
	//Make a SELECT query from the flight table with flightID specified by the 'flight_id' parameter from flightSearch_AdminCR.jsp
	String str, str_query, str_query_title;
	str = "SELECT * FROM DB1.Ticket t WHERE t.ticket_num = '" + ticketNum + "'";
	str_query = "Result for " + ticketNum + " updates:<br><br>";
	str_query_title = ticketNum;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Flight Update Information - <%
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

			//Get parameters from the HTML form at flightInfo_AdminCR.jsp
			String ticket_num = request.getParameter("ticket_num");
			String new_round_trip = request.getParameter("round_trip");
			String new_booking_fee = request.getParameter("booking_fee");
			String new_total_fare = request.getParameter("total_fare");
			String new_issue_date = request.getParameter("issue_date");

			//Make an insert statement for the Flight table:
			String update = "UPDATE Ticket SET round_trip = ?, booking_fee = ?, total_fare = ?, issue_date = ? WHERE ticketNum = ?";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(update);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, new_round_trip);
			ps.setString(2, new_booking_fee);
			ps.setString(3, new_total_fare);
			ps.setString(4, new_issue_date);
			//Run the query against the DB
			ps.executeUpdate();

			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();

			out.print("Update succeeded!");

		} catch (Exception ex) {
			out.print(ex);
			out.print("Update failed :()");
		}
	%>
</body>
</html>