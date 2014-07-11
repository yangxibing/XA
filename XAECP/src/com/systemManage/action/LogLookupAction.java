package com.systemManage.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;

import com.model.Page;
import com.model.XALog;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.systemManage.service.LogLookupService;

public class LogLookupAction extends ActionSupport implements ModelDriven<XALog>,RequestAware, SessionAware{

	private Map<String, Object> request;
	private XALog xalog = new XALog();
	private Map session;
	private LogLookupService logLookupService;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	private List<XALog> list;
	
	/**
	 * 获取用户登录日志信息
	 */
	public String queryXAUserLogInfo(){
		Integer totalCount = this.logLookupService.xalogTotalCount(xalog);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		this.list = this.logLookupService.getXAUserLogInfoByLog(xalog, page);
		this.request.put("query", list);
		this.request.put("logVO", xalog);
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);		
		return SUCCESS;
	}
	
	//Getter and Setter
	public XALog getModel() {
		return xalog;
	}
	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}
	public XALog getXalog() {
		return xalog;
	}
	public void setXalog(XALog xalog) {
		this.xalog = xalog;
	}
	public Map getSession() {
		return session;
	}
	public LogLookupService getLogLookupService() {
		return logLookupService;
	}
	public void setLogLookupService(LogLookupService logLookupService) {
		this.logLookupService = logLookupService;
	}
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
