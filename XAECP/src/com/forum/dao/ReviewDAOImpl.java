package com.forum.dao;

import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.common.UserInfo;
import com.model.Review;

public class ReviewDAOImpl extends SqlMapClientDaoSupport implements ReviewDAO{

	private UserDAO userDao;
	public void save(Review review) {
		this.getSqlMapClientTemplate().insert("review.insertReview",review);
	}

	public List<Map<String, Object>> query(UserInfo userInfo) {
		return this.getSqlMapClientTemplate().queryForList("topic.reviewTopic", userInfo);
	}
	
	public int getMaxId(){
		Object o= this.getSqlMapClientTemplate().queryForObject("review.selectMaxId");
		if(o==null)
			return 0;
		else
			return (Integer)o;
	}
	
	public List<Map<String,Object>> queryByTopicId(int in){
		
		return (List<Map<String,Object>>)this.getSqlMapClientTemplate().queryForList("review.queryByTopicId", in);
	}
}
