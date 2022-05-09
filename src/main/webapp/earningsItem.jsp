<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Earnings by Item</title>
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
		<h1>Earnings by Item<br></h1>
			<% Report temp = new Report();
			String header = "";
			ArrayList<String[]> list = new ArrayList<String[]> ();
			%>
		<form name="dropdown" method="get" action="#">
			<select name="sortBy">
				<option value="itemName" hidden disabled selected>Earnings By...</option>
				<option value="1">Year</option>
				<option value="2">Make</option>
				<option value="3">Model</option>
			</select>
			<input type="submit" value="Select">
			<%
			String sortby = request.getParameter("sortBy"); 
			if (sortby == null) {
				list = temp.itemEarnings(1);
				header = "Year";
			} else{
				list = temp.itemEarnings(Integer.parseInt(sortby));
				switch(sortby){
					case "1": header = "Year"; break;
					case "2": header = "Make"; break;
					case "3": header = "Model"; break;
				}
			}
			%>
			</form>
		<table>
			<tr>
				<th><%=header%></th>
				<th>Total Earnings </th>
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