package com.orderManage.basePurchase.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.model.CentralizedPlanedPurchase;
import com.model.GoodsAddress;
import com.model.Supplier;
import com.model.SupplierProduct;
import com.opensymphony.xwork2.ActionSupport;
import com.orderManage.basePurchase.service.BaseOrderService;

public class AjaxDropDownListAction extends ActionSupport implements SessionAware {
	
	private Map<String, Object> session;
	private String supplierId;
	private BaseOrderService baseOrderServiceForBase;
	private List<Supplier> supplierIdNameList;
	private List<CentralizedPlanedPurchase> centralizedPurchaseIdList;
	private List<CentralizedPlanedPurchase> planedPurchaseIdList;
	private List<SupplierProduct> supplierProductList;
	private String userIdInSession;
	private String baseIdInSession;
	private List<GoodsAddress> baseReceiveAddressList;
 	
	public String getUserIdInSession() {
		return userIdInSession;
	}
	public void setUserIdInSession(String userIdInSession) {
		this.userIdInSession = userIdInSession;
	}
	public String getBaseIdInSession() {
		return baseIdInSession;
	}
	public void setBaseIdInSession(String baseIdInSession) {
		this.baseIdInSession = baseIdInSession;
	}
	public List<GoodsAddress> getBaseReceiveAddressList() {
		return baseReceiveAddressList;
	}
	public void setBaseReceiveAddressList(List<GoodsAddress> baseReceiveAddressList) {
		this.baseReceiveAddressList = baseReceiveAddressList;
	}
	public List<SupplierProduct> getSupplierProductList() {
		return supplierProductList;
	}
	public void setSupplierProductList(List<SupplierProduct> supplierProductList) {
		this.supplierProductList = supplierProductList;
	}
	public List<Supplier> getSupplierIdNameList() {
		return supplierIdNameList;
	}
	public void setSupplierIdNameList(List<Supplier> supplierIdNameList) {
		this.supplierIdNameList = supplierIdNameList;
	}
	

	public List<CentralizedPlanedPurchase> getCentralizedPurchaseIdList() {
		return centralizedPurchaseIdList;
	}
	public void setCentralizedPurchaseIdList(
			List<CentralizedPlanedPurchase> centralizedPurchaseIdList) {
		this.centralizedPurchaseIdList = centralizedPurchaseIdList;
	}
	

	public List<CentralizedPlanedPurchase> getPlanedPurchaseIdList() {
		return planedPurchaseIdList;
	}
	public void setPlanedPurchaseIdList(
			List<CentralizedPlanedPurchase> planedPurchaseIdList) {
		this.planedPurchaseIdList = planedPurchaseIdList;
	}
	
	@JSON(serialize = false)
	public BaseOrderService getBaseOrderServiceForBase() {
		return baseOrderServiceForBase;
	}
	public void setBaseOrderServiceForBase(BaseOrderService baseOrderService) {
		this.baseOrderServiceForBase = baseOrderService;
	}
	
	public String returnSupplierIdNameList() {
		supplierIdNameList = this.baseOrderServiceForBase.querySupplierList();
		return "supplierIdNameList";
	}
	
	public String returnCentralizedPurchaseIdList() {
		centralizedPurchaseIdList = this.baseOrderServiceForBase.queryCentralizedPurchaseList();
		return "centralizedPurchaseIdList";
	}
	
	public String returnPlanedPurchaseIdList() {
		planedPurchaseIdList = this.baseOrderServiceForBase.queryPlanedPurchaseList();
		return "planedPurchaseIdList";
	}
	
	public String returnSupplierProductList() {
		supplierProductList = this.baseOrderServiceForBase.querySupplierProductList(supplierId);
		return "supplierProductList";
	}
	
	/**
	 * 获取接收地址列表
	 * @return
	 */
	public String returnBaseReceiveAddressList() {
		GoodsAddress address = new GoodsAddress();
		this.userIdInSession = (String) this.session.get("userId");
		address.setUserId(userIdInSession);
		address.setSendOrReceive(true);
		baseReceiveAddressList = this.baseOrderServiceForBase.queryGoodsAddressList(address);
		return "baseReceiveAddressList";
	}
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;		
	}
	
	@JSON(serialize = false)	
	public Map<String, Object> getSession() {
		return session;
	}
	public String getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}
}
