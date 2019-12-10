<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Search for Flights!</title>
	</head>
	<body>
		<br>
		<h3>Search for an airline</h3>
			<form method="get" action="airlineResults_AdminCR.jsp" enctype=text/plain>
				<table>
					<tr>
						<td>Airline ID:</td>
						<td><input type="text" name="airline_id" placeholder="Airline ID"></td>
					</tr>
				</table>
				
				<input type = 'submit' name="submit" value = "Submit">
			</form>
			
			<form method="get" action="airlineResults_AdminCR.jsp" enctype=text/plain>
				<td>Click here to get all: </td>
				<td><input type = 'submit' name="airline_id" value = ""></td>
			</form>
			
		
	</body>
</html>