package com.cs336.classes;

import com.cs336.pkg.ApplicationDB;

import java.sql.*;
import java.util.Random;

public class Car {
	
	public int itemId;
	public boolean isConvertible;
	public boolean hasNavigation;
	public float mpg;
	public float horsepower;
	
	public Car(int itemId, float mpg, boolean isConvertible, float horsepower, boolean hasNavigation) {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		try {
			//Create a SQL statement

			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO cars(itemId,mpg,isConvertible,horsepower, hasNavigation)"
					+ "VALUES (?, ?, ?, ?, ?)";
			
			//Create the insert statement
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1, itemId);
			ps.setFloat(2, mpg);
			ps.setBoolean(3, isConvertible);
			ps.setFloat(4, horsepower);
			ps.setBoolean(5, hasNavigation);
			
			// Add the item to the database
			ps.executeUpdate();
			
			// Set the values of this object
			this.itemId = itemId;
			this.isConvertible = isConvertible;
			this.hasNavigation = hasNavigation;
			this.mpg = mpg;
			this.horsepower = horsepower;
			con.close();
		} catch (Exception e) {
			System.out.println("an error occurred");
		}
		
	}
	
	public Car(int itemId) {
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
				this.mpg = result.getFloat("mpg");
				this.isConvertible = result.getBoolean("isConvertible");
				this.horsepower = result.getFloat("horsepower");
				this.hasNavigation = result.getBoolean("hasNavigation");

			}
			con.close();
		} catch (Exception e) {
			System.out.println("an error occurered");
		}
	}
	
}