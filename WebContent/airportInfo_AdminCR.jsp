
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

	String airportID = request.getParameter("airportID");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Airport Information - <%
	out.println("airportName");
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
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String city = "SELECT ap.city FROM DB1.Airport ap WHERE ap.airport_id = " + airportID;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(city);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("bar");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("beer");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("price");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("bar"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("beer"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("price"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
	<br> Airport ID:
	<%
		out.println(" <b></b><br>");
	%>
	Location:
	<%
		out.println(" <b></b><br>");
	%>
	<br> Airlines:
	<%
		out.println(" <b></b><br>");
	%>
	<br> Departing Flights:
	<%
		out.println(" <b></b><br>");
	%>
	Arriving Flights:
	<%
		out.println(" <b></b><br>");
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