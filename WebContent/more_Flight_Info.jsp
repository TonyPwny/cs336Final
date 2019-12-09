<!-- 
Nicolas Gundersen
CS336
Professor Miranda
Project Final Group 4
 -->


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Here are your results!</title>
<h4>Filter by Price, Take off, Land time, Airline</h4>
</head>
<body>

	<%
		//Get arguments

		Boolean roundtrip = Boolean.parseBoolean(request.getParameter("round_trip"));
		String takeoffd1 = request.getParameter("take_off_date");
		String takeoffd2 = request.getParameter("take_off_date_2");
		String arrived1 = request.getParameter("arrive_date");
		String arrived2 = request.getParameter("arrive_date_2");
		String flightid = request.getParameter("flight_id");
		String departing_port = request.getParameter("depport");
		String arriving_port = request.getParameter("arrivport");

		
		if {   }
		else {

			out.println("You didnt enter any data!<br>");
			out.println("<a href='flight_Search'>Try Again</a>");
		}
	%>



	<a href="success.jsp">Want to go back?</a>

</body>
</html>