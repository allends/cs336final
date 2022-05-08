<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Total Earnings</title>
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
<%

	Report temp = new Report();
	List<String[]> list = temp.totalEarnings();
	%>
		<h1>Earnings Report</h1>
		<table>
			<tr>
				<th>Item Name </th>
				<th>Price </th>
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
</CENTER>
</body>
</html>