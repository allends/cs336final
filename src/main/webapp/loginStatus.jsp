<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>cs336project</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM AccountInfo a WHERE a.username = '" + username + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			String actualPassword = "";
			String actualUsername = "";
			String accountType = "";
			
			while (result.next()) {
					actualUsername = result.getString("username");
					actualPassword = result.getString("password");
					accountType = result.getString("accountType");
					}
			if (actualUsername == "")
				response.sendRedirect("loginpage.jsp");
			
			else if ((password.equals(actualPassword)) && (accountType.equals("administrator"))) {
				session.setAttribute("username",username);
				response.sendRedirect("admin.jsp");
			}
			
			else if ((password.equals(actualPassword)) && (accountType.equals("customer"))) {
				session.setAttribute("username",username);
				response.sendRedirect("mainpage.jsp");
			}
			
			else if ((password.equals(actualPassword)) && (accountType.equals("customerRep"))) {
				session.setAttribute("username",username);
				response.sendRedirect("customerRep.jsp");
			}
			
			else {
				response.sendRedirect("loginpage.jsp");
			}


			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	
	%>
	</body>
	<body>
		<form method="get" action="loginpage.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="Log Out">
		</form>
	

</body>
</html>