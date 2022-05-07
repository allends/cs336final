package com.cs336.classes;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import java.util.Random;

import com.cs336.pkg.ApplicationDB;

public class Alert {
	
	public int alertId;
	public int itemId;
	public String username;
	public String content;
	public Date datePosted;
	public Time timePosted;
	
	public Alert(int itemId, String username, String content) {
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
			int alertId = 1;
			while (true) {
				Random randInt = new Random();
				int upperBound = 100000;
				alertId = alertId * randInt.nextInt(upperBound);
				stmt = con.createStatement();
				String str = "SELECT * FROM alerts a WHERE a.alertId = '" + alertId + "'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				if (result.next() == false) {
					break;
				}

			}
			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO alerts (alertId, itemId, username, content, datePosted, timePosted)"
					+ "VALUES (?, ?, ?, ?, ?, ?)";
			
			//Create the insert statement
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1, alertId);
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
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("an error occurered");
		}
	}
	
}



