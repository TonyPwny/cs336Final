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
		<h3>What type of flight?</h3>
		<form method="get" action="flight_Search.jsp" enctype=text/plain>
		<input type = "radio" name = "round_trip" value="0"/> One Way
		<input type = "radio" name = "round_trip" value="1"/> Round Trip	
		
		<table>
				<tr>
					<!-- textbox for flight search -->
					<td>Take off date</td>
						</tr>
							<tr>
								<td>From:</td>
						<td>
								<input type="text" name="take_off_date" placeholder="Start Range"> To:
					 			<input type= "text" name= "take_off_date_2" placeholder="End Range"> 
							</td> 
						</tr>
						<br>
					<tr>
						 <td> Arrive date </td>
						</tr>
					<tr> 
						<td>From:</td> 
						<td>
							<input type="text" name="arrive_date" placeholder= "Start Range"> To:
							<input type="text" name="arrive_date_2" placeholder ="End Range">
				
				
				</table>
				
		<input type = 'submit' name="submit" value = "submit"> 	
			
			</form>
		
		<br>
		<br>Want to go back?<br>
		<a href="success.jsp">Want to go back?</a>
		
	</body>
</html>