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

	//Get the flight_id from the flightInfo_AdminCR.jsp
	String flightID = request.getParameter("flight_id");

	String str_query_title;
	str_query_title = flightID;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Flight Date Delete - <%
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
			String dateDelete = request.getParameter("dateDelete");

			//Make a delete statement for the FlightDate table:
			String update = "DELETE FROM FlightDate WHERE " + dateDelete;

			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(update);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			//			ps.setString(1, dateDelete);
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