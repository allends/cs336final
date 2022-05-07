<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Leave a comment</title>
</head>
	<%
		// itemId
		// username
		// content
		String comment = request.getParameter("comment");
		String username = String.valueOf(session.getAttribute("username"));
		int itemId = Integer.valueOf(request.getParameter("itemId"));	
		
		if (comment.length() > 2) {
			Comment addedComment = new Comment(itemId, username, comment);
		}
		%>
		<form method="get" action="#">
			<table>
				<tr>
					<td>Comment</td><td><input type="text" name="comment"></td>
					<td><input type="submit" value="Post"></td>
				</tr>
			</table>
		</form>
		<%
	%>
	<p>
	&ensp;
	</p>
	<body>
		<form method="get" action="mainpage.jsp">
			<table>
				<tr>    
			</table>
			<input type="submit" value="Go Back to Home Page">
		</form>
	</body>
	<body> 
	<p>
	&ensp;
	</p>
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
</html>