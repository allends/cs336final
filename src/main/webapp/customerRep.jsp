<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login Page</title>
	</head>
	
	<body>
	<body>
		<% String welcomeStr = "Welcome Customer Representative " + session.getAttribute("user") + "!" ;
		out.print(welcomeStr);
		   %>
		
	</body>
	<body>
		<form method="get" action="logout.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="Log Out">
		</form>
	<p>
	&ensp;
	</p>
	<br>
	Please enter an items's identification number to remove an auction:

		<form method="get" action="deleteAuction.jsp">
			<table>
				<tr>    
					<td>Item Identification Number</td><td><input type="text" name="itemId"></td>
				</tr>
			</table>
			<input type="submit" value="Submit">
		</form>
		<p>
		&ensp;
		</p>
	Please enter a bid's identification number to remove it from an auction:
		<form method="get" action="deleteBid.jsp">
			<table>
				<tr>    
					<td>Bid Identification Number</td><td><input type="text" name="bidId"></td>
				</tr>
			</table>
			<input type="submit" value="Submit">
		</form>
	<body>
	<br>

</body>
</html>