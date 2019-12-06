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
					out.println("Invalid Input for Year<br>");
					validInput = false;
				}
			} else {
				out.println("Invalid Input for Year<br>");
				validInput = false;	
			}
			
			if (validInput) {
				//Format month string
				if (month.length() == 1) {
					month = "0" + month;
				}
				
				out.println("<br><b>Sales Report for " + year + "/" + month + "</b><br><br>");
				
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
						"select flight.flight_id id, sum(ticket.total_fare) profit, count(*) customers " +
						"from ticket, trip, flight " +
						"where ticket.trip_id = trip.trip_id " +
							"and trip.flight_id = flight.flight_id " +
							"and trip.date >= \"?-?-01\"" + 
							"and trip.date < \"?-?-01\" " +
						"group by (flight.flight_id)" +
						"order by trip.date asc";
				PreparedStatement stmt = conn.prepareStatement(str);
				stmt.setString(1, year);
				stmt.setString(2, month);
				stmt.setString(3, year2);
				stmt.setString(4, month2);
				
				//gets all flights within month with ID, profit, and # of customers
				ResultSet flights = stmt.executeQuery();
				conn.close();
				
				//get total profit of month by adding each flight's profit
				double totalProfit = 0;
				int n = 0;
				while (flights.next()) {
					totalProfit += flights.getDouble("profit");
					n++;
				}
				
				
				out.println("Total Profit: " + totalProfit);
				
				if (n > 0) {
					out.println("<br><br>Flights<br>");
					
					out.println("<table><form method=\"post\" action=adminFlightInfo.jsp>" +
						"<tr>" +
							"<th>Flight ID</th>" +
							"<th>Profit from Flight</th>" +
							"<th>Number of Customers on Flight</th>" + 
						"<tr>"
					);
					
					//Adds each flight to list of flights
					flights.absolute(0);
					do {
						out.println(
							"<tr>" +
								"<td><input type=\"submit\" name=\"flightid\" onclick=" +
									"\"session.setAttribute('profit', " + flights.getDouble("fProfit") + "); session.setAttribute('fNumCustomers', " + flights.getInt("customers") + ")\"" +
									" value=\"" + flights.getInt("id") + "\"></td>" +
								"<td>" + flights.getDouble("profit") + "</td>" +
								"<td>" + flights.getInt("customers") + "</td>" +
							"</tr>"
						);
					} while (flights.next());
					
					out.println("</form></table><br><br>");
				}
			}
		%>
		
		<a href="salesReportSearch.jsp">Return to Sales Report Search</a>
		<br><a href="logout.jsp">Logout</a>
	</body>
</html>