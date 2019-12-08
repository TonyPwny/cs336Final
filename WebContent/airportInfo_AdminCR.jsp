
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
			//Get the search from the airlineInforSearch_AdminCR.jsp
			String airportID = request.getParameter("airportID");
			//Make a SELECT query from the Airport table with airportID specified by the 'airport_id' parameter at the airlineInfoSearch_AdminCR.jsp
			String str, str_query;
			if (airportID == null || airportID.equals("getAll")) {
				str = "SELECT * FROM DB1.Airport";
				if (airportID == null) {
					str_query = "No Airport ID given, showing all results:<br><br>";
				}
				else {
					str_query = "Querying for all Airports:<br><br>";
				}
			} else {
				str = "SELECT * FROM DB1.Airport ap WHERE ap.airport_id = " + airportID;
				str_query = "Result for " + airportID + ":<br><br>";
			}
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
			out.print("Airport ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Name");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("City");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("State");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Country");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current airport_id:
				out.print(result.getString("airport_id"));
				out.print("</td>");
				out.print("<td>");
				//Print out current name:
				out.print(result.getString("name"));
				out.print("</td>");
				out.print("<td>");
				//Print out current city:
				out.print(result.getString("city"));
				out.print("</td>");
				out.print("<td>");
				//Print out current state (if any):
				out.print(result.getString("state"));
				out.print("</td>");
				out.print("<td>");
				//Print out current country:
				out.print(result.getString("country"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
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