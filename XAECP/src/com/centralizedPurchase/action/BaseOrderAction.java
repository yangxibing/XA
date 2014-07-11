package com.centralizedPurchase.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.centralizedPurchase.service.BaseOrderService;
import com.centralizedPurchase.service.SellOrderManageService;
import com.model.BaseOrder;
import com.model.BaseOrderDetail;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.Supplier;
import com.model.SupplierProduct;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("serial")
public class BaseOrderAction extends ActionSupport implements ModelDriven<BaseOrder>, RequestAware,SessionAware {

	private BaseOrder baseOrder=new BaseOrder();
	private Map<String, Object> request;
	private Map<String, Object> session;
	private String supplierId="";
	private String userId="";
	private BaseOrderService baseOrderService;
	private List<SupplierProduct> supplierProducts;
	private BaseOrder baseOrderX;
	public List<BaseOrderDetail> productList;
	private SupplierProduct supplierProduct;
	private String productId;
	private String productString;
	private SellOrderManageService sellOrderManageService;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	public String listSupplierOrders(){
		if(this.session.get("partnerId")!=null){
			supplierId = (String) this.session.get("partnerId");
		}
		baseOrder.setSupplierId(supplierId);
		
		Integer totalCount = this.baseOrderService.supplierOrderTotalCount(baseOrder);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<BaseOrder> baseOrders=this.baseOrderService.listSupplierOrders(baseOrder, page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		request.put("baseOrders", baseOrders);
		return SUCCESS;
	}
	
	public String baseOrderProducts(){
		if(this.session.get("partnerId")!=null){
		supplierId = (String) this.session.get("partnerId");
		}
		baseOrder.setSupplierId(supplierId);
		baseOrderX=this.baseOrderService.listSupplierOrders(baseOrder).get(0);
		productList=this.baseOrderService.getProductByOrderId(baseOrder.getBaseOrderId());
		supplierProducts=this.baseOrderService.getProductBySupplierId(supplierId);
		return "baseOrderProducts";
	}
	
	public String selectProductByPId(){
		supplierProduct=this.baseOrderService.selectProductByPId(productId);
		
		return "product";
	}
	
	public String updateBaseOrderAndDetail(){
		
		this.baseOrderService.updateBaseOrder(baseOrder);
		this.baseOrderService.updateBaseOrderDetail(productString, baseOrder.getBaseOrderId());
		return SUCCESS;
	}
	
	public String assureForm(){
		if(this.session.get("userId")!=null){
			userId = (String) this.session.get("userId");
		}
		baseOrder=this.baseOrderService.getBaseOrderById(baseOrder.getBaseOrderId());
		List<BaseOrderDetail> productList=this.baseOrderService.selectProduct(baseOrder.getBaseOrderId());
		List<Supplier> logistics=this.sellOrderManageService.selectLogistics();
		List<GoodsAddress> goodsAddress=this.sellOrderManageService.sendGoodsAddress(userId,0);
		request.put("logistics", logistics);
		request.put("list", productList);
		request.put("goodsAddress", goodsAddress);
		return SUCCESS;
	}
	
	public String assureSendGoods(){
		this.baseOrderService.assureSendGoods(baseOrder);
		return SUCCESS;
	}
	
	public String getReturnGoodsForm(){
		baseOrder=this.baseOrderService.getBaseOrderById(baseOrder.getBaseOrderId());
		List<BaseOrderDetail> productList=this.baseOrderService.selectProduct(baseOrder.getBaseOrderId());
		request.put("list", productList);
		return SUCCESS;
	}
	
	public String assureGetReturnGoods(){
		this.baseOrderService.assureGetReturnGoods(baseOrder.getBaseOrderId(),"8");
		return SUCCESS;
	}
	public String payReturnGoodsForm(){
		baseOrder=this.baseOrderService.getBaseOrderById(baseOrder.getBaseOrderId());
		List<BaseOrderDetail> productList=this.baseOrderService.selectProduct(baseOrder.getBaseOrderId());
		request.put("list", productList);
		return SUCCESS;
	}
	public String updateActualRefund(){
		this.baseOrderService.assureGetReturnGoods(baseOrder.getBaseOrderId(),"9");
		this.baseOrderService.updateActualRefund(baseOrder);
		return SUCCESS;
	}
	public String returnGoodsDetailForm(){
		baseOrder=this.baseOrderService.getBaseOrderById(baseOrder.getBaseOrderId());
		List<BaseOrderDetail> productList=this.baseOrderService.selectProduct(baseOrder.getBaseOrderId());
		request.put("list", productList);
		return SUCCESS;
	}
	
	public List<BaseOrderDetail> getProductList() {
		return productList;
	}

	public void setProductList(List<BaseOrderDetail> productList) {
		this.productList = productList;
	}

	@JSON(serialize = false)
	public BaseOrder getModel() {
			return baseOrder;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request=arg0;
	}


	@JSON(serialize = false)
	public BaseOrder getBaseOrder() {
		return baseOrder;
	}



	public void setBaseOrder(BaseOrder baseOrder) {
		this.baseOrder = baseOrder;
	}


	@JSON(serialize = false)
	public BaseOrderService getBaseOrderService() {
		return baseOrderService;
	}



	public void setBaseOrderService(BaseOrderService baseOrderService) {
		this.baseOrderService = baseOrderService;
	}

	public BaseOrder getBaseOrderX() {
		return baseOrderX;
	}

	public void setBaseOrderX(BaseOrder baseOrderX) {
		this.baseOrderX = baseOrderX;
	}

	public List<SupplierProduct> getSupplierProducts() {
		return supplierProducts;
	}

	public void setSupplierProducts(List<SupplierProduct> supplierProducts) {
		this.supplierProducts = supplierProducts;
	}

	public SupplierProduct getSupplierProduct() {
		return supplierProduct;
	}

	public void setSupplierProduct(SupplierProduct supplierProduct) {
		this.supplierProduct = supplierProduct;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProductString() {
		return productString;
	}

	public void setProductString(String productString) {
		this.productString = productString;
	}
	@JSON(serialize = false)
	public SellOrderManageService getSellOrderManageService() {
		return sellOrderManageService;
	}

	public void setSellOrderManageService(
			SellOrderManageService sellOrderManageService) {
		this.sellOrderManageService = sellOrderManageService;
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
