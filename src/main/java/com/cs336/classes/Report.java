package com.cs336.classes;

import com.cs336.pkg.ApplicationDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.Random;

public class Report {

	public float sum = 0.0f;
	
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
			String str = "SELECT * FROM items i WHERE i.isOpen = 0";
			// Run the query against the database.
			ResultSet auction = stmt.executeQuery(str);
			while (auction.next()) {
				this.sum = this.sum + auction.getFloat("currentBid");
				String item[] = {Integer.toString(auction.getInt("year")) + " " + auction.getString("make") + " " + auction.getString("model"), Float.toString(auction.getFloat("currentBid"))};
				result.add(item);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("An error occurred");
		}
		
		return result;
		
	}
	
	public float returnSum() {
		float temp = this.sum;
		this.sum = 0.0f;
		return temp;
	}
	
	public ArrayList<String[]> typeEarnings() {
		ArrayList<String[]> result = new ArrayList<String[]>();
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		try {
			// Create a SQL statement
			Statement stmt = con.createStatement();
			stmt = con.createStatement();
			String car = "SELECT SUM(currentBid) FROM items i WHERE i.isOpen = 0 and i.itemType = \'car\' ";
			// Run the query against the database.
			ResultSet carType = stmt.executeQuery(car);
			while (carType.next()) {
				String carArr[] = {"Car", carType.getString(1)};
				result.add(carArr);
			}
			
			String truck = "SELECT SUM(currentBid) FROM items i WHERE i.isOpen = 0 and i.itemType = \'truck\' ";
			// Run the query against the database.
			ResultSet truckType = stmt.executeQuery(truck);
			while (truckType.next()) {
				String truckArr[] = {"Truck", truckType.getString(1)};
				result.add(truckArr);
			}
			
			String bike = "SELECT SUM(currentBid) FROM items i WHERE i.isOpen = 0 and i.itemType = \'bike\' ";
			// Run the query against the database.
			ResultSet bikeType = stmt.executeQuery(bike);
			while (bikeType.next()) {
				String bikeArr[] = {"Bike", bikeType.getString(1)};
				result.add(bikeArr);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("An error occurred");
		}
		
		return result;
		
	}

}
