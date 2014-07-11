package com.forum.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;

import com.common.UserInfo;
import com.forum.dao.TopicDAO;
import com.forum.dao.UserDAO;
import com.model.PageUtils;
import com.model.Topic;
import com.model.User;

public class TopicServiceImpl implements TopicService{

	private TopicDAO topicDao;
	private UserDAO userDao;
	
	public void addTopic(UserInfo userInfo,ServletContext servletContext) throws Exception {
		
		Topic topic=new Topic();
		User user=userDao.load("wang");
		topic.setUser(user);
		topic.setLastReplyTime(new Date());
		topic.setPostTopicTime(new Date());
		topic.setName(userInfo.getTitle());
		String randomStr=String.valueOf(new Random().nextInt(Integer.MAX_VALUE));
		topic.setTopicPath(randomStr);
		topicDao.save(topic);//±£¥Êtopic
		
		String filePath=servletContext.getRealPath("/content")+"/"+"wang"+"/"+randomStr;
		File dir=new File(filePath);
		if(!dir.exists())
			dir.mkdirs();
		filePath+="/"+"topic.txt";
		OutputStream os=new FileOutputStream(filePath);
		OutputStreamWriter osw=new OutputStreamWriter(os);
		osw.write(userInfo.getContent());
		osw.close();
		os.close();
	}
	public TopicDAO getTopicDao() {
		return topicDao;
	}
	public void setTopicDao(TopicDAO topicDao) {
		this.topicDao = topicDao;
	}
	
	
	public List<Topic> getTopics(PageUtils page,UserInfo userInfo) {
		List <Topic> topics=new ArrayList<Topic>();
		List<Map<String,Object>> map=topicDao.query(page,userInfo);//∑÷“≥≤È—Øtopic
		for(int i=0;i<map.size();i++){
			Topic topic=new Topic();
			topic.setName((String)map.get(i).get("name"));
			topic.setLastReplyTime((Date)map.get(i).get("lastReplyTime"));
			topic.setPostTopicTime((Date)map.get(i).get("postTopicTIme"));
			topic.setReplyCount((Integer)map.get(i).get("replyCount"));
			topic.setTopicPath((String)map.get(i).get("topicPath"));
			topic.setViewCount((Integer)map.get(i).get("viewCount"));
			topic.setUser(userDao.queryById((Integer)map.get(i).get("userId")));
			topics.add(topic);
		}
		return topics;
	}
	
	public int getTopicCount(UserInfo userInfo) {
		
		return this.topicDao.getTopicCount(userInfo);
	}
	public UserDAO getUserDao() {
		return userDao;
	}
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}
	
}
