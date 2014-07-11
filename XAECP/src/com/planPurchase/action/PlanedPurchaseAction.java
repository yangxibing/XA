package com.planPurchase.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.model.CentralizedPlanedPurchase;
import com.model.Page;
import com.model.Supplier;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.planPurchase.service.PlanedPurchaseService;

public class PlanedPurchaseAction extends ActionSupport implements ModelDriven<CentralizedPlanedPurchase>,RequestAware {
	private CentralizedPlanedPurchase planedPurchase = new CentralizedPlanedPurchase();
	private Map<String,Object> request;
	private PlanedPurchaseService planedPurchaseService;
	private String planedPurchaseList;
	private String ajaxResult;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	public String listPlanedPurchaseInfo() {
		
		Integer totalCount = this.planedPurchaseService.planedPurchaseInfoTotalCount(planedPurchase);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<CentralizedPlanedPurchase> list = this.planedPurchaseService.listPlanedPurchaseInfo(planedPurchase, page);
		
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		
		request.put("planedPurchaseVO", planedPurchase);
		request.put("query", list);
		return SUCCESS;
	}
	
	public String addPlanedPurchaseInfo() {
		this.planedPurchaseService.addPlanedPurchaseInfo(planedPurchase);
		return SUCCESS;
	}
	
	public String updatePlanedPurchaseInfo() {
		this.planedPurchaseService.updatePlanedPurchaseInfo(planedPurchase);
		return SUCCESS;
	}
	
	public String deletePlanedPurchaseInfo() {
		this.planedPurchaseService.deletePlanedPurchaseInfo(planedPurchaseList);
		return SUCCESS;
	}
	
	public String selectPlanedPurchaseInfo() {
		planedPurchase = this.planedPurchaseService.getPlanedPurchaseInfoById(planedPurchase.getCpPurchaseInfoId());
		ajaxResult = planedPurchase.getCpPurchaseInfoId()+","
					+ planedPurchase.getCpPurchaseInfoTitle()+","
					+ planedPurchase.getProductTypeId()+","
					+ planedPurchase.getMeasureUnit()+","
					+ planedPurchase.getCombinePlanedNum();
		return SUCCESS;	
	}
	
	@JSON(serialize=false)
	public CentralizedPlanedPurchase getModel() {
		// TODO Auto-generated method stub
		return planedPurchase;
	}
	public void setRequest(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		this.request = arg0;
	}
	
	@JSON(serialize=false)
	public CentralizedPlanedPurchase getPlanedPurchase() {
		return planedPurchase;
	}
	public void setPlanedPurchase(CentralizedPlanedPurchase planedPurchase) {
		this.planedPurchase = planedPurchase;
	}
	
	@JSON(serialize=false)
	public PlanedPurchaseService getPlanedPurchaseService() {
		return planedPurchaseService;
	}
	public void setPlanedPurchaseService(PlanedPurchaseService planedPurchaseService) {
		this.planedPurchaseService = planedPurchaseService;
	}
	public String getPlanedPurchaseList() {
		return planedPurchaseList;
	}
	public void setPlanedPurchaseList(String planedPurchaseList) {
		this.planedPurchaseList = planedPurchaseList;
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
