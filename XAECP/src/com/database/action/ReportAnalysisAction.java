package com.database.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;

import com.database.service.ReportAnalysisService;
import com.model.BaseOrder;
import com.model.PurchaseOrder;
import com.model.ReportAnalysis;
import com.opensymphony.xwork2.ActionSupport;

public class ReportAnalysisAction extends ActionSupport implements RequestAware{
	
	private Map<String, Object> request;
	private ReportAnalysisService reportAnalysisService;
	
	//报表查询条件
	private String year;
	private String orderType="0";
	private String partnerName;
	
	/**
	 * 根据查询条件进行报表查询
	 */
	public String reportAnalysis(){
		if(year==null || year.equals("")){
			Calendar calendar = Calendar.getInstance();
			year = Integer.toString(calendar.get(Calendar.YEAR));
		}		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(orderType.equals("1")){
			PurchaseOrder order = new PurchaseOrder();
			try {
				order.setBegin(dateFormat.parse(year+"-1-1 00:00:00"));
				order.setEnd(dateFormat.parse(year+"-12-31 23:59:59"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			order.setPurchaserName(partnerName);
			List<ReportAnalysis> list = this.reportAnalysisService.purchaserReportAnalysis(order);
			this.request.put("query", list);
		} else {
			BaseOrder order = new BaseOrder();
			try {
				order.setBegin(dateFormat.parse(year+"-1-1 00:00:00"));
				order.setEnd(dateFormat.parse(year+"-12-31 23:59:59"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			order.setSupplierName(partnerName);
			List<ReportAnalysis> list = this.reportAnalysisService.baseReportAnalysis(order);
			this.request.put("query", list);
		}
		
		this.request.put("year", year);
		this.request.put("orderType", orderType);
		this.request.put("partnerName", partnerName);
		return SUCCESS;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}

	public Map<String, Object> getRequest() {
		return request;
	}

	public ReportAnalysisService getReportAnalysisService() {
		return reportAnalysisService;
	}

	public void setReportAnalysisService(ReportAnalysisService reportAnalysisService) {
		this.reportAnalysisService = reportAnalysisService;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public String getPartnerName() {
		return partnerName;
	}

	public void setPartnerName(String partnerName) {
		this.partnerName = partnerName;
	}
}
