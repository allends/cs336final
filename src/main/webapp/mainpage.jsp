<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>cs336project</title>
<style>
	.navigation-container {
		display: flex;
		flex-direction: row;
		justify-content: space-around;
	}
</style>
</head>
<body>
	<CENTER>
		<h1>
			<% String welcomeStr = "Welcome to BuyMe " + session.getAttribute("username") + "!" ;
			out.print(welcomeStr);
				 %> 
		</h1>
	</CENTER>
	<br>
		&ensp;
	Click here to view all alerts from your bids!
		<form method="get" action="viewAlerts.jsp">
			<input type="submit" value="Submit to View Alerts">
		</form>	
		&ensp;
	Please enter the following information to post an item for an auction:
	<br>
		<form method="post" action="newItemAuction.jsp">
		<table>
		<tr>    
		<td>Item Name</td><td><input type="text" name="itemName"></td>
		</tr>
		<tr>
		<td>Make of Vehicle</td><td><input type="text" name="make"></td>
		</tr>
		<tr>
		<td>Model of Vehicle</td><td><input type="text" name="model"></td>
		</tr>
		<tr>
		<td>Number of Seats</td><td><input type="text" name="numSeats"></td>
		</tr>
		<tr>
		<td>Minimum Price</td><td><input type="text" name="minPrice"></td>
		</tr>
		<tr>
		<td>Bid Increment</td><td><input type="text" name="bidIncrement"></td>
		</tr>
		<tr>
		<td>Closing Date</td><td><input type="text" name="closeDate"></td>
		</tr>
		<tr>
		<td>Closing Time</td><td><input type="text" name="closeTime"></td>
		</tr>
		</table>
		<input type="submit" value="Add me!">
		</form>
	<br>
	<p>
	<p>
	&emsp;
	</p>
	<body>
	Click here to view all auctions that weren't posted by you!
		<form method="get" action="viewNonOwnedAuctions.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="View Auctions">
		</form>
	</body>
	<body>
	<p>
	&ensp;
	</p>
	Click here to view all auctions that were posted by you!
		<form method="get" action="viewOwnedAuctions.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="View Your Current Auctions">
		</form>
	</body>
	<p>
	&ensp;
	</p>
	<body>
	Click here to view all auctions that are currently the highest bidder!
		<form method="get" action="viewBiddedOnAuctions.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="View Your Current Auctions">
		</form>
	</body>
	<body>
	<p>
	&ensp;
	</p>
	
	Please enter the username to view that account's bidding information:
		<form method="get" action="viewAccountBiddingHistory.jsp">
			<table>
				<tr>
				<td>Username</td><td><input type="text" name="usernameBidder"></td>
				</tr> 
			</table>
			<input type="submit" value="Submit to View History">
		</form>
	<p>
	&ensp;
	</p>
	Click here to view all auctions where you are selling an item!
		<form method="get" action="viewAccountAuctionPostingHistory.jsp">
			<table>
				<tr>
				<td>Username</td><td><input type="text" name="usernamePoster"></td>
				</tr> 
			</table>
			<input type="submit" value="Submit to View History">
		</form>
		<form method="get" action="logout.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="Log Out">
		</form> 
	</body>
	<CENTER>
		<h4>Naviagtion</h4>
		<div class="navigation-container">
			<form method="get" action="logout.jsp">
				<table>
					<tr>    
				</table>
				<input type="submit" value="Log Out">
			</form> 
		</div>
	</CENTER>
</html>