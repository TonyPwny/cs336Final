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
<title>Here are your results!</title>
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
					
					"SELECT Flight.flight_id, departure.depart_date, departure.airport_id, arrival.arrive_date, arrival.airport_id " +																											 										 
					"from Flight, arrival, departure " +
					"where Flight.flight_id = arrival.flight_id " +
					"and Flight.flight_id = departure.flight_id " +
					"and departure.depart_date >= ? " + 
					"and departure.depart_date <= ? " +
					"and departure.airport_id = ? " +
					"and arrival.airport_id = ?";
					
			PreparedStatement stmt = conn.prepareStatement(str);
			stmt.setString(1, takeoffd1);
			stmt.setString(2, takeoffd2);
			stmt.setString(3, departing_port);
			stmt.setString(4, arriving_port);
			ResultSet flightsAB = stmt.executeQuery();
					
			if (flightsAB.next()) {
				String str2 =	
						
					"SELECT Flight.flight_id, departure.depart_date, departure.airport_id, arrival.arrive_date, arrival.airport_id " +																											 										 
					"from Flight, arrival, departure " +
					"where Flight.flight_id = arrival.flight_id " +
					"and Flight.flight_id = departure.flight_id " +
					"and departure.depart_date >= ?" +  
					"and departure.depart_date <= ? " +
					"and departure.airport_id = ? " +
					"and arrival.airport_id = ? ";
						
				PreparedStatement stmt2 = conn.prepareStatement(str2);
				stmt2.setString(1, arrived1);
				stmt2.setString(2, arrived2);
				stmt2.setString(3, arriving_port);
				stmt2.setString(4, departing_port);
				ResultSet flightsBA = stmt2.executeQuery();
				
				out.print("<table>");
				
				//make a row
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
				out.print("departure airport");
				out.print("</td>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("arrive date");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("arriving airport");
				out.print("</td>");
				out.print("</tr>");

				//Store AB info
				String flightAB_id = flightsAB.getString("Flight.flight_id");
				String depAB_date = flightsAB.getString("departure.depart_date");
				String depAB_port = flightsAB.getString("departure.airport_id");
				String arrAB_date = flightsAB.getString("arrival.arrive_date");
				String arrAB_port = flightsAB.getString("arrival.airport_id");
				
				
				//parse out the results
				out.print("AB Flight: " + flightsAB.getString("Flight.flight_id") + "<br>");
				while (flightsBA.next()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current flightid:
					out.print(flightAB_id);
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(depAB_date);
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(depAB_port);
					out.print("</td>");
					out.print("</tr>");
					//Print out current price
					out.print(arrAB_date);
					out.print("</td>");
					out.print("</tr>");
					//Print out current price
					out.print(arrAB_port);
					out.print("</td>");
					out.print("</tr>");
					
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current flightid:
					out.print(flightsBA.getString("Flight.flight_id"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(flightsBA.getString("arrival.airport_id"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(flightsBA.getString("arrival.arrive_date"));
					out.print("</td>");
					out.print("</tr>");
					//Print out current price
					out.print(flightsBA.getString("departure.airport_id"));
					out.print("</td>");
					out.print("</tr>");
					//Print out current price
					out.print(flightsBA.getString("departure.depart_date"));
					out.print("</td>");
					out.print("</tr>");
					
		
				}
				out.print("</table>");
				out.print("<br>All BA Flights above<br><br>");
			}	
			//close the connection
			conn.close();
		
		
		
		
	%>

<br><br>

	<a href="success.jsp">Want to go back?</a>

</body>
</html>