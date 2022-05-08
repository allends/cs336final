<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*,com.cs336.classes.*"%>
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
	<%
	java.sql.Time now = new java.sql.Time(Calendar.getInstance().getTime().getTime());
	java.sql.Date today = new java.sql.Date(Calendar.getInstance().getTime().getTime());
	
    // Get the database connection
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    try {
        Statement stmt = con.createStatement();
        String str = "select * from items i where i.isOpen = 1";
        ResultSet result = stmt.executeQuery(str);


        while (result.next()){
        	int itemId = result.getInt("itemId");
        	String winningUsername = result.getString("currentBidder");
        	String seller = result.getString("sellerUsername");
        	String itemName = result.getString("itemName");
        	java.sql.Date closeDate = result.getDate("closeDate");
    		java.sql.Time closeTime = result.getTime("closeTime");
    		Float currentBid = result.getFloat("currentBid");
    		Float minPrice = result.getFloat("minPrice");
    		
            if (today.after(closeDate)||(today.compareTo(closeDate) == 0 && now.after(closeTime))) {
                PreparedStatement close = con.prepareStatement(
                        "UPDATE items SET isOpen = ? WHERE itemId = ?");
                    close.setBoolean(1, false);
                    close.setInt(2, itemId);
                    close.executeUpdate();

                if (currentBid < minPrice) { 
                    String delete = "DELETE FROM items i WHERE i.itemId = ?";
                    PreparedStatement del = con.prepareStatement(delete);
                    del.setInt(1,itemId);
                    del.executeUpdate();
                    /* System.out.print("Auction successfully deleted!");                    String auctionClosedMessage = "This auction has been closed without a winner " + itemName + "(" + itemId + ")!";
            		Alert auctionEndedNotif = new Alert(itemId, winningUsername, auctionClosedMessage);
            		String unsuccessfulSell = "You have been sold the item in auction " + itemName + "(" + itemId + ")!";
            		Alert noSellAuction = new Alert(itemId, seller, unsuccessfulSell);
            		*/
                }

                else {
                	String winningMessage = "You have been won auction " + itemName + "(" + itemId + ")!";
            		Alert wonAuction = new Alert(itemId, winningUsername, winningMessage);
            		String successfulSell = "You have been sold the item in auction " + itemName + "(" + itemId + ")!";
            		Alert soldAuction = new Alert(itemId, seller, successfulSell);
                }
            }
        }

    } catch (Exception e){
    }
	%>
	<br>
	
		&ensp;
	Click here to view all alerts from your bids!
		<form method="get" action="viewAlerts.jsp">
			<input type="submit" value="Submit to View Alerts">
		</form>	
		&ensp;
	Please select which type of item you want to post for an auction:
	<br>
		<form method="post" action="newItemAuction.jsp">
		<table>
		<tr>    
		<td>Item Name</td><td><input type="text" name="itemName"></td>
		</tr>
		<tr>    
		<td>Item Type</td><td><input type="text" name="itemType"></td>
		</tr>
		<tr>
		<td>Make of Vehicle</td><td><input type="text" name="make"></td>
		</tr>
		<tr>
		<td>Model of Vehicle</td><td><input type="text" name="model"></td>
		</tr>
		<tr>
		<td>Year</td><td><input type="text" name="year"></td>
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
		<input type="submit" value="Submit to Add Auction">
		</form>
	<br>
		Click the type of item you want to post for an auction:!
		<form method="get" action="addTruck.jsp">
			<input type="submit" value="Truck">
		</form>	
		<form method="get" action="addBike.jsp">
			<input type="submit" value="Bike">
		</form>
		<form method="get" action="addCar.jsp">
			<input type="submit" value="Car">
		</form>
		
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
		<h4>Navigation</h4>
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