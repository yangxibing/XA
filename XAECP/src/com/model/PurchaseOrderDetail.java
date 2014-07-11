package com.model;

public class PurchaseOrderDetail {

	private String purchaseOrderId;
	private String productId;
		private String productName;
	private Double price;
	private Double number;
	private String measureUnit ;
	private Double returnNumber;
	private Integer score;
	private Double allPrice;
	private String idName;
	
	public String getIdName() {
		return idName;
	}
	public void setIdName(String idName) {
		this.idName = idName;
	}
	public Double getAllPrice() {
		return allPrice;
	}
	public void setAllPrice(Double allPrice) {
		this.allPrice = allPrice;
	}
	public String getPurchaseOrderId() {
		return purchaseOrderId;
	}
	public void setPurchaseOrderId(String purchaseOrderId) {
		this.purchaseOrderId = purchaseOrderId;
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
	public Double getNumber() {
		return number;
	}
	public void setNumber(Double number) {
		this.number = number;
	}
	public String getMeasureUnit() {
		return measureUnit;
	}
	public void setMeasureUnit(String measureUnit) {
		this.measureUnit = measureUnit;
	}
	public Double getReturnNumber() {
		return returnNumber;
	}
	public void setReturnNumber(Double returnNumber) {
		this.returnNumber = returnNumber;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
}
