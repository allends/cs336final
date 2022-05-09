<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Best Selling Items</title>
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
		<h1>Best Selling Items<br></h1>
			<% Report temp = new Report();
			String header1 = "";
			String header2 = "";
			ArrayList<String[]> list = new ArrayList<String[]> ();
			%>
		<form name="dropdown" method="get" action="#">
			<select name="sortBy">
				<option value="itemName" hidden disabled selected>Best Selling By...</option>
				<option value="1">Year</option>
				<option value="2">Make</option>
				<option value="3">Model</option>
			</select>
			<input type="submit" value="Select">
			<%
			String sortby = request.getParameter("sortBy"); 
			if (sortby == null) {
				list = temp.bestItems(1);
				header1 = "Year";
				header2 = "Make";
			} else{
				list = temp.bestItems(Integer.parseInt(sortby));
				switch(sortby){
					case "1": header1 = "Year"; header2 = "Make"; break;
					case "2": header1 = "Make"; header2 = "Model"; break;
					case "3": header1 = "Model"; header2 = "Year"; break;
				}
			}
			%>
			</form>
		<table>
			<tr>
				<th><%=header1%></th>
				<th><%=header2%></th>
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