package com.basicData.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.basicData.service.ProductTypeService;
import com.model.Page;
import com.model.ProductType;
import com.model.Supplier;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class ProductTypeAction extends ActionSupport implements  ModelDriven<ProductType>,RequestAware {
	
	private ProductType productType = new ProductType();
	private Map<String,Object> request;
	private ProductTypeService productTypeService;
	
	private String deleteProTypeIdList;
	private String ajaxResultSelectProductType;
	
	private List<ProductType> productTypeDropDownList;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	private String checkProductIdExistAjax="";

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}

	/**
	 * 根据组合查询条件列出符合条件的产品类别列表
	 * @return
	 */
	public String listProductType() {
		
		Integer totalCount = this.productTypeService.productTypeTotalCount(productType);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<ProductType> list=this.productTypeService.listProductType(productType, page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		this.request.put("productTypeVO", productType);
		request.put("query", list);
		return SUCCESS;
	}
	
	/**
	 * 根据产品类型代码查询
	 */
	public String queryProductType() {
		ProductType pt=this.productTypeService.queryProductType(productType);
		ajaxResultSelectProductType = pt.getProductTypeId()+","
			+pt.getProductTypeName()+","
			+pt.getParentProductTypeId()+","
			+pt.getRemark();
		return "ajaxResultSelectProductType";
	}
	
	/**
	 * 增加一个产品类别
	 * @return
	 */
	public String addProductType() {
		
		this.productTypeService.addProductType(productType);
		return SUCCESS;
	}
	
	/**
	 * 删除一个产品类别
	 * @return
	 */
	public String deleteProductType() {
		this.productTypeService.deleteProductType(deleteProTypeIdList);
		return SUCCESS;
	}
	
	/**
	 * 更新产品类别信息
	 * @return
	 */
	public String updateProductType() {
		this.productTypeService.updateProductType(productType);
		return SUCCESS;
	}
	
	public String checkProductIdExistAjax(){
		
		if(this.productTypeService.queryProductType(productType)==null){
			checkProductIdExistAjax = "notExist";
		}else{
			checkProductIdExistAjax = "exist";
		}
		return "checkProductIdExistAjax";
	}
	//用于异步获取获取所有产品类型 id 和name列表
	public String getProductTypeList() {
		productTypeDropDownList = this.productTypeService.getAllProductType();
		return "ProductTypeDropDownList";
	}
	
	
	@JSON(serialize = false)
	public ProductTypeService getProductTypeService() {
		return productTypeService;
	}

	public void setProductTypeService(ProductTypeService productTypeService) {
		this.productTypeService = productTypeService;
	}

	@JSON(serialize = false)
	public ProductType getProductType() {
		return productType;
	}

	public void setProductType(ProductType productType) {
		this.productType = productType;
	}
	
	

	public String getDeleteProTypeIdList() {
		return deleteProTypeIdList;
	}

	public void setDeleteProTypeIdList(String deleteProTypeIdList) {
		this.deleteProTypeIdList = deleteProTypeIdList;
	}

	@JSON(serialize = false)
	public Map<String, Object> getRequest() {
		return request;
	}

	@JSON(serialize = false)
	public ProductType getModel() {
		return productType;
	}
	
	public List<ProductType> getProductTypeDropDownList() {
		return productTypeDropDownList;
	}

	public void setProductTypeDropDownList(List<ProductType> productTypeDropDownList) {
		this.productTypeDropDownList = productTypeDropDownList;
	}

	public String getAjaxResultSelectProductType() {
		return ajaxResultSelectProductType;
	}

	public void setAjaxResultSelectProductType(String ajaxResultSelectProductType) {
		this.ajaxResultSelectProductType = ajaxResultSelectProductType;
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

	public String getCheckProductIdExistAjax() {
		return checkProductIdExistAjax;
	}

	public void setCheckProductIdExistAjax(String checkProductIdExistAjax) {
		this.checkProductIdExistAjax = checkProductIdExistAjax;
	}
	
}
