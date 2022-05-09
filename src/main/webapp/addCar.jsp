<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
			<% String welcomeStr = "Post a car for auction, " + session.getAttribute("username") + "!" ;
			out.print(welcomeStr);
				 %> 
		</h1>
	</CENTER>
	<br>
	<p>
		&ensp;
	</p>
	Please submit the characteristics of the car you are posting:
	<br>
		<form method="post" action="newItemAuction.jsp">
		<input type="hidden" name="itemType" value="car">
		<table>
		<tr>    
		<td>Item Name</td><td><input type="text" name="itemName"></td>
		</tr>
		<tr>
		<td>Make of Vehicle</td><td><input type="text" name="make"></td>
		</tr>
		<tr>
		<td>Model of Vehicle</td><td><input type="text" name="model"></td>
		</tr>
		<tr>
		<td>Year</td><td><input type="text" name="year"></td>
		</tr>
		<tr>
		<td>Number of Seats</td><td><input type="text" name="numSeats"></td>
		</tr>
		<tr>
		<td>Minimum Price</td><td><input type="text" name="minPrice"></td>
		</tr>
		<tr>
		<td>Bid Increment</td><td><input type="text" name="bidIncrement"></td>
		</tr>
		<tr>
		<td>Closing Date</td><td><input type="text" name="closeDate"></td>
		</tr>
		<tr>
		<td>Closing Time</td><td><input type="text" name="closeTime"></td>
		</tr>
		<tr>
		<td>Miles per gallon </td><td><input type="text" name="mpg"></td>
		</tr>
		<tr>
		<td>Is it a convertible? (enter "true" or "false")</td><td><input type="text" name="isConvertible"></td>
		</tr>
		<tr>
		<td>Horsepower</td><td><input type="text" name="horsepower"></td>
		</tr>
		<tr>
		<td>Does it have a navigation system? (enter "true" or "false")</td><td><input type="text" name="hasNavigation"></td>
		</tr>
		</table>
		<input type="submit" value="Submit to Add Auction">
		</form>
		
	<CENTER>
		<h4>Navigation</h4>
		<div class="navigation-container">
			<form method="get" action="logout.jsp">
				<table>
					<tr>    
				</table>
				<input type="submit" value="Log Out">
			</form> 
			<p>
			&ensp;
			</p>
			<form method="get" action="mainpage.jsp">
				<table>
					<tr>    
				</table>
				<input type="submit" value="Go Back to Main Page">
			</form> 
			
		</div>
	</CENTER>
</html>