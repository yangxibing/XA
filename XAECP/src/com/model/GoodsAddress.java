package com.model;

public class GoodsAddress {

	private String userId;
	private String addressId;
	private String sendAddress;
	private String zipCode;
	private String userName;
	private String telephone;
	private String contacter;
	private String defaultOrNot;
	private Boolean sendOrReceive;
	private String shippingAddress;
	
	public String getContacter() {
		return contacter;
	}
	public String getAddressId() {
		return addressId;
	}
	public void setAddressId(String addressId) {
		this.addressId = addressId;
	}
	public void setContacter(String contacter) {
		this.contacter = contacter;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSendAddress() {
		return sendAddress;
	}
	public void setSendAddress(String sendAddress) {
		this.sendAddress = sendAddress;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getDefaultOrNot() {
		return defaultOrNot;
	}
	public void setDefaultOrNot(String defaultOrNot) {
		this.defaultOrNot = defaultOrNot;
	}
	public Boolean getSendOrReceive() {
		return sendOrReceive;
	}
	public void setSendOrReceive(Boolean sendOrReceive) {
		this.sendOrReceive = sendOrReceive;
	}
	public String getShippingAddress() {
		return shippingAddress;
	}
	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}
	
}
