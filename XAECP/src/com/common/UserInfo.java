package com.common;

import java.util.List;

import com.model.Review;
import com.model.Topic;

public class UserInfo
{
	
	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	private List<Topic> topics;
	private List<Review> reviews;
	private String userName;
	private String topicPath;//路径
	private Topic topic;
	private String topicURL;
	private String path;//与头topics表中的topicpath是一个
	private String content;//对应FCKeidtor的编辑区的内容
	private String title;//发帖的标题
	private String searchText;
	private String searchBoolean;
	public String getSearchBoolean() {
		return searchBoolean;
	}

	public void setSearchBoolean(String searchBoolean) {
		this.searchBoolean = searchBoolean;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	
	public String getTopicURL() {
		return topicURL;
	}

	public void setTopicURL(String topicURL) {
		this.topicURL = topicURL;
	}

	public Topic getTopic(){
		return topic;
	}

	public void setTopic(Topic topic) {
		this.topic = topic;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getTopicPath() {
		return topicPath;
	}

	public void setTopicPath(String topicPath) {
		this.topicPath = topicPath;
	}

	
	public List<Topic> getTopics() {
		return topics;
	}

	public void setTopics(List<Topic> topics) {
		this.topics = topics;
	}
	
}
