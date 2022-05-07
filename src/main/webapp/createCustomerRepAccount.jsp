<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the mainpage.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
	
		
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO accountInfo(accountId,accountType, username,password)"
				+ "VALUES (?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		//Find unused int for itemid
		int accountId = 1;
		while (true) {
			Random randInt = new Random();
			int upperBound = 100000;
			accountId = accountId * randInt.nextInt(upperBound);
			stmt = con.createStatement();
			String str = "SELECT * FROM accountInfo a WHERE a.accountId = '" + accountId + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			if (result.next() == false) {
				break;
			}

		}
		stmt = con.createStatement();
		String str = "SELECT * FROM accountInfo a WHERE a.username = '" + username + "'";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		if (result.next() == false) {
			out.print("Your account was successfully created!");
			ps.setInt(1, accountId);
			ps.setString(2, "customerRep");
			ps.setString(3, username);
			ps.setString(4,password);
			ps.executeUpdate();
		}
		else {
			out.print("That username was already taken, please choose another one!");
		}
		

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		//Find unused int for itemid
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("It failed to create an account, please try again!");
	}
	%>
	<p>
	&ensp;
	</p>
	<body>
		<form method="get" action="admin.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="Go Back to Admin Page">
		</form>
	</body>
</html>