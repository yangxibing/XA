package com.basicData.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.basicData.service.PurchaserService;
import com.model.Page;
import com.model.Supplier;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class PurchaserAction extends ActionSupport implements ModelDriven<Supplier>,RequestAware{

	private Supplier purchaser = new Supplier();
	private Map<String,Object> request;
	private PurchaserService purchaserService;
	private String purchaserList;
	private String ajaxResult;
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	public String listPurchaser(){
		this.purchaser.setPartnerType(1);

		Integer totalCount = this.purchaserService.purchaserTotalCount(purchaser);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();

		List<Supplier> list=this.purchaserService.listPurchaser(purchaser,page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		request.put("query", list);
		request.put("purchaserVO", this.purchaser);
		return SUCCESS;
	}
	
	public String addPurchaser(){
		this.purchaser.setPartnerType(1);
		this.purchaserService.addPurchaser(purchaser);
		return SUCCESS;
	}
	
	public String deletePurchaser(){
		System.out.println(purchaserList);
		this.purchaserService.deletePurchasers(purchaserList);
		return SUCCESS;
	}
	
	public String updatePurchaser(){
		this.purchaserService.updatePurchaser(purchaser);
		return SUCCESS;
	}
	
	public String selectPurchaser(){
		
		if(this.purchaserService.getIndexPurchaser(purchaser.getPartnerId())!=null){
			purchaser = this.purchaserService.getIndexPurchaser(purchaser.getPartnerId());
			ajaxResult=purchaser.getPartnerId()+","
					  +purchaser.getPartnerName()+","
					  +purchaser.getFirstAddress()+","
					  +purchaser.getSecondAddress()+","
					  +purchaser.getCountry()+","
					  +purchaser.getProvince()+","
					  +purchaser.getCity()+","
					  +purchaser.getWebsite()+","
					  +purchaser.getIntroduction()+","
					  +purchaser.getPartnerLevel()+","
					  +purchaser.getBlackList()+","
					  +purchaser.getContactPerson()+","
					  +purchaser.getTelephone()+","
					  +purchaser.getFax()+","
					  +purchaser.getEmail()+","
					  +purchaser.getZipCode()+","
					  +purchaser.getOrderRate();
		}else{
			ajaxResult = "notExist";
		}
		
		return SUCCESS;
	}
	
	public String getIndexPurchaser(){
		System.out.println("fdsds"+purchaser.getPartnerId());
		this.purchaser = this.purchaserService.getIndexPurchaser(this.purchaser.getPartnerId());
		request.put("purchaserItem", purchaser);
		return SUCCESS;
	}
	@JSON(serialize=false)
	public Supplier getModel() {
		return purchaser;
	}
	@JSON(serialize=false)
	public Supplier getPurchaser() {
		return purchaser;
	}

	public void setPurchaser(Supplier purchaser) {
		this.purchaser = purchaser;
	}
	
	@JSON(serialize=false)
	public PurchaserService getPurchaserService() {
		return purchaserService;
	}

	public void setPurchaserService(PurchaserService purchaserService) {
		this.purchaserService = purchaserService;
	}
	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}

	public void setModel(Supplier purchaser){
		this.purchaser = purchaser;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}
	
	
	public String getPurchaserList() {
		return purchaserList;
	}

	public void setPurchaserList(String purchaserList) {
		this.purchaserList = purchaserList;
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
