<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
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

	
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String username = "" + session.getAttribute("username");
			%>
			
			<h1><%="Alerts to " + username + "!"%></h1>
			
			<table>
			<tr>
				<th>Alert ID </th>
				<th>Item ID </th>
				<th>Content</th>
				<th>Date Posted</th>
				<th>Time Posted</th>
			</tr>
			</table>
			
			<% 
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM alerts a WHERE a.username = '" + username + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			while (result.next()) {
				Alert currentAlert = new Alert(result.getInt("alertId"));
				
				%>
				<table>
				<tr>
					<td><%= currentAlert.alertId %></td>
					<td><%= currentAlert.itemId %></td>
					<td><%= currentAlert.content %></td>
					<td><%= currentAlert.datePosted %></td>
					<td><%= currentAlert.timePosted %></td>
				</tr>
			<%
		}
	%>
</table>
<%
			
			

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
	<br>
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