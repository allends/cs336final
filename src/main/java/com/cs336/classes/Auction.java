package com.cs336.classes;

import com.cs336.pkg.ApplicationDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.Random;

public class Auction {

	public int itemId;
	public int numSeats;
	public float currentBid;
	public String itemType;
	public float minPrice;
	public float bidIncrement;
	public String make;
	public String model;
	public int year;
	public String itemName;
	public String sellerUsername;
	public String currentBidder;
	public Date closeDate;
	public Time closeTime;

	public Auction(String sellerUsername, String itemName, String itemType, float minPrice, float bidIncrement, int numSeats, String make,
			String model, int year, Date closeDate, Time closeTime) {

		// Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		try {
			// Create a SQL statement
			Statement stmt = con.createStatement();
			int itemid = 1;
			while (true) {
				Random randInt = new Random();
				int upperBound = 100000;
				itemid = itemid * randInt.nextInt(upperBound);
				stmt = con.createStatement();
				String str = "SELECT * FROM items i WHERE i.itemId = '" + itemid + "'";
				// Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				if (result.next() == false) {
					break;
				}

			}

			// Make an insert statement for the Sells table:
			String insert = "INSERT INTO items(itemId,itemName,sellerUsername,itemType,make,model,year,numSeats,minPrice,bidIncrement,closeDate,closeTime,currentBid)"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)";

			// Create the insert statement
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1, itemid);
			ps.setString(2, itemName);
			ps.setString(3, sellerUsername);
			ps.setString(4, itemType);
			ps.setString(5, make);
			ps.setString(6, model);
			ps.setInt(7, year);
			ps.setInt(8, numSeats);
			ps.setFloat(9, minPrice);
			ps.setFloat(10, bidIncrement);
			ps.setDate(11, closeDate);
			ps.setTime(12, closeTime);
			ps.setFloat(13, 0);

			// Add the item to the database
			ps.executeUpdate();

			// Set the values of this object
			this.itemId = itemid;
			this.sellerUsername = sellerUsername;
			this.itemName = itemName;
			this.itemType = itemType;
			this.make = make;
			this.model = model;
			this.year = year;
			this.numSeats = numSeats;
			this.minPrice = minPrice;
			this.bidIncrement = bidIncrement;
			this.closeDate = closeDate;
			this.closeTime = closeTime;
			this.currentBid = 0f;
			this.currentBidder = "";

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("an error occurered");
		}

	}

	public Auction(int itemId) {
		// Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		try {
			// Create a SQL statement
			Statement stmt = con.createStatement();

			// Get the Auction with the associated itemId:
			String str = "SELECT * FROM items i WHERE i.itemId = '" + itemId + "'";
			// Create a Prepared SQL statement allowing you to introduce the parameters of
			// the query
			ResultSet result = stmt.executeQuery(str);

			while (result.next()) {
				this.itemId = itemId;
				this.sellerUsername = result.getString("sellerUsername");
				this.itemName = result.getString("itemName");
				this.itemType = result.getString("itemType");
				this.make = result.getString("make");
				this.model = result.getString("model");
				this.year = result.getInt("year");
				this.numSeats = result.getInt("numSeats");
				this.minPrice = result.getInt("minPrice");
				this.closeDate = result.getDate("closeDate");
				this.closeTime = result.getTime("closeTime");
				this.currentBid = result.getFloat("currentBid");
				this.bidIncrement = result.getFloat("bidIncrement");
				this.currentBidder = result.getString("currentBidder") != null ? result.getString("currentBidder") : "";
			}

		} catch (Exception e) {
			System.out.println("an error occurered");
		}
	}

	public String addBid(Float bidAmount, String bidder) {
		// Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		try {
			String highestBid = "SELECT MAX(amountBid) as amountBid, bidder FROM bids b WHERE b.itemId=" + this.itemId + " GROUP BY bidder";
			Statement stmt = con.createStatement();

			ResultSet result = stmt.executeQuery(highestBid);
			while (result.next()) {
				if (result.getInt("amountBid") < bidAmount) {
					// update the entries
					// update the auction in mysql
					System.out.println("the bid is valid");
					this.currentBidder = bidder;
					this.currentBid = bidAmount;
					this.updateAuction();

					Bid newHighestBid = new Bid(this.itemId, bidder, bidAmount);
					this.outBidNotifications(result.getString("bidder"));
					return "Success!";
				} else {
					// nothing
					System.out.println("the bid is not high enough");
					return "Bid not high enough!";
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			return "System error, try again please!";
		}
		return "EBAY";
	}

	public void updateAuction() {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		try {
			PreparedStatement ps = con.prepareStatement(
				"UPDATE items SET currentBidder = ?, currentBid = ? WHERE itemId = ?");
			ps.setString(1, this.currentBidder);
			ps.setFloat(2, this.currentBid);
			ps.setInt(3, this.itemId);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean isOpen() {
		Date today = new Date(System.currentTimeMillis());
		Time now = new Time(System.currentTimeMillis());
		if (today.before(this.closeDate)) {
			return true;
		} else if (today.compareTo(this.closeDate) == 0 && now.before(this.closeTime)) {
			return true;
		}
		return false;
	}

	public String getStatus() {
		if (this.isOpen()) {
			return "Open";
		} else if (!this.isOpen() && this.currentBidder == null) {
			return "Expired";
		} else {
			return "Closed";
		}
	}

	// Return a list of bids for this Auction
	public void getBids() {
	}

	// Return a list of bids for this Auction
	public ArrayList<Comment> getComments() {
		ArrayList<Comment> result = new ArrayList<Comment>();

		// Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		try {
			// Create a SQL statement
			Statement stmt = con.createStatement();
			stmt = con.createStatement();
			String str = "SELECT * FROM comments c WHERE c.itemId = '" + this.itemId
					+ "' ORDER BY c.datePosted DESC, c.timePosted ASC";
			// Run the query against the database.
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

	public void outBidNotifications(String userName) {

	}

	public void hello() {
		System.out.println("hello");
	}

	// Close the bidding
	public void closeAuction() {
	}

}
