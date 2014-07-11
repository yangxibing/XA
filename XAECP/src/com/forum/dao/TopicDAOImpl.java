package com.forum.dao;

import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.common.UserInfo;
import com.model.PageUtils;
import com.model.Topic;

public class TopicDAOImpl extends SqlMapClientDaoSupport implements TopicDAO{

	public void save(Topic topic) {
		this.getSqlMapClientTemplate().insert("topic.insertTopic", topic);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> query(PageUtils page,UserInfo userInfo) {
		page.setSearchText(userInfo.getSearchText());
		return (List<Map<String,Object>>)this.getSqlMapClientTemplate().queryForPaginatedList("topic.query_topics",page,4);
	}
	public void updateById(Topic topic) {
		
		this.getSqlMapClientTemplate().update("topic.updateTopicById", topic);
	}
	public void updateReplyTopic(Topic topic) {
		
		this.getSqlMapClientTemplate().update("topic.updateReplyTopic", topic);
	}

	public int getTopicCount(UserInfo userInfo){
		System.out.println("searchText: "+userInfo.getSearchText());
		int in= (Integer)this.getSqlMapClientTemplate().queryForObject("topic.topicCount",userInfo);
		System.out.println("in: "+in);
		return in;
	}
}
