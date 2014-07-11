package com.forum.action;

import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;

import com.common.UserInfo;
import com.opensymphony.xwork2.ModelDriven;

public class ShowTopicsPerPageAction extends BaseAction implements ModelDriven<UserInfo>,RequestAware{

	private Map<String,Object> request;
	public UserInfo getModel() {
		
		return userInfo;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request=arg0;
		
	}
	
	

}
