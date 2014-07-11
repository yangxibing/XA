package com.forum.action;

import com.common.UserInfo;
import com.forum.service.ReviewService;
import com.opensymphony.xwork2.ModelDriven;

public class ViewTopicAction extends BaseAction implements ModelDriven<UserInfo>{

	private ReviewService reviewService;
	
	public UserInfo getModel() {
		return userInfo;
	}

	public String execute(){
		System.out.println("path: "+userInfo.getPath());
		reviewService.getReviews(userInfo,servletContext);
		com.common.WebEditor.createFCKEditor(request, "700", "350");
		return SUCCESS;
	}
	
	
	public ReviewService getReviewService() {
		return reviewService;
	}

	public void setReviewService(ReviewService reviewService) {
		this.reviewService = reviewService;
	}
}
