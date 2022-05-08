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
<style>
	.navigation-container {
		display: flex;
		flex-direction: column;
		row-gap: 5px;
	}
	.comment-container {
		display: flex;
		flex-direction: column;
		row-gap: 15px;
		margin-top: 10px;
		width: 50vw;
	}
	.comment {
		border-style: solid;
		border-color: black;
		border-width: 2px;
		border-radius: 5px;
		padding-bottom: 10px;
	}
	.reply-container {
		display: flex;
		flex-direction: column;
		row-gap: 5px;
	}
	.reply {

	}
</style>
</head>
<body>
<%
String searchTerm = request.getParameter("searchTerm");
String username = session.getAttribute("username") + "";
Integer itemId = Integer.valueOf(request.getParameter("itemId"));
Auction auction = new Auction(itemId);
%>
    <CENTER>
        <h1>Search Results</h1>
        <br>
        <div class="comment-container">
			<%
                ArrayList<Comment> commentList = auction.getCommentsFiltered(searchTerm);
				for (Comment comment : commentList) {
					ArrayList<Comment> replyList = comment.getReplies(comment.commentId);
					%>
					<div class="comment">
						<p><b><%= comment.username %> on <%= comment.datePosted %></b></p>
						<p><%= comment.content %></p>
						<div class="reply-container">
					<%
					for (Comment reply : replyList) {
						%>
							<div class="reply">
								<p>^ <b><%= reply.username %> on <%= reply.datePosted %></b></p>
								<p><%= reply.content %></p>
							</div>
						<%
					}
					%>
					</div>
				</div>
				<%
			}
				
		%>
		</div>
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

</body>
</html>