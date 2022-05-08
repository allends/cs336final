package com.cs336.classes;

import com.cs336.pkg.ApplicationDB;

import java.sql.*;
import java.util.Random;

public class Truck {
	
	public int itemId;
	public boolean hasTruckBed;
	public float towingPower;
	public float mpg;
	public float horsepower;
	
	public Truck(int itemId, boolean hasTruckBed, float towingPower, float mpg, float horsepower) {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		try {
			//Create a SQL statement

			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO trucks(itemId,hasTruckBed,towingPower,mpg,horsepower)"
					+ "VALUES (?, ?, ?, ?, ?)";
			
			//Create the insert statement
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1, itemId);
			ps.setBoolean(2, hasTruckBed);
			ps.setFloat(3, towingPower);
			ps.setFloat(4, mpg);
			ps.setFloat(5, horsepower);
			
			// Add the item to the database
			ps.executeUpdate();
			
			// Set the values of this object
			this.itemId = itemId;
			this.hasTruckBed = hasTruckBed;
			this.towingPower = towingPower;
			this.mpg = mpg;
			this.horsepower = horsepower;
			
		} catch (Exception e) {
			System.out.println("an error occurred");
		}
		
	}
	
	public Truck(int itemId) {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		try {
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get the Auction with the associated itemId:
			String str = "SELECT * FROM trucks t WHERE t.itemId = '" + itemId + "'";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
				this.itemId = itemId;
				this.hasTruckBed = result.getBoolean("hasTruckBed");
				this.towingPower = result.getFloat("towingPower");
				this.mpg = result.getFloat("mpg");
				this.horsepower = result.getFloat("horsepower");

			}
			
		} catch (Exception e) {
			System.out.println("an error occurered");
		}
	}
	
}