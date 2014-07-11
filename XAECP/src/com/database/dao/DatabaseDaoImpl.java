package com.database.dao;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;


public class DatabaseDaoImpl extends SqlMapClientDaoSupport implements DatabaseDao {

	public String backup(String path) {
		
	 this.getSqlMapClientTemplate().queryForObject("database.backup",path);
	 return "backupSuccess";
	 
	}

	public String restore(String path) {
		try{
		this.getSqlMapClientTemplate().queryForObject("database.restore", path);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "restoreSuccess";
	}

}
