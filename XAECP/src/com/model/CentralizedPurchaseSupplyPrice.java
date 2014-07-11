package com.model;

public class CentralizedPurchaseSupplyPrice {

	private String CPIId;
	private String productId;
	private Double price;
	private String productName;
	private String measureUnit;
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getMeasureUnit() {
		return measureUnit;
	}
	public void setMeasureUnit(String measureUnit) {
		this.measureUnit = measureUnit;
	}
	public String getCPIId() {
		return CPIId;
	}
	public void setCPIId(String cPIId) {
		CPIId = cPIId;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	
}
