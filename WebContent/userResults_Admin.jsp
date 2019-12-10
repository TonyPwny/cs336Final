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
	String flightInfo = "flightInfo_AdminCR.jsp";

	if (session.getAttribute("username") == null || logintype.equals("User")) {
		response.sendRedirect(loginURL);
	}

	//Get the search from the flightSearch_AdminCR.jsp
	String flightID = request.getParameter("flight_id");
	//Make a SELECT query from the Airport table with flightID specified by the 'flight_id' parameter at the flightSearch_AdminCR.jsp
	String str, str_query, str_query_title;
	if (flightID.isEmpty() || flightID.equals("getAll")) {
		str = "SELECT * FROM DB1.Flight f, DB1.Airline al, DB1.Aircraft ac WHERE f.airline_id = al.airline_id AND f.aircraft_id = ac.aircraft_id;";
		if (flightID.isEmpty()) {
			str_query = "No Airline ID given, press back to search again.<br><br>";
			str_query_title = "Empty Search";
		} else {
			str_query = "Querying for all Flights:<br><br>";
			str_query_title = "Displaying All Flights";
		}
	} else {
		str = "SELECT * FROM DB1.Flight f, DB1.Airline al, DB1.Aircraft ac WHERE f.flight_id LIKE '" + flightID
				+ "%' AND f.airline_id = al.airline_id AND f.aircraft_id = ac.aircraft_id";
		str_query = "Result for " + flightID + ":<br><br>";
		str_query_title = flightID + " search results";
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Flight Results - <%
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
		if (flightID.isEmpty()) {
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
				out.print("Flight ID");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Airline");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Aircraft");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Capacity");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Type");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Departure Time");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Arrival Time");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Days");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("First Class Fare");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Business Class Fare");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Economy Class Fare");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("");
				out.print("</td>");
				out.print("</tr>");

				//parse out the results
				while (result.next()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current flight_id:
					out.print(result.getString("flight_id"));
					out.print("</td>");
					out.print("<td>");
					//Print out current airline_name:
					out.print(result.getString("airline_name"));
					out.print("</td>");
					out.print("<td>");
					//Print out current aircraft_id:
					out.print(result.getString("aircraft_id"));
					out.print("</td>");
					out.print("<td>");
					//Print out current capacity:
					out.print(result.getString("capacity"));
					out.print("</td>");
					out.print("<td>");
					//Print out current flight_type:
					out.print(result.getString("flight_type"));
					out.print("</td>");
					out.print("<td>");
					//Print out current depart_time:
					out.print(result.getString("depart_time"));
					out.print("</td>");
					out.print("<td>");
					//Print out current arrive_time:
					out.print(result.getString("arrive_time"));
					out.print("</td>");
					out.print("<td>");
					//Print out current flight_days:
					out.print(result.getString("flight_days"));
					out.print("</td>");
					out.print("<td>");
					//Print out current fare_first:
					out.print(result.getString("fare_first"));
					out.print("</td>");
					out.print("<td>");
					//Print out current fare_bust:
					out.print(result.getString("fare_bus"));
					out.print("</td>");
					out.print("<td>");
					//Print out current fare_econ:
					out.print(result.getString("fare_econ"));
					out.print("</td>");
					out.print("<td>");
					//Print out an edit button:
					out.print("<form method='post' action='" + flightInfo + "'>");
					out.print(
							"<button type='submit' name='flight_id' value=" + result.getString("flight_id") + ">");
					out.print("more info");
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