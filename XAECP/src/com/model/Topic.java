package com.model;

import java.util.Date;


public class Topic {

	private int id;
	private String name;
	private Date postTopicTime;
	private User user;
	private int viewCount;
	private int replyCount;
	private Date lastReplyTime;
	private int lastReplyUserId;
	private String topicPath;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getPostTopicTime() {
		return postTopicTime;
	}
	public void setPostTopicTime(Date postTopicTime) {
		this.postTopicTime = postTopicTime;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public Date getLastReplyTime() {
		return lastReplyTime;
	}
	public void setLastReplyTime(Date lastReplyTime) {
		this.lastReplyTime = lastReplyTime;
	}
	public int getLastReplyUserId() {
		return lastReplyUserId;
	}
	public void setLastReplyUserId(int lastReplyUserId) {
		this.lastReplyUserId = lastReplyUserId;
	}
	public String getTopicPath() {
		return topicPath;
	}
	public void setTopicPath(String topicPath) {
		this.topicPath = topicPath;
	}
}