<!--
Anthony Tiongson
CS336 Section 07
Professor Miranda
Project Final Group 4

Page was coded with aid from the project beer template and ProjectSETUP guide.
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String login = (String) session.getAttribute("username");
	String logintype = (String) session.getAttribute("usertype");
	String loginURL = "login.jsp";

	if (session.getAttribute("username") == null || logintype.equals("User")) {
		response.sendRedirect(loginURL);
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>[<%
	out.println(logintype);
%>] Ticket Information -
</title>
</head>
<body>
	<br> Logged in as:
	<%
		out.println(" <b>" + login + " - " + logintype);
	%>
	<br>
	<br> Ticket Number:
	<%
		out.println(" <b></b><br>");
	%>
	Type:
	<%
		out.println(" <b></b><br>");
	%>
	Booking Fee:
	<%
		out.println(" <b></b><br>");
	%>
	Total Fare:
	<%
		out.println(" <b></b><br>");
	%>
	Issue Date:
	<%
		out.println(" <b></b><br>");
	%>
	Customer:
	<%
		out.println(" <b></b><br>");
	%>
	<br> Trip Information:
	<%
		out.println(" <b></b><br>");
	%>
	<br>
	<br>
	<%
		// Try and get the current count from the session
		Integer count = (Integer) session.getAttribute("COUNT");
		// If COUNT is not found, create it and add it to the session
		if (count == null) {
			count = new Integer(1);
			session.setAttribute("COUNT", count);
		} else {
			count = new Integer(count.intValue() + 1);
			session.setAttribute("COUNT", count);
		}
		// Print the number of times the user has visited the site
		out.println("Current session site views: <b>" + count + "</b>");
	%>
</body>
</html>