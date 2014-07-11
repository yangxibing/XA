package com.forum.dao;

import java.util.List;
import java.util.Map;

import com.common.UserInfo;
import com.model.PageUtils;
import com.model.Topic;

public interface TopicDAO {

	public void save(Topic topic);
	public List<Map<String,Object>> query(PageUtils page,UserInfo userInfo); 
	public void updateById(Topic topic);
	public void updateReplyTopic(Topic topic);
	public int getTopicCount(UserInfo userInfo);
}
