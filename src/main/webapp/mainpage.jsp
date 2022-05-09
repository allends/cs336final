<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*,com.cs336.classes.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
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
	java.time.LocalDate today = java.time.LocalDate.now();
	java.time.LocalTime now = java.time.LocalTime.now();
	
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
        	java.time.format.DateTimeFormatter t = java.time.format.DateTimeFormatter.ofPattern("HH:mm:ss");
        	String closeDateS = result.getDate("closeDate").toString();
        	java.time.LocalDate closeDate = java.time.LocalDate.parse(closeDateS);
        	String closeTimeS = result.getTime("closeTime").toString();
        	java.time.LocalTime closeTime = java.time.LocalTime.parse(closeTimeS, t);
        	out.println(closeTime.toString());
    		Float currentBid = result.getFloat("currentBid");
    		Float minPrice = result.getFloat("minPrice");
    		
    		
    		out.println(closeDate);
    		out.println(closeTime + "<br>");
    		out.println((today.compareTo(closeDate)));
    		out.println(now.compareTo(closeTime) + "<br><br>");
    		
            if (today.compareTo(closeDate) > 0 || today.compareTo(closeDate) == 0 && now.compareTo(closeTime) > 0) {
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
	
	Please enter the username to view that account's bidding history:
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
	Click here to view all auctions from a specific user:
		<form method="get" action="viewAccountPostingHistory.jsp">
			<table>
				<tr>
				<td>Username</td><td><input type="text" name="usernamePoster"></td>
				</tr> 
			</table>
			<input type="submit" value="Submit to View History">
		</form>
		<p>
	&ensp;
	</p>
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