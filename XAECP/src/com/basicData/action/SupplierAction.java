package com.basicData.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.basicData.service.SupplierService;
import com.model.Page;
import com.model.Supplier;
import com.model.SupplierProduct;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class SupplierAction extends ActionSupport implements ModelDriven<Supplier>,RequestAware{
	
	private Supplier supplier = new Supplier();
	private Map<String,Object> request;
	private SupplierService supplierService;
	private String supplierList;
	private String ajaxResult;
	private List<Supplier> homeShowSupplier;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	public String listSupplier() {
		
		Integer totalCount = this.supplierService.supplierCount(supplier);
		Page page = new Page(currentPage, totalCount, 2);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
	
		List<Supplier> list=this.supplierService.listSupplier(supplier,page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		request.put("query", list);
		return SUCCESS;
	} 
	
	
	public String homeShowSupplier(){
		Integer totalCount = this.supplierService.supplierCount(supplier);
		Page page = new Page(currentPage, totalCount, 10);
		homeShowSupplier = this.supplierService.listSupplier(supplier, page);
		return "homeShowSupplier";
	}
	
	public String homeShowSupplierMore() {
		Integer totalCount = this.supplierService.supplierCount(supplier);
		Page page = new Page(currentPage, totalCount, Page.pageSize);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
	
		List<Supplier> list=this.supplierService.homeListSupplierMore(page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		request.put("query", list);
		return SUCCESS;
	}
	
	public String addSupplier(){
		this.supplierService.addSupplier(supplier);
		return SUCCESS;
	}
	
	public String deleteSupplier() {
		System.out.println(supplierList);
		this.supplierService.deleteSupplier(supplierList);
		return SUCCESS;
	}
	
	public String selectSupplier() {
		if(this.supplierService.selectSupplier(supplier.getPartnerId())!=null){
			supplier = this.supplierService.selectSupplier(supplier.getPartnerId());
			ajaxResult=supplier.getPartnerId()+","
				  +supplier.getPartnerName()+","
				  +supplier.getFirstAddress()+","
				  +supplier.getSecondAddress()+","
				  +supplier.getCountry()+","
				  +supplier.getProvince()+","
				  +supplier.getCity()+","
				  +supplier.getWebsite()+","
				  +supplier.getIntroduction()+","
				  +supplier.getIntegrity()+","
				  +supplier.getBlackList()+","
				  +supplier.getContactPerson()+","
				  +supplier.getTelephone()+","
				  +supplier.getFax()+","
				  +supplier.getEmail()+","
				  +supplier.getZipCode();
		}else{
			ajaxResult = "notExist";
		}
		return SUCCESS;
	}
	public String updateSupplier() {
		this.supplierService.updateSupplier(supplier);
		return SUCCESS;
	}
	
	public String productDetail() {
		List<SupplierProduct> productList=this.supplierService.productDetail(supplier.getPartnerId());
		request.put("productList", productList);
		request.put("supplierId", supplier.getPartnerId());
		return SUCCESS;
	}
	
	
	
	@JSON(serialize = false)
	public Map<String, Object> getRequest() {
		return request;
	}
	@JSON(serialize = false)
	public Supplier getSupplier() {
		return supplier;
	}
	@JSON(serialize = false)
	public Supplier getModel() {
		
		return supplier;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request=arg0;
	}
	@JSON(serialize = false)
	public SupplierService getSupplierService() {
		return supplierService;
	}
	public void setSupplierService(SupplierService supplierService) {
		this.supplierService = supplierService;
	}
	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}
	
	public String getSupplierList() {
		return supplierList;
	}
	public void setSupplierList(String supplierList) {
		this.supplierList = supplierList;
	}
	public String getAjaxResult() {
		return ajaxResult;
	}
	public void setAjaxResult(String ajaxResult) {
		this.ajaxResult = ajaxResult;
	}

	public List<Supplier> getHomeShowSupplier() {
		return homeShowSupplier;
	}

	public void setHomeShowSupplier(List<Supplier> homeShowSupplier) {
		this.homeShowSupplier = homeShowSupplier;
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
