<!--
Anthony Tiongson
CS336 Section 07
Professor Miranda
Project Final Group 4

Page was coded with aid from the project beer template and ProjectSETUP guide.
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String login = (String) session.getAttribute("username");
	String logintype = (String) session.getAttribute("usertype");
	String loginURL = "login.jsp";

	if (session.getAttribute("username") == null || logintype.equals("User")) {
		response.sendRedirect(loginURL);
	}

	//Get the search from the airlineSearch_AdminCR.jsp
	String airlineID = request.getParameter("airline_id");
	//Make a SELECT query from the Airline table with airline specified by the 'airline_id' parameter at the airlineSearch_AdminCR.jsp
	String str, str_query, str_query_title;
	str = "SELECT * FROM DB1.Airline al WHERE al.airline_id = '" + airlineID + "'";
	str_query = "Result for " + airlineID + " updates:<br><br>";
	str_query_title = airlineID;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Airline Update Information - <%
	out.println(str_query_title);
%></title>
</head>
<body>
	<br> Logged in as:
	<%
		out.println(" <b>" + login + "</b> - " + logintype);
	%>
	<br>
	<br>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();

			//Get parameters from the HTML form at airlineInfo_AdminCR.jsp
			String airline_id = request.getParameter("airline_id");
			String new_name = request.getParameter("airline_name");
			String new_revenue = request.getParameter("airline_revenue");

			//Make an insert statement for the Sells table:
			String update = "UPDATE Airline SET airline_name = ? WHERE airline_id = ?";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(update);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, new_name);
			ps.setString(2, airline_id);
			//Run the query against the DB
			ps.executeUpdate();

			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();

			out.print("Update succeeded!");

		} catch (Exception ex) {
			out.print(ex);
			out.print("Update failed :()");
		}
	%>
</body>
</html>