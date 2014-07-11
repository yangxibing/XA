package com.forum.action;

import com.common.UserInfo;
import com.forum.service.TopicService;
import com.opensymphony.xwork2.ModelDriven;

public class PostTopicAction extends BaseAction implements ModelDriven<UserInfo> {
	private TopicService topicService;
	
	public UserInfo getModel() {
		return userInfo;
	}

	public String execute()throws Exception{
		try{
			topicService.addTopic(userInfo,servletContext);
			return SUCCESS;
		}catch(Exception e){
			System.out.println("Ã·Ωª”–ŒÛ");
		}
		return "error";
	}
	
	public TopicService getTopicService() {
		return topicService;
	}

	public void setTopicService(TopicService topicService) {
		this.topicService = topicService;
	}
}
