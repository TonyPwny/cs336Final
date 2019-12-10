<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String airportID = request.getParameter("airport_id");
	String str, url, str_query;
	
	str = "SELECT * FROM DB1.Airport a WHERE a.airport_id LIKE '" + airportID + "%'";
	str_query = "Info about " + airportID;
	
	List<String> list = new ArrayList<String>();
	
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);

		//Show what kind of query is being processed
		out.print(str_query);

		//Make an HTML table to show the results in:
		out.print("<table>");

		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("Airport ID");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Name");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("City");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("State");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Country");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("");
		out.print("</td>");
		out.print("</tr>");

		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current airport_id:
			out.print(result.getString("airport_id"));
			out.print("</td>");
			out.print("<td>");
			//Print out current name:
			out.print(result.getString("name"));
			out.print("</td>");
			out.print("<td>");
			//Print out current city:
			out.print(result.getString("city"));
			out.print("</td>");
			out.print("<td>");
			//Print out current state (if any):
			out.print(result.getString("state"));
			out.print("</td>");
			out.print("<td>");
			//Print out current country:
			out.print(result.getString("country"));
			out.print("</td>");
			out.print("<td>");
		}
		out.print("</table>");

		//close the connection.
		con.close();

	} catch (Exception e) {
	}
	
	
%>