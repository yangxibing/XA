package com.baseInformation.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.baseInformation.service.PriceQuotationService;
import com.model.PriceQuotation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class PriceQuotationAction extends ActionSupport implements ModelDriven<PriceQuotation>,RequestAware{

	private PriceQuotation priceQuotation = new PriceQuotation();
	private Map<String,Object> request;
	private PriceQuotationService priceQuotationService;
	private String ajaxResult;
	private String quotationList;
	
	//json返回的对象
	private List<PriceQuotation> priceListAjax;
	
	public String queryQuotationAddList(){
		List<PriceQuotation> list = this.priceQuotationService.getQuotationAddList(this.priceQuotation);
		ajaxResult="";
		int index=0;
		for(index=0; index<list.size()-1; index++){
			ajaxResult+=list.get(index).getProductId()+ " " + list.get(index).getProductName() + ",";
		}
		ajaxResult+=list.get(index).getProductId()+ " " + list.get(index).getProductName();
		return SUCCESS;
	}
	
	public String homePriceQuotationList(){
		this.priceListAjax = this.priceQuotationService.queryPriceQuotation(this.priceQuotation);
		return "list";
	}
	
	public String addPriceQuotation(){
		this.priceQuotationService.addPriceQuotation(this.priceQuotation);
		return SUCCESS;
	}
	
	public String updatePriceQuotation(){
		this.priceQuotationService.updatePriceQuotation(this.priceQuotation);
		return SUCCESS;
	}
	
	public String deletePriceQuotation(){
		this.priceQuotationService.deletePriceQuotationById(quotationList);
		return SUCCESS;
	}
	
	@JSON(serialize=false)
	public PriceQuotation getModel() {
		return this.priceQuotation;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}

	@JSON(serialize=false)
	public PriceQuotation getPriceQuatation() {
		return priceQuotation;
	}

	public void setPriceQuatation(PriceQuotation priceQuotation) {
		this.priceQuotation = priceQuotation;
	}

	@JSON(serialize=false)
	public PriceQuotationService getPriceQuotationService() {
		return priceQuotationService;
	}

	public void setPriceQuotationService(PriceQuotationService priceQuotationService) {
		this.priceQuotationService = priceQuotationService;
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

	public PriceQuotation getPriceQuotation() {
		return priceQuotation;
	}

	public void setPriceQuotation(PriceQuotation priceQuotation) {
		this.priceQuotation = priceQuotation;
	}

	public String getQuotationList() {
		return quotationList;
	}

	public void setQuotationList(String quotationList) {
		this.quotationList = quotationList;
	}

	public List<PriceQuotation> getPriceListAjax() {
		return priceListAjax;
	}

	public void setPriceListAjax(List<PriceQuotation> priceListAjax) {
		this.priceListAjax = priceListAjax;
	}

}
