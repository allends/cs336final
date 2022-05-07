package com.cs336.classes;

import com.cs336.pkg.ApplicationDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.Random;

public class Auction {

	public int itemId;
	public int numSeats;
	public float currentBid;
	public float minPrice;
	public float bidIncrement;
	public String make;
	public String model;
	public String itemName;
	public String sellerUsername;
	public String currentBidder;
	public Date closeDate;
	public Time closeTime;
	
	public Auction(String sellerUsername, String itemName, float minPrice, float bidIncrement, int numSeats, String make, String model, Date closeDate, Time closeTime) {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		try {
			//Create a SQL statement
			Statement stmt = con.createStatement();
			int itemid = 1;
			while (true) {
				Random randInt = new Random();
				int upperBound = 100000;
				itemid = itemid * randInt.nextInt(upperBound);
				stmt = con.createStatement();
				String str = "SELECT * FROM items i WHERE i.itemId = '" + itemid + "'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				if (result.next() == false) {
					break;
				}

			}
			
			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO items(itemId,itemName,sellerUsername,make,model,numSeats,minPrice,bidIncrement,closeDate,closeTime,currentBid)"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			//Create the insert statement
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1, itemid);
			ps.setString(2, itemName);
			ps.setString(3, sellerUsername);
			ps.setString(4, make);
			ps.setString(5, model);
			ps.setInt(6,numSeats);
			ps.setFloat(7, minPrice);
			ps.setFloat(8, bidIncrement);
			ps.setDate(9, closeDate);
			ps.setTime(10, closeTime);
			ps.setFloat(11,0);
			
			// Add the item to the database
			ps.executeUpdate();
			
			// Set the values of this object
			this.itemId = itemid;
			this.sellerUsername = sellerUsername;
			this.itemName = itemName;
			this.make = make;
			this.model = model;
			this.numSeats = numSeats;
			this.minPrice = minPrice;
			this.bidIncrement = bidIncrement;
			this.closeDate = closeDate;
			this.closeTime = closeTime;
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("an error occurered");
		}
		
	}
	
	public Auction(int itemId) {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		try {
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get the Auction with the associated itemId:
			String str = "SELECT * FROM items i WHERE i.itemId = '" + itemId + "'";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
				this.itemId = itemId;
				this.sellerUsername = result.getString("sellerUsername");
				this.itemName = result.getString("itemName");
				this.make = result.getString("make");
				this.model = result.getString("model");
				this.numSeats = result.getInt("numSeats");
				this.minPrice = result.getInt("minPrice");
				this.closeDate = result.getDate("closeDate");
				this.closeTime = result.getTime("closeTime");
				this.currentBid = result.getFloat("currentBid");
				this.bidIncrement = result.getFloat("bidIncrement");
				this.currentBidder = result.getString("currentBidder");
			}
			
		} catch (Exception e) {
			System.out.println("an error occurered");
		}
	}
	
	// Bids cannot be deleted once created
	public void addBid(int bidAmount) {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		try {
			String getBids = "SELECT MAX(bidAmount) FROM bids b WHERE b.itemId=" + this.itemId;
			Statement stmt = con.createStatement();
			
			ResultSet result = stmt.executeQuery(getBids);
			while (result.next()) {
				if (result.getInt("bidAmount") < bidAmount) {
					// update the entries
					// add the new bid
					System.out.println("the bid is valid");
				} else {
					// nothing
				}
			}
			
		} catch (Exception e) {
			System.out.println("Error adding a big");
		}
	}
	
	public boolean isOpen() {
		// Date today = new Date();
		// Time now = new Time();
		return true;
	}
	
	// Return a list of bids for this Auction
	public void getBids() {}
	
	// Return a list of bids for this Auction
	public ArrayList<Comment> getComments() {
		ArrayList<Comment> result = new ArrayList<Comment>();
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		try {
			//Create a SQL statement
			Statement stmt = con.createStatement();
			stmt = con.createStatement();
			String str = "SELECT * FROM comments c WHERE c.itemId = '" + this.itemId + "'";
			//Run the query against the database.
			ResultSet comments = stmt.executeQuery(str);
			while (comments.next()) {
				result.add(new Comment(comments.getInt("commentId")));
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("an error occurered");
		}
		return result;
	}
	
	// Close the bidding
	public void closeAuction() {}
	
}
