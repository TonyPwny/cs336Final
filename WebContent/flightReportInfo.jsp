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
				
				session.setAttribute("flightid", flightid);
				
				out.println(
					"View Flight Info <form method=\"post\" action=flightInfo.jsp>" +
						"<input type=\"submit\" name=\"flightid\" value=\"" + flightid + "\"" + ">" +
					"</form><br>"
				);
				
				out.println(
					"<br>Profit: " + session.getAttribute("fProfit") +
					"<br>Number of Customers: " + session.getAttribute("fNumCustomers") +
					"<br>"
				);
			} else {
				out.println("<br>Flight id missing. Please try again<br><br>");
			}
		%>
		
		<a href="salesReportSearch.jsp">Return to Sales Report Search</a>
		<br><a href="logout.jsp">Logout</a>
	</body>
</html>