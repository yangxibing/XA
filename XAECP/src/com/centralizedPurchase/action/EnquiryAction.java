package com.centralizedPurchase.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.centralizedPurchase.service.EnquiryService;
import com.model.Enquiry;
import com.model.Page;
import com.model.ProductType;
import com.model.Quote;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class EnquiryAction extends ActionSupport implements ModelDriven<Enquiry>,RequestAware{
	
	private Map<String,Object> request;
	private EnquiryService enquiryService;
	private Enquiry enquiry = new Enquiry();
	private String ajaxResult;
	private String enquiryList;
	private String quoteList;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;	
	
	//ajax返回结果
	private ProductType ajaxRoot;
	
	public String queryEnquiryStr(){
		System.out.println("id: "+this.enquiry.getAskPriceId());
		this.enquiry = this.enquiryService.getEnquiryById(this.enquiry.getAskPriceId());
		ajaxResult = enquiry.getAskPriceId() + ","
			+ enquiry.getProductTypeId() + ","
			+ enquiry.getMeasureUnit() + ","
			+ enquiry.getNumber() + ","
			+ enquiry.getDeadline().split(" ")[0] + ","
			+ enquiry.getRemark();
		return "enquiryStr";
	}
	
	public String queryProductTypeList(){
		ajaxResult = "";
		List<ProductType> list = this.enquiryService.getProductTypeInEnquiry();
		if(list.size() == 0) return "ajaxResult";
		int index = 0;
		for(; index<list.size()-1; index++){
			ajaxResult += list.get(index).getProductTypeId() + " " + list.get(index).getProductTypeName() + ",";
		}
		ajaxResult += list.get(index).getProductTypeId() + " " + list.get(index).getProductTypeName();	
		return "productTypeList";
	}
	
	public String queryProductTypeListServerSide(){
		this.ajaxRoot = this.enquiryService.queryProductTypeListServerSide();
		return "root";
	}
	
	public String queryEnquiry(){
		Integer totalCount = this.enquiryService.enquiryTotalCount(enquiry);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();		
		
		List<Enquiry> list = this.enquiryService.queryEnquiry(enquiry, page);
		for(int index=0; index<list.size(); index++){
			if(list.get(index).getDeadline() != null && list.get(index).getDeadline() != ""){
				list.get(index).setDeadline(list.get(index).getDeadline().split(" ")[0]);
			}
			switch(list.get(index).getAskPriceState()){
				case 0:
					list.get(index).setAskPriceStateStr("未发布");
					break;
				case 1:
					list.get(index).setAskPriceStateStr("已发布");
					break;
				case 2:
					list.get(index).setAskPriceStateStr("询比价完成");
					break;
				default:
					list.get(index).setAskPriceStateStr("未发布");
			}
		}
		this.request.put("query", list);
		this.request.put("enquiryVO", this.enquiry);
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);
		return SUCCESS;
	}
	
	public String addEnquiry(){
		this.enquiryService.addEnquiry(enquiry);
		return SUCCESS;
	}
	
	public String updateEnquiry(){
		this.enquiryService.updateEnquiry(enquiry);
		return SUCCESS;
	}
	
	public String deleteEnquiry(){
		this.enquiryService.deleteEnquiry(enquiryList);
		return SUCCESS;
	}
	
	public String priceCompare(){
		Quote quote = new Quote();
		quote.setAskPriceId(this.enquiry.getAskPriceId());
		quote.setIsAnswer(true);
		quote.setIsSelected(false);
		if(this.enquiry.getAskPriceState() == 2){
			quote.setIsSelected(true);
		}
		List<Quote> list = this.enquiryService.getQuotesInEnquiry(quote);
		request.put("query", list);
		request.put("enquiryId", this.enquiry.getAskPriceId());
		return SUCCESS;
	}
	
	public String publishPriceCompare(){
		this.enquiryService.publishPriceCompare(quoteList, this.enquiry);
		return SUCCESS;
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

	public String getEnquiryList() {
		return enquiryList;
	}

	public void setEnquiryList(String enquiryList) {
		this.enquiryList = enquiryList;
	}

	public String getQuoteList() {
		return quoteList;
	}

	public void setQuoteList(String quoteList) {
		this.quoteList = quoteList;
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

	public ProductType getAjaxRoot() {
		return ajaxRoot;
	}

	public void setAjaxRoot(ProductType ajaxRoot) {
		this.ajaxRoot = ajaxRoot;
	}

}
