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
</head>
<body>
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
				<td><%= selectedAuction.numSeats %>
				<td><%= selectedAuction.closeDate %>
				<td><%= selectedAuction.closeTime %>
				<td><%= selectedAuction.currentBid %>
				<td><%= selectedAuction.currentBidder %>
			</tr>
		</table>
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
				if (content != null) {
					Comment addedComment = new Comment(selectedAuction.itemId, username, content);
				}
			%>
			<table>
				<tr>
					<td><input type="text" value="" name="content"></td>
					<td><input type="submit" value="Post comment"></td>
				</tr>
			</table>
		</form>
	
<form method="get" action="loginpage.jsp">
	<table>
		<tr>    
	</table>
	<input type="submit" value="Log Out">
</form>
<form method="get" action="mainpage.jsp">
	<table>
		<tr>    
	</table>
	<input type="submit" value="Go Back to Home Page">
</form>
</body>
</html>