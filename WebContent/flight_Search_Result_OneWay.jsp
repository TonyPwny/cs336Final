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
		String flightid = request.getParameter("flight_id");
		String departing_port = request.getParameter("depport");
		String arriving_port = request.getParameter("arrivport");

		List<String> list = new ArrayList<String>();

		if (!flightid.isEmpty()){

			//Connect to database
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();

			String str = "SELECT Flight.flight_id, departure.depart_date, departure.airport_id, arrival.arrive_date, arrival.airport_id "
					+ "from Flight, arrival, departure " + "where Flight.flight_id = ? "
					+ "and arrival.flight_id = Flight.flight_id " + "and departure.flight_id = Flight.flight_id";

			PreparedStatement stmt = conn.prepareStatement(str);
			stmt.setString(1, flightid);
			ResultSet flights = stmt.executeQuery();

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
			//print out column header
			out.print("<td>");
			out.print("arrive date");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("arrival port");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (flights.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current flightid:
				out.print(flights.getString("Flight.flight_id"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(flights.getString("departure.depart_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(flights.getString("departure.airport_id"));
				out.print("</td>");
				out.print("<td>");

				//Print out arrival date
				out.print(flights.getString("arrival.arrive_date"));
				out.print("</td>");
				out.print("<td>");

				//Print out arrival airport id
				out.print(flights.getString("arrival.airport_id"));
				out.print("</td>");
				out.print("<td>");
				//Print out a moreinfo button:
				out.print("<form method='post' action='more_Flight_Info.jsp'>");
				out.print("<button type='submit' name='more_info' +  value = \"" + flights.getString("Flight.flight_id") + "\">");
				out.print("more info");
				out.print("</button>");
				out.print("</form>");
				out.print("</td>");
				out.print("</tr>");
				
				
			}


			
			out.print("</table>");

			//close the connection
			conn.close();

					
		}
			
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			
			
			String str =

					"SELECT Flight.flight_id, departure.depart_date, departure.airport_id, arrival.arrive_date, arrival.airport_id "
							+ "from Flight, arrival, departure " 
							+ "where Flight.flight_id = arrival.flight_id "
							+ "and Flight.flight_id = departure.flight_id " 
							+ "and departure.depart_date >= ? "
							+ "and departure.depart_date <= ? " 
							+ "and departure.airport_id = ? "
							+ "and arrival.airport_id = ?";

			PreparedStatement stmt = conn.prepareStatement(str);
			stmt.setString(1, takeoffd1);
			stmt.setString(2, takeoffd2);
			stmt.setString(3, departing_port);
			stmt.setString(4, arriving_port);
			ResultSet flights = stmt.executeQuery();
			

			
			
		
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
			//print out column header
			out.print("<td>");
			out.print("arrive date");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("arriving airport");
			out.print("</td>");

			//parse out the results
			while (flights.next()) {
			
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current flightid:
				out.print(flights.getString("Flight.flight_id"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(flights.getString("departure.depart_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(flights.getString("departure.airport_id"));
				out.print("</td>");
				out.print("<td>");

				//Print out arrival date
				out.print(flights.getString("arrival.arrive_date"));
				out.print("</td>");
				out.print("<td>");

				//Print out arrival airport id
				out.print(flights.getString("arrival.airport_id"));
				out.print("</td>");
				out.print("<td>");
				out.print("<form method='post' action='more_Flight_Info.jsp'>");
				out.print("<button type='submit' name='more_info' +  value = \"" + flights.getString("Flight.flight_id") + "\">");
				out.print("more info");
				out.print("</button>");
				out.print("</form>");
				out.print("</td>");
				out.print("</tr>");


			}
			out.print("</table>");

			//close the connection
			conn.close();

		
	
		
		
	%>



	<a href="success.jsp">Want to go back?</a>

</body>
</html>