package com.model;

public class CentralizedPurchaseDemand {
	
	private String CPIId;
	private String purchaserId;
	private String purchaserName;
	private Double demandNumber;
	private Short demandState;
		private Short originalState;
	private String reportDemandTime;
	
	private String measureUnit;
	
	public String getCPIId() {
		return CPIId;
	}
	public void setCPIId(String cPIId) {
		CPIId = cPIId;
	}
	public String getPurchaserId() {
		return purchaserId;
	}
	public void setPurchaserId(String purchaserId) {
		this.purchaserId = purchaserId;
	}
	public Double getDemandNumber() {
		return demandNumber;
	}
	public void setDemandNumber(Double demandNumber) {
		this.demandNumber = demandNumber;
	}
	public Short getDemandState() {
		return demandState;
	}
	public void setDemandState(Short demandState) {
		this.demandState = demandState;
	}
	public String getReportDemandTime() {
		return reportDemandTime;
	}
	public void setReportDemandTime(String reportDemandTime) {
		this.reportDemandTime = reportDemandTime;
	}
	public String getPurchaserName() {
		return purchaserName;
	}
	public void setPurchaserName(String purchaserName) {
		this.purchaserName = purchaserName;
	}
	public String getMeasureUnit() {
		return measureUnit;
	}
	public void setMeasureUnit(String measureUnit) {
		this.measureUnit = measureUnit;
	}
	public Short getOriginalState() {
		return originalState;
	}
	public void setOriginalState(Short originalState) {
		this.originalState = originalState;
	}
}
