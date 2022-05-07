<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="com.cs336.classes.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>cs336project</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String itemIdStr = request.getParameter("itemId");
			Integer itemId = Integer.parseInt(itemIdStr);
			String bidAmountStr = request.getParameter("bidAmount");
			Float bidAmount = Float.parseFloat(bidAmountStr);
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM items i WHERE i.itemId = '" + itemId + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			Float currentBid = 0.0f;
			Float bidIncrement = 0.0f;
			String itemName = "";
			String lastBidder = "";
			String currentBidder = "" + session.getAttribute("username");
			
			while (result.next()) {
					itemName = result.getString("itemName");
					currentBid = result.getFloat("currentBid");
					bidIncrement = result.getFloat("bidIncrement");
					lastBidder = result.getString("currentBidder");
					}
			out.print("Hello " + session.getAttribute("username") + "\n");
			
			String alertMessage = "You have been outbid on " + itemName + "(" + itemId + ")!";
			
			if (bidAmount > (currentBid+bidIncrement)) {
				Alerts alertPastBidder = new Alerts(itemId, lastBidder, alertMessage);
				stmt = con.createStatement();
				PreparedStatement ps = con.prepareStatement(
					      "UPDATE items SET currentBidder = ?, currentBid = ? WHERE itemId = ?");
				ps.setString(1,currentBidder);
				ps.setFloat(2,bidAmount);
				ps.setInt(3,itemId);
				
				ps.executeUpdate();
				
				ps = con.prepareStatement("INSERT INTO bids(bidId,itemId,bidder,amountBid)"
						+ "VALUES (?, ?, ?, ?)");
				//Find unused int for itemid
				int bidId = 1;
				while (true) {
					Random randInt = new Random();
					int upperBound = 100000;
					bidId = bidId * randInt.nextInt(upperBound);
					stmt = con.createStatement();
					String string = "SELECT * FROM bids b WHERE b.bidId = '" + bidId + "'";
					//Run the query against the database.
					result = stmt.executeQuery(string);
					if (result.next() == false) {
						break;
					}
				}
				String bidder = "" + session.getAttribute("username");
				ps.setInt(1,bidId);
				ps.setInt(2,itemId);
				ps.setString(3,bidder);
				ps.setFloat(4,bidAmount);
				ps.executeUpdate();
				ps.close();
				out.print("Bidding successful. The listing has been updated.");
				
			}
			else {
				out.print("Bid amount too low, please put in a different amount");
			}

			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Bidding Failed.");
		}
	
	%>
	</body>
	<body>
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