<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Auction</title>
<style>
	.navigation-container {
		display: flex;
		flex-direction: column;
		row-gap: 5px;
	}
</style>
</head>
<body>
	<CENTER>
<% 
//Get parameters from the HTML form at the mainpage.jsp
String newItemName = request.getParameter("itemName");
String newMakeOfVehicle = request.getParameter("make");
String newModelOfVehicle = request.getParameter("model");
int numSeats = Integer.valueOf(request.getParameter("numSeats"));

float minPrice = Float.valueOf(request.getParameter("minPrice"));
float bidIncrement = Float.valueOf(request.getParameter("bidIncrement"));
java.sql.Date closeDate = java.sql.Date.valueOf(request.getParameter("closeDate"));
java.sql.Time closeTime = java.sql.Time.valueOf(request.getParameter("closeTime"));

String usernameName = "" + session.getAttribute("username");
Auction new_auction = new Auction(usernameName, newItemName, minPrice, bidIncrement, numSeats, newMakeOfVehicle, newModelOfVehicle, closeDate, closeTime);
%>

<%
	List<String> list = new ArrayList<String>();
	int itemId;
	String itemIdString = request.getParameter("itemId");
	if (itemIdString == null) {
		itemId = Integer.valueOf(String.valueOf(session.getAttribute("itemId")));
	} else {
		itemId = Integer.valueOf(itemIdString);
		session.setAttribute("itemId", itemId);
	}
	Auction selectedAuction = new Auction( Integer.valueOf(request.getParameter("itemId")) );
	
	%>
		<h1><%= selectedAuction.itemName %> for sale by <%= selectedAuction.sellerUsername %></h1>
		<table>
			<tr>
				<th>Item Name </th>
				<th>Seller</th>
				<th>Make</th>
				<th>Model</th>
				<th>Year</th>
				<th>Seats</th>
				<th>Closing Date</th>
				<th>Closing Time</th>
				<th>Current bid</th>
				<th>Current highest bidder</th>
			</tr>
			<tr>
				<td><%= selectedAuction.itemName %>
				<td><%= selectedAuction.sellerUsername %>
				<td><%= selectedAuction.make %>
				<td><%= selectedAuction.model %>
				<td><%= selectedAuction.year %>
				<td><%= selectedAuction.numSeats %>
				<td><%= selectedAuction.closeDate %>
				<td><%= selectedAuction.closeTime %>
				<td><%= selectedAuction.currentBid %>
				<td><%= selectedAuction.currentBidder %>
			</tr>
		</table>
		<br>
		<h3>Make a bid</h3>
		<form method="get" action="processBid.jsp"> 
			<input type="text" name="itemId" hidden="true" value="<%= selectedAuction.itemId %>"></td>
			<td>Bid Amount</td><td><input type="text" name="bidAmount"></td>
			<input type="submit" value="Submit the bid request!">
		</form>
		<br>
		<h3>Comments/Questions</h3>
		<table>
			<tr>
				<th>Username </th>
				<th>Comment</th>
				<th>Date</th>
				<th>Time</th>
			</tr>
			<%
				ArrayList<Comment> commentList = selectedAuction.getComments();
				for (Comment comment : commentList) {
					%>
						<tr>
							<td><%= comment.username %></td>
							<td><%= comment.content %></td>
							<td><%= comment.datePosted %></td>
							<td><%= comment.timePosted %></td>
						</tr>
					<%
				}
			%>
		</table>
		<form method="post" action="#">
			<%
				String content = request.getParameter("content");
				String username = session.getAttribute("username") + "";
				if (content != null && content.length() > 1) {
					Comment addedComment = new Comment(selectedAuction.itemId, username, content);
					request.setAttribute("content", null);
				}
			%>
			<table>
				<tr>
					<td><input type="text" value="" name="content"></td>
					<td><input type="submit" value="Post comment"></td>
				</tr>
			</table>
		</form>
	
		<h4>Naviagtion</h4>
		<div class="navigation-container">
			<form method="get" action="viewNonOwnedAuctions.jsp">
				<input type="submit" value="Back to Auctions">
			</form>
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