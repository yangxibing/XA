package com.centralizedPurchase.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.centralizedPurchase.service.CentralizedPlanedPurchaseService;
import com.centralizedPurchase.service.PurchaseOrderDetailService;
import com.centralizedPurchase.service.SellOrderManageService;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.PurchaseOrderDetail;
import com.model.Supplier;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class SellOrderManageAction extends ActionSupport implements ModelDriven<PurchaseOrder>,RequestAware,SessionAware{

	public PurchaseOrder purchaseOrder=new PurchaseOrder();
	private Map<String,Object> request;
	private SellOrderManageService sellOrderManageService;
	private PurchaseOrderDetailService purchaseOrderDetailService;
	private CentralizedPlanedPurchaseService centralizedPlanedPurchaseService;
	private String purOId;
	private Map<String, Object> session;
	private String userId="";//临时作为登陆的用户ID
	private String purchaserId="";
	private String addresses;
	private List<Supplier> purchasers;
	private String products;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	public String listOrders(){
		
		Integer totalCount = this.sellOrderManageService.baseSellOrderTotalCount(purchaseOrder);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<PurchaseOrder> purchaseOrders=this.sellOrderManageService.listOrders(purchaseOrder, page);
		request.put("query", purchaseOrders);
		return SUCCESS;
	}
	
	public String saveOrder(){
		purchaseOrder.setPurchaseOrderId(purOId);
		this.sellOrderManageService.saveOrder(purchaseOrder);
		return SUCCESS;
	}
	
	public String assureDelivery(){
		
		this.sellOrderManageService.assureDelivery(purchaseOrder.getPurchaseOrderId());
		return SUCCESS;
	}
	
	public String assureForm(){
		if(this.session.get("userId")!=null){
			userId = (String) this.session.get("userId");
		}
		purchaseOrder=this.sellOrderManageService.getPurchaseOrderById(purOId);
		List<PurchaseOrderDetail> productList=this.purchaseOrderDetailService.selectProduct(purOId);
		List<Supplier> logistics=this.sellOrderManageService.selectLogistics();
		List<GoodsAddress> goodsAddress=this.sellOrderManageService.sendGoodsAddress(userId,1);
		request.put("logistics", logistics);
		request.put("list", productList);
		request.put("goodsAddress", goodsAddress);
		return SUCCESS;
	}
	
	public String defaultAddress(){
	
		this.sellOrderManageService.defaultAddress(addresses);
		return SUCCESS;
	}
	
	public String assureSendGoods(){
		this.sellOrderManageService.updateProduct(products,"发货");
		this.sellOrderManageService.assureSendGoods(purchaseOrder);
		return SUCCESS;
	}
	
	public String getAllPurchasers(){
		purchasers=this.sellOrderManageService.getAllPurchasers();
		return "purchasers";
	}

	public String assuerGetGoods(){
		this.sellOrderManageService.updateProduct(products,"收到退货");
		this.sellOrderManageService.assuerGetGoods(purchaseOrder.getPurchaseOrderId());
		return SUCCESS;
	}
	
	public String assuerPayGoods(){
		
		this.sellOrderManageService.assuerPayGoods(purchaseOrder.getPurchaseOrderId());
		return SUCCESS;
	}
	
	public String submitCPIOrder(){
		if(this.session.get("partnerId")!=null){
			
			purchaserId = (String) this.session.get("partnerId");
		}
		purchaseOrder.setPurchaserId(purchaserId);
		this.centralizedPlanedPurchaseService.updateDemandState(String.valueOf(purchaseOrder.getCPIId()), purchaseOrder.getPurchaserId(), String.valueOf(4));
		this.sellOrderManageService.updatePurchaseOrderAndDetail(purchaseOrder, products);
		return SUCCESS;
	}
	
	public String cancelDemand(){
		
		if(this.session.get("partnerId")!=null){
			
			purchaserId = (String) this.session.get("partnerId");
		}
		purchaseOrder.setPurchaserId(purchaserId);
		this.centralizedPlanedPurchaseService.updateDemandState(String.valueOf(purchaseOrder.getCPIId()), purchaseOrder.getPurchaserId(), String.valueOf(3));
		return SUCCESS;
	}
	@JSON(serialize = false)
	public PurchaseOrder getModel() {
		
		return this.purchaseOrder;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request=arg0;
	}
	@JSON(serialize = false)
	public PurchaseOrder getPurchaseOrder() {
		return purchaseOrder;
	}

	public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
		this.purchaseOrder = purchaseOrder;
	}
	@JSON(serialize = false)
	public Map<String, Object> getRequest() {
		return request;
	}
	@JSON(serialize = false)
	public SellOrderManageService getSellOrderManageService() {
		return sellOrderManageService;
	}


	public void setSellOrderManageService(
			SellOrderManageService sellOrderManageService) {
		this.sellOrderManageService = sellOrderManageService;
	}

	public String getPurOId() {
		return purOId;
	}

	public void setPurOId(String purOId) {
		this.purOId = purOId;
	}
	@JSON(serialize = false)
	public PurchaseOrderDetailService getPurchaseOrderDetailService() {
		return purchaseOrderDetailService;
	}

	public void setPurchaseOrderDetailService(
			PurchaseOrderDetailService purchaseOrderDetailService) {
		this.purchaseOrderDetailService = purchaseOrderDetailService;
	}

	public String getAddresses() {
		return addresses;
	}

	public void setAddresses(String addresses) {
		this.addresses = addresses;
	}

	public List<Supplier> getPurchasers() {
		return purchasers;
	}
	public void setPurchasers(List<Supplier> purchasers) {
		this.purchasers = purchasers;
	}

	public String getProducts() {
		return products;
	}

	public void setProducts(String products) {
		this.products = products;
	}
	@JSON(serialize = false)
	public CentralizedPlanedPurchaseService getCentralizedPlanedPurchaseService() {
		return centralizedPlanedPurchaseService;
	}

	public void setCentralizedPlanedPurchaseService(
			CentralizedPlanedPurchaseService centralizedPlanedPurchaseService) {
		this.centralizedPlanedPurchaseService = centralizedPlanedPurchaseService;
	}

	public void setSession(Map<String, Object> arg0) {
		
		this.session = arg0;
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