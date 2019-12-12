<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Sales Report Search</title>
	</head>
	<body>
		<br><b>Sales Report Search</b><br><br>
		<% out.print(session.getAttribute("test")); out.print(session.getAttribute("test2")); %>
		<form method="post" action=salesReportResult.jsp>
			Month<select name="month">
				<option value="1" >January</option>
				<option value="2" >February</option>
				<option value="3" >March</option>
				<option value="4" >April</option>
				<option value="5" >May</option>
				<option value="6" >June</option>
				<option value="7" >July</option>
				<option value="8" >August</option>
				<option value="9" >September</option>
				<option value="10">October</option>
				<option value="11">November</option>
				<option value="12">December</option>
			</select><br>
			Year<input type="number" name="year">
			
			<br><input type="submit">
		</form>
		
		<br><a href="logout.jsp">Logout</a>
	</body>
</html>