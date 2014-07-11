package com.basicData.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.basicData.service.SupplierProductService;
import com.model.Page;
import com.model.SupplierProduct;
import com.model.SupplierProductPrice;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class SupplierProductAction extends ActionSupport implements ModelDriven<SupplierProduct>,RequestAware,SessionAware{

	private SupplierProduct supplierProduct=new SupplierProduct();
	private Map<String,Object> request;
	private SupplierProductService supplierProductService;
	private String ajaxResult;
	private String supplierProductList;
	private String supplierId;
	private Map<String, Object> session;
	private String chekProductIdExsitAjax;
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	public String getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}
	public String getSupplierProductList() {
		return supplierProductList;
	}
	public void setSupplierProductList(String supplierProductList) {
		this.supplierProductList = supplierProductList;
	}
	public String addSupplierProduct(){
		System.out.println("supplierId:"+supplierProduct.getSupplierId());
		System.out.println("typeId"+supplierProduct.getProductTypeId());
		this.supplierProductService.addSupplierProduct(supplierProduct);
		System.out.println("success");
		return SUCCESS;
	}
	public String selectSupplierProduct(){
		System.out.println("ajaxResult"+supplierProduct.getProductId());
		supplierProduct = this.supplierProductService.selectSupplierProduct(supplierProduct.getProductId());
		System.out.println("productID:"+supplierProduct.getProductId());
		ajaxResult=supplierProduct.getProductId()+","
				  +supplierProduct.getProductName()+","
				  +supplierProduct.getMeasureUnit()+","
				  +supplierProduct.getRemark()+","
				  +supplierProduct.getProductTypeId()+","
				  +supplierProduct.getBasePrice()+","
				  +supplierProduct.getFormat()+","
				  +supplierProduct.getProductTypeName();
		System.out.println(ajaxResult);	 
		return SUCCESS;
	}
	
	public String updateSupplierProduct() {
		this.getSupplierProductService().updateSupplierProduct(supplierProduct);
		return SUCCESS;
	}
	
	public String selectProductBySupplierId(){
		
		List<SupplierProduct> list=this.supplierProductService.selectProductBySupplierId(supplierProduct);
		request.put("productList", list);
		return SUCCESS;
	}
	
	public String selectProductBySupplierIdAjax(){
		
		if(this.supplierProductService.selectProductBySupplierId(supplierProduct)==null){
			chekProductIdExsitAjax = "notExist";
		}else{
			chekProductIdExsitAjax = "exist";
		}
		return "chekProductIdExsitAjax";
	}
	public String deleteSupplierProduct(){
		
		this.supplierProductService.deleteSupplierProduct(supplierProductList);
		return SUCCESS;
	}
	public String listSupplierProduct(){

		if(supplierProduct.getSupplierId()==null&&session.get("partnerId")!=null){
			supplierProduct.setSupplierId((String)session.get("partnerId"));
		}
		
		Integer totalCount = this.supplierProductService.supplierProductTotalCount(supplierProduct);
		Page page = new Page(currentPage, totalCount, Page.pageSize);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		
		List<SupplierProduct> list=this.supplierProductService.listSupplierProduct(supplierProduct, page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		
		request.put("productList",list);
		request.put("supplierId", supplierProduct.getSupplierId());
		supplierProduct.setSupplierId(supplierProduct.getSupplierId());
		return SUCCESS;
	}
	public String productPrice() {
		
		int totalCount = this.supplierProductService.priceTotalCount(supplierProduct.getProductId());
		Page page = new Page(currentPage, totalCount, Page.pageSize);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		

		List<SupplierProductPrice> list=this.supplierProductService.productPrice(supplierProduct.getProductId(), page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		request.put("productPriceList", list);
		request.put("productId",supplierProduct.getProductId());
		return SUCCESS;
	}
	
	public String productPriceWatch(){
		
		int totalCount = this.supplierProductService.priceTotalCount(supplierProduct.getProductId());
		Page page = new Page(currentPage, totalCount, Page.pageSize);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		

		List<SupplierProductPrice> list=this.supplierProductService.productPrice(supplierProduct.getProductId(), page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		request.put("productPriceList", list);
		request.put("productId",supplierProduct.getProductId());
		return SUCCESS;
	}
	
	@JSON(serialize=false)
	public SupplierProductService getSupplierProductService() {
		return supplierProductService;
	}
	public void setSupplierProductService(
			SupplierProductService supplierProductService) {
		this.supplierProductService = supplierProductService;
	}
	@JSON(serialize=false)
	public SupplierProduct getModel() {
		
		return supplierProduct;
	}	
	@JSON(serialize=false)
	public SupplierProduct getSupplierProduct() {
		return supplierProduct;
	}
	public void setSupplierProduct(SupplierProduct supplierProduct) {
		
		this.supplierProduct = supplierProduct;
	}
	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}
	public void setRequest(Map<String, Object> arg0) {
		request=arg0;
	}
	public String getAjaxResult() {
		return ajaxResult;
	}
	public void setAjaxResult(String ajaxResult) {
		this.ajaxResult = ajaxResult;
	}
	public String getsupplierProductList() {
		return supplierProductList;
	}
	public void setsupplierProductList(String supplierProductList) {
		this.supplierProductList = supplierProductList;
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
	public String getChekProductIdExsitAjax() {
		return chekProductIdExsitAjax;
	}
	public void setChekProductIdExsitAjax(String chekProductIdExsitAjax) {
		this.chekProductIdExsitAjax = chekProductIdExsitAjax;
	}
	
}
