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
	String flightSearch = "flightSearch_AdminCR.jsp";
	String flightUpdate = "flightUpdate_AdminCR.jsp";
	String flightDelete = "flightDelete_Admin.jsp";
	String flightDateUpdate = "flightDateUpdate_AdminCR.jsp";
	String flightDateAdd = "flightDateAdd_AdminCR.jsp";
	String flightDateDelete = "flightDateDelete_AdminCR.jsp";

	if (session.getAttribute("username") == null || logintype.equals("User")) {
		response.sendRedirect(loginURL);
	}

	if (request.getParameter("flight_id") == null) {
		response.sendRedirect(flightSearch);
	}

	//Get the more info parameter from flightResults_AdminCR.jsp
	String flightID = request.getParameter("flight_id");
	//Make a SELECT query to the Flight table with flightID specified by the more info parameter from flightResults_AdminCR.jsp
	String flightInfo, flightDate, str_query, str_query_title;
	flightInfo = "SELECT * FROM DB1.Flight f, DB1.Airline al, DB1.Aircraft ac WHERE f.flight_id = '" + flightID
			+ "' AND f.airline_id = al.airline_id AND f.aircraft_id = ac.aircraft_id";
	flightDate = "SELECT * FROM DB1.FlightDate fd WHERE fd.flight_id = '" + flightID + "'";
	str_query = "Result for " + flightID + ":<br><br>";
	str_query_title = flightID;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Flight Information - <%
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
			Statement stmt1 = con.createStatement();
			Statement stmt2 = con.createStatement();

			//Run the query against the database.
			ResultSet flightInfoResult = stmt1.executeQuery(flightInfo);
			ResultSet flightDateResult = stmt2.executeQuery(flightDate);

			//Show what kind of query is being processed
			out.print(str_query);

			//Make an HTML table to show the flightInfoResults in:
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
			out.print("Departure Airport");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Departure Time");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Arrival Airport");
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

			//parse out the flightInfoResults
			while (flightInfoResult.next()) {
				//make a row
				out.print("<tr>");
				//begin form to update Flight Info
				out.print("<form method='post' action='" + flightUpdate + "'>");
				//make a column
				out.print("<td>");
				//Print out current flight_id:
				out.print("<input type='text' name='flight_id' value='"
						+ flightInfoResult.getString("flight_id") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current airline_name:
				out.print("<input type='text' name='airline_name' value='"
						+ flightInfoResult.getString("airline_name") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current aircraft_id:
				out.print("<input type='text' name='aircraft_id' value='"
						+ flightInfoResult.getString("aircraft_id") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current capacity:
				out.print("<input type='text' name='capacity' value='" + flightInfoResult.getString("capacity")
						+ "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current flight_type:
				out.print("<input type='text' name='flight_type' value='"
						+ flightInfoResult.getString("flight_type") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current depart_aid:
				out.print("<input type='text' name='depart_aid' value='" + flightInfoResult.getString("depart_aid")
						+ "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current depart_time:
				out.print("<input type='text' name='depart_time' value='"
						+ flightInfoResult.getString("depart_time") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current arrive_aid:
				out.print("<input type='text' name='arrive_aid' value='" + flightInfoResult.getString("arrive_aid")
						+ "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current arrive_time:
				out.print("<input type='text' name='arrive_time' value='"
						+ flightInfoResult.getString("arrive_time") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current flight_days:
				out.print("<input type='text' name='flight_days' value='"
						+ flightInfoResult.getString("flight_days") + "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current fare_first:
				out.print("<input type='text' name='fare_first' value='" + flightInfoResult.getString("fare_first")
						+ "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current fare_bus:
				out.print("<input type='text' name='fare_bus' value='" + flightInfoResult.getString("fare_bus")
						+ "'");
				out.print("</td>");
				out.print("<td>");
				//Print out current fare_econ:
				out.print("<input type='text' name='fare_econ' value='" + flightInfoResult.getString("fare_econ")
						+ "'");
				out.print("</td>");
				out.print("<td>");
				//Print out an update button:
				out.print("<input type='submit' value='update'>");
				out.print("</form>");
				out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");
			
			if (logintype.equals("Admin")) {
				out.print("<table><tr><td>[ADMIN MODE]: </td>");
				out.print("<td><form method='post' action='" + flightDelete + "'>");
				out.print("<button type='submit' name='flight_id' value='" + flightID + "'>");
				out.print("delete");
				out.print("</button>");
				out.print("</form></td></tr></table>");
			}

			//Make an HTML table to show the flightDateResults in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Departing Dates");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Arriving Dates");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("");
			out.print("</td>");
			out.print("</tr>");

			//make a row
			out.print("<tr>");
			//begin form to update Flight Info
			out.print("<form method='post' action='" + flightDateAdd + "'>");
			//make a column
			out.print("<td>");
			//Print out current airline_name:
			out.print("<input type='text' name='depart_date' value='YEAR-MM-DD'>");
			out.print("</td>");
			out.print("<td>");
			//Print out current airline_name:
			out.print("<input type='text' name='arrive_date' value='YEAR-MM-DD'>");
			out.print("</td>");
			//make a column
			out.print("<td>");
			//Print out a more info button:
			out.print("<button type='submit' name='flight_id' value=" + flightID + " >");
			out.print("add");
			out.print("</button>");
			out.print("</form>");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (flightDateResult.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current depart_date:
				out.print(flightDateResult.getString("depart_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out current arrive_date:
				out.print(flightDateResult.getString("arrive_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out a delete button:
				String deleteDate = "depart_date = \"" + flightDateResult.getString("depart_date") + "\" AND flight_id = \"" + flightID + "\"";
				out.print("<form method='post' action='" + flightDateDelete + "'>");
				out.print("<button type='submit' name='dateDelete' value='" + deleteDate + "'>");
				out.print("delete");
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