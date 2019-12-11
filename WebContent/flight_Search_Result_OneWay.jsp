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
		//Search a one way flight by flightid
		if (!flightid.isEmpty()){

			//Connect to database
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();

			String str = "SELECT FlightDate.flight_id, FlightDate.depart_date, FlightDate.depart_aid, FlightDate.arrive_date, FlightDate.arrive_aid "
					+ "from FlightDate " + "where FlightDate.flight_id = ? ";
					

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
				out.print(flights.getString("FlightDate.flight_id"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(flights.getString("FlightDate.depart_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(flights.getString("FlightDate.depart_aid"));
				out.print("</td>");
				out.print("<td>");

				//Print out arrival date
				out.print(flights.getString("FlightDate.arrive_date"));
				out.print("</td>");
				out.print("<td>");

				//Print out arrival airport id
				out.print(flights.getString("FlightDate.arrive_aid"));
				out.print("</td>");
				out.print("<td>");
				//Print out a moreinfo button:
				out.print("<form method='post' action='more_Flight_Info.jsp'>");
				out.print("<button type='submit' name='more_info' +  value = \"" + flights.getString("FlightDate.flight_id") + "\">");
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
			//Search a one way by Airport ids and dates
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			
	
			String str =

					"SELECT FlightDate.flight_id, FlightDate.depart_date, FlightDate.depart_aid, FlightDate.arrive_date, FlightDate.arrive_aid "
							+ "from FlightDate "
							+ "WHERE FlightDate.depart_date >= ? "
							+ "and FlightDate.depart_date <= ? " 
							+ "and FlightDate.depart_aid = ? "
							+ "and FlightDate.arrive_aid = ?";

			PreparedStatement stmt = conn.prepareStatement(str);
			stmt.setString(1, takeoffd1);
			stmt.setString(2, takeoffd2);
			stmt.setString(3, departing_port);
			stmt.setString(4, arriving_port);
			ResultSet flights = stmt.executeQuery();

		
			// Thanks to anthonys beautiful query
			//Search a connecting one way by Airport ids and dates 
			
			String str2 = 
							"DROP TABLE IF EXISTS Departing; DROP TABLE IF EXISTS Arrival; "
							+ "CREATE TEMPORARY TABLE DB1.Departing ( "
							+ "SELECT * FROM DB1.FlightDate fd "
							+ "WHERE fd.depart_aid = ? "
							+ "AND fd.depart_date >= ? "
							+ "AND fd.depart_date <= ? ); "
							
							+ "CREATE TEMPORARY TABLE DB1.Arriving ( "
							+ "SELECT * FROM DB1.FlightDate fd "
							+ "WHERE fd.arrive_aid = ? ); "
							
							+ "SELECT DB1.d.depart_date AS depart1_date, "
							+ "DB1.d.arrive_date AS arrive1_date, "
							+ "DB1.d.flight_id AS flight1_id, "
							+ "DB1.d.depart_aid AS depart1_aid, "
							+ "DB1.d.arrive_aid AS arrive1_aid, "
							+ "DB1.a.depart_date AS depart2_date, "
							+ "DB1.a.arrive_date AS arrive2_date, "
							+ "DB1.a.flight_id AS flight2_id, "
							+ "DB1.a.depart_aid AS depart2_aid, "
							+ "DB1.a.arrive_aid AS arrive2_aid "
							+ "FROM DB1.Departing d, DB1.Arriving a "
							+ "WHERE d.depart_aid = ? "
							+ "AND a.arrive_aid = ? "
							+ "AND d.arrive_aid = a.depart_aid";
							
							PreparedStatement stmt2 = conn.prepareStatement(str2);
							stmt2.setString(1, departing_port);
							stmt2.setString(2, takeoffd1);
							stmt2.setString(3, takeoffd2);
							stmt2.setString(4, arriving_port);
							stmt2.setString(5, departing_port);
							stmt2.setString(6, arriving_port);

							ResultSet flightsCon1 = stmt2.executeQuery();
									
									
			out.print("<table>");
							
			while(flights.next() || flightsCon1.next()){	
			if(flights.next()){
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
			
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current flightid:
				out.print(flights.getString("FlightDate.flight_id"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(flights.getString("FlightDate.depart_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(flights.getString("FlightDate.depart_aid"));
				out.print("</td>");
				out.print("<td>");

				//Print out arrival date
				out.print(flights.getString("FlightDate.arrive_date"));
				out.print("</td>");
				out.print("<td>");

				//Print out arrival airport id
				out.print(flights.getString("FlightDate.arrive_aid"));
				out.print("</td>");
				out.print("<td>");
				out.print("<form method='post' action='more_Flight_Info.jsp'>");
				out.print("<button type='submit' name='more_info' +  value = \"" + flights.getString("FlightDate.flight_id") + "\">");
				out.print("more info");
				out.print("</button>");
				out.print("</form>");
				out.print("</td>");
				out.print("</tr>");


			}
			else if(flightsCon1.next()){
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
				out.print("arrive date");
				out.print("</td>");
				//print out column header
				out.print("<td>");
				out.print("flight id");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("arriving airport");
				out.print("</td>");
				out.print("<td>");
				//print out column header
				out.print("depart date");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("arrive date");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("flight id");
				out.print("</td>");
				//print out column header
				out.print("<td>");
				out.print("departing airport");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("arriving airport");
				out.print("</td>");
				
				// new row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current flightid:
				out.print(flightsCon1.getString("depart1_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(flightsCon1.getString("arrive1_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(flightsCon1.getString("flight1_id"));
				out.print("</td>");
				out.print("<td>");

				//Print out arrival date
				out.print(flightsCon1.getString("depart1_aid"));
				out.print("</td>");
				out.print("<td>");

				//Print out arrival airport id
				out.print(flightsCon1.getString("arrive1_aid"));
				out.print("</td>");
				out.print("<td>");
				
				out.print(flightsCon1.getString("depart2_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(flightsCon1.getString("arrive2_date"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(flightsCon1.getString("flight2_id"));
				out.print("</td>");
				out.print("<td>");

				//Print out arrival date
				out.print(flightsCon1.getString("depart2_aid"));
				out.print("</td>");
				out.print("<td>");

				//Print out arrival airport id
				out.print(flightsCon1.getString("arrive2_aid"));
				out.print("</td>");
				out.print("<td>");
			
			}
			out.print("</table>");

			
			}

			//close the connection
	
			conn.close();

	
	
		
		
	%>



	<a href="success.jsp">Want to go back?</a>

</body>
</html>