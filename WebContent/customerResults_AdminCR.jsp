<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!-- Thomas Fiorilla, cs336 Final Project, Group 4 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String login = (String) session.getAttribute("username");
	String logintype = (String) session.getAttribute("usertype");
	String loginURL = "login.jsp";
	/*
	if (session.getAttribute("username") == null || logintype.equals("User")) {
		response.sendRedirect(loginURL);
	}
	*/
	//Get the search from the userSearch_Admin.jsp
	String username = request.getParameter("username");
	//Make a SELECT query from the Airport table with username specified by the 'username' parameter at the userSearch_Admin.jsp
	String str, str_query, str_query_title;
	if (username.isEmpty() || username.equals("getAll")) {
		str = "SELECT * FROM DB1.User u WHERE u.usertype = 'User';";
		if (username.isEmpty()) {
			str_query = "No Username given, press back to search again.<br><br>";
			str_query_title = "Empty Search";
		} else {
			str_query = "Querying for all Users:<br><br>";
			str_query_title = "Displaying All Users";
		}
	} else {
		str = "SELECT * FROM DB1.User u WHERE u.usertype = 'User' AND u.username LIKE '" + username + "%'";
		str_query = "Result for " + username + ":<br><br>";
		str_query_title = username + " search results";
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Username Results - <%
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
		if (username.isEmpty()) {
			out.print(str_query);
		} else {
			List<String> list = new ArrayList<String>();

			try {

				//Get the database connection
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();

				//Create a SQL statement
				Statement stmt = con.createStatement();

				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);

				//Show what kind of query is being processed
				out.print(str_query);

				//Make an HTML table to show the results in:
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Username");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Name");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Fare Totals");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("");
				out.print("</td>");

				//parse out the results
				while (result.next()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current username:
					out.print(result.getString("username"));
					out.print("</td>");
					out.print("<td>");
					//Print out current name_user:
					out.print(result.getString("name_user"));
					out.print("</td>");
					out.print("<td>");
					
					//Make a query for the sum of the user's total fares
					/*String str2 = "SELECT sum(total_fare) as fare_sum from DB1.reserves r, DB1.Ticket t" +
					"WHERE r.ticket_num = t.ticket_num AND r.username LIKE '" + result.getString("username") + "';";*/
					String str2 = "SELECT sum(total_fare) as fare_sum from DB1.reserves r, DB1.Ticket t "
						+ "WHERE r.ticket_num = t.ticket_num AND r.username LIKE '" + result.getString("username") + "';";
					//Create a SQL statement
					Statement stmt2 = con.createStatement();
					//Run the query against the database.
					ResultSet result2 = stmt2.executeQuery(str2);
					
					//Check to see if total fares is null; if so, just print 0
					if(!result2.first()){
						out.print("0");
					} else{
						if(result2.getString("fare_sum") == null){
							out.print("0");
						} else{
							out.print(result2.getString("fare_sum"));
						}
					}
					out.print("</td>");
					out.print("<td>");
					//Create a button for admins/sales reps to view reservations
					out.print("<form method='get' action='customerReservation_AdminCR.jsp' enctype=text/plain>");
						out.print("<button type='submit' name='username' value=" + result.getString("username") + ">");
							out.print("Check Reservations");
						out.print("</button>");
					out.print("</form>");
					out.print("</td>");
					out.print("</tr>");
				}
				out.print("</table>");

				//close the connection.
				con.close();

			} catch (Exception e) {
			}
		}
	%>
	<br>
	<br>
	<%
		// Try and get the current count from the session
		Integer count = (Integer) session.getAttribute("COUNT");
		// If COUNT is not found, create it and add it to the session
		if (count == null) {
			count = new Integer(1);
			session.setAttribute("COUNT", count);
		} else {
			count = new Integer(count.intValue() + 1);
			session.setAttribute("COUNT", count);
		}
		// Print the number of times the user has visited the site
		out.println("Current session site views: <b>" + count + "</b>");
	%>
</body>
</html>