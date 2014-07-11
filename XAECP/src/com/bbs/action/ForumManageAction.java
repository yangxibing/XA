package com.bbs.action;

import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.bbs.service.ForumManageService;
import com.model.BBSSubject;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class ForumManageAction extends ActionSupport implements ModelDriven<BBSSubject>,RequestAware, SessionAware{

	private BBSSubject bBSSubject = new BBSSubject();
	private Map<String,Object> request;
	private Map<String, Object> session;
	
	private String ajaxResultCode;
	
	private ForumManageService forumManageService;
	
	@JSON(serialize=false)
	public ForumManageService getForumManageService() {
		return forumManageService;
	}

	public void setForumManageService(ForumManageService forumManageService) {
		this.forumManageService = forumManageService;
	}

	@JSON(serialize=false)
	public BBSSubject getbBSSubject() {
		return bBSSubject;
	}

	public void setbBSSubject(BBSSubject bBSSubject) {
		this.bBSSubject = bBSSubject;
	}

	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}
	
	public void setRequest(Map<String, Object> request) {
		this.request = request;
	}

	public String publishForum() {
		String publishForumUser = (String) this.session.get("bbsUserId");
		this.bBSSubject.setSubjectCreator(publishForumUser);
		this.forumManageService.addBBSSubject(this.bBSSubject);
		ajaxResultCode = "success";
		return "publish";
	}

	@JSON(serialize=false)
	public BBSSubject getModel() {
		return bBSSubject;
	}

	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	@JSON(serialize=false)
	public Map<String, Object> getSession() {
		return session;
	}

	public String getAjaxResultCode() {
		return ajaxResultCode;
	}

	public void setAjaxResultCode(String ajaxResultCode) {
		this.ajaxResultCode = ajaxResultCode;
	}
}