<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Earnings by Seller</title>
<style>
	.navigation-container {
		display: flex;
		flex-direction: column;
		row-gap: 5px;
	}
</style>
</head>
<body>
	<CENTER>
		<h1>Earnings by Seller<br></h1>
			<% Report temp = new Report();
			String header = "";
			ArrayList<String[]> list = new ArrayList<String[]> ();
			%>
		<form name="dropdown" method="get" action="#">
			<select name="sortBy">
				<option value="itemName" hidden disabled selected>Sort By...</option>
				<option value="1">Money Made</option>
				<option value="2">Auctions Completed</option>
			</select>
			<input type="submit" value="Select">
			<%
			String sortby = request.getParameter("sortBy"); 
			if (sortby == null) {
				list = temp.sellerEarnings(1);
				header = "Money Made";
			} else{
				list = temp.sellerEarnings(Integer.parseInt(sortby));
				switch(sortby){
					case "1": header = "Money Made"; break;
					case "2": header = "Auctions Completed"; break;
				}
			}
			%>
			</form>
		<table>
			<tr>
				<th>Seller</th>
				<th><%=header%></th>
			</tr>
			<% for (String[] value : list) {
					%>
						<tr>
							<td><%= value[0] %></td>
							<td><%= value[1]%></td>
						</tr>
					<%
				} %>
		</table>
		<br>
		
		<h4>Navigation</h4>
		<div class="navigation-container">
			<form method="get" action="admin.jsp">
				<input type="submit" value="Go Back to Home Page">
			</form>
			<form method="get" action="logout.jsp">
				<input type="submit" value="Log Out">
			</form>
		</div>
	</CENTER>
</body>
</html>