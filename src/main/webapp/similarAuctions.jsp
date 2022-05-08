<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
	.navigation-container {
		display: flex;
		flex-direction: column;
		row-gap: 5px;
	}
table, th, td {
  border: 1px solid black;
  padding: 5px;
}
table {
  border-spacing: 15px;
}
</style>
</head>
<body>
		<CENTER>
			<h1>Auctions</h1>
		<form name="dropdown" method="get" action="#">
			<select name="orderby">
				<option value="ASC" hidden disabled selected>Ascending/descending</option>
				<option value="ASC">Ascending</option>
				<option value="DESC">Descending</option>
			</select>
			<select name="sortby">
				<option value="itemName" hidden disabled selected>Order by...</option>
				<option value="itemName">Name</option>
				<option value="currentBid">Price</option>
				<option value="closeDate">Date</option>
				<option value="itemId">itemId</option>
			</select>
			<input type="submit" value="Sort">
		</form>
		<h2>Search</h2>
		<div class="search-bar">
			<h4>Search for questions/answers: </h4>
			<form method="get" action="auctionSearch.jsp"> 
				<td>Search term</td><td><input type="text" name="auctionSearchTerm"></td>
				<input type="submit" value="Search!">
			</form>
		</div>
	<p> &ensp; </p>
	For the 4 sub-type categories, the format is (truck,car,bike). The first subcategory shows whether a truck has a truck bed, a car's miles per gallon, or whether a bike is a mountain bike respectively. The second subcategory shows the towing power of a truck, whether a bike has lights, or whether a car is a convertible respectively. The third subcategory shows the truck's miles per gallon, the car's horsepower, or the number of gears in the bike respectively. The final subcategory shows the truck's horsepower, whether the car has navigation, or the intended age of the bike respectively.   
	<p> &ensp; </p>
	<%
		Auction similar = new Auction(Integer.valueOf(request.getParameter("itemId")));
        ArrayList<Auction> similarList = similar.getSimilar();
            %>
			<table>
				<tr>
					<td>Item ID</td>
					<td>Item Name</td>
					<td>Item Type</td>
					<td>Seller</td>
					<td>Make</td>
					<td>Model</td>
					<td>Year</td>
					<td>Close Date</td>
					<td>Close Time</td>
					<td>Current Bid</td>
					<td>Current Bidder</td>
					<td>SubCat 1 </td>
					<td>SubCat 2 </td>
					<td>SubCat 3 </td>
					<td>SubCat 4 </td>
					<td>Open Page</td>
				</tr>
				<%
				String subCategory1 = "";
				String subCategory2 = "";
				String subCategory3 = "";
				String subCategory4= "";
					for (Auction current: similarList) {
						if (current.itemType.compareTo("truck") == 0) {
							Truck currentItem = new Truck(current.itemId);
							subCategory1 = Boolean.toString(currentItem.hasTruckBed);
							subCategory2 = String.valueOf(currentItem.towingPower);
							subCategory3 = String.valueOf(currentItem.mpg);
							subCategory4 = String.valueOf(currentItem.horsepower);
						}
						else if (current.itemType.compareTo("car") == 0) {
							Car currentItem = new Car(current.itemId);
							subCategory1 = String.valueOf(currentItem.mpg);
							subCategory2 = Boolean.toString(currentItem.isConvertible);
							subCategory3 = String.valueOf(currentItem.horsepower);
							subCategory4 = Boolean.toString(currentItem.hasNavigation);
						}
						else if (current.itemType.compareTo("bike")==0){
							Bike currentItem = new Bike(current.itemId);
							subCategory1 = Boolean.toString(currentItem.isMountainBike);
							subCategory2 = Boolean.toString(currentItem.hasLights);
							subCategory3 = String.valueOf(currentItem.numGears);
							subCategory4 = currentItem.bikeIntendedAge;
						}
						
						
						%>
						
							<tr>
								<td><%= current.itemId %></td>
								<td><%= current.itemName %></td>
								<td><%= current.itemType %></td>
								<td><%= current.sellerUsername %></td>
								<td><%= current.make %></td>
								<td><%= current.model %></td>
								<td><%= current.year %></td>
								<td><%= current.closeDate %></td>
								<td><%= current.closeTime %></td>
								<td><%= current.currentBid %></td>
								<td><%= current.currentBidder %></td>
								<td><%= subCategory1 %></td>
								<td><%= subCategory2 %></td>
								<td><%= subCategory3 %></td>
								<td><%= subCategory4 %></td>
								<td>
									<form method="get" action="auctionPage.jsp">
										<input type="submit" value="View auction">
										<input type="text" name="itemId" hidden="true" value="<%= current.itemId %>">
									</form>
								</td>
							</tr>
						<%
					}
				%>
			</table>
	<br>
	<h4>Navigation</h4>
	<div class="navigation-container"> 
		<form method="get" action="mainpage.jsp">
			<input type="submit" value="Go Back to Home Page">
		</form>
		<form method="get" action="logout.jsp">
			<input type="submit" value="Log Out">
		</form>
	</div>
	</CENTER>
</body>
</html>