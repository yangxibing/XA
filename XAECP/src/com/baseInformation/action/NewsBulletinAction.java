package com.baseInformation.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.baseInformation.service.NewsBulletinService;
import com.model.NewsBulletin;
import com.model.Page;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class NewsBulletinAction extends ActionSupport implements ModelDriven<NewsBulletin>,RequestAware, SessionAware{

	private Map<String,Object> request;
	private Map<String,Object> session;
	private NewsBulletin news = new NewsBulletin();
	private NewsBulletinService newsBulletinService;
	
	private String newsList;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	//从会话中获取的变量
	private String userIdInSession;
	private String partnerIdInSession;
	
	//ajax返回变量
	private NewsBulletin newsAjax;
	private List<NewsBulletin> newsListAjax;
	
	public String queryNewsBulletin(){
		Integer totalCount = this.newsBulletinService.newsTotalCount(news);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<NewsBulletin> list = this.newsBulletinService.getNewsBulletinList(news, page);
		this.request.put("query", list);
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);
		return SUCCESS;
	}
	
	public String homeNewsBulletinMore(){
		Integer totalCount = this.newsBulletinService.newsTotalCount(news);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<NewsBulletin> list = this.newsBulletinService.getNewsBulletinList(news, page);
		this.request.put("query", list);
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);
		return SUCCESS;	
	}
	
	public String homeNewsBulletinSearch(){
		Integer totalCount = this.newsBulletinService.newsTotalCount(news);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<NewsBulletin> list = this.newsBulletinService.getNewsBulletinList(news, page);
		this.request.put("query", list);
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);
		return SUCCESS;			
	}
	
	//获取新闻、公告列表，以json形式返回
	public String homeNewsBulletinList(){
		this.newsListAjax = this.newsBulletinService.getNewsBulletinList(news);
		return "list";
	}
	
	//删除选中的新闻、公告
	public String deleteNewsBulletin(){
		this.newsBulletinService.deleteNewsBulletin(newsList);
		return SUCCESS;
	}
	
	//根据id获取指定的新闻、公告
	public String queryNewsBulletinById(){
		newsAjax = this.newsBulletinService.getNewsBulletinById(this.news.getId());
		return "newsAjax";
	}
	
	//获取指定的新闻、公告
	public String queryNewsBulletinInfo(){
		this.news = this.newsBulletinService.getNewsBulletinById(this.news.getId());
		this.request.put("news", news);
		this.newsBulletinService.visitNumberPlusPuls(this.news.getId());
		return SUCCESS;
	}
	
	//添加新的新闻、公告
	public String addNewsBulletin(){
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		String time = format.format(now);
		news.setPublishDate(time);
		this.userIdInSession = (String) this.session.get("userId");
		news.setPublisher(this.userIdInSession);
		news.setVisitNumber(0);		
		
		this.newsBulletinService.addNewsBulletin(news);
		return SUCCESS;
	}
	
	//更新新闻、广告
	public String updateNewsBulletin(){
		this.newsBulletinService.updateNewsBulletin(news);
		return SUCCESS;
	}
	
	/**
	 * Getter and Setter for private members.
	 */
	@JSON(serialize=false)
	public NewsBulletin getModel() {
		return this.news;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}

	@JSON(serialize=false)
	public NewsBulletin getNews() {
		return news;
	}

	public void setNews(NewsBulletin news) {
		this.news = news;
	}

	@JSON(serialize=false)
	public NewsBulletinService getNewsBulletinService() {
		return newsBulletinService;
	}

	public void setNewsBulletinService(NewsBulletinService newsBulletinService) {
		this.newsBulletinService = newsBulletinService;
	}

	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}

	public String getNewsList() {
		return newsList;
	}

	public void setNewsList(String newsList) {
		this.newsList = newsList;
	}

	public NewsBulletin getNewsAjax() {
		return newsAjax;
	}

	public void setNewsAjax(NewsBulletin newsAjax) {
		this.newsAjax = newsAjax;
	}

	public String getUserIdInSession() {
		return userIdInSession;
	}

	public void setUserIdInSession(String userIdInSession) {
		this.userIdInSession = userIdInSession;
	}

	public String getPartnerIdInSession() {
		return partnerIdInSession;
	}

	public void setPartnerIdInSession(String partnerIdInSession) {
		this.partnerIdInSession = partnerIdInSession;
	}

	public List<NewsBulletin> getNewsListAjax() {
		return newsListAjax;
	}

	public void setNewsListAjax(List<NewsBulletin> newsListAjax) {
		this.newsListAjax = newsListAjax;
	}

	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	@JSON(serialize=false)
	public Map<String, Object> getSession() {
		return session;
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
