<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!-- Thomas Fiorilla, cs336 Final Project, Group 4 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search for Tickets</title>
</head>
<body>
	<br>
	<h3>Look for a ticket number.</h3>
	<form method="get" action="ticketResults_AdminCR.jsp" enctype=text/plain>
		<table>
			<tr>
				<td>Ticket Number: </td>
				<td><input type="text" name="ticket_num" placeholder="ticket number"></td>
			</tr>
		</table>

		<input type='submit' name="submit" value="Submit">
	</form>
		<form method="get" action="ticketResults_AdminCR.jsp" enctype=text/plain>
			<button type="submit" name="ticket_num" value="getAll">Get All</button>
		
	</form>
</body>
</html>