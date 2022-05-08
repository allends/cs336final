<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, com.cs336.classes.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
    <CENTER>
        <h1>Comment Posted</h1>
        <br>
        <h4>Naviagtion</h4>
		<div class="navigation-container">
            <form method="get" action="auctionPage.jsp">
                <input type="submit" value="Back to Listing">
                <input type="text" name="itemId" value="<%= request.getParameter("itemId") %>" hidden="true">
            </form>
			<form method="get" action="viewNonOwnedAuctions.jsp">
				<input type="submit" value="Back to Auctions">
			</form>
			<form method="get" action="mainpage.jsp">
				<input type="submit" value="Go Back to Home Page">
			</form>
			<form method="get" action="logout.jsp">
				<input type="submit" value="Log Out">
			</form>
		</div>
    </CENTER>
    <%
    String content = request.getParameter("content");
    String username = session.getAttribute("username") + "";
    String repliedTo = request.getParameter("repliedTo");
    Integer itemId = Integer.valueOf(request.getParameter("itemId"));
    if (repliedTo == null) {
        Comment addedComment = new Comment(itemId, username, content);
    } else {
        Integer repliedToInt = Integer.valueOf(repliedTo);
        Comment addedComment = new Comment(itemId, repliedToInt, username, content);
    }
%>
</body>
</html>