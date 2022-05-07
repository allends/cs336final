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
	String bidIdString = request.getParameter("bidId");
	int bidId = Integer.valueOf(bidIdString);
	
try {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	Statement stmt = con.createStatement();
	Bid currentBid = new Bid(bidId);
	int itemId = currentBid.itemId;
	//Make an insert statement for the Sells table:
	String delete = "DELETE FROM bids b WHERE b.bidId = ?";
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(delete);
	ps.setInt(1,bidId);
	ps.execute();
	
	ps = con.prepareStatement(
		      "UPDATE items SET currentBidder = ?, currentBid = ? WHERE itemId = ?");
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	
	String str = "SELECT * FROM bids b WHERE b.bidAmount = (SELECT MAX(bidAmount) FROM bids)";
	//Run the query against the database.
	ResultSet result = stmt.executeQuery(str);
	if (result.next() == false) {
		ps.setNull(1, java.sql.Types.NULL);
		ps.setFloat(2,0.0f);
		ps.setInt(3,itemId);
		
		ps.executeUpdate();
		ps.close();
	}
	else {
		String currentBidder = result.getString("bidder");
		Float amountBid = result.getFloat("bidAmount");
		ps.setString(1,currentBidder);
		ps.setFloat(2,amountBid);
		ps.setInt(3,itemId);
		ps.executeUpdate();
		ps.close();
	}
	
	
	out.print("Bid successfully deleted!");
	

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	//Find unused int for itemid
	
	
	//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
	con.close();
	
	
} catch (Exception ex) {
	out.print(ex);
	out.print("It failed to delete the , please try again!");
}
%>
		
<form method="get" action="loginpage.jsp">
	<table>
		<tr>    
	</table>
	<input type="submit" value="Log Out">
</form>
<form method="get" action="customerRep.jsp">
	<table>
		<tr>    
	</table>
	<input type="submit" value="Go Back to Customer Rep Home Page">
</form>
</body>
</html>