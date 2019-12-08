
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
%>] Flight Information -
</title>
</head>
<body>
	<br> Logged in as:
	<%
		out.println(" <b>" + login + "</b> - " + logintype);
	%>
	<br>
	<br> Flight ID:
	<%
		out.println(" <b></b><br>");
	%>
	Operated by:
	<%
		out.println(" <b></b><br>");
	%>
	Aircraft Model:
	<%
		out.println(" <b></b><br>");
	%>
	<br> Type:
	<%
		out.println(" <b></b><br>");
	%>
	Departure from:
	<%
		out.println(" <b></b><br>");
	%>
	Departure days and time:
	<%
		out.println(" <b></b><br>");
	%>
	Arrival to:
	<%
		out.println(" <b></b><br>");
	%>
	Arrival days and time:
	<%
		out.println(" <b></b><br>");
	%>
	<br> First class fare:
	<%
		out.println(" <b></b><br>");
	%>
	Business class fare:
	<%
		out.println(" <b></b><br>");
	%>
	Economy class fare:
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