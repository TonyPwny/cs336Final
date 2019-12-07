
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
		<title>Flight Information</title>
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
		<b>Flight ID:</b><br>
		<b>Operated by:</b><br>
		<b>Aircraft Model:</b><br>
		<br>
		<b>Type:</b><br>
		<b>Departure from:</b><br>
		<b>Departure day and time:</b><br>
		<b>Arrival to:</b><br>
		<b>Arrival day and time:</b><br>
		<br>
		<b>Economy class fare:</b><br>
		<b>Business class fare:</b><br>
		<b>First class fare:</b><br>
		<br>
		<br>
	</body>
</html>