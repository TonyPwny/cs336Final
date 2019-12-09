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
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			
			//Check arguments
			boolean validInput = true;
			if (!year.isEmpty()) {
				try {
					Integer.parseInt(year);
				} catch (NumberFormatException e) {
					out.println("Invalid Input for Year<br><br>");
					validInput = false;
				}
			} else {
				out.println("Invalid Input for Year<br><br>");
				validInput = false;	
			}
			
			if (validInput) {
				//Format month string
				if (month.length() == 1) {
					month = "0" + month;
				}
				
				out.println("<br><b>Sales Report for " + month + "/" + year + "</b><br><br>");
				
				//Get end of month
				String year2 = Integer.toString(Integer.parseInt(year)+1);
				String month2 = Integer.toString(Integer.parseInt(month)+1);
				if (month2.equals("13")) {
					month2 = "01";
				}
				if (month2.length() == 1) {
					month2 = "0" + month2;
				}
				
				String url = "jdbc:mysql://steve2.ckgj9bgqpyor.us-east-2.rds.amazonaws.com:3306/DB2";
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				//Connect to database
				Connection conn = DriverManager.getConnection(url, "admin", "password");
				String str = 
						"select flight.flight_id id, flight.fare_econ fe, flight.fare_first ff, flight.fare_bus fb, trip.depart_time" +
						"from ticket, trip, flight " +
						"where ticket.ticket_id = trip.ticket_id " +
							"and trip.flight_id = flight.flight_id " +
							"and flight.depart_time >= \"?-?-01T00:00:00.000\" " + 
							"and flight.depart_time < \"?-?-01T00:00:00.000\" " +
						"group by (flight.flight_id)" +
						"order by trip.depart_time asc";
				PreparedStatement stmt = conn.prepareStatement(str);
				stmt.setString(1, year);
				stmt.setString(2, month);
				stmt.setString(3, year2);
				stmt.setString(4, month2);
				//gets all flights within month with ID, profit, and # of customers
				ResultSet flights = stmt.executeQuery();
				/*
				str =
					"select ticket.ticket_id id, seat.class class, flight.fare_econ fe, flight.fare_first ff, flight.fare_bus fb, flight.depart_time departTime" +
					"from ticket, trip, seat, flight " +
					"where ticket.ticket_id = trip.ticket_id " +
						"and trip.seat_num = seat.seat_num" +
						"and trip.flight_id = flight.flight_id" +
						"and flight.depart_time >= \"?-?-01T00:00:00.000\" " + 
						"and flight.depart_time < \"?-?-01T00:00:00.000\"";
				stmt = conn.prepareStatement(str);
				stmt.setString(1, year);
				stmt.setString(2, month);
				stmt.setString(3, year2);
				stmt.setString(4, month2);
				//gets all tickets, their seat's class, and all prices for that flight
				ResultSet costs = stmt.executeQuery();
				*/		
				conn.close();
				/*
				//get total profit of month by adding each flight's profit
				double totalProfit = 0;
				int n = 0; //also get number of flights
				while (costs.next()) {
					String c = costs.getString("class");
					if (c.equals("economy")) {
						totalProfit += costs.getDouble("fe");
					} else if (c.equals("first")) {
						totalProfit += costs.getDouble("ff");
					} else if (c.equals("business")) {
						totalProfit += costs.getDouble("fb");
					}
					n++;
				}
				
				
				out.println("Total Profit: " + totalProfit);
				
				//If atleast 1 flight
				if (n > 0) {
					out.println("<br><br>Flights<br>");
					
					out.println("<table><form method=\"post\" action=adminFlightInfo.jsp>" +
						"<tr>" +
							"<th>Flight ID</th>" +
							"<th>Econ Class Price</th>" +
							"<th>First Class Price</th>" +
							"<th>Bus Class Price</th>" +
							"<th>Departure Time</th>" +
						"<tr>"
					);
					
					//Adds each flight to list of flights
					flights.first();
					do {
						out.println(
							String.format(
								"<tr>" +
									"<td><input type=\"submit\" name=\"flightid\" value=\"%d\"></td>" +
									"<td>%.2f</td>" +
									"<td>%.2f</td>" +
									"<td>%.2f</td>" +
									"<td>%s</td>" +
								"</tr>",
								flights.getInt("id"),
								flights.getDouble("fe"),
								flights.getDouble("ff"),
								flights.getDouble("fb"),
								flights.getTimestamp("departTime").toString()
							)
						);
					} while (flights.next());
					
					out.println("</form></table><br><br>");
				} else {
					out.println("<br><br>No flights found.<br><br>");
				}*/
			}
		%>
		
		<a href="salesReportSearch.jsp">Return to Sales Report Search</a>
		<br><a href="logout.jsp">Logout</a>
	</body>
</html>