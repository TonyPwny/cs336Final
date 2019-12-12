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

	//Get the search from the flightSearch_AdminCR.jsp
	String flightID = request.getParameter("flight_id");
	//Make a SELECT query from the flight table with flightID specified by the 'flight_id' parameter from flightSearch_AdminCR.jsp
	String str_query_title;
	str_query_title = flightID;
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
			String flight_id = request.getParameter("flight_id");
			String new_aircraft_id = request.getParameter("aircraft_id");
			String new_depart_time = request.getParameter("depart_time");
			String new_arrive_time = request.getParameter("arrive_time");
			String new_flight_days = request.getParameter("flight_days");
			String new_flight_type = request.getParameter("flight_type");
			String new_fare_econ = request.getParameter("fare_econ");
			String new_fare_first = request.getParameter("fare_first");
			String new_fare_bus = request.getParameter("fare_bus");

			//Make an insert statement for the Flight table:
			String update = "UPDATE Flight SET aircraft_id = ?, depart_time = ?, arrive_time = ?, flight_days = ?, flight_type = ?, fare_econ = ?, fare_first = ?, fare_bus = ? WHERE flight_id = ?";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(update);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, new_aircraft_id);
			ps.setString(2, new_depart_time);
			ps.setString(3, new_arrive_time);
			ps.setString(4, new_flight_days);
			ps.setString(5, new_flight_type);
			ps.setString(6, new_fare_econ);
			ps.setString(7, new_fare_first);
			ps.setString(8, new_fare_bus);
			ps.setString(9, flight_id);
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