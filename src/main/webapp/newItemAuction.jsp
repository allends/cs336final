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
		boolean hasTruckBed  = false;
		float towingPower = 0.0f;
		float mpg = 0.0f;
		float horsepower = 0.0f;
		boolean isConvertible  = false;
		boolean hasNavigation  = false;
		boolean isMountainBike  = false;
		boolean hasLights  = false;
		int numGears = 0;
		String bikeIntendedAge = "";
		if (newItemType.compareTo("truck") == 0) {
			hasTruckBed  = Boolean.valueOf(request.getParameter("hasTruckBed"));
			towingPower = Float.valueOf(request.getParameter("towingPower"));
			mpg = Float.valueOf(request.getParameter("mpg"));
			horsepower = Float.valueOf(request.getParameter("horsepower"));
		}
		else if (newItemType.compareTo("car") == 0) {
				mpg = Float.valueOf(request.getParameter("mpg"));
				isConvertible  = Boolean.valueOf(request.getParameter("isConvertible"));
				horsepower = Float.valueOf(request.getParameter("horsepower"));
				hasNavigation  = Boolean.valueOf(request.getParameter("hasNavigation"));
		}
		else if (newItemType.compareTo("bike")==0){
					isMountainBike  = Boolean.valueOf(request.getParameter("isMountainBike"));
					hasLights  = Boolean.valueOf(request.getParameter("hasLights"));
					numGears = Integer.valueOf(request.getParameter("numGears"));
					bikeIntendedAge = request.getParameter("bikeIntendedAge");
		}
		String usernameName = "" + session.getAttribute("username");
		Auction new_auction = new Auction(usernameName, newItemName, newItemType, minPrice, bidIncrement, numSeats, newMakeOfVehicle, newModelOfVehicle, year, closeDate, closeTime);
		out.print("1");
		int itemId = new_auction.itemId;
		if (new_auction.itemType.compareTo("truck") == 0) {
			out.print("3");
			Truck new_truck = new Truck(itemId, hasTruckBed, towingPower, mpg, horsepower);
		}
		else if (new_auction.itemType.compareTo("car") == 0) {
			Car new_car = new Car(itemId, mpg, isConvertible, horsepower, hasNavigation);
		}
		else if (new_auction.itemType.compareTo("bike") == 0){
			Bike new_bike = new Bike(itemId, isMountainBike, hasLights, numGears, bikeIntendedAge);
		}
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