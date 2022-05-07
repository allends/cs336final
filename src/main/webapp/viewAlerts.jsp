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
			String username = "" + session.getAttribute("username");
			out.print("Alerts to " + username + "!");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM alerts a WHERE a.username = '" + username + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Alert Number");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Item Id");
			out.print("</td>");
			out.print("<td>");
			out.print("Message");
			out.print("</td>");
			out.print("<td>");
			out.print("Date Issued");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Time Issued");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getString("alertId"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("itemId"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("content"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("datePosted"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("timePosted"));
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