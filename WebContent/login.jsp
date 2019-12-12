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
				//Get arguments
				String username = request.getParameter("username");
				String password = request.getParameter("password");
		
				if (username == null) username = "";
				if (password == null) password = "";
				
				String url = "jdbc:mysql://steve2.ckgj9bgqpyor.us-east-2.rds.amazonaws.com:3306/DB1";
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				//Connect to database
				Connection conn = DriverManager.getConnection(url, "admin", "password");
				
				Statement s = conn.createStatement();
				String str = "select * from User where username=\"" + username + "\" and password=\"" + password + "\"";
				
				//gets all tuples from A
				ResultSet result = s.executeQuery(str);
				
				if (result.next()) {
					session.setAttribute("username", username);
				// gets usertype from column 3 and sets it to usertype object
					String usertype = result.getString(4);
					session.setAttribute("usertype", usertype);
				
				// checks what type of guest is on the site
					if(usertype.contains("User")){
						conn.close();
						response.sendRedirect("success.jsp");
					}
					else if(usertype.contains("Admin")){
						conn.close();
						response.sendRedirect("adminHomepage.jsp");
					}
					else if(usertype.contains("SalesRep")){
						conn.close();
						response.sendRedirect("rep_Homepage.jsp");
					}
					
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