package com.model;

public class AnswerPrice {
	private String answerPriceId;
	private String askPriceId;
	private String productId;
	private String productName;
	private String supplierId;
	private double price;
	private String remark;
	private boolean isAnswer;
	private boolean isSelected;	
	
	public boolean getIsAnswer() {
		return isAnswer;
	}
	public void setIsAnswer(boolean isAnswer) {
		this.isAnswer = isAnswer;
	}
	public boolean getIsSelected() {
		return isSelected;
	}
	public void setIsSelected(boolean isSelect) {
		this.isSelected = isSelect;
	}
	public String getAnswerPriceId() {
		return answerPriceId;
	}
	public void setAnswerPriceId(String answerPriceId) {
		this.answerPriceId = answerPriceId;
	}
	public String getAskPriceId() {
		return askPriceId;
	}
	public void setAskPriceId(String askPriceId) {
		this.askPriceId = askPriceId;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
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
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
}
