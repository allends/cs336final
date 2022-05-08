package com.cs336.classes;

import com.cs336.pkg.ApplicationDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.Random;

public class Report {

	public Report() {

	}

	public ArrayList<String[]> totalEarnings() {
		ArrayList<String[]> result = new ArrayList<String[]>();
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		try {
			// Create a SQL statement
			Statement stmt = con.createStatement();
			stmt = con.createStatement();
			String str = "SELECT * FROM auction a WHERE a.isClose = 0";
			// Run the query against the database.
			ResultSet auction = stmt.executeQuery(str);
			while (auction.next()) {
				String item[] = {Integer.toString(auction.getInt("year")) + " " + auction.getString("make") + " " + auction.getString("model"), Float.toString(auction.getFloat("currentBid"))};
				result.add(item);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("An error occurred");
		}
		return result;
		
	}

}
