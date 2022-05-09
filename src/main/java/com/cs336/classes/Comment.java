package com.cs336.classes;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Random;

import com.cs336.pkg.ApplicationDB;

public class Comment {
	
	public int itemId;
	public int repliedTo;
	public int commentId;
	public String username;
	public String content;
	public Date datePosted;
	public Time timePosted;
	
	public Comment(int itemId, String username, String content) {
		// add to the database
		//Get the database connection
		System.out.println("making a comment");
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		Date datePosted = new Date(System.currentTimeMillis());
		Time timePosted = new Time(System.currentTimeMillis());
		try {
			//Create a SQL statement
			Statement stmt = con.createStatement();
			int commentId = 1;
			while (true) {
				Random randInt = new Random();
				int upperBound = 100000;
				commentId = commentId * randInt.nextInt(upperBound);
				stmt = con.createStatement();
				String str = "SELECT * FROM comments c WHERE c.commentId = '" + commentId + "'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				if (result.next() == false) {
					break;
				}

			}
			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO comments (commentId, itemId, username, content, datePosted, timePosted)"
					+ "VALUES (?, ?, ?, ?, ?, ?)";
			
			//Create the insert statement
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1, commentId);
			ps.setInt(2, itemId);
			ps.setString(3, username);
			ps.setString(4, content);
			ps.setDate(5, datePosted);
			ps.setTime(6, timePosted);
			
			// Add the item to the database
			ps.executeUpdate();
			
			// Set the values of this object
			this.itemId = itemId;
			this.username = username;
			this.content = content;
			this.datePosted = datePosted;
			this.timePosted = timePosted;
			this.commentId = commentId;
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("There was a problem creating the comment");
		}
	}

	public Comment(int itemId, int repliedTo,String username, String content) {
		// add to the database
		//Get the database connection
		System.out.println("Making a reply");
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		Date datePosted = new Date(System.currentTimeMillis());
		Time timePosted = new Time(System.currentTimeMillis());
		try {
			//Create a SQL statement
			Statement stmt = con.createStatement();
			int commentId = 1;
			while (true) {
				Random randInt = new Random();
				int upperBound = 100000;
				commentId = commentId * randInt.nextInt(upperBound);
				stmt = con.createStatement();
				String str = "SELECT * FROM comments c WHERE c.commentId = '" + commentId + "'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				if (result.next() == false) {
					break;
				}

			}stmt = con.createStatement();
			String str = "SELECT a.accountType FROM accountInfo a WHERE a.username = '" + username + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			String accountType = "";
			while (result.next()) {
				accountType = result.getString("accountType");
			}
			//Make an insert statement for the Sells table:
			if (accountType.compareTo("customerRep")==0) {
				
				String insert = "INSERT INTO comments (commentId, itemId, repliedTo, username, content, datePosted, timePosted)"
						+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
			
			//Create the insert statement
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setInt(1, commentId);
				ps.setInt(2, itemId);
				ps.setInt(3, repliedTo);
				ps.setString(4, username);
				ps.setString(5, content);
				ps.setDate(6, datePosted);
				ps.setTime(7, timePosted);
			
				// Add the item to the database
				ps.executeUpdate();
			
			// Set the values of this object
				this.itemId = itemId;
				this.username = username;
				this.content = content;
				this.datePosted = datePosted;
				this.timePosted = timePosted;
				this.commentId = commentId;
				this.repliedTo = repliedTo;
			}
			else {
				System.out.println("Invalid account type");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("There was a problem creating the comment");
		}
	}
	
	public Comment(int commentId) {
		// Retrieve the comment
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		try {
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String findComment = "select * from comments c where c.commentId = " + commentId;
			ResultSet comment = stmt.executeQuery(findComment);
			while (comment.next()) {
				this.itemId = comment.getInt("itemId");
				this.username = comment.getString("username");
				this.content = comment.getString("content");
				this.datePosted = comment.getDate("datePosted");
				this.timePosted = comment.getTime("timePosted");
				this.commentId = commentId;
			}
			
		} catch (Exception e) {
			System.out.println("There was a problem retrieving the comment");
		}
	}
	
	public void addReply(String username, String content, Date datePosted, Time timePosted) {}
	
	public ArrayList<Comment> getReplies(int commentId) {
		ArrayList<Comment> results = new ArrayList<Comment>();
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		try {
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String findComment = "select * from comments c where c.repliedTo = " + commentId;
			ResultSet comment = stmt.executeQuery(findComment);
			while (comment.next()) {
				results.add(new Comment(comment.getInt("commentId")));
			}
			
		} catch (Exception e) {
			System.out.println("There was a problem retrieving the comment");
		}
		return results;
	}

	public static void main(String args[]) {
		Comment test = new Comment(1492, "allends", "this is a comment");
	}
}
