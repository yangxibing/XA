package com.forum.service;

import java.util.List;

import javax.servlet.ServletContext;

import com.common.UserInfo;
import com.model.PageUtils;
import com.model.Topic;

public interface TopicService {

	public void addTopic(UserInfo userInfo,ServletContext servletContext)throws Exception;
	public List<Topic> getTopics(PageUtils page,UserInfo userInfo);
	public int getTopicCount(UserInfo userInfo);
}
