package com.basicData.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;

import com.basicData.service.ProductCatalogService;
import com.model.Page;
import com.model.SupplierProduct;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class ProductCatalogAction extends ActionSupport implements ModelDriven<SupplierProduct>, RequestAware{

	private SupplierProduct supplierProduct = new SupplierProduct();
	private Map<String,Object> request;
	
	private ProductCatalogService productCatalogService;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	public SupplierProduct getModel() {
		return supplierProduct;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}

	public SupplierProduct getSupplierProduct() {
		return supplierProduct;
	}

	public void setSupplierProduct(SupplierProduct supplierProduct) {
		this.supplierProduct = supplierProduct;
	}

	public Map<String, Object> getRequest() {
		return request;
	}
	
	public String listProduct() {
		Integer totalCount = this.productCatalogService.productTotalCount(supplierProduct);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<SupplierProduct> list= this.productCatalogService.listProduct(supplierProduct, page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		request.put("supplierProductVO", supplierProduct);
		request.put("query", list);
		return SUCCESS;
	}

	public ProductCatalogService getProductCatalogService() {
		return productCatalogService;
	}

	public void setProductCatalogService(ProductCatalogService productCatalogService) {
		this.productCatalogService = productCatalogService;
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
