package com.systemManage.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.model.Actor;
import com.model.FunctionTable;
import com.model.Page;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.systemManage.service.ActorManageService;

public class ActionManageAction extends ActionSupport implements ModelDriven<Actor>,RequestAware{

	private Actor actor = new Actor();
	private Map<String, Object> request;
	private ActorManageService actorManageService;
	private static final String  purchaserId="9000000";
	private static final String userId="2008303403";//临时作为登陆的用户ID	
	private String actorIdString;
	private String idExitOrNot;
	private List<FunctionTable> functions;
	private String functionIds;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	//列出符合条件的actor
	public String listActors(){
		
		Integer totalCount = this.actorManageService.actorsTotalCount(actor);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<Actor> list = this.actorManageService.listActors(actor, page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		request.put("actors", list);
		return SUCCESS;
	}
	
	//新建一个actor并保存
	public String newActor(){
		
		this.actorManageService.newActor(actor);
		return SUCCESS;
	}
	
	//编辑actor并保存
	public String updateActor(){
		
		
		this.actorManageService.updateActor(actor);
		return SUCCESS;
	}
	
	//删除一个actor
	public String deleteActor(){
		
		this.actorManageService.deleteActor(actorIdString);
		return SUCCESS;
	}
	
	//检查actorId是否已经存在
	public String checkActorIdExist(){
		
		if(this.actorManageService.checkActorIdExist(actor.getActorId())!=0){
			idExitOrNot = "exit";
		}
		return "idExitOrNot";
	}
	
	public String listFunction(){
		
		functions = this.actorManageService.listFunction(actor);
		return "functions";
	}
	
	public String saveActorFunction(){
		
		this.actorManageService.saveActorFunction(actor.getActorId(), functionIds);
		return SUCCESS;
	}
	
	@JSON(serialize = false)
	public Actor getModel() {
		
		return actor;
	}
	public void setRequest(Map<String, Object> arg0) {
		
		this.request = arg0;
	}
	@JSON(serialize = false)
	public Actor getActor() {
		return actor;
	}

	public void setActor(Actor actor) {
		this.actor = actor;
	}
	@JSON(serialize = false)
	public ActorManageService getActorManageService() {
		return actorManageService;
	}

	public void setActorManageService(ActorManageService actorManageService) {
		this.actorManageService = actorManageService;
	}
	@JSON(serialize = false)
	public Map<String, Object> getRequest() {
		return request;
	}

	public String getActorIdString() {
		return actorIdString;
	}

	public void setActorIdString(String actorIdString) {
		this.actorIdString = actorIdString;
	}

	public String getIdExitOrNot() {
		return idExitOrNot;
	}

	public void setIdExitOrNot(String idExitOrNot) {
		this.idExitOrNot = idExitOrNot;
	}

	public List<FunctionTable> getFunctions() {
		return functions;
	}

	public void setFunctions(List<FunctionTable> functions) {
		this.functions = functions;
	}

	public String getFunctionIds() {
		return functionIds;
	}

	public void setFunctionIds(String functionIds) {
		this.functionIds = functionIds;
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
