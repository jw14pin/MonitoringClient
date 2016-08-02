package com.models;

public class DBTest {
	private String db;
	private String verifyQuery;
	
	public DBTest(String db, String verifyQuery) {
		super();
		this.db = db;
		this.verifyQuery = verifyQuery;
	}
	
	public String getDb() {
		return db;
	}
	public void setDb(String db) {
		this.db = db;
	}
	public String getVerifyQuery() {
		return verifyQuery;
	}
	public void setVerifyQuery(String verifyQuery) {
		this.verifyQuery = verifyQuery;
	}
	
	
	
	
}
