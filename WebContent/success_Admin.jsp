<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Welcome to Our Domain</title>
	</head>
	<body>
		<br><b>Welcome</b><br><br>
		<% 
		out.println("Hello " + (String)session.getAttribute("username") + "!" + "You are a " + (String)session.getAttribute("usertype") + "!");
		%><br>
		Nice to meet you!<br><br>
		<a href="logout.jsp">Logout</a>
	</body>
</html>