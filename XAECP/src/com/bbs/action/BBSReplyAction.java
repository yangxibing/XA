package com.bbs.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.bbs.service.BBSReplyService;
import com.model.BBSReply;
import com.model.BBSSubject;
import com.model.Page;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class BBSReplyAction  extends ActionSupport implements ModelDriven<BBSReply>,RequestAware, SessionAware{

	private Map<String, Object> request;
	private Map session;
	private BBSReply bbsReply = new BBSReply();
	private BBSReplyService bbsReplyService;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	//ajax返回结果
	private List<BBSSubject> ajaxNewSubjectList;
	private List<BBSSubject> ajaxHotSubjectList;
	private List<BBSSubject> ajaxRecommendSubjectList;
	private BBSReply bbsReplyAjax;
	
	/**
	 * 获取论坛首页的最新帖、最热帖、推荐帖列表
	 */
	public String bbsHomeNewSubjectList(){		
		this.ajaxNewSubjectList = this.bbsReplyService.bbsHomeNewSubjectList();
		return "list";
	}
	public String bbsHomeHotSubjectList(){		
		this.ajaxHotSubjectList = this.bbsReplyService.bbsHomeHotSubjectList();
		return "list";
	}
	public String bbsHomeRecommendSubjectList(){
		this.ajaxRecommendSubjectList = this.bbsReplyService.bbsHomeRecommendSubjectList();
		return "list";
	}
	
	/**
	 * 获取更多最新帖列表
	 */
	public String bbsMoreNewSubjectList(){
		Integer totalCount = this.bbsReplyService.bbsReplyNewTotalCount();
		Page page = new Page(currentPage, totalCount, 20);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		this.ajaxNewSubjectList = this.bbsReplyService.bbsMoreNewSubjectList(page);
		return "list";
	}
	public String bbsMoreHotSubjectList(){
		Integer totalCount = this.bbsReplyService.bbsReplyHotTotalCount();
		Page page = new Page(currentPage, totalCount, 20);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		this.ajaxHotSubjectList = this.bbsReplyService.bbsMoreHotSubjectList(page);
		return "list";
	}
	
	public String bbsSubjectSearch(){
		Integer totalCount = this.bbsReplyService.bbsSubjectTotalCount(this.bbsReply.getSubjectTitle());
		Page page = new Page(currentPage, totalCount, 20);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<BBSSubject> list = this.bbsReplyService.getBBSSubjectByTitle(this.bbsReply.getSubjectTitle(), page);
		this.bbsReplyService.bbsSubjectReadPlusPlus(this.bbsReply.getSubjectId());
		this.request.put("query", list);
		this.request.put("title", bbsReply.getSubjectTitle());
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);
		return SUCCESS;		
	}
	
	/**
	 * 论坛回复页面数据获取：主题内容及回复内容
	 * 
	 * 下面有两处调用：addBBSSubjectReply, removeSubjectReply
	 */
	public String bbsHomeReplyProcess(){
		Integer totalCount = this.bbsReplyService.bbsReplyTotalCount(this.bbsReply.getSubjectId());
		Page page = new Page(currentPage, totalCount, 20);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		BBSSubject bbsSubject = this.bbsReplyService.getBBSSubjectById(this.bbsReply.getSubjectId());
		List<BBSReply> list = this.bbsReplyService.getBBSReplyBySubjectId(this.bbsReply.getSubjectId(), page);
		this.bbsReplyService.bbsSubjectReadPlusPlus(this.bbsReply.getSubjectId());
		this.request.put("bbsSubject", bbsSubject);
		this.request.put("list", list);
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);
		return SUCCESS;
	}
	
	/**
	 *  用户回复提交
	 */
	public String submitBBSReply(){
		String bbsUserIdInSession = (String) this.session.get("bbsUserId");
		this.bbsReply.setResponser(bbsUserIdInSession);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		String time = format.format(now);		
		this.bbsReply.setResponseTime(time);
		this.bbsReplyAjax = this.bbsReplyService.submitBBSReply(this.bbsReply);
		this.bbsReplyService.bbsSubjectReplyPlusPlus(this.bbsReply.getSubjectId());
		return "bbsReply";
	}
	
	/**
	 * 推荐帖处理
	 */
	public String recommendSubject(){
		this.bbsReplyService.recommendSubject(this.bbsReply.getSubjectId());
		return SUCCESS;
	}
	
	public String cancelRecommendSubject(){
		this.bbsReplyService.cancelRecommendSubject(this.bbsReply.getSubjectId());
		return SUCCESS;
	}
	
	/**
	 * 删除帖
	 */
	public String removeBBSSubject(){	
		this.bbsReplyService.removeBBSSubject(this.bbsReply.getSubjectId());
		this.bbsReplyService.removeSubjectReply(this.bbsReply);
		return SUCCESS;
	}
	
	/**
	 * 增加帖
	 */
	public String addBBSSubjectReply(){
		String bbsUserIdInSession = (String) this.session.get("bbsUserId");
		this.bbsReply.setResponser(bbsUserIdInSession);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		String time = format.format(now);		
		this.bbsReply.setResponseTime(time);
		this.bbsReplyAjax = this.bbsReplyService.submitBBSReply(this.bbsReply);
		this.bbsReplyService.bbsSubjectReplyPlusPlus(this.bbsReply.getSubjectId());
		
		//this.bbsHomeReplyProcess();
		return SUCCESS;
	}
	
	/**
	 * 删除回复
	 */
	public String removeBBSSubjectReply(){
		this.bbsReplyService.removeSubjectReply(this.bbsReply);

		//this.bbsHomeReplyProcess();
		return SUCCESS;
	}
	
	//Getter and Setter
	@JSON(serialize=false)
	public BBSReply getModel() {
		return this.bbsReply;
	}
	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}
	@JSON(serialize=false)
	public Map getSession() {
		return session;
	}
	@JSON(serialize=false)
	public BBSReply getBbsReply() {
		return bbsReply;
	}
	public void setBbsReply(BBSReply bbsReply) {
		this.bbsReply = bbsReply;
	}
	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}
	@JSON(serialize=false)
	public BBSReplyService getBbsReplyService() {
		return bbsReplyService;
	}
	public void setBbsReplyService(BBSReplyService bbsReplyService) {
		this.bbsReplyService = bbsReplyService;
	}

	public List<BBSSubject> getAjaxNewSubjectList() {
		return ajaxNewSubjectList;
	}

	public void setAjaxNewSubjectList(List<BBSSubject> ajaxNewSubjectList) {
		this.ajaxNewSubjectList = ajaxNewSubjectList;
	}

	public List<BBSSubject> getAjaxHotSubjectList() {
		return ajaxHotSubjectList;
	}

	public void setAjaxHotSubjectList(List<BBSSubject> ajaxHotSubjectList) {
		this.ajaxHotSubjectList = ajaxHotSubjectList;
	}

	public BBSReply getBbsReplyAjax() {
		return bbsReplyAjax;
	}

	public void setBbsReplyAjax(BBSReply bbsReplyAjax) {
		this.bbsReplyAjax = bbsReplyAjax;
	}
	public List<BBSSubject> getAjaxRecommendSubjectList() {
		return ajaxRecommendSubjectList;
	}
	public void setAjaxRecommendSubjectList(
			List<BBSSubject> ajaxRecommendSubjectList) {
		this.ajaxRecommendSubjectList = ajaxRecommendSubjectList;
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
