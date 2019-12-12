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
		str_query = "Search Results for " + username + ":<br><br>";
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
	<%
		out.println("Logged in as: <b>" + login + "</b> - " + logintype + "<br><br>");
	
		if (username.isEmpty()) {
			out.print(str_query);
		} else {
			try {

				String url = "jdbc:mysql://steve2.ckgj9bgqpyor.us-east-2.rds.amazonaws.com:3306/DB1";
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				//Connect to database
				Connection conn = DriverManager.getConnection(url, "admin", "password");

				PreparedStatement stmt = conn.prepareStatement(str);

				//Run the query against the database.
				ResultSet result = stmt.executeQuery();

				//Show what kind of query is being processed
				out.print(str_query);

				out.print(
					"<form action=userInfo_Admin.jsp><table><tr>" + 
						"<td>" + 
							"Username" + 
						"</td>" + 
						"<td>" + 
							"Name" + 
						"</td>" + 
						"<td>" + 
							"Usertype" + 
						"</td>" + 
						"<td>" + 
							"Revenue" + 
						"</td>" +
						"<td>" +
							"" +
						"</td>"
				);

				//parse out the results
				while (result.next()) {
					//Make a query for the sum of the user's total fares
					String str2 = 
						"select sum(T.booking_fee) fare_sum " +
						"from buys b, Ticket T " +
						"where b.username = ? " +
						"and b.ticket_num = T.ticket_num " +
						"group by (b.username)";
					PreparedStatement stmt2 = conn.prepareStatement(str2);
					stmt2.setString(1, result.getString("username"));
					
					//Get sum of 
					ResultSet result2 = stmt2.executeQuery();
					//make a row
					if (result2.next()) {
						out.print(
							String.format(
								"<tr>" +
									"<td>%s</td>" + 
									"<td>%s</td>" +
									"<td>%s</td>" + 
									"<td>%.2f</td>",
								result.getString("username"),
								result.getString("name_user"),
								result.getString("usertype"),
								result2.getDouble("fare_sum")
							)
						);
					} else {
						out.print(
							String.format(
								"<tr>" +
									"<td>%s</td>" + 
									"<td>%s</td>" +
									"<td>%s</td>" + 
									"<td>%s</td>",
								result.getString("username"),
								result.getString("name_user"),
								result.getString("usertype"),
								"0.00"
							)
						);
					}
					out.print(
						String.format(
							"<td><button type='submit' name='username' value='%s'>More Info</button></td>" +
							"</tr>",
							result.getString("username")
						)
					);
					
				}
				out.print("</table></form>");

				//close the connection.
				conn.close();

			} catch (Exception e) {
				out.print(e);
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