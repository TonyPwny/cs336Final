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
				
				if((roundtrip == null) && (takeoffd1.isEmpty()) && (takeoffd2.isEmpty()) && (arrived1.isEmpty()) 
						&& (arrived2.isEmpty()) && (arrived2.isEmpty()) && (flightid.isEmpty()))
						{
							out.println("You didnt enter any data!<br>");
							out.println("<a href='flight_Search'>Try Again</a>");	
						}
				if(!flightid.isEmpty())
				{
				
				String url = "jdbc:mysql://steve2.ckgj9bgqpyor.us-east-2.rds.amazonaws.com:3306/DB2";
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				//Connect to database
				Connection conn = DriverManager.getConnection(url, "admin", "password");
				String str = 
						"SELECT flight_id" +																											
						"from Flight " +
						"where flight_id = \"?\"";
				PreparedStatement stmt = conn.prepareStatement(str);
				stmt.setString(1, flightid);
				ResultSet flights = stmt.executeQuery();

				}
				else if(roundtrip == false)
				{
					String url = "jdbc:mysql://steve2.ckgj9bgqpyor.us-east-2.rds.amazonaws.com:3306/DB2";
					Class.forName("com.mysql.jdbc.Driver").newInstance();
					//Connect to database
					Connection conn = DriverManager.getConnection(url, "admin", "password");
					String str = 
							"SELECT Flight.flight_id" +																											 										 
							"from Flight, arrival, departure" +
							"where Flight.flight_id = arrival.flight_id " +
							"and Flight.flight_id = departure.flight_id " +
							"and departure.depart_date >= \"?\" " + 
							"and departure.depart_date < \"?\" " +
							"and arrival.arrive_date >= \"?\" " + 
							"and arrival.arrive_date < \"?\" " +
							"and flight_id = \"?\"";
				
				
					PreparedStatement stmt = conn.prepareStatement(str);
					stmt.setString(1, flightid);
					stmt.setString(2, takeoffd1);
					stmt.setString(3, takeoffd2);
					stmt.setString(4, arrived1);
					stmt.setString(5, arrived2);
					ResultSet flights = stmt.executeQuery();

				}
				else if(roundtrip == true)
				{
					
					
					
					
					
				}
				
				
				
				%>
			
	

		<a href="success.jsp">Want to go back?</a>
		
	</body>
</html>