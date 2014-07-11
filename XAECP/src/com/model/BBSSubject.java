package com.model;

public class BBSSubject {
	
	private String subjectId;
	private String subjectTitle;
	private String subjectContent;
	private Boolean recommendOrNot = false;
	private Integer responseNumber;
	private Integer readNumber;
	private String lastResponserId;
	private String lastResponseTime;
	private String subjectCreator;
	private String subjectCreatTime;
	
	public String getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(String subjectId) {
		this.subjectId = subjectId;
	}
	public String getSubjectTitle() {
		return subjectTitle;
	}
	public void setSubjectTitle(String subjectTitle) {
		this.subjectTitle = subjectTitle;
	}
	public String getSubjectContent() {
		return subjectContent;
	}
	public void setSubjectContent(String subjectContent) {
		this.subjectContent = subjectContent;
	}
	public Boolean getRecommendOrNot() {
		return recommendOrNot;
	}
	public void setRecommendOrNot(Boolean recommendOrNot) {
		this.recommendOrNot = recommendOrNot;
	}
	public Integer getResponseNumber() {
		return responseNumber;
	}
	public void setResponseNumber(Integer responseNumber) {
		this.responseNumber = responseNumber;
	}
	public Integer getReadNumber() {
		return readNumber;
	}
	public void setReadNumber(Integer readNumber) {
		this.readNumber = readNumber;
	}
	public String getLastResponserId() {
		return lastResponserId;
	}
	public void setLastResponserId(String lastResponserId) {
		this.lastResponserId = lastResponserId;
	}
	public String getLastResponseTime() {
		return lastResponseTime;
	}
	public void setLastResponseTime(String lastResponseTime) {
		this.lastResponseTime = lastResponseTime;
	}
	public String getSubjectCreator() {
		return subjectCreator;
	}
	public void setSubjectCreator(String subjectCreator) {
		this.subjectCreator = subjectCreator;
	}
	public String getSubjectCreatTime() {
		return subjectCreatTime;
	}
	public void setSubjectCreatTime(String subjectCreatTime) {
		this.subjectCreatTime = subjectCreatTime;
	}
}
