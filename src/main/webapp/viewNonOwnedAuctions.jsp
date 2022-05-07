<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<script>
function redirect(int itemId) {
	console.log(itemId);
}
</script>
<body>
	<body>
		<form method="get" action="mainpage.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="Go Back to Home Page">
		</form>
		<form method="get" action="logout.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="Log Out">
		</form>
		<form name="dropdown1" method="get" action="#">
			<select name="sortby">
				<option value="itemName">Name</option>
				<option value="currentBid">Price</option>
				<option value="closeDate">Date</option>
				<option value="itemId">itemId</option>
			</select>
			<input type="submit" value="Sort">
		</form>
		<form name="dropdown2" method="get" action="#">
			<select name="orderby">
				<option value="ASC">Ascending</option>
				<option value="DESC">Descending</option>
			</select>
			<input type="submit" value="Sort">
		</form>
		
	</body>
	<body>
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
			String sortby = request.getParameter("sortby");
			String orderby = request.getParameter("orderby");
			if (sortby == null) {
				sortby = "currentBid";
			}
			if (orderby == null) {
				orderby = "ASC";
			}
			String str = "SELECT * FROM items i WHERE i.sellerUsername != '" + usernameName + "'" + " ORDER BY " + sortby + " " + orderby;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			%>
			<script type="text/javascript">
				function redirect(int itemId) {
					console.log(itemId);
				}
			</script>
			<table>
				<tr>
					<td>Item ID</td>
					<td>Item Name</td>
					<td>Seller</td>
					<td>Make</td>
					<td>Model</td>
					<td>Seats</td>
					<td>Close Date</td>
					<td>Close Time</td>
					<td>Current Bid</td>
					<td>Current Bidder</td>
					<td>Open Page</td>
				</tr>
				<%
					while(result.next()) {
						Auction current = new Auction(result.getInt("itemId"));
						%>
							<tr>
								<td><%= current.itemId %></td>
								<td><%= current.itemName %></td>
								<td><%= current.sellerUsername %></td>
								<td><%= current.make %></td>
								<td><%= current.model %></td>
								<td><%= current.numSeats %></td>
								<td><%= current.closeDate %></td>
								<td><%= current.closeTime %></td>
								<td><%= current.currentBid %></td>
								<td><%= current.currentBidder %></td>
								<td><button onclick="redirect(current.itemId)">Open Auction</button></td>
							</tr>
						<%
					}
				%>
			</table>
		<%
			//close the connection.
			//<td><input type="submit" action="#"></td>
			con.close();

		} catch (Exception e) {
		}
	%>
	</body>
	<body>
		Please insert the Item Id and Bid amount that you want to make on an auction!
		<br>
			<form method="get" action="processBid.jsp">
				<table>
					<tr>    
						<td>Item Id</td><td><input type="text" name="itemId"></td>
					</tr>
					<tr>
						<td>Bid Amount</td><td><input type="text" name="bidAmount"></td>
					</tr>
				</table>
				<input type="submit" value="Submit the bid request!">
			</form>
		<br>
	</body>

</body>
</html>