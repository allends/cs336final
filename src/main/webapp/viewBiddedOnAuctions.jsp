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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<body>
		<CENTER>
			<h1>Auctions where you are the highest Bidder!</h1>
	<p> &ensp; </p>
	For the 4 sub-type categories, the format is (truck,car,bike). The first subcategory shows whether a truck has a truck bed, a car's miles per gallon, or whether a bike is a mountain bike respectively. The second subcategory shows the towing power of a truck, whether a bike has lights, or whether a car is a convertible respectively. The third subcategory shows the truck's miles per gallon, the car's horsepower, or the number of gears in the bike respectively. The final subcategory shows the truck's horsepower, whether the car has navigation, or the intended age of the bike respectively.   
	<p> &ensp; </p>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String usernameName = "" + session.getAttribute("username");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp

			String str = "SELECT * FROM items i WHERE i.currentBidder = '" + usernameName + "' AND i.isOpen = 1";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
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
				</tr>
				<%
				String subCategory1 = "";
				String subCategory2 = "";
				String subCategory3 = "";
				String subCategory4= "";
					while(result.next()) {
						Auction current = new Auction(result.getInt("itemId"));
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
								<td><%= current.itemType %>
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
						<%
					}
				%>
			</table>
		<%
			con.close();


		} catch (Exception e) {
		}
	%>
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