package com.basicData.action;

import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.basicData.service.ProductPriceService;
import com.model.SupplierProductPrice;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class ProductPriceAction extends ActionSupport implements ModelDriven<SupplierProductPrice>,RequestAware{

	private Map<String,Object> request;
	private SupplierProductPrice productPrice=new SupplierProductPrice();
	private ProductPriceService productPriceService;
	private String ajaxResult;
	private String priceList;
	private String checkNumberIntervalExistAjax;

	public String getPriceList() {
		return priceList;
	}

	public void setPriceList(String priceList) {
		this.priceList = priceList;
	}

	public String addPrice(){
		productPrice.setNumberInterval(productPrice.getStartNumber()+"-"+productPrice.getEndNumber());
		this.productPriceService.addPrice(productPrice);
		return SUCCESS;
	}
	
	public String selectPrice(){
		productPrice=this.productPriceService.selectPrice(productPrice);
		String[] number=productPrice.getNumberInterval().split("-");
		productPrice.setStartNumber(number[0]);
		productPrice.setEndNumber(number[1]);
		ajaxResult = this.productPrice.getStartNumber()+","
					+productPrice.getEndNumber()+","
					+productPrice.getPrice()+","
					+productPrice.getRemark()+","
					+productPrice.getProductId()+","
					+productPrice.getMeasureUnit();
		return SUCCESS;
	}
	
	public String checkNumberIntervalExistAjax(){
		
		productPrice.setNumberInterval(productPrice.getStartNumber()+"-"+productPrice.getEndNumber());
		if(this.productPriceService.selectPrice(productPrice)==null){
			this.checkNumberIntervalExistAjax = "notExist";
		}else{
			checkNumberIntervalExistAjax = "exist";
		}
		return "checkNumberIntervalExistAjax";
	}
	public String updatePrice(){
		productPrice.setNumberInterval(productPrice.getStartNumber()+"-"+productPrice.getEndNumber());
		this.productPriceService.updatePrice(productPrice);
		return SUCCESS;
	}
	
	public String deletePrice(){
		this.productPriceService.deletePrice(productPrice.getProductId(), priceList);
		return SUCCESS;
	}
	@JSON(serialize = false)
	public SupplierProductPrice getModel() {
		
		return productPrice;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request=arg0;
	}
	@JSON(serialize = false)
	public SupplierProductPrice getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(SupplierProductPrice productPrice) {
		this.productPrice = productPrice;
	}
	@JSON(serialize = false)
	public Map<String, Object> getRequest() {
		return request;
	}

	@JSON(serialize = false)
	public ProductPriceService getProductPriceService() {
		return productPriceService;
	}


	public void setProductPriceService(ProductPriceService productPriceService) {
		this.productPriceService = productPriceService;
	}
	public String getAjaxResult() {
		return ajaxResult;
	}

	public void setAjaxResult(String ajaxResult) {
		this.ajaxResult = ajaxResult;
	}

	public String getCheckNumberIntervalExistAjax() {
		return checkNumberIntervalExistAjax;
	}

	public void setCheckNumberIntervalExistAjax(String checkNumberIntervalExistAjax) {
		this.checkNumberIntervalExistAjax = checkNumberIntervalExistAjax;
	}
	
}
