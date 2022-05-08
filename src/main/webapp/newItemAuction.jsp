<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		//Get parameters from the HTML form at the mainpage.jsp
		String newItemName = request.getParameter("itemName");
		String newItemType = request.getParameter("itemType");
		String newMakeOfVehicle = request.getParameter("make");
		String newModelOfVehicle = request.getParameter("model");
		int year = Integer.valueOf(request.getParameter("year"));
		int numSeats = Integer.valueOf(request.getParameter("numSeats"));
		
		float minPrice = Float.valueOf(request.getParameter("minPrice"));
		float bidIncrement = Float.valueOf(request.getParameter("bidIncrement"));
		java.sql.Date closeDate = java.sql.Date.valueOf(request.getParameter("closeDate"));
		java.sql.Time closeTime = java.sql.Time.valueOf(request.getParameter("closeTime"));
		
		String usernameName = "" + session.getAttribute("username");
		Auction new_auction = new Auction(usernameName, newItemName, newItemType, minPrice, bidIncrement, numSeats, newMakeOfVehicle, newModelOfVehicle, year, closeDate, closeTime);
	%>
	<p>
	&ensp;
	</p>
	<body>
		<form method="get" action="mainpage.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="Go Back to Home Page">
		</form>
	</body>
	<body> 
	<p>
	&ensp;
	</p>
	</body>
	</body>
	<body>
		<form method="get" action="logout.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="Log Out">
		</form>
	</body>
</html>