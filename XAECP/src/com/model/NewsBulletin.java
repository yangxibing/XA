package com.model;

public class NewsBulletin {

	private String id;
	private Short publishType;
	private String title;
	private String publishContent;
	private Integer visitNumber;
	private String publisher;
		private String publisherName;
	private String publishDate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Short getPublishType() {
		return publishType;
	}
	public void setPublishType(Short publishType) {
		this.publishType = publishType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPublishContent() {
		return publishContent;
	}
	public void setPublishContent(String publishContent) {
		this.publishContent = publishContent;
	}
	public Integer getVisitNumber() {
		return visitNumber;
	}
	public void setVisitNumber(Integer visitNumber) {
		this.visitNumber = visitNumber;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getPublisherName() {
		return publisherName;
	}
	public void setPublisherName(String publisherName) {
		this.publisherName = publisherName;
	}
	public String getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}	
}
