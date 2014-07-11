package com.centralizedPurchase.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.centralizedPurchase.service.QuoteManageService;
import com.model.AnswerPrice;
import com.model.SupplierProduct;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 获取某一个供应商的产品Id和Name下拉列表
 * @author lenovo
 *
 */
public class GetProductIdNameAction  extends ActionSupport implements RequestAware {
	private String supplierId;
	private Map<String,Object> request;
	private QuoteManageService quoteManageService;
	private String ajaxResult;
	public void setRequest(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		this.request = arg0;
	}
	
	@JSON(serialize=false)
	public String getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}
	
	@JSON(serialize=false)
	public QuoteManageService getQuoteManageService() {
		return quoteManageService;
	}
	public void setQuoteManageService(QuoteManageService quoteManageService) {
		this.quoteManageService = quoteManageService;
	}
	public String getAjaxResult() {
		return ajaxResult;
	}
	public void setAjaxResult(String ajaxResult) {
		this.ajaxResult = ajaxResult;
	}
	
	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}
	
	public String queryProductIdNameListBySupplierId() {
		List<SupplierProduct> list = this.quoteManageService.getProductIdNameListBySupplierId(supplierId);
		if(list.size() == 0) return SUCCESS;
		int index = 0;
		ajaxResult="";
		for(; index<list.size()-1; index++){
			ajaxResult += list.get(index).getProductId() + " " + list.get(index).getProductName() + ",";
		}
		ajaxResult += list.get(index).getProductId() + " " + list.get(index).getProductName();
		return SUCCESS;
	}
}
