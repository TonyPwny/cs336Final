<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Search for Customers</title>
	</head>
	<body>
		<br>
		<h3>Search for a customer.</h3>
			<form method="get" action="customerResults_AdminCR.jsp" enctype=text/plain>
				<table>
					<tr>
						<td>Username: </td>
						<td><input type="text" name=""username"" placeholder="username"></td>
					</tr>
				</table>
				
				<input type = 'submit' name="submit" value = "Submit">
			</form>
			
			<form method="get" action="customerResults_AdminCR.jsp" enctype=text/plain>
				<button type="submit" name="username" value="getAll">Get All</button>
			</form>
		
	</body>
</html>