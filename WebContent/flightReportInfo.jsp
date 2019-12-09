<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Sales Report Search Result</title>
	</head>
	<body>	
		<%
			//Get arguments
			String flightid = request.getParameter("flightid");
			if (flightid != null) {
				out.println("<br><b>Flight " + flightid + "</b><br><br>");
				
				out.println(
					"View Flight Info <form method=\"post\" action=flightInfo.jsp>" +
						"<input type=\"submit\" name=\"flightid\" value=\"" + flightid + "\"" + ">" +
					"</form><br>"
				);
				
				String url = "jdbc:mysql://steve2.ckgj9bgqpyor.us-east-2.rds.amazonaws.com:3306/DB2";
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				//Connect to database
				Connection conn = DriverManager.getConnection(url, "admin", "password");
				String str = 
					"select F.aircraft_id aircraftId, F.airline_id airlineId, F.flight_type fType, F.fare_econ fe, F.fare_first ff, F.fare_bus fb, sum(trip.ticket_id) numCustomers " +
					"from Flight F, trip " +
					"where F.flight_id = trip.flight_id " +
						"and F.flight_id = \"?\"" +
					"group by F.flight_id";
				PreparedStatement stmt = conn.prepareStatement(str);
				stmt.setString(1, flightid);
				//gets flight info
				ResultSet flight = stmt.executeQuery();
				flight.next();
				
				str = 
					"select buys.username username, Ticket.total_fare cost" +
					"from buys, Ticket, trip " + 
					"where buys.ticket_num = Ticket.ticket_num " +
						"and Ticket.ticket_num = trip.ticket_num " +
						"and trip.flight_id = \"?\"";
				stmt = conn.prepareStatement(str);
				stmt.setString(1, flightid);
				//gets customers on flight
				
				conn.close();
				
				out.println(
					String.format(
						"<br>Profit: %d" +
						"<br>Number of Customers: %d" +
						"<br>",
						flight.getInt("profit"),
						flight.getInt
					)
				);
			} else {
				out.println("<br>Flight id missing. Please try again<br><br>");
			}
		%>
		
		<a href="salesReportSearch.jsp">Return to Sales Report Search</a>
		<br><a href="logout.jsp">Logout</a>
	</body>
</html>