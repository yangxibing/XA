package com.forum.dao;

import java.util.List;
import java.util.Map;

import com.common.UserInfo;
import com.model.Review;

public interface ReviewDAO {

	public void save(Review review);
	public List<Map<String,Object>> query(UserInfo userinfo);
	public int getMaxId();
	public List<Map<String,Object>> queryByTopicId(int in);
}
