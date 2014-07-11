package com.centralizedPurchase.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.centralizedPurchase.service.CentralizedPlanedPurchaseService;
import com.centralizedPurchase.service.SellOrderManageService;
import com.model.CentralizedPlanedPurchase;
import com.model.CentralizedPurchaseSupplyPrice;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrderDetail;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class CentralizedPlanedPurchaseAction extends ActionSupport implements ModelDriven<CentralizedPlanedPurchase>, RequestAware,SessionAware{

	private CentralizedPlanedPurchase centralizedPlanedPurchase = new CentralizedPlanedPurchase();
	private Map<String, Object> request;
	private SellOrderManageService sellOrderManageService;
	private Map<String, Object> session;
	private String  purchaserId="";
	private String userId="";//临时作为登陆的用户ID
	private CentralizedPlanedPurchaseService centralizedPlanedPurchaseService;
	private List<CentralizedPurchaseSupplyPrice> productList;
	private List<GoodsAddress> goodsAddress;
	private Double orderRate;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	public String listCPR(){
		
		if(this.session.get("partnerId")!=null){
			
			purchaserId  = (String) this.session.get("partnerId");
		}
		
		Integer totalCount = this.centralizedPlanedPurchaseService.CPRTotalCount(purchaserId);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<CentralizedPlanedPurchase> list=this.centralizedPlanedPurchaseService.listCPR(purchaserId, page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		request.put("centralizeDemand", list);
		return SUCCESS;
	}
	
	public String selectProductsByCPIIdAndSupplierId(){
		
	    if(this.session.get("partnerId")!=null&&this.session.get("userId")!=null){
			
			purchaserId  = (String) this.session.get("partnerId");
			userId = (String) this.session.get("userId");
		}
		productList=this.centralizedPlanedPurchaseService.selectProductsByCPIIdAndSupplierId(purchaserId,this.centralizedPlanedPurchase.getCpPurchaseInfoId());
		goodsAddress=this.sellOrderManageService.sendGoodsAddress(userId,0);
		orderRate=this.sellOrderManageService.getOrderRateByPId(purchaserId);
		return "selectProducts";
	}
	
	public String getCPIByCPIId(){
		centralizedPlanedPurchase=this.centralizedPlanedPurchaseService.getCPIByCPIId(centralizedPlanedPurchase.getCpPurchaseInfoId());
		return SUCCESS;
	}
	
	
	
	@JSON(serialize = false)
	public CentralizedPlanedPurchase getModel() {
		
		return centralizedPlanedPurchase;
	}

	public void setRequest(Map<String, Object> arg0) {
		request=arg0;
	}
	@JSON(serialize = false)
	public CentralizedPlanedPurchase getCentralizedPlanedPurchase() {
		return centralizedPlanedPurchase;
	}

	public void setCentralizedPlanedPurchase(
			CentralizedPlanedPurchase centralizedPlanedPurchase) {
		centralizedPlanedPurchase = centralizedPlanedPurchase;
	}
	@JSON(serialize = false)
	public Map<String, Object> getRequest() {
		return request;
	}

	@JSON(serialize = false)
	public CentralizedPlanedPurchaseService getCentralizedPlanedPurchaseService() {
		return centralizedPlanedPurchaseService;
	}


	public void setCentralizedPlanedPurchaseService(
			CentralizedPlanedPurchaseService centralizedPlanedPurchaseService) {
		this.centralizedPlanedPurchaseService = centralizedPlanedPurchaseService;
	}
	@JSON(serialize = false)
	public SellOrderManageService getSellOrderManageService() {
		return sellOrderManageService;
	}
	
	public void setSellOrderManageService(
			SellOrderManageService sellOrderManageService) {
		this.sellOrderManageService = sellOrderManageService;
	}

	public List<CentralizedPurchaseSupplyPrice> getProductList() {
		return productList;
	}

	public void setProductList(List<CentralizedPurchaseSupplyPrice> productList) {
		this.productList = productList;
	}

	public List<GoodsAddress> getGoodsAddress() {
		return goodsAddress;
	}

	public void setGoodsAddress(List<GoodsAddress> goodsAddress) {
		this.goodsAddress = goodsAddress;
	}

	public Double getOrderRate() {
		return orderRate;
	}

	public void setOrderRate(Double orderRate) {
		this.orderRate = orderRate;
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
