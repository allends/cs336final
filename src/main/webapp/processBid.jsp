<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="com.cs336.classes.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
	.navigation-container {
		display: flex;
		flex-direction: column;
		row-gap: 5px;
	}
</style>
<title>cs336project</title>
</head>
<body>
	<CENTER>
	<%
		int itemId = Integer.valueOf(request.getParameter("itemId"));
		Float bidAmount = Float.valueOf(request.getParameter("bidAmount"));
		String bidder = session.getAttribute("username") + "";
		Auction biddedOnAuction = new Auction(itemId);
		String status = biddedOnAuction.addBid(bidAmount, bidder);
	%>
	<h1><%= status %></h1>
	<div class="navigation-container">
		<form method="get" action="auctionPage.jsp">
			<input type="submit" value="Back to Listing">
			<input type="text" name="itemId" value="<%= request.getParameter("itemId") %>" hidden="true">
		</form>
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