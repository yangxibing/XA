package com.database.dao;

public interface DatabaseDao {

	public String backup(String path);
	public String restore(String path);
}
