package com.centralizedPurchase.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.centralizedPurchase.service.QuoteManageService;
import com.model.AnswerPrice;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;


/**
 * 产品报价管理
 * @author hubo
 *
 */
public class ProductQuoteManageAction extends ActionSupport implements ModelDriven<AnswerPrice>,RequestAware,SessionAware{

	private AnswerPrice answerPrice = new AnswerPrice();
	private Map<String,Object> request;
	private Map<String,Object> session;
	private QuoteManageService quoteManageService;
	private String answerPriceIdList;
	private String ajaxResult;
	
	private String supplierIdInSession;
	
	public AnswerPrice getModel() {
		return answerPrice;
	}

	public void setRequest(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		this.request = arg0;	
	}
	
	@JSON(serialize=false)
	public AnswerPrice getAnswerPrice() {
		return answerPrice;
	}

	public void setAnswerPrice(AnswerPrice answerPrice) {
		this.answerPrice = answerPrice;
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
	
	public void setAjaxResult(String ajaxResult) {
		this.ajaxResult = ajaxResult;
	}
	public String getAjaxResult() {
		return ajaxResult;
	}
	
	@JSON(serialize=false)
	public String getAnswerPriceIdList() {
		return answerPriceIdList;
	}

	public void setAnswerPriceIdList(String answerPriceIdList) {
		this.answerPriceIdList = answerPriceIdList;
	}
	

	public String listProductQuote() {
		this.supplierIdInSession = (String) this.session.get("partnerId");
		answerPrice.setSupplierId(supplierIdInSession);
		List<AnswerPrice> list = this.quoteManageService.listProductQuote(answerPrice);
		request.put("query", list);
		return SUCCESS;
	}
	
	public String listProductQuoteDetailAfterFromal() {
		this.supplierIdInSession = (String) this.session.get("partnerId");
		answerPrice.setSupplierId(supplierIdInSession);
		List<AnswerPrice> list = this.quoteManageService.listProductQuoteDetailAfterFromal(answerPrice);
		request.put("query", list);
		return SUCCESS;
	}
	
	public String addProductQuote() {
		this.quoteManageService.addProductQuote(answerPrice);
		return SUCCESS;
	}
	
	public String deleteProductQuote() {
		this.quoteManageService.deleteProductQuote(answerPriceIdList);
		return SUCCESS;
	}
	
	public String updateProductQuote() {
		this.quoteManageService.updateProductQuote(answerPrice);
		return SUCCESS;
	}
	
	public String getProductQuoteById() {
		AnswerPrice ans = this.quoteManageService.getProductQuoteById(answerPrice.getAnswerPriceId());
		ajaxResult = (ans.getProductId() + ","
				+ ans.getProductName() +","
				+ ans.getPrice() +","
				+ ans.getRemark() +","
				+ ans.getAnswerPriceId());
		return SUCCESS;
	}
	
	public String formalProductQuote() {
		this.quoteManageService.formalProductQuote(answerPriceIdList);
		return SUCCESS;
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
}
