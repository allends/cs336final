<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*"%>

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
	<p> &ensp; </p>
	<%
		List<String> list = new ArrayList<String>();
		String auctionSearchTerm = request.getParameter("auctionSearchTerm");
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String usernameName = "" + session.getAttribute("username");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String sortby = request.getParameter("sortby");
			String orderby = request.getParameter("orderby");
			if (sortby == null) {
				sortby = "currentBid";
			}
			if (orderby == null) {
				orderby = "ASC";
			}
			String str = "SELECT * FROM items i WHERE i.sellerUsername != '" + usernameName + "' and match(itemName, itemType) against ('" + auctionSearchTerm + "' in natural language mode) ORDER BY " + sortby + " " + orderby;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			%>
			<table>
				<tr>
					<td>Item Name</td>
					<td>Make</td>
					<td>Model</td>
					<td>Close Date</td>
					<td>Close Time</td>
					<td>Status</td>
					<td>Current Bid</td>
					<td>Current Bidder</td>
					<td>Open Page</td>
				</tr>
				<%
					while(result.next()) {
						Auction current = new Auction(result.getInt("itemId"));
						%>
							<tr>
								<td><%= current.itemName %></td>
								<td><%= current.make %></td>
								<td><%= current.model %></td>
								<td><%= current.closeDate %></td>
								<td><%= current.closeTime %></td>
								<td><%= current.getStatus() %></td>
								<td><%= current.currentBid %></td>
								<td><%= current.currentBidder %></td>
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
		<%
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<br>
	<h4>Naviagtion</h4>
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