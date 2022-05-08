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
	.comment-container {
		display: flex;
		flex-direction: column;
		row-gap: 15px;
		margin-top: 10px;
		width: 50vw;
	}
	.comment {
		border-style: solid;
		border-color: black;
		border-width: 2px;
		border-radius: 5px;
		padding-bottom: 10px;
	}
	.reply-container {
		display: flex;
		flex-direction: column;
		row-gap: 5px;
	}
	.reply {

	}
</style>
</head>
<body>
	<CENTER>
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
				<th>Item ID </th>
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
				<td><%= selectedAuction.itemId %>
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
		<br>
		<h3>Make a bid</h3>
		<form method="get" action="processBid.jsp"> 
			<input type="text" name="itemId" hidden="true" value="<%= selectedAuction.itemId %>"></td>
			<td>Bid Amount</td><td><input type="text" name="bidAmount"></td>
			<input type="submit" value="Submit the bid request!">
		</form>
		<br>
		<h3>Bid History</h3>
		<table>
			<tr>
				<th>Bid ID</th>
				<th>Username </th>
				<th>Bid Amount</th>
			</tr>
		<%
				ArrayList<Bid> bidList = selectedAuction.getBids();
				for (Bid bid : bidList) {
					%>
						<tr>
							<td><%= bid.bidId %></td>
							<td><%= bid.bidder %></td>
							<td><%= bid.bidAmount %></td>
							
						</tr>
					<%
				}
			%>
		</table>
		<h3>Comments/Questions</h3>

		<div class="search-bar">
			<h4>Search for questions/answers: </h4>
			<form method="get" action="questionSearch.jsp"> 
				<input type="text" name="itemId" hidden="true" value="<%= selectedAuction.itemId %>"></td>
				<td>Search term</td><td><input type="text" name="searchTerm"></td>
				<input type="submit" value="Search!">
			</form>
		</div>

		<div class="comment-container">
			<%
				ArrayList<Comment> commentList = selectedAuction.getComments();
				for (Comment comment : commentList) {
					ArrayList<Comment> replyList = comment.getReplies(comment.commentId);
					%>
					<div class="comment">
						<p><b><%= comment.username %> on <%= comment.datePosted %></b></p>
						<p><%= comment.content %></p>
						<div class="reply-container">
					<%
					for (Comment reply : replyList) {
						%>
							<div class="reply">
								<p>^ <b><%= reply.username %> on <%= reply.datePosted %></b></p>
								<p><%= reply.content %></p>
							</div>
						<%
					}
					%>
						<div>
							<form method="post" action="processComment.jsp">
								<input type="text" value="" name="content">
								<input type="submit" value="Add answer">
								<input type="text" name="itemId" value="<%= selectedAuction.itemId %>" hidden="true">
								<input type="text" name="repliedTo" value="<%= comment.commentId %>" hidden="true">
							</form>
						</div>
					</div>
					</div>
					<%
				}
				
			%>
		</div>
		<h4>Add a question: </h4>
		<form method="post" action="processComment.jsp">
			<table>
				<tr>
					<td><input type="text" value="" name="content"></td>
					<td><input type="submit" value="Post question"></td>
				</tr>
			</table>
			<input type="text" name="itemId" value="<%= selectedAuction.itemId %>" hidden="true">
			<input type="text" value="<%= selectedAuction.itemId %>" hidden="true">
		</form>
	
		<h4>Navigation</h4>
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