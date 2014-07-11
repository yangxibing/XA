package com.centralizedPurchase.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.centralizedPurchase.service.PurchaseOrderService;
import com.model.CentralizedPlanedPurchase;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.PurchaseOrderDetail;
import com.model.Supplier;
import com.model.SupplierProduct;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class PurchaseOrderAction extends ActionSupport implements ModelDriven<PurchaseOrder>,RequestAware,SessionAware{

	private Map<String,Object> request;
	private Map<String,Object> session;
	private PurchaseOrderService purchaseOrderService;
	private PurchaseOrder purchaseOrder = new PurchaseOrder();
	private String purchaseOrderList;
	private String purchaseOrderDetailList;
	private String rejectList;
	private String purchaseOrderDetailOriginalList;
	private String newInfo;
	private String editInfo;
	private String detailInfo;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	private String productId;
	private Integer score;
	
	private String userIdInSession;
	private String purchaserIdInSession;
	
	/**
	 *queryPurchaseOrderList.action->this.queryPurchaseOrderList().
	 *Get the PurchaseOrder List with parameter specified in purchaseOrder.  
	 *
	 * @return SUCCESS
	 */
	public String queryPurchaseOrderList(){
		this.purchaserIdInSession = (String) this.session.get("partnerId");
		this.purchaseOrder.setPurchaserId(this.purchaserIdInSession);
		
		Integer totalCount = this.purchaseOrderService.purchaseOrderTotalCount(purchaseOrder);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<PurchaseOrder> list = this.purchaseOrderService.queryPurchaseOrderList(purchaseOrder, page);
		this.request.put("query", list);
		this.request.put("purchaseOrder", purchaseOrder);
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);
		return SUCCESS;
 	}
	
	/**
	 * deletePurchaseOrder.action->this.deletePurchaseOrder()
	 * Delete not_submitted purchaseOrder according to purchaseOrderList
	 * 		which contain a list of purchase order id.
	 * 
	 * @return SUCCESS
	 */
	public String deletePurchaseOrder(){
		this.purchaseOrderService.deletePurchaseOrder(purchaseOrderList);
		return SUCCESS;
	}
	
	/**
	 * queryNewInfo.action->this.queryNewInfo()
	 * Get necessary information when new a purchase order, 
	 * including: the product list, the current purchaser, the address list
	 * 
	 * @return String
	 */
	public String queryNewInfo(){
		newInfo = "";
		GoodsAddress address = new GoodsAddress();
		this.userIdInSession = (String) this.session.get("userId");
		this.purchaserIdInSession = (String) this.session.get("partnerId");
		address.setUserId(userIdInSession);
		address.setSendOrReceive(false);
		newInfo += this.purchaseOrderService.getProductInfo() + ";"
				  		+ this.purchaseOrderService.getPurchaserInfo(purchaserIdInSession) + ";"
				  		+ this.purchaseOrderService.getAddressInfo(address);
		return "newInfo";
	}
	
	/**
	 * queryEditInfo.action->this.queryEditInfo()
	 * Get necessary information when edit a purchase order, 
	 * including: the product list, the current purchaser, the address list, 
	 * the purchase order and the purchase order detail.
	 * 
	 * @return String
	 */
	public String queryEditInfo(){
		editInfo = "";
		GoodsAddress address = new GoodsAddress();
		this.userIdInSession = (String) this.session.get("userId");
		this.purchaserIdInSession = (String) this.session.get("partnerId");
		address.setUserId(userIdInSession);
		address.setSendOrReceive(false);
		editInfo += this.purchaseOrderService.getProductInfo() + ";"
				  		+ this.purchaseOrderService.getPurchaserInfo(purchaserIdInSession) + ";"
				  		+ this.purchaseOrderService.getAddressInfo(address) + ";"
				  		+ this.purchaseOrderService.getPurchaseOrderInfo(this.purchaseOrder.getPurchaseOrderId()) + ";"
				  		+ this.purchaseOrderService.getPurchaseOrderDetailInfo(this.purchaseOrder.getPurchaseOrderId());
		return "editInfo";
	}
	
	/**
	 * queryDetailInfo.action->this.queryDetailInfo()
	 * Get necessary information when show a purchase order, 
	 * including: the current purchaser, the address list, 
	 * the purchase order and the purchase order detail.
	 * 
	 * @return String
	 */
	public String queryDetailInfo(){
		detailInfo = "";
		this.purchaserIdInSession = (String) this.session.get("partnerId");
		String purchaserInfo = this.purchaseOrderService.getPurchaserInfo(purchaserIdInSession);
		String purchaseOrderInfo = this.purchaseOrderService.getPurchaseOrderInfo(this.purchaseOrder.getPurchaseOrderId());
		String purchaseOrderDetailInfo = this.purchaseOrderService.getPurchaseOrderDetailInfo(this.purchaseOrder.getPurchaseOrderId());
		String goodsAddressInfo = this.purchaseOrderService.getGoodsAddressInfoById(purchaseOrderInfo.split(" ")[4]);
		detailInfo += purchaserInfo + ";" + purchaseOrderInfo + ";"
			+ purchaseOrderDetailInfo + ";" + goodsAddressInfo;
		return "detailInfo";
	}
	
	public String addPurchaseOrder(){
		this.purchaserIdInSession = (String) this.session.get("partnerId");
		this.purchaseOrder.setPurchaserId(this.purchaserIdInSession);
		String pk = this.purchaseOrderService.addPurchaseOrder(purchaseOrder);
		this.purchaseOrderService.addPurchaseOrderDetail(purchaseOrderDetailList, pk);
		return SUCCESS;
	}
	
	public String updatePurchaseOrder(){
		this.purchaserIdInSession = (String) this.session.get("partnerId");
		this.purchaseOrder.setPurchaserId(this.purchaserIdInSession);
		this.purchaseOrderService.updatePurchaseOrder(purchaseOrder);
		this.purchaseOrderService.updatePurchaseOrderDetail(purchaseOrderDetailList, purchaseOrderDetailOriginalList, 
				this.purchaseOrder.getPurchaseOrderId());
		return SUCCESS;
	}
	
	/**
	 * cancelPurchaseOrder.action->this.cancelPurchaseOrder()
	 * Canceling a purchase order means changing its orderState. 
	 * 
	 * @return SUCCESS
	 */
	public String cancelPurchaseOrder(){
		this.purchaseOrderService.cancelPurchaseOrder(this.purchaseOrder.getPurchaseOrderId());
		return SUCCESS;
	}
	
	/**
	 * comfirmReceiveGoods.action->this.comfirmReceiveGoods()
	 * Purchaser comfirm receive goods and update the database.
	 * 
	 * @return SUCCESS
	 */
	public String comfirmReceiveGoods(){
		List<PurchaseOrderDetail> list = this.purchaseOrderService.queryPurchaseOrderDetail(this.purchaseOrder.getPurchaseOrderId());
		this.request.put("query", list);
		this.request.put("purchaseOrderId", purchaseOrder.getPurchaseOrderId());
		return SUCCESS;
	}
	public String comfirmReceiveGoodsUpdate(){
		this.purchaseOrderService.comfirmReceiveGoodsUpdate(this.purchaseOrder.getPurchaseOrderId());
		return SUCCESS;
	}
	
	public String payForDeposit(){
		List<PurchaseOrderDetail> list = this.purchaseOrderService.queryPurchaseOrderDetail(this.purchaseOrder.getPurchaseOrderId());
		this.request.put("query", list);
		this.purchaseOrder = this.purchaseOrderService.getPurchaseOrderMoreById(this.purchaseOrder.getPurchaseOrderId());
		this.request.put("purchaseOrder", purchaseOrder);
		return SUCCESS;
	}
	
	public String payForDepositUpdate(){
		/*
		 * 需要调用第三方支付接口支付定金
		 */
		this.purchaseOrder = this.purchaseOrderService.getPurchaseOrderMoreById(this.purchaseOrder.getPurchaseOrderId());
		Double deposit = this.purchaseOrder.getTotalPrice()*this.purchaseOrder.getOrderRate();
		this.purchaseOrder.setDeposit(deposit);
		this.purchaseOrderService.payForDepositUpdate(this.purchaseOrder);
		return SUCCESS;
	}
	
	public String payForGoods(){
		List<PurchaseOrderDetail> list = this.purchaseOrderService.queryPurchaseOrderDetail(this.purchaseOrder.getPurchaseOrderId());
		this.request.put("query", list);
		this.purchaseOrder = this.purchaseOrderService.getPurchaseOrderById(this.purchaseOrder.getPurchaseOrderId());
		this.request.put("purchaseOrder", purchaseOrder);
		return SUCCESS;
	}
	
	public String payForGoodsUpdate(){
		/*
		 * 需要调用第三方支付接口支付货款
		 */
		this.purchaseOrder = this.purchaseOrderService.getPurchaseOrderById(this.purchaseOrder.getPurchaseOrderId());
		Double remainPayment = this.purchaseOrder.getTotalPrice();
		if(this.purchaseOrder.getDeposit() != null){
			remainPayment = remainPayment - this.purchaseOrder.getDeposit();
		}		
		this.purchaseOrderService.payForGoodsUpdate(this.purchaseOrder.getPurchaseOrderId());
		
		if(this.purchaseOrder.getCPIId()!= null && this.purchaseOrder.getCPIId().trim().length()!=0){
			if(this.purchaseOrderService.countNonEndCentralizedPurchase(this.purchaseOrder.getCPIId())<=0){
				CentralizedPlanedPurchase purchase = new CentralizedPlanedPurchase();
				purchase.setCpPurchaseInfoId(this.purchaseOrder.getCPIId());
				purchase.setCentralizedPurchaseState(new Short("6"));
				this.purchaseOrderService.updateCentralizedPurchaseStateToEnd(purchase);
			}
		}
		
		return SUCCESS;
	}
	
	public String evaluateForProduct(){
		List<PurchaseOrderDetail> list = this.purchaseOrderService.queryPurchaseOrderDetail(this.purchaseOrder.getPurchaseOrderId());
		this.request.put("query", list);
		this.request.put("purchaseOrderId", this.purchaseOrder.getPurchaseOrderId());
		
		return SUCCESS;
	}
	
	public String evaluateForProductUpdate(){
		PurchaseOrderDetail detail = new PurchaseOrderDetail();
		detail.setPurchaseOrderId(this.purchaseOrder.getPurchaseOrderId());
		detail.setProductId(productId);
		detail.setScore(score);
		this.purchaseOrderService.evaluateForProductUpdate(detail);
		
		SupplierProduct product = this.purchaseOrderService.getSupplierProductByProductId(productId);
		if(product.getSupplierId() != null && product.getSupplierId().trim().length() != 0){
			Supplier supplier = new Supplier();
			supplier.setPartnerId(product.getSupplierId());
			supplier.setIntegrityLevel(score);
			this.purchaseOrderService.updateSupplierIntegrityLevel(supplier);		
		}
		return SUCCESS;
	}
	
	/**
	 * purchaseRejectedMag.action->this.purchaseRejectedMag()
	 * When user click to rejected goods, here to get purchase order detail.
	 * 
	 * @return SUCCESS
	 */
	public String purchaseRejectedMag(){
		List<PurchaseOrderDetail> list = this.purchaseOrderService.queryPurchaseOrderDetail(this.purchaseOrder.getPurchaseOrderId());
		this.request.put("query", list);
		this.request.put("purchaseOrderId", this.purchaseOrder.getPurchaseOrderId());
		return SUCCESS;
	}
	
	public String purchaseRejectedInfo(){
		List<PurchaseOrderDetail> list = this.purchaseOrderService.queryPurchaseOrderDetail(this.purchaseOrder.getPurchaseOrderId());
		this.request.put("query", list);
		this.purchaseOrder = this.purchaseOrderService.getPurchaseOrderById(this.purchaseOrder.getPurchaseOrderId());
		this.request.put("purchaseOrderId", this.purchaseOrder.getPurchaseOrderId());
		this.request.put("actualRefund", this.purchaseOrder.getActualRefund());
		return SUCCESS;
	}
	
	/**
	 * logisticsInformation.action->this.logisticsInformation()
	 * Look up logistics information of the specified purchase order.
	 * 
	 * @return SUCCESS
	 */
	public String logisticsInformation(){
		this.purchaseOrder = this.purchaseOrderService.logisticsInformation(this.purchaseOrder.getPurchaseOrderId());
		this.request.put("purchaseOrder", purchaseOrder);
		return SUCCESS;
	}
	
	/**
	 * Goods Address manage: get the current user's goods address
	 * 
	 * @return SUCCESS
	 */
	public String goodsAddressManage(){
		this.userIdInSession = (String) this.session.get("userId");
		List<GoodsAddress> list = this.purchaseOrderService.queryGoodsAddress(this.userIdInSession);
		this.request.put("query", list);
		return SUCCESS;
	}
	
	/**
	 * The current user confirmed the reject and the action update the database here.
	 * 
	 * @return SUCCESS
	 */
	public String purchaserConfirmRejected(){
		this.purchaseOrderService.updateRejectedPurchaseOrder(this.purchaseOrder);
		this.purchaseOrderService.updateRejectedPurchaseOrderDetail(this.purchaseOrder.getPurchaseOrderId(), this.rejectList);
		
		List<PurchaseOrderDetail> list = this.purchaseOrderService.queryPurchaseOrderDetail(this.purchaseOrder.getPurchaseOrderId());
		this.request.put("query", list);
		this.request.put("purchaseOrderId", this.purchaseOrder.getPurchaseOrderId());
		this.request.put("actualRefund", this.purchaseOrder.getActualRefund());
		return SUCCESS;
	}
	
	@JSON(serialize=false)
	public PurchaseOrder getModel() {
		return this.purchaseOrder;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}
	
	@JSON(serialize=false)
	public PurchaseOrderService getPurchaseOrderService() {
		return purchaseOrderService;
	}

	public void setPurchaseOrderService(PurchaseOrderService purchaseOrderService) {
		this.purchaseOrderService = purchaseOrderService;
	}

	@JSON(serialize=false)
	public PurchaseOrder getPurchaseOrder() {
		return purchaseOrder;
	}

	public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
		this.purchaseOrder = purchaseOrder;
	}

	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}

	public String getPurchaseOrderList() {
		return purchaseOrderList;
	}

	public void setPurchaseOrderList(String purchaseOrderList) {
		this.purchaseOrderList = purchaseOrderList;
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

	public String getNewInfo() {
		return newInfo;
	}

	public void setNewInfo(String newInfo) {
		this.newInfo = newInfo;
	}

	public String getEditInfo() {
		return editInfo;
	}

	public void setEditInfo(String editInfo) {
		this.editInfo = editInfo;
	}

	public String getPurchaseOrderDetailList() {
		return purchaseOrderDetailList;
	}

	public void setPurchaseOrderDetailList(String purchaseOrderDetailList) {
		this.purchaseOrderDetailList = purchaseOrderDetailList;
	}

	public String getPurchaseOrderDetailOriginalList() {
		return purchaseOrderDetailOriginalList;
	}

	public void setPurchaseOrderDetailOriginalList(
			String purchaseOrderDetailOriginalList) {
		this.purchaseOrderDetailOriginalList = purchaseOrderDetailOriginalList;
	}

	public String getDetailInfo() {
		return detailInfo;
	}

	public void setDetailInfo(String detailInfo) {
		this.detailInfo = detailInfo;
	}

	public String getRejectList() {
		return rejectList;
	}

	public void setRejectList(String rejectList) {
		this.rejectList = rejectList;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	@JSON(serialize=false)
	public Map<String, Object> getSession() {
		return session;
	}

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
}
