package com.database.action;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.database.service.DatabaseService;
import com.opensymphony.xwork2.ActionSupport;

public class DatabaseAction extends ActionSupport implements RequestAware{

	private DatabaseService databaseService;
	private String backup;
	private String restore;
	private Map<String, Object> request = new HashMap<String, Object>();
	public String backup(){
		
		this.databaseService.backup();
		request.put("backup", "success");
		return SUCCESS;
	}
	
	public String restore(){
		
		this.databaseService.restore();
		request.put("restore", "success");
		return SUCCESS;
	}
	
	public DatabaseService getDatabaseService() {
		return databaseService;
	}

	public void setDatabaseService(DatabaseService databaseService) {
		this.databaseService = databaseService;
	}

	public String getBackup() {
		return backup;
	}

	public void setBackup(String backup) {
		this.backup = backup;
	}

	public String getRestore() {
		return restore;
	}

	public void setRestore(String restore) {
		this.restore = restore;
	}

	public void setRequest(Map<String, Object> arg0) {
		
		this.request = arg0;
	}

	public Map<String, Object> getRequest() {
		return request;
	}

}
