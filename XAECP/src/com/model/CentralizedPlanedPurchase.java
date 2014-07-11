package com.model;

import java.util.Date;

public class CentralizedPlanedPurchase {
	private String cpPurchaseInfoId;
	private String cpPurchaseInfoTitle;
	private String productTypeId;
		private String productTypeName;
	private String purchasePriceInterval;
	private String publishDate;
	private String publisher;
		private String publisherName;
	private String deadline;
		private Date deadlineDate;
	private String telephone;
	private String briefExplain;
	private Short centralizedPurchaseState;
		private String centralizedPurchaseStateName;
	private String measureUnit;
	private Integer combinePlanedNum;
	private Boolean isEnterOrderProcess;
	private Boolean centraOrplaned;
	
	private String purchasePriceBegin;
	private String purchasePriceEnd;
	private String purchasePriceUnit;
	private Short applyAvailable;   //0=可申请，1=已过期，2=不是“信息已发布”状态
	private Double demandNumber;    //为申请集中采购而设置，存储采购商提交的数量
	/**
	 * c2.demandNumber demandNumber,
	   c2.reportDemandTime reportDemandTime,
	   c2.demandState demandState
	 * 
	 * */
	//王永康start
	private String reportDemandTime;//需求申报时间
	private String demandState;//需求状态
	private String demandStateName;
	//王永康end
	public String getDemandStateName() {
		return demandStateName;
	}
	public void setDemandStateName(String demandStateName) {
		this.demandStateName = demandStateName;
	}
	public String getReportDemandTime() {
		return reportDemandTime;
	}
	public void setReportDemandTime(String reportDemandTime) {
		this.reportDemandTime = reportDemandTime;
	}
	public String getDemandState() {
		return demandState;
	}
	public void setDemandState(String demandState) {
		this.demandState = demandState;
	}
	public String getCpPurchaseInfoId() {
		return cpPurchaseInfoId;
	}
	public void setCpPurchaseInfoId(String cpPurchaseInfoId) {
		this.cpPurchaseInfoId = cpPurchaseInfoId;
	}
	public String getCpPurchaseInfoTitle() {
		return cpPurchaseInfoTitle;
	}
	public void setCpPurchaseInfoTitle(String cpPurchaseInfoTitle) {
		this.cpPurchaseInfoTitle = cpPurchaseInfoTitle;
	}
	public String getProductTypeId() {
		return productTypeId;
	}
	public void setProductTypeId(String productTypeId) {
		this.productTypeId = productTypeId;
	}
	public String getProductTypeName() {
		return productTypeName;
	}
	public void setProductTypeName(String productTypeName) {
		this.productTypeName = productTypeName;
	}
	public String getPurchasePriceInterval() {
		return purchasePriceInterval;
	}
	public void setPurchasePriceInterval(String purchasePriceInterval) {
		this.purchasePriceInterval = purchasePriceInterval;
	}
	public String getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getBriefExplain() {
		return briefExplain;
	}
	public void setBriefExplain(String briefExplain) {
		this.briefExplain = briefExplain;
	}
	public Short getCentralizedPurchaseState() {
		return centralizedPurchaseState;
	}
	public void setCentralizedPurchaseState(Short centralizedPurchaseState) {
		this.centralizedPurchaseState = centralizedPurchaseState;
	}
	public String getMeasureUnit() {
		return measureUnit;
	}
	public void setMeasureUnit(String measureUnit) {
		this.measureUnit = measureUnit;
	}
	public Integer getCombinePlanedNum() {
		return combinePlanedNum;
	}
	public void setCombinePlanedNum(Integer combinePlanedNum) {
		this.combinePlanedNum = combinePlanedNum;
	}
	public Boolean getIsEnterOrderProcess() {
		return isEnterOrderProcess;
	}
	public void setIsEnterOrderProcess(Boolean isEnterOrderProcess) {
		this.isEnterOrderProcess = isEnterOrderProcess;
	}
	public Boolean getCentraOrplaned() {
		return centraOrplaned;
	}
	public void setCentraOrplaned(Boolean centraOrplaned) {
		this.centraOrplaned = centraOrplaned;
	}
	public String getPurchasePriceBegin() {
		return purchasePriceBegin;
	}
	public void setPurchasePriceBegin(String purchasePriceBegin) {
		this.purchasePriceBegin = purchasePriceBegin;
	}
	public String getPurchasePriceEnd() {
		return purchasePriceEnd;
	}
	public void setPurchasePriceEnd(String purchasePriceEnd) {
		this.purchasePriceEnd = purchasePriceEnd;
	}
	public String getPurchasePriceUnit() {
		return purchasePriceUnit;
	}
	public void setPurchasePriceUnit(String purchasePriceUnit) {
		this.purchasePriceUnit = purchasePriceUnit;
	}
	public Short getApplyAvailable() {
		return applyAvailable;
	}
	public void setApplyAvailable(Short applyAvailable) {
		this.applyAvailable = applyAvailable;
	}
	public String getPublisherName() {
		return publisherName;
	}
	public void setPublisherName(String publisherName) {
		this.publisherName = publisherName;
	}
	public Double getDemandNumber() {
		return demandNumber;
	}
	public void setDemandNumber(Double demandNumber) {
		this.demandNumber = demandNumber;
	}
	public String getCentralizedPurchaseStateName() {
		return centralizedPurchaseStateName;
	}
	public void setCentralizedPurchaseStateName(String centralizedPurchaseStateName) {
		this.centralizedPurchaseStateName = centralizedPurchaseStateName;
	}
	public Date getDeadlineDate() {
		return deadlineDate;
	}
	public void setDeadlineDate(Date deadlineDate) {
		this.deadlineDate = deadlineDate;
	}

	
}
