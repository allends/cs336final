<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
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
	<body>
		<CENTER>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String username = request.getParameter("usernamePoster");
			%>
			
			<h1> <%= username + "'s Auction Posting History"%></h1>
			<%
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM items i WHERE i.sellerUsername = '" + username + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
			%>

			<table>

				<tr>
					<td>Item ID</td>
					<td>Item Name</td>
					<td>Item Type</td>
					<td>Make</td>
					<td>Model</td>
					<td>Year</td>
					<td>Close Date</td>
				</tr>
				<%

					while(result.next()) {
						Auction current = new Auction(result.getInt("itemId"));

						%>
						
							<tr>
								<td><%= current.itemId %></td>
								<td><%= current.itemName %></td>
								<td><%= current.itemType %>
								<td><%= current.make %></td>
								<td><%= current.model %></td>
								<td><%= current.year %></td>
								<td><%= current.closeDate %></td>
						<%
					}
				%>
			</table>
		<%
			con.close();


		} catch (Exception e) {
		}
	%>
		<h4>Navigation</h4>
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