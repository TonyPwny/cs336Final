
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
		<br>
		<!-- Show html form to i) display something, ii) choose an action via a 
		  radio button -->
		<!-- forms are used to collect user input 
		  The default method when submitting form data is GET.
		  However, when GET is used, the submitted form data will be visible in the page address field-->
		<b>Login</b>
		<form method="post" action=login.jsp>
			<table>
				<tr>
					<!-- textbox for username -->
					<td>Username:</td>
					<td><input type="text" name="username" placeholder="Username"></td>
				</tr>
				
				<tr>
					<td>Password:</td>
					<td><input type="password" name="password" placeholder="Password"></td>
				</tr>
			</table>
			<!-- sends username and password to checkLogin.jsp on submit -->
			<input type="submit" value="Submit"/>
		</form><br><br><br>
		
		<b>Register</b>
		<form method="post" action=register.jsp>
			<table>
				<tr>
					<td>Username:</td>
					<td><input type="text" name="username" placeholder="Username"></td>
				</tr>
				
				<tr>
					<td>Password:</td>
					<td><input type="password" name="password" placeholder="Password"></td>
				</tr>
			</table>
			<input type="submit" value="Submit"/>
		</form>
	</body>
</html>