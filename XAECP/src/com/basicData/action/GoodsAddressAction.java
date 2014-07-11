package com.basicData.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.basicData.service.GoodsAddressService;
import com.model.GoodsAddress;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class GoodsAddressAction extends ActionSupport implements ModelDriven<GoodsAddress>,RequestAware,SessionAware{

	private Map<String,Object> request;
	private Map<String,Object> session; 
	private GoodsAddress goodsAddress = new GoodsAddress();
	private GoodsAddressService goodsAddressService;
	private String addressList;
	private String addressInfo;
	
	private String userIdInSession;
	private String purchaserIdInSession;
	
	/**
	 * goodsAddressManage.action->this.goodsAddressManage()
	 * Get the current user's all goods address.
	 * 
	 * @return SUCCESS
	 */
	public String goodsAddressManage(){
		this.userIdInSession = (String) this.session.get("userId");
		List<GoodsAddress> list = this.goodsAddressService.queryGoodsAddress(this.userIdInSession, this.goodsAddress.getSendOrReceive());
		this.request.put("query", list);
		this.request.put("sendOrReceiveTag", this.goodsAddress.getSendOrReceive());
		return SUCCESS;
	}
	
	/**
	 * setDefaultAddress.action->this.setDefaultAddress()
	 * Set specified address as default address.
	 * 
	 * @return SUCCESS
	 */
	public String setDefaultAddress(){
		this.userIdInSession = (String) this.session.get("userId");
		goodsAddress.setUserId(userIdInSession);
		this.goodsAddressService.setDefaultAddress(goodsAddress);
		return SUCCESS;
	}
	
	/**
	 * deleteGoodsAddress.action->this.deleteGoodsAddress()
	 * Delete the selected goods address in addressList
	 * 
	 * @return SUCCESS
	 */
	public String deleteGoodsAddress(){
		this.goodsAddressService.deleteGoodsAddress(addressList);
		return SUCCESS;
	}
	
	/**
	 * getGoodsAddressById.action->this.getGoodsAddressById()
	 * Get goodsAddress specified by the id.
	 * 
	 * @return String : "ajaxAddress"
	 */
	public String getGoodsAddressById(){
		addressInfo="";
		this.goodsAddress = this.goodsAddressService.getGoodsAddressById(this.goodsAddress.getAddressId());
		if(goodsAddress == null) return "addressInfo";
		addressInfo += goodsAddress.getAddressId() + ","
				+ goodsAddress.getShippingAddress() + ","
				+ goodsAddress.getZipCode() + ","
				+ goodsAddress.getContacter() + ","
				+ goodsAddress.getTelephone() + ","
				+ goodsAddress.getDefaultOrNot();
		return "addressInfo";
	}
	
	/**
	 * addGoodsAddress.action->this.addGoodsAddress()
	 * Add new goods address into the database.
	 * 
	 * @return SUCCESS
	 */
	public String addGoodsAddress(){
		this.userIdInSession = (String) this.session.get("userId");
		this.goodsAddress.setUserId(userIdInSession);
		String str = this.goodsAddressService.addGoodsAddress(this.goodsAddress);
		this.goodsAddress.setAddressId(str);
		if(goodsAddress.getDefaultOrNot().equals("true")){
			this.goodsAddressService.setDefaultAddress(goodsAddress);
		}		
		return SUCCESS;
	}
	
	/**
	 * updateGoodsAddress.action->updateGoodsAddress()
	 * Update the goods address.
	 * 
	 * @return SUCCESS
	 */
	public String updateGoodsAddress(){
		this.userIdInSession = (String) this.session.get("userId");
		goodsAddress.setUserId(this.userIdInSession);
		this.goodsAddressService.updateGoodsAddress(goodsAddress);
		if(goodsAddress.getDefaultOrNot().equals("true")){
			this.goodsAddressService.setDefaultAddress(goodsAddress);
		}
		return SUCCESS;
	}
	
	@JSON(serialize=false)
	public GoodsAddress getModel() {
		return goodsAddress;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}

	@JSON(serialize=false)
	public GoodsAddress getGoodsAddress() {
		return goodsAddress;
	}

	public void setGoodsAddress(GoodsAddress goodsAddress) {
		this.goodsAddress = goodsAddress;
	}

	@JSON(serialize=false)
	public GoodsAddressService getGoodsAddressService() {
		return goodsAddressService;
	}

	public void setGoodsAddressService(GoodsAddressService goodsAddressService) {
		this.goodsAddressService = goodsAddressService;
	}

	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}

	public String getAddressList() {
		return addressList;
	}

	public void setAddressList(String addressList) {
		this.addressList = addressList;
	}

	public String getUserIdInSession() {
		return userIdInSession;
	}

	public void setUserIdInSession(String userIdInSession) {
		this.userIdInSession = userIdInSession;
	}

	public String getPurchaserIdInSession() {
		return purchaserIdInSession;
	}

	public void setPurchaserIdInSession(String purchaserIdInSession) {
		this.purchaserIdInSession = purchaserIdInSession;
	}

	public String getAddressInfo() {
		return addressInfo;
	}

	public void setAddressInfo(String addressInfo) {
		this.addressInfo = addressInfo;
	}

	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	@JSON(serialize=false)
	public Map<String, Object> getSession() {
		return session;
	}
}
