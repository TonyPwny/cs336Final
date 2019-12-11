<!--
Nicolas Gundersen
CS336
Professor Miranda
Project Final Group 4
 -->


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Round Trip Results</title>
<h3> Round Trip Results</h3>
<h4>Filter by Price, Take off, Land time, Airline</h4>
</head>
<body>

	<%
		//Get arguments


		String takeoffd1 = request.getParameter("take_off_date");
		String takeoffd2 = request.getParameter("take_off_date_2");
		String arrived1 = request.getParameter("arrive_date");
		String arrived2 = request.getParameter("arrive_date_2");
		String departing_port = request.getParameter("depport");
		String arriving_port = request.getParameter("arrivport");

		List<String> list = new ArrayList<String>();



			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();

			String str =

					"SELECT FlightDate.flight_id, FlightDate.depart_date, FlightDate.depart_aid, FlightDate.arrive_date, FlightDate.arrive_aid " +
					"from FlightDate " +
					"and FlightDate.depart_date >= ? " +
					"and FlightDate.depart_date <= ? " +
					"and FlightDate.depart_aid = ? " +
					"and FlightDate.arrive_aid = ?";

			PreparedStatement stmt = conn.prepareStatement(str);
			stmt.setString(1, takeoffd1);
			stmt.setString(2, takeoffd2);
			stmt.setString(3, departing_port);
			stmt.setString(4, arriving_port);
			ResultSet flightsAB = stmt.executeQuery();

			if (flightsAB.next()) {



				String str2 =

					"SELECT FlightDate.flight_id, FlightDate.depart_date, FlightDate.depart_aid, FlightDate.arrive_date, FlightDate.arrive_aid " +
					"from FlightDate " +
					"and FlightDate.depart_date >= ?" +
					"and FlightDate.depart_date <= ? " +
					"and FlightDate.arrive_aid = ? " +
					"and FlightDate.depart_aid = ? ";

				PreparedStatement stmt2 = conn.prepareStatement(str2);
				stmt2.setString(1, arrived1);
				stmt2.setString(2, arrived2);
				stmt2.setString(3, arriving_port);
				stmt2.setString(4, departing_port);
				ResultSet flightsBA = stmt2.executeQuery();


				out.print("<table>");
				
				
				out.print("<tr>");
				out.print("potential trip");
				out.print("</tr>");

				//make a row
				

				//Store AB inf	

				while (flightsBA.next()) {
					
					out.print("<tr>");
					out.print("potential trip");
					out.print("</tr>");
					
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//print out column header
					out.print("flight id");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("departure date");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("depart airport");
					out.print("</td>");
					//make a column
					out.print("<td>");
					//print out column header
					out.print("arrive date");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("arrive airport");
					out.print("</td>");
					out.print("</tr>");
					
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print(flightsAB.getString("FlightDate.flight_id"));
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print(flightsAB.getString("FlightDate.depart_date"));
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print(flightsAB.getString("FlightDate.airport_id"));
				out.print("</td>");
				//print out column header
				out.print("<td>");
				out.print(flightsAB.getString("FlightDate.arrive_date"));
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print(flightsAB.getString("FlightDate.airport_id"));
				out.print("</td>");
				
				
			
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current flightid:
					out.print(flightsBA.getString("Flight.flight_id"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(flightsBA.getString("FlightDate.depart_date"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(flightsBA.getString("FlightDate.airport_id"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(flightsBA.getString("FlightDate.arrive_date"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(flightsBA.getString("FlightDate.airport_id"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print("</tr>");
	

				}
				out.print("</table>");
				
			}
			//close the connection
			conn.close();




	%>

<br><br>

	<a href="success.jsp">Want to go back?</a>

</body>
</html>
