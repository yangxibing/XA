package com.centralizedPurchase.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.centralizedPurchase.service.PurchaseOrderDetailService;
import com.model.PurchaseOrderDetail;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class PurchaseOrderDetailAction extends ActionSupport implements ModelDriven<PurchaseOrderDetail>,RequestAware{

	private PurchaseOrderDetail purchaseOrderDetail=new PurchaseOrderDetail();
	private Map<String, Object> request;
	private PurchaseOrderDetailService purchaseOrderDetailService;
	private String purId;
	private String ajaxResult;
	private List<PurchaseOrderDetail> alist=new ArrayList<PurchaseOrderDetail>();
	private List<PurchaseOrderDetail> blist=new ArrayList<PurchaseOrderDetail>();

	public String selectProducts(){
		List<PurchaseOrderDetail> list=this.purchaseOrderDetailService.selectProduct(purId);
		StringBuilder sb=new StringBuilder();
		for(int i=0;i<list.size();i++){
			sb.append(list.get(i).getPurchaseOrderId()+"[]"
					+ list.get(i).getIdName()+"[]"
					+ list.get(i).getMeasureUnit()+"[]"
					+ list.get(i).getPrice()+"[]"
					+ list.get(i).getNumber()+"[]"
					+ list.get(i).getReturnNumber()+",");
		}
		ajaxResult=sb.toString();
		return SUCCESS;
	}   
	/////////////////////
	public String AjaxTest(){
		PurchaseOrderDetail a=new PurchaseOrderDetail();
		a.setProductId("wangyongkang");
		PurchaseOrderDetail b=new PurchaseOrderDetail();
		b.setProductId("tangsuyan");
		alist.add(a);
		alist.add(b);
		blist.add(a);
		blist.add(b);
		return "ajaxList";
	}
	///////////////
	public String saveOrder(){
		
		return SUCCESS;
	}
	@JSON(serialize = false)
	public PurchaseOrderDetail getModel() {
		
		return purchaseOrderDetail;
	}

	public void setRequest(Map<String, Object> arg0) {
		
		this.request=arg0;
	}
	@JSON(serialize = false)
	public PurchaseOrderDetail getPurchaseOrderDetail() {
		return purchaseOrderDetail;
	}
	public void setPurchaseOrderDetail(PurchaseOrderDetail purchaseOrderDetail) {
		this.purchaseOrderDetail = purchaseOrderDetail;
	}
	@JSON(serialize = false)
	public PurchaseOrderDetailService getPurchaseOrderDetailService() {
		return purchaseOrderDetailService;
	}

	public void setPurchaseOrderDetailService(
			PurchaseOrderDetailService purchaseOrderDetailService) {
		this.purchaseOrderDetailService = purchaseOrderDetailService;
	}
	@JSON(serialize = false)
	public Map<String, Object> getRequest() {
		return request;
	}
	public String getPurId() {
		return purId;
	}
	public void setPurId(String purId) {
		this.purId = purId;
	}
	public String getAjaxResult() {
		return ajaxResult;
	}
	public void setAjaxResult(String ajaxResult) {
		this.ajaxResult = ajaxResult;
	}
	public List<PurchaseOrderDetail> getAlist() {
		return alist;
	}
	public void setAlist(List<PurchaseOrderDetail> alist) {
		this.alist = alist;
	}
	public List<PurchaseOrderDetail> getBlist() {
		return blist;
	}
	public void setBlist(List<PurchaseOrderDetail> blist) {
		this.blist = blist;
	}


	
}
