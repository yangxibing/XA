package com.forum.action;

import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;

import com.common.UserInfo;
import com.forum.service.TopicService;
import com.model.PageUtils;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("serial")
public class MainAction extends BaseAction implements ModelDriven<UserInfo>,RequestAware{

	private TopicService topicService;
	private Map<String,Object> request;
	private String currentPage="0";
	
	public String execute()throws Exception{
		System.out.println("searchText: "+userInfo.getSearchText());
		ActionContext.getContext().getSession().put("searchT", userInfo.getSearchText());
		System.out.println("topicCount: "+this.topicService.getTopicCount(userInfo));
		System.out.println("currentPage: "+currentPage);
		System.out.println("session: "+ActionContext.getContext().getSession().get("searchT"));
		PageUtils pageUtils =new PageUtils(this.topicService.getTopicCount(userInfo),Integer.parseInt(currentPage),4);
		userInfo.setTopics(topicService.getTopics(pageUtils,userInfo));
		request.put("pu", pageUtils);
		return SUCCESS;
	}
	
	public TopicService getTopicService() {
		return topicService;
	}
	public void setTopicService(TopicService topicService) {
		this.topicService = topicService;
	}
	public UserInfo getModel() {
		// TODO Auto-generated method stub
		return userInfo;
	}
	public void setRequest(Map<String, Object> arg0) {
		this.request=arg0;
	}
	
	public String getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(String currentPage) {
		if(currentPage.equals(""))
			currentPage="0";
		this.currentPage=currentPage;
	}
}
