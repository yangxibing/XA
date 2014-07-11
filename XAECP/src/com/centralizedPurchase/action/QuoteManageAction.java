package com.centralizedPurchase.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.centralizedPurchase.service.QuoteManageService;
import com.model.Enquiry;
import com.model.Page;
import com.model.ProductType;
import com.model.Supplier;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class QuoteManageAction extends ActionSupport implements ModelDriven<Enquiry>,RequestAware,SessionAware{
	private Enquiry enquiry = new Enquiry();
	private Map<String,Object> request;
	private Map<String,Object> session;
	private QuoteManageService quoteManageService;
	private String ajaxResult;
	
	private String supplierIdInSession;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	@JSON(serialize=false)
	public Enquiry getModel() {
		// TODO Auto-generated method stub
		return enquiry;
	}
	public void setRequest(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		this.request = arg0;	
	}
	
	@JSON(serialize=false)
	public Enquiry getEnquiry() {
		return enquiry;
	}
	public void setEnquiry(Enquiry enquiry) {
		this.enquiry = enquiry;
	}
	
	@JSON(serialize=false)
	public QuoteManageService getQuoteManageService() {
		return quoteManageService;
	}
	public void setQuoteManageService(QuoteManageService quoteManageService) {
		this.quoteManageService = quoteManageService;
	}
	
	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}
	
	public String listEnquiry() {
		this.supplierIdInSession = (String) this.session.get("partnerId");
		enquiry.setSupplierId(supplierIdInSession);
		
		Integer totalCount = this.quoteManageService.enquiryInfoForQuoteTotalCount(enquiry);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		
		List<Enquiry> list = this.quoteManageService.listEnquirys(enquiry, page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		request.put("enquiryVO", enquiry);
		request.put("query", list);
		return SUCCESS;
	}
	
	public String getEnquiryForQuoteById() {
		Enquiry en = this.quoteManageService.getEnquiryForQuoteById(enquiry.getAskPriceId());
		ajaxResult = (en.getAskPriceId() + ","
			+ en.getProductTypeName()+ ","
			+ en.getNumber() + ","
			+ en.getMeasureUnit() + ","
			+ en.getDeadline().split(" ")[0] + ","
			+ en.getRemark());
		return SUCCESS;
	}
	
	public void setAjaxResult(String ajaxResult) {
		this.ajaxResult = ajaxResult;
	}
	public String getAjaxResult() {
		return ajaxResult;
	}
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}
	public String getSupplierIdInSession() {
		return supplierIdInSession;
	}
	public void setSupplierIdInSession(String supplierIdInSession) {
		this.supplierIdInSession = supplierIdInSession;
	}
	@JSON(serialize=false)
	public Map<String, Object> getSession() {
		return session;
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
