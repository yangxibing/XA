package com.forum.service;

import javax.servlet.ServletContext;

import com.common.UserInfo;

public interface ReviewService {

	public void getReviews(UserInfo userInfo,ServletContext servletContext);
	public void addReview(UserInfo userInfo,ServletContext servletContext)throws Exception;
}
