package com.common;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.centralizedPurchase.service.EnquiryService;
import com.model.Enquiry;
import com.model.ProductType;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class QueryProductType extends ActionSupport implements ModelDriven<Enquiry>,RequestAware{
	private Map<String,Object> request;
	private EnquiryService enquiryService;
	private Enquiry enquiry = new Enquiry();
	private String ajaxResult;
	
	public String queryProductType(){
		ajaxResult = "";
		List<ProductType> list = this.enquiryService.getProductTypeInEnquiry();
		if(list.size() == 0) return "ajaxResult";
		int index = 0;
		for(; index<list.size()-1; index++){
			ajaxResult += list.get(index).getProductTypeId() + " " + list.get(index).getProductTypeName() + ",";
		}
		ajaxResult += list.get(index).getProductTypeId() + " " + list.get(index).getProductTypeName();
		return "ajaxResult";
	}
	
	@JSON(serialize=false)
	public Enquiry getModel() {
		return this.enquiry;
	}
	
	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}
	@JSON(serialize=false)
	public EnquiryService getEnquiryService() {
		return enquiryService;
	}
	
	public void setEnquiryService(
			EnquiryService enquiryService) {
		this.enquiryService = enquiryService;
	}
	@JSON(serialize=false)
	public Enquiry getEnquiry() {
		return enquiry;
	}
	public void setEnquiry(Enquiry enquiry) {
		this.enquiry = enquiry;
	}
	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}

	public String getAjaxResult() {
		return ajaxResult;
	}

	public void setAjaxResult(String ajaxResult) {
		this.ajaxResult = ajaxResult;
	}
}
