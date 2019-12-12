<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!-- Steven Nguyen, cs336 Final Project, Group 4 -->

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
			if (year != null && !year.isEmpty()) {
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
				String year2 = year;
				String month2 = Integer.toString(Integer.parseInt(month)+1);
				if (month2.equals("13")) {
					month2 = "01";
					year2 = Integer.toString(Integer.parseInt(year)+1);
				}
				if (month2.length() == 1) {
					month2 = "0" + month2;
				}
				
				String url = "jdbc:mysql://steve2.ckgj9bgqpyor.us-east-2.rds.amazonaws.com:3306/DB1";
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				//Connect to database
				Connection conn = DriverManager.getConnection(url, "admin", "password");
				String str = 
						"select F.flight_id id, F.fare_econ fe, F.fare_first ff, F.fare_bus fb, FD.depart_date depart_date, F.depart_time depart_time " +
						"from Flight F, FlightDate FD " +
						"where F.flight_id = FD.flight_id " +
							"and FD.depart_date >= \"" + year + "-" + month + "-01\" " + 
							"and FD.depart_date < \"" + year2 + "-" + month2 + "-01\" " +
						"group by (id)" +
						"order by FD.depart_date asc";
				PreparedStatement stmt = conn.prepareStatement(str);
				//gets all flights within month with ID, profit, and # of customers
				ResultSet flights = stmt.executeQuery();
				
				str =
					"select T.ticket_num id, t.class class, F.fare_econ fe, F.fare_first ff, F.fare_bus fb " +
					"from Ticket T, trip t, Flight F, FlightDate FD " +
					"where T.ticket_num = t.ticket_num " +
						"and t.flight_id = F.flight_id " +
						"and F.flight_id = FD.flight_id " +
						"and FD.depart_date >= \"" + year + "-" + month + "-01\" " + 
						"and FD.depart_date < \"" + year2 + "-" + month2 + "-01\" ";
				stmt = conn.prepareStatement(str);
				//gets all tickets, their seat's class, and all prices for that flight
				ResultSet costs = stmt.executeQuery();
				
				double totalProfit = 0.00; //get total profit of month by adding each flight's profit
				while (costs.next()) {
					String c = costs.getString("class");
					if (c.equals("economy")) {
						totalProfit += costs.getDouble("fe");
					} else if (c.equals("first")) {
						totalProfit += costs.getDouble("ff");
					} else if (c.equals("business")) {
						totalProfit += costs.getDouble("fb");
					}
				}
				
				
				out.println(
					String.format(
						"Total Profit: %.2f",
						totalProfit
					)
				);
				
				//If atleast 1 flight
				if (flights.next()) {
					out.println("<br><br>Flights<br>");
					
					//Create table for Flight ID, Econ Price, FirstClass Price, Business Price, Depart Date, Depart Time
					out.println("<table><form method=\"post\" action=flightReportInfo.jsp>" +
						"<tr>" +
							"<th>Flight ID</th>" +
							"<th>Econ Class Price</th>" +
							"<th>First Class Price</th>" +
							"<th>Bus Class Price</th>" +
							"<th>Departure Date</th>" +
							"<th>Departure Time</th>" +
						"<tr>"
					);
					
					//Adds each flight to list of flights
					do {
						out.println(
							String.format(
								"<tr>" +
									"<td><input type=\"submit\" name=\"flightid\" value=\"%s\"></td>" +
									"<td>%s</td>" +
									"<td>%.2f</td>" +
									"<td>%.2f</td>" +
									"<td>%s</td>" +
									"<td>%s</td>" +
								"</tr>",
								flights.getString("id"),
								flights.getDouble("fe"),
								flights.getDouble("ff"),
								flights.getDouble("fb"),
								flights.getDate("depart_date").toString(),
								flights.getTime("depart_time").toString()
							)
						);
					} while (flights.next());
					
					out.println("</form></table><br><br>");
				} else {
					out.println("<br><br>No flights found.<br><br>");
				}
				conn.close();
			}
		%>
		
		<a href="salesReportSearch.jsp">Return to Sales Report Search</a>
		<br><a href="logout.jsp">Logout</a>
	</body>
</html>