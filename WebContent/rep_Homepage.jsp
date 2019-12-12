<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!-- Steven Nguyen, cs336 Final Project, Group 4 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Representative Homepage</title>
	</head>
	<body>
		<br><b>Customer Representative Homepage</b><br><br>
		<% 
			out.println("Hello " + (String)session.getAttribute("username") + "!");
		%><br>
		
		<a href="flightSearch_AdminCR.jsp">Flight Search</a><br>
		<a href="airlineSearch_AdminCR.jsp">Airline Search</a><br>
		<a href="ticketSearch_AdminCR.jsp">Ticket Search</a><br>
		<a href="airportSearch_AdminCR.jsp">Airport Search</a><br>
		<a href="customerSearch_AdminCR.jsp">Search Customers</a><br>
		
		<br><a href="logout.jsp">Logout</a>
	</body>
</html>