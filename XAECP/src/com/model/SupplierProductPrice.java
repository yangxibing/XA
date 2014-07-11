package com.model;

public class SupplierProductPrice {

	private String  productId;
	private String numberInterval;
	private String startNumber;
	private String endNumber;
	public String getStartNumber() {
		return startNumber;
	}
	public void setStartNumber(String startNumber) {
		this.startNumber = startNumber;
	}
	public String getEndNumber() {
		return endNumber;
	}
	public void setEndNumber(String endNumber) {
		this.endNumber = endNumber;
	}
	private double price;
	private String remark;
	private String measureUnit;
	public String getMeasureUnit() {
		return measureUnit;
	}
	public void setMeasureUnit(String measureUnit) {
		this.measureUnit = measureUnit;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getNumberInterval() {
		return numberInterval;
	}
	public void setNumberInterval(String numberInterval) {
		this.numberInterval = numberInterval;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
