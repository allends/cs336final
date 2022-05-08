package com.cs336.classes;

import com.cs336.pkg.ApplicationDB;

import java.sql.*;
import java.util.Random;

public class Bid {
	
	public int bidId;
	public int itemId;
	public String bidder;
	public float bidAmount;
	
	public Bid(int itemId, String bidder, float bidAmount) {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		try {
			//Create a SQL statement
			Statement stmt = con.createStatement();
			int bidId = 1;
			while (true) {
				Random randInt = new Random();
				int upperBound = 100000;
				bidId = bidId * randInt.nextInt(upperBound);
				stmt = con.createStatement();
				String str = "SELECT * FROM bids b WHERE b.bidId = '" + bidId + "'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				if (result.next() == false) {
					break;
				}

			}
			
			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO bids(bidId,itemId,bidder,amountBid)"
					+ "VALUES (?, ?, ?, ?)";
			
			//Create the insert statement
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1, bidId);
			ps.setInt(2, itemId);
			ps.setString(3, bidder);
			ps.setFloat(4, bidAmount);
			
			// Add the item to the database
			ps.executeUpdate();
			
			// Set the values of this object
			this.bidId = bidId;
			this.itemId = itemId;
			this.bidder = bidder;
			this.bidAmount = bidAmount;
			
		} catch (Exception e) {
			System.out.println("an error occurred");
		}
		
	}
	
	public Bid(int bidId) {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		try {
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get the Auction with the associated itemId:
			String str = "SELECT * FROM bids b WHERE b.bidId = '" + bidId + "'";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
				this.bidId = bidId;
				this.itemId = result.getInt("itemId");
				this.bidder = result.getString("bidder");
				this.bidAmount = result.getFloat("bidAmount");
			}
			
		} catch (Exception e) {
			System.out.println("an error occurered");
		}
	}
	
}