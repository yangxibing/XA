package com.baseInformation.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.baseInformation.service.PriceQuotationService;
import com.model.Page;
import com.model.PriceQuotation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class BaseInformationAction extends ActionSupport implements ModelDriven<PriceQuotation>,RequestAware{

	private PriceQuotation priceQuatation = new PriceQuotation();
	private Map<String,Object> request;
	private PriceQuotationService priceQuotationService;
	private String ajaxResult;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	public String queryPriceQuotation(){
		Integer totalCount = this.priceQuotationService.quotationTotalCount(priceQuatation);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<PriceQuotation> list = this.priceQuotationService.queryPriceQuotation(this.priceQuatation, page);
		this.request.put("query", list);
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);
		return SUCCESS;
	}	
	
	public String getPriceQuotationById(){
		System.out.println("id: " + this.priceQuatation.getProductId());
		this.priceQuatation = this.priceQuotationService.getPriceQuotationById(this.priceQuatation.getProductId());
		ajaxResult = this.priceQuatation.getProductId() + " " + this.priceQuatation.getProductName() + ","
			+ this.priceQuatation.getPrice() + ","
			+ this.priceQuatation.getNumber();
		return SUCCESS;
	}
	
	@JSON(serialize=false)
	public PriceQuotation getModel() {
		return this.priceQuatation;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}

	@JSON(serialize=false)
	public PriceQuotation getPriceQuatation() {
		return priceQuatation;
	}

	public void setPriceQuatation(PriceQuotation priceQuatation) {
		this.priceQuatation = priceQuatation;
	}

	@JSON(serialize=false)
	public PriceQuotationService getPriceQuotationService() {
		return priceQuotationService;
	}

	public void setPriceQuotationService(PriceQuotationService priceQuotationService) {
		this.priceQuotationService = priceQuotationService;
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
