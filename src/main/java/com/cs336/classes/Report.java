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
			String str = "SELECT * FROM items i WHERE i.isOpen = 0 ORDER BY currentBid DESC";
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
	
	public ArrayList<String[]> itemEarnings(int sw) {
		ArrayList<String[]> result = new ArrayList<String[]>();
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		try {
			// Create a SQL statement
			Statement stmt = con.createStatement();
			stmt = con.createStatement();
			String comm = "";
			
			switch(sw) {
				case 1:
					comm = "SELECT year, SUM(currentBid) FROM items i WHERE i.isOpen = 0 GROUP BY year ORDER BY SUM(currentBid) DESC";
					break;
				case 2:
					comm = "SELECT make, SUM(currentBid) FROM items i WHERE i.isOpen = 0 GROUP BY make ORDER BY SUM(currentBid) DESC";
					break;
				case 3:
					comm = "SELECT model, SUM(currentBid) FROM items i WHERE i.isOpen = 0 GROUP BY model ORDER BY SUM(currentBid) DESC";
					break;
					
			}
			
			ResultSet res = stmt.executeQuery(comm);
			while (res.next()) {
				String temp[] = {res.getString(1), res.getString(2)};
				result.add(temp);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("An error occurred");
		}
		
		return result;
		
	}
	
	public ArrayList<String[]> sellerEarnings(int sw) {
		ArrayList<String[]> result = new ArrayList<String[]>();
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		try {
			// Create a SQL statement
			Statement stmt = con.createStatement();
			stmt = con.createStatement();
			String comm = "";
			
			switch(sw) {
				case 1:
					comm = "SELECT sellerUsername, SUM(currentBid) FROM items i WHERE i.isOpen = 0 GROUP BY sellerUsername ORDER BY SUM(currentBid) DESC";
					break;
				case 2:
					comm = "SELECT sellerUsername, Count(sellerUsername) FROM items i WHERE i.isOpen = 0 GROUP BY sellerUsername ORDER BY COUNT(sellerUsername) DESC";
					break;
					
			}
			
			ResultSet res = stmt.executeQuery(comm);
			while (res.next()) {
				String temp[] = {res.getString(1), res.getString(2)};
				result.add(temp);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("An error occurred");
		}
		
		return result;
	}
	
	public ArrayList<String[]> buyerSpending(int sw) {
		ArrayList<String[]> result = new ArrayList<String[]>();
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		try {
			// Create a SQL statement
			Statement stmt = con.createStatement();
			stmt = con.createStatement();
			String comm = "";
			
			switch(sw) {
				case 1:
					comm = "SELECT currentBidder, SUM(currentBid) FROM items i WHERE i.isOpen = 0 GROUP BY currentBidder ORDER BY SUM(currentBid) DESC";
					break;
				case 2:
					comm = "SELECT currentBidder, Count(sellerUsername) FROM items i WHERE i.isOpen = 0 GROUP BY currentBidder ORDER BY COUNT(currentBidder) DESC";
					break;
					
			}
			
			ResultSet res = stmt.executeQuery(comm);
			while (res.next()) {
				String temp[] = {res.getString(1), res.getString(2)};
				result.add(temp);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("An error occurred");
		}
		
		return result;
	}
		
	public ArrayList<String[]> bestItems(int sw) {
		ArrayList<String[]> result = new ArrayList<String[]>();
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		try {
			// Create a SQL statement
			Statement stmt = con.createStatement();
			stmt = con.createStatement();
			String comm = "";
			
			switch(sw) {
				case 1:
					comm = "SELECT year, make FROM items i WHERE i.isOpen = 0 GROUP BY year, make ORDER BY COUNT(year) DESC LIMIT 1";
					break;
				case 2:
					comm = "SELECT make, model FROM items i WHERE i.isOpen = 0 GROUP BY make, model ORDER BY COUNT(make) DESC LIMIT 1";
					break;
				case 3:
					comm = "SELECT model, year FROM items i WHERE i.isOpen = 0 GROUP BY model, year ORDER BY COUNT(model) DESC LIMIT 1";
					break;
					
			}
			
			ResultSet res = stmt.executeQuery(comm);
			while (res.next()) {
				String temp[] = {res.getString(1), res.getString(2)};
				result.add(temp);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("An error occurred");
		}
		
		return result;
		
	}

}
