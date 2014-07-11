package com.basicData.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.basicData.service.LogisticsService;
import com.model.Page;
import com.model.Supplier;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class LogisticsAction extends ActionSupport implements ModelDriven<Supplier>,RequestAware {

	private Supplier logistics = new Supplier(); 
	private Map<String,Object> request;
	private LogisticsService logisticsService;
	private String logisticsList;
	private String ajaxResult;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	public String listLogistics(){
		this.logistics.setPartnerType(2);
		
		Integer totalCount = this.logisticsService.logisticsTotalCount(logistics);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();

		
		List<Supplier> list=this.logisticsService.listLogistics(logistics, page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		request.put("logisticsVO", logistics);
		request.put("query", list);
		return SUCCESS;
	} 
	
	public String addLogistics(){
		this.logistics.setPartnerType(2);
		this.logisticsService.addLogistics(logistics);
		return SUCCESS;
	}
	
	public String deleteLogistics(){
		this.logisticsService.deleteLogistics(logisticsList);
		return SUCCESS;
	}
	
	public String updateLogistics(){
		this.logisticsService.updateLogistics(logistics);
		return SUCCESS;
	}
	
	public String selectLogistics(){
		logistics = this.logisticsService.getLogisticsById(logistics.getPartnerId());
		ajaxResult=logistics.getPartnerId()+","
				  +logistics.getPartnerName()+","				  
				  +logistics.getFirstAddress()+","
				  +logistics.getSecondAddress()+","
				  +logistics.getCountry()+","
				  +logistics.getProvince()+","
				  +logistics.getCity()+","
				  +logistics.getWebsite()+","
				  +logistics.getIntroduction()+","
				  +logistics.getPartnerLevel()+","
				  +logistics.getBlackList()+","
				  +logistics.getContactPerson()+","
				  +logistics.getTelephone()+","
				  +logistics.getFax()+","
				  +logistics.getEmail()+","
				  +logistics.getZipCode();
		return SUCCESS;
	}
	
	public String getDetailLogistics(){
		this.logistics = this.logisticsService.getLogisticsById(this.logistics.getPartnerId());
		request.put("logisticsItem", logistics);
		return SUCCESS;
	}

	
	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}

	@JSON(serialize=false)
	public Supplier getModel() {
		return logistics;
	}
	
	@JSON(serialize=false)
	public Supplier getLogistics() {
		return logistics;
	}

	public void setLogistics(Supplier logistics) {
		this.logistics = logistics;
	}

	@JSON(serialize=false)
	public LogisticsService getLogisticsService() {
		return logisticsService;
	}

	public void setLogisticsService(LogisticsService logisticsService) {
		this.logisticsService = logisticsService;
	}

	public String getLogisticsList() {
		return logisticsList;
	}

	public void setLogisticsList(String logisticsList) {
		this.logisticsList = logisticsList;
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
