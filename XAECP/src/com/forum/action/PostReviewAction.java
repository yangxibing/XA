package com.forum.action;

import com.common.UserInfo;
import com.forum.service.ReviewService;
import com.opensymphony.xwork2.ModelDriven;

public class PostReviewAction extends BaseAction implements ModelDriven<UserInfo>{

	private ReviewService reviewService;
	public String execute()throws Exception{
		reviewService.addReview(userInfo, servletContext);
		return SUCCESS;
	}
	
	public UserInfo getModel() {
		
		return userInfo;
	}
	public ReviewService getReviewService() {
		return reviewService;
	}
	public void setReviewService(ReviewService reviewService) {
		this.reviewService = reviewService;
	}

	
}
