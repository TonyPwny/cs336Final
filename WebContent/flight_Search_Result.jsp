<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Here are your results!</title>
		<h4> Filter by Price, Take off, Land time, Airline</h4>
	</head>
	<body>
		
		<%
				//Get arguments
				
				Boolean roundtrip = Boolean.parseBoolean(request.getParameter("round_trip"));
				String takeoffd1 = request.getParameter("take_off_date");
				String takeoffd2 = request.getParameter("take_off_date_2");
				String arrived1 = request.getParameter("arrive_date");
				String arrived2 = request.getParameter("arrive_date_2");
				String flightid = request.getParameter("flight_id");
			
				
				
				
				if(!flightid.isEmpty())
				{
				
				String url = "jdbc:mysql://steve2.ckgj9bgqpyor.us-east-2.rds.amazonaws.com:3306/DB2";
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				//Connect to database
				Connection conn = DriverManager.getConnection(url, "admin", "password");
				String str = 
						"SELECT Flight.flight_id, departure.depart_date, departure.airport_id, arrival.arrive_date, arrival.airport_id " +																											
						"from Flight, arrival, departure " +
						"where flight_id = \"?\"";
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
				out.print("</tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("arrive date");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("arriving airport");
				out.print("</td>");

				//parse out the results
				while (flights.next()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current flightid:
					out.print(flights.getString("flight_id"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(flights.getString("depart_date"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(flights.getString("departure.airport_id"));
					out.print("</td>");
					out.print("</tr>");
					//Print out current price
					out.print(flights.getString("arrive_date"));
					out.print("</td>");
					out.print("</tr>");
					//Print out current price
					out.print(flights.getString("arrival.airport_id"));
					out.print("</td>");
					out.print("</tr>");

				}
				out.print("</table>");

				//close the connection
				conn.close();

				}
				else if(roundtrip == false)
				{
					String url = "jdbc:mysql://steve2.ckgj9bgqpyor.us-east-2.rds.amazonaws.com:3306/DB2";
					Class.forName("com.mysql.jdbc.Driver").newInstance();
					//Connect to database
					Connection conn = DriverManager.getConnection(url, "admin", "password");
					String str = 
							
							"SELECT Flight.flight_id, departure.depart_date, departure.airport_id, arrival.arrive_date, arrival.airport_id " +																											 										 
							"from Flight, arrival, departure " +
							"where Flight.flight_id = arrival.flight_id " +
							"and Flight.flight_id = departure.flight_id " +
							"and departure.depart_date >= \"?\" " + 
							"and departure.depart_date < \"?\" " +
							"and arrival.arrive_date >= \"?\" " + 
							"and arrival.arrive_date < \"?\"";
				
				
					PreparedStatement stmt = conn.prepareStatement(str);
					stmt.setString(1, takeoffd1);
					stmt.setString(2, takeoffd2);
					stmt.setString(3, arrived1);
					stmt.setString(4, arrived2);
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
					out.print("</tr>");
					//make a column
					out.print("<td>");
					//print out column header
					out.print("arrive date");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("arriving airport");
					out.print("</td>");

					//parse out the results
					while (flights.next()) {
						//make a row
						out.print("<tr>");
						//make a column
						out.print("<td>");
						//Print out current flightid:
						out.print(flights.getString("flight_id"));
						out.print("</td>");
						out.print("<td>");
						//Print out current beer name:
						out.print(flights.getString("depart_date"));
						out.print("</td>");
						out.print("<td>");
						//Print out current price
						out.print(flights.getString("departure.airport_id"));
						out.print("</td>");
						out.print("</tr>");
						//Print out current price
						out.print(flights.getString("arrive_date"));
						out.print("</td>");
						out.print("</tr>");
						//Print out current price
						out.print(flights.getString("arrival.airport_id"));
						out.print("</td>");
						out.print("</tr>");

					}
					out.print("</table>");

					//close the connection
					conn.close();

				}
				else if(roundtrip == true)
				{
					
					String url = "jdbc:mysql://steve2.ckgj9bgqpyor.us-east-2.rds.amazonaws.com:3306/DB2";
					Class.forName("com.mysql.jdbc.Driver").newInstance();
					//Connect to database
					Connection conn = DriverManager.getConnection(url, "admin", "password");
					String str = 
							
							"SELECT Flight.flight_id, departure.depart_date as ddate1, departure.airport_id as depportid, arrival.arrive_date as adate1, arrival.airport_id as aportid " +																											 										 
							"from Flight, arrival, departure " +
							"where Flight.flight_id = arrival.flight_id " +
							"and Flight.flight_id = departure.flight_id " +
							"and departure.depart_date >= \"?\" " + 
							"and departure.depart_date < \"?\" " +
							"and arrival.arrive_date >= \"?\" " + 
							"and arrival.arrive_date < \"?\" " +
							
				
													
							
							"SELECT Flight.flight_id, departure.depart_date, departure.airport_id, arrival.arrive_date, arrival.airport_id" +																											 										 
							"from Flight, arrival, departure " +
							"where Flight.flight_id = arrival.flight_id " +
							"and Flight.flight_id = departure.flight_id " +
							"and departure.depart_date >= adate1 " + 
							"and departure.depart_date < \"?\" " +
							"and arrival.arrive_date >= adate1 " + 
							"and arrival.arrive_date < \"?\" " +
							"and arrival.airport_id = depportid";
							
							
							
							
					PreparedStatement stmt = conn.prepareStatement(str);
					stmt.setString(1, takeoffd1);
					stmt.setString(2, takeoffd2);
					stmt.setString(3, arrived1);
					stmt.setString(4, arrived2);
					stmt.setString(5, takeoffd2);
					stmt.setString(6, arrived2);
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
					out.print("</tr>");
					//make a column
					out.print("<td>");
					//print out column header
					out.print("arrive date");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("arriving airport");
					out.print("</td>");

					//parse out the results
					while (flights.next()) {
						//make a row
						out.print("<tr>");
						//make a column
						out.print("<td>");
						//Print out current flightid:
						out.print(flights.getString("flight_id"));
						out.print("</td>");
						out.print("<td>");
						//Print out current beer name:
						out.print(flights.getString("depart_date"));
						out.print("</td>");
						out.print("<td>");
						//Print out current price
						out.print(flights.getString("departure.airport_id"));
						out.print("</td>");
						out.print("</tr>");
						//Print out current price
						out.print(flights.getString("arrive_date"));
						out.print("</td>");
						out.print("</tr>");
						//Print out current price
						out.print(flights.getString("arrival.airport_id"));
						out.print("</td>");
						out.print("</tr>");

					}
					out.print("</table>");

					//close the connection
					conn.close();
					
		
				}
				else	{
					out.println("You didnt enter any data!<br>");
					out.println("<a href='flight_Search'>Try Again</a>");
					}
				
						
					
						
				
				
				%>
			
	

		<a href="success.jsp">Want to go back?</a>
		
	</body>
</html>