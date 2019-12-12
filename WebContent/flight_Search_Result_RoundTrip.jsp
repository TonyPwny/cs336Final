<!--
Nicolas Gundersen neg62
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
		out.print("<br>");

		String takeoffd1 = request.getParameter("take_off_date");
		String takeoffd2 = request.getParameter("take_off_date_2");
		String arrived1 = request.getParameter("arrive_date");
		String arrived2 = request.getParameter("arrive_date_2");
		String departing_port = request.getParameter("depport");
		String arriving_port = request.getParameter("arrivport");
		String flight1id;
		String flight2id;
		String flight3id;
		String flight4id;
		String flight5id;
		String flight6id;

		List<String> list = new ArrayList<String>();



			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();

			String str =

					"SELECT FlightDate.flight_id, FlightDate.depart_date, Flight.depart_aid, FlightDate.arrive_date, Flight.arrive_aid, " +
					"Flight.fare_econ, Flight.fare_bus, Flight.fare_first "+
					"from FlightDate, Flight " +
					"WHERE FlightDate.flight_id = Flight.flight_id " +
					"and FlightDate.depart_date >= ? " +
					"and FlightDate.depart_date <= ? " +
					"and Flight.depart_aid = ? " +
					"and Flight.arrive_aid = ?";

			PreparedStatement stmt = conn.prepareStatement(str);
			stmt.setString(1, takeoffd1);
			stmt.setString(2, takeoffd2);
			stmt.setString(3, departing_port);
			stmt.setString(4, arriving_port);
			ResultSet flightsAB = stmt.executeQuery();

			out.print("<table>");

			if (flightsAB.next()) {



				String str2 =

					"SELECT FlightDate.flight_id, FlightDate.depart_date, Flight.depart_aid, FlightDate.arrive_date, Flight.arrive_aid, " +
					"Flight.fare_econ, Flight.fare_bus, Flight.fare_first "+
					"from FlightDate, Flight " +
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


				
			
				//make a row
				

				//Store AB inf	

				while (flightsBA.next()) {
					
					
					out.print("<tr>");
					out.print("potential trip");
					out.print("<td>");
					
					out.print("<form method='post' action='reservationMake.jsp'>");
					out.print("<button type='submit' name='book_now' +  value = \"" + flightsBA.getString("FlightDate.flight_id") + "\">");
					out.print("Book now!");
				
					out.print("</button>");
					out.print("</form>");
					
					out.print("</td>");
					
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
					
					out.print("<td>");
					out.print("Economy Fare");
					out.print("</td>");
					
					out.print("<td>");
					out.print("Business Fare");
					out.print("</td>");
					
					out.print("<td>");
					out.print("First Class Fare");
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
				out.print(flightsAB.getString("Flight.arrival_aid"));
				out.print("</td>");
				//print out column header
				out.print("<td>");
				out.print(flightsAB.getString("FlightDate.arrive_date"));
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print(flightsAB.getString("Flight.depart_aid"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(flightsAB.getString("Flight.fare_econ"));
				out.print("</td>");
				//print out column header
				out.print("<td>");
				out.print(flightsAB.getString("Flight.fare_bus"));
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print(flightsAB.getString("Flight.fare_first"));
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
					out.print(flightsBA.getString("Flight.depart_aid"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(flightsBA.getString("FlightDate.arrive_date"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(flightsBA.getString("Flight.depart_aid"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsBA.getString("Flight.fare_econ"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(flightsBA.getString("Flight.fare_bus"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(flightsBA.getString("Flight.fare_first"));
					out.print("</td>");
					out.print("<td>");
					
					//Button to display direct round trip
					out.print("<form method='post' action='reservationUserInput.jsp'>");
					out.print("<button type='submit' name='book_now' onclick=\"" 
							+ "session.setAttribute(\"flight1id\", " + (flightsAB.getString("Flight.flight_id")) + ") " 
							+ "session.setAttribute(\"flight2id\", " + (flightsBA.getString("Flight.flight_id")) + ") " + ">");


					
					
					
					out.print("Book now!");
				
					out.print("</button>");
					out.print("</form>");
					
					out.print("</td>");
					
		
					
					out.print("</tr>");
	

				}
				
			}
			
			String str3 =		
					
					"SELECT * "
					+ "FROM (SELECT f.flight_id AS flight1_id, "
					+ "f.depart_aid AS depart1_aid, "
					+ "fd.depart_date AS depart1_date, "
					+ "f.depart_time AS depart1_time, "
					+ "f.arrive_aid AS stop1_aid, "
					+ "fd.arrive_date AS arrive1_date, "
					+ "f.arrive_time AS arrive1_time, "
					+ "f.fare_econ AS fareecon1, "
					+ "f.fare_bus AS farebus1, "
					+ "f.fare_first AS farefirst1 "
					+ "FROM DB1.Flight f, DB1.FlightDate fd "
					+ "WHERE f.flight_id = fd.flight_id "
					+ "AND f.depart_aid = ? AND fd.depart_date >= ? AND fd.depart_date <= ? ) AS Trip1, " 
					+ "(SELECT f.flight_id AS flight2_id, "
					+ "f.depart_aid AS depart2_aid, "
					+ "fd.depart_date AS depart2_date, "
					+ "f.depart_time AS depart2_time, "
					+ "f.arrive_aid AS stop2_aid, "
					+ "fd.arrive_date AS arrive2_date, "
					+ "f.arrive_time AS arrive2_time, "
					+ "f.fare_econ AS fareecon2, "
					+ "f.fare_bus AS farebus2, "
					+ "f.fare_first AS farefirst2 "	
					+ "FROM DB1.Flight f, DB1.FlightDate fd "
					+ "WHERE f.flight_id = fd.flight_id "
					+ "AND f.arrive_aid = ? ) AS Trip2 "
					+ "WHERE Trip1.stop1_aid = Trip2.depart2_aid";
			
			
			
						PreparedStatement stmt3 = conn.prepareStatement(str3);
						stmt3.setString(1, departing_port);
						stmt3.setString(2, takeoffd1);
						stmt3.setString(3, takeoffd2);
						stmt3.setString(4, arriving_port);

						ResultSet flightsABCon1 = stmt3.executeQuery();
								
			
			if(flightsABCon1.next())
			
			{
			
				
				
			String str4 =		
						
					"SELECT * "
					+ "FROM (SELECT f.flight_id AS flight1_id, "
					+ "f.depart_aid AS depart1_aid, "
					+ "fd.depart_date AS depart1_date, "
					+ "f.depart_time AS depart1_time, "
					+ "f.arrive_aid AS stop1_aid, "
					+ "fd.arrive_date AS arrive1_date, "
					+ "f.arrive_time AS arrive1_time, "
					+ "f.fare_econ AS fareecon1, "
					+ "f.fare_bus AS farebus1, "
					+ "f.fare_first AS farefirst1 "
					+ "FROM DB1.Flight f, DB1.FlightDate fd "
					+ "WHERE f.flight_id = fd.flight_id "
					+ "AND f.depart_aid = ? AND fd.depart_date >= ? AND fd.depart_date <= ? ) AS Trip1, " 
					+ "(SELECT f.flight_id AS flight2_id, "
					+ "f.depart_aid AS depart2_aid, "
					+ "fd.depart_date AS depart2_date, "
					+ "f.depart_time AS depart2_time, "
					+ "f.arrive_aid AS stop2_aid, "
					+ "fd.arrive_date AS arrive2_date, "
					+ "f.arrive_time AS arrive2_time, "
					+ "f.fare_econ AS fareecon2, "
					+ "f.fare_bus AS farebus2, "
					+ "f.fare_first AS farefirst2 "	
					+ "FROM DB1.Flight f, DB1.FlightDate fd "
					+ "WHERE f.flight_id = fd.flight_id "
					+ "AND f.arrive_aid = ? ) AS Trip2 "
					+ "WHERE Trip1.stop1_aid = Trip2.depart2_aid";
			
			
			
						PreparedStatement stmt4 = conn.prepareStatement(str4);
						stmt4.setString(1, arriving_port);
						stmt4.setString(2, arrived1);
						stmt4.setString(3, arrived2);
						stmt4.setString(4, departing_port);

						ResultSet flightsBACon1 = stmt4.executeQuery();
								
				while(flightsBACon1.next()){
				
					out.print("<tr>");
					out.print("potential trip");
					
					
					out.print("<td>");
					
					out.print("<form method='post' action='reservationUserInput.jsp'>");
					out.print("<button type='submit' name='book_now' onclick=\"" 
					+ "session.setAttribute(\"flight3id\", " + (flightsABCon1.getString("flight1_id")) + ") " 
					+ "session.setAttribute(\"flight4id\", " + (flightsABCon1.getString("flight2_id")) + ") " 
					+ "session.setAttribute(\"flight5id\", " + (flightsBACon1.getString("flight1_id")) + ") " 
					+ "session.setAttribute(\"flight6id\", " + (flightsBACon1.getString("flight2_id")) + ") " + ">");


					
					
					
					out.print("Book now!");
				
					out.print("</button>");
					out.print("</form>");
					
					out.print("</td>");
					
						out.print("</tr>");

					
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//print out column header
					out.print("flight id");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("departure port");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("departure date");
					out.print("</td>");
					//print out column header
					out.print("<td>");
					out.print("depart time");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("arrive port");
					out.print("</td>");
					//print out column header
					out.print("<td>");
					out.print("Arrive date");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("arrive time");
					out.print("</td>");
					//
					out.print("<td>");
					out.print("Economy Fare");
					out.print("</td>");
				
					out.print("<td>");
					out.print("Business Fare");
					out.print("</td>");
					
					out.print("<td>");
					out.print("First Class Fare");
					out.print("</td>");
					
					out.print("<td>");
					out.print("flight id2");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("departure port2");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("departure date2");
					out.print("</td>");
					//print out column header
					out.print("<td>");
					out.print("depart time2");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("arrive port2");
					out.print("</td>");
					//print out column header
					out.print("<td>");
					out.print("Arrive date2");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("arrive time2");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("Economy Fare");
					out.print("</td>");
				
					out.print("<td>");
					out.print("Business Fare");
					out.print("</td>");
				
					out.print("<td>");
					out.print("First Class Fare");
					out.print("</td>");
					
					out.print("<td>");
					out.print("");
					out.print("</td>");
					out.print("</tr>");
				
						
					//Results
					// new row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current flightid:
					out.print(flightsABCon1.getString("flight1_id"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(flightsABCon1.getString("depart1_aid"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(flightsABCon1.getString("depart1_date"));
					out.print("</td>");
					out.print("<td>");

					//Print out arrival date
					out.print(flightsABCon1.getString("depart1_time"));
					out.print("</td>");
					out.print("<td>");

					//Print out arrival airport id
					out.print(flightsABCon1.getString("stop1_aid"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsABCon1.getString("arrive1_date"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(flightsABCon1.getString("arrive1_time"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(flightsABCon1.getString("fareecon1"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsABCon1.getString("farebus1"));
					out.print("</td>");
					out.print("<td>");
				
					out.print(flightsABCon1.getString("farefirst1"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsABCon1.getString("flight2_id"));
					out.print("</td>");
					out.print("<td>");

					//Print out arrival date
					out.print(flightsABCon1.getString("depart2_aid"));
					out.print("</td>");
					out.print("<td>");

					//Print out arrival airport id
					out.print(flightsABCon1.getString("depart2_date"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsABCon1.getString("depart2_time"));
					out.print("</td>");
					out.print("<td>");
				
					out.print(flightsABCon1.getString("stop2_aid"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsABCon1.getString("arrive2_date"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsABCon1.getString("arrive2_time"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsABCon1.getString("fareecon2"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsABCon1.getString("farebus2"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsABCon1.getString("farefirst2"));
					out.print("</td>");
					
			
					
					
					
					
					
					out.print("<td>");
					out.print("");
					out.print("</td>");
					
					out.print("</tr>");
				
				
					// new row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current flightid:
					out.print(flightsBACon1.getString("flight1_id"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(flightsBACon1.getString("depart1_aid"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(flightsBACon1.getString("depart1_date"));
					out.print("</td>");
					out.print("<td>");

					//Print out arrival date
					out.print(flightsBACon1.getString("depart1_time"));
					out.print("</td>");
					out.print("<td>");

					//Print out arrival airport id
					out.print(flightsBACon1.getString("stop1_aid"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsBACon1.getString("arrive1_date"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(flightsBACon1.getString("arrive1_time"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsBACon1.getString("fareecon1"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsBACon1.getString("farebus1"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsBACon1.getString("farefirst1"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(flightsBACon1.getString("flight2_id"));
					out.print("</td>");
					out.print("<td>");

					//Print out arrival date
					out.print(flightsBACon1.getString("depart2_aid"));
					out.print("</td>");
					out.print("<td>");

					//Print out arrival airport id
					out.print(flightsBACon1.getString("depart2_date"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsBACon1.getString("depart2_time"));
					out.print("</td>");
					out.print("<td>");
				
					out.print(flightsBACon1.getString("stop2_aid"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsBACon1.getString("arrive2_date"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsBACon1.getString("arrive2_time"));
					out.print("</td>");
					out.print("<td>");

					
					out.print(flightsBACon1.getString("fareecon2"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsBACon1.getString("farebus2"));
					out.print("</td>");
					out.print("<td>");
					
					out.print(flightsBACon1.getString("farefirst2"));
					out.print("</td>");
					
					//out.print("<td>");
					
					//out.print("<form method='post' action='reservationMake.jsp'>");
					//out.print("<button type='submit' name='book_now' +  value = \"" + flightsCon1.getString("flight1_id") + "\">");
					//out.print("Book now!");
				
					//out.print("</button>");
					//out.print("</form>");
					
					//out.print("</td>");
					
					
					out.print("</tr>");	
				
				
				
				
				
				
				
				
				
				}
				
				
				
				
				
				
				
				
				
				
				
				
			}
			
			
			
			
			out.print("</table>");
			//close the connection
			conn.close();




	%>

<br><br>

	<a href="success.jsp">Want to go back?</a>

</body>
</html>
