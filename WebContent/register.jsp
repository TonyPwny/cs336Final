<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Registering</title>
	</head>
	<body><br>
		<%
			try {
				if (session.getAttribute("username") != null) {
					response.sendRedirect("success.jsp");
				}
				
				//Get arguments
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				
				//Check username & password requirements
				if (username.length() < 3 || username.length() > 50) {
					out.println("Username must be within 3 to 50 characters, please try another.<br><br>");
			        out.println("<a href='index.jsp'>Try Again</a>");
					return;
				}
				if (password.length() < 3 || password.length() > 50) {
					out.println("Password must be within 3 to 50 characters, please try another.<br><br>");
			        out.println("<a href='index.jsp'>Try Again</a>");
					return;
				}
				
				String url = "jdbc:mysql://steve2.ckgj9bgqpyor.us-east-2.rds.amazonaws.com:3306/DB1";
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				//Connect to database
				Connection conn = DriverManager.getConnection(url, "admin", "password");
				
				Statement s = conn.createStatement();
				String str = "select * from User where username=\"" + username + "\"";
				
				//gets all tuples from A
				ResultSet result = s.executeQuery(str);
				if (result.next()) {
					out.println("Unavaliable username, please try another.<br><br>");
			        out.println("<a href='index.jsp'>Try Again</a>");
					conn.close();
				} else {
					session.setAttribute("username", username);
					str = "insert into User(username, password) values(\"" + username + "\", \"" + password + "\")";
					s.executeUpdate(str);
					
					conn.close();
					response.sendRedirect("success.jsp");
				}
			} catch (Exception e) {
				out.print(e);
			}
		%>
	</body>
</html>