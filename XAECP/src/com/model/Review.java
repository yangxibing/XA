package com.model;

import java.util.Date;

public class Review {

	private int id;//回复id
	private int reviewUserId;//评论的用户ID
	private int topicId;//评论的帖子的ID
	private String reviewTime;//评论时间
	private User user;
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getReviewUserId() {
		return reviewUserId;
	}
	public void setReviewUserId(int reviewUserId) {
		this.reviewUserId = reviewUserId;
	}
	public int getTopicId() {
		return topicId;
	}
	public void setTopicId(int topicId) {
		this.topicId = topicId;
	}
	public String getReviewTime() {
		return reviewTime;
	}
	public void setReviewTime(String reviewTime) {
		this.reviewTime = reviewTime;
	}
}