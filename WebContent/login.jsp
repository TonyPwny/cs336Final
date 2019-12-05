<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Logging in</title>
	</head>
	<body>
		<%
			try {
				if (session.getAttribute("username") != null) {
					response.sendRedirect("success.jsp");
				}
				
				//Get arguments
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				
				String url = "jdbc:mysql://steve2.ckgj9bgqpyor.us-east-2.rds.amazonaws.com:3306/DB2";
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				//Connect to database
				Connection conn = DriverManager.getConnection(url, "admin", "password");
				
				Statement s = conn.createStatement();
				String str = "select * from login where username=\"" + username + "\" and password=\"" + password + "\"";
				
				//gets all tuples from A
				ResultSet result = s.executeQuery(str);
				if (result.next()) {
					session.setAttribute("username", username);
	
					conn.close();
					response.sendRedirect("success.jsp");
				} else {
					out.println("Invalid username and password<br>");
					out.println("<a href='index.jsp'>Try Again</a>");
					conn.close();
				}
			} catch (Exception e) {
				out.print(e);
			}
		%>
	</body>
</html>