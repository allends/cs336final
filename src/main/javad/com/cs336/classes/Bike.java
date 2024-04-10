package com.cs336.classes;

import com.cs336.pkg.ApplicationDB;

import java.sql.*;
import java.util.Random;

public class Bike {
	
	public int itemId;
	public boolean isMountainBike;
	public boolean hasLights;
	public int numGears;
	public String bikeIntendedAge;
	
	public Bike(int itemId, boolean isMountainBike, boolean hasLights, int numGears, String bikeIntendedAge) {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		try {
			//Create a SQL statement

			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO bikes(itemId,isMountainBike,hasLights,numGears,bikeIntendedAge)"
					+ "VALUES (?, ?, ?, ?, ?)";
			
			//Create the insert statement
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1, itemId);
			ps.setBoolean(2, isMountainBike);
			ps.setBoolean(3, hasLights);
			ps.setInt(4, numGears);
			ps.setString(5, bikeIntendedAge);
			
			// Add the item to the database
			ps.executeUpdate();
			
			// Set the values of this object
			this.itemId = itemId;
			this.isMountainBike = isMountainBike;
			this.hasLights = hasLights;
			this.numGears = numGears;
			this.bikeIntendedAge = bikeIntendedAge;
			con.close();
		} catch (Exception e) {
			System.out.println("an error occurred");
		}
		
	}
	
	public Bike(int itemId) {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		try {
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get the Auction with the associated itemId:
			String str = "SELECT * FROM bikes b WHERE b.itemId = '" + itemId + "'";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
				this.itemId = itemId;
				this.isMountainBike = result.getBoolean("isMountainBike");
				this.hasLights = result.getBoolean("hasLights");
				this.numGears = result.getInt("numGears");
				this.bikeIntendedAge = result.getString("bikeIntendedAge");

			}
			con.close();
		} catch (Exception e) {
			System.out.println("an error occurered");
		}
	}
	
}