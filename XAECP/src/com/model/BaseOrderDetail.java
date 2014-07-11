package com.model;


public class BaseOrderDetail {
	private String baseOrderId;
	private String productId;
	private Double price;
	private Double number;
	private String measureUnit;
	private Double returnNumber;
	private String idName;
	private Double allPrice;
	private String productName;//Õı”¿øµ
	public String getIdName() {
		return idName;
	}
	public void setIdName(String idName) {
		this.idName = idName;
	}
	public String getBaseOrderId() {
		return baseOrderId;
	}
	public void setBaseOrderId(String baseOrderId) {
		this.baseOrderId = baseOrderId;
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
	public Double getAllPrice() {
		return allPrice;
	}
	public void setAllPrice(Double allPrice) {
		this.allPrice = allPrice;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	
}
