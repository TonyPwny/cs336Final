
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<%
		if (session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
		}
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Ticket Information</title>
	</head>
	<body>
		<br>
		<b>
			<%
				out.println("Logged in as: " + (String)session.getAttribute("username") + " - " + (String)session.getAttribute("usertype"));
			%>
		</b>
		<br>
		<br>
		<b>Ticket number:</b><br>
		<b>Revenue:</b><br>
		<b>Price:</b><br>
		<br>
		<b>Trip Information:</b><br>
		<br>
		<br>
	</body>
</html>