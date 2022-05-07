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
	
try {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	
	String itemIdString = request.getParameter("itemId");
	int itemId = Integer.valueOf(itemIdString);
	
	String delete = "DELETE FROM items i WHERE i.itemId = ?";
	PreparedStatement ps = con.prepareStatement(delete);
	ps.setInt(1,itemId);
	ps.executeUpdate();
	out.print("Auction successfully deleted!");
	
	con.close();
	
	
} catch (Exception ex) {
	out.print(ex);
	out.print("It failed to delete the auction, please try again!");
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