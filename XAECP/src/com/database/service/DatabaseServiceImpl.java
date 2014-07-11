package com.database.service;

import com.database.dao.DatabaseDao;

public class DatabaseServiceImpl implements DatabaseService{

	private DatabaseDao databaseDao;
	private static final String databasePath="D:\\b.db";
	
	public String backup() {
		
		return this.databaseDao.backup(databasePath);
	}
	
	public String restore() {
		
		return this.databaseDao.restore(databasePath);
	}
	
	public DatabaseDao getDatabaseDao() {
		return databaseDao;
	}
	public void setDatabaseDao(DatabaseDao databaseDao) {
		this.databaseDao = databaseDao;
	}

}
