<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<body>
		<form method="get" action="mainpage.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="Go Back to Home Page">
		</form>
	</body>
	<body> 
	</body>
	</body>
	<body>
		<form method="get" action="logout.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="Log Out">
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
			String str = "SELECT * FROM items i WHERE i.currentBidder = '" + usernameName + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Item Identification Number");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Item Name");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Username of Seller");
			out.print("</td>");
			out.print("<td>");
			out.print("Make of Vehicle");
			out.print("</td>");
			out.print("<td>");
			out.print("Model of Vehicle");
			out.print("</td>");
			out.print("<td>");
			out.print("Number of Seats");
			out.print("</td>");
			out.print("<td>");
			out.print("Closing Date");
			out.print("</td>");
			out.print("<td>");
			out.print("Closing Time");
			out.print("</td>");
			out.print("<td>");
			out.print("Current Bid");
			out.print("</td>");
			out.print("<td>");
			out.print("Username of Current Bidder");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getString("itemId"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("itemName"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("sellerUsername"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("make"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("model"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("numSeats"));
				out.print("</td>");
				//Skip secret minimum
				result.getString("minPrice");
				out.print("<td>");
				out.print(result.getString("closeDate"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("closeTime"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("currentBid"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("currentBidder"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
	</body>

</html>