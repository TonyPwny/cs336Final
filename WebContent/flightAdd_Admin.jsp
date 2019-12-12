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

	if (session.getAttribute("username") == null || !logintype.equals("Admin")) {
		response.sendRedirect(loginURL);
	}

	//Get the new flight_id from the flightAddForm_Admin.jsp
	String flightID = request.getParameter("flight_id");

	String str_query_title;
	str_query_title = flightID;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Flight Add - <%
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

			String airline_id = request.getParameter("airline_id");
			String aircraft_id = request.getParameter("aircraft_id");
			String depart_aid = request.getParameter("depart_aid");
			String arrive_aid = request.getParameter("arrive_aid");
			String depart_time = request.getParameter("depart_time");
			String arrive_time = request.getParameter("arrive_time");
			String flight_days = request.getParameter("flight_days");
			String flight_type = request.getParameter("flight_type");
			String fare_econ = request.getParameter("fare_econ");
			String fare_first = request.getParameter("fare_first");
			String fare_bus = request.getParameter("fare_bus");

			//Make an insert statement for the Flight table:
			String update = "INSERT INTO Flight VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(update);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, flightID);
			ps.setString(2, airline_id);
			ps.setString(3, aircraft_id);
			ps.setString(4, depart_aid);
			ps.setString(5, arrive_aid);
			ps.setString(6, depart_time);
			ps.setString(7, arrive_time);
			ps.setString(8, flight_days);
			ps.setString(9, flight_type);
			ps.setString(10, fare_econ);
			ps.setString(11, fare_first);
			ps.setString(12, fare_bus);
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