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
	private static final String userId="2008303403";//��ʱ��Ϊ��½���û�ID	
	private String actorIdString;
	private String idExitOrNot;
	private List<FunctionTable> functions;
	private String functionIds;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	//�г�����������actor
	public String listActors(){
		
		Integer totalCount = this.actorManageService.actorsTotalCount(actor);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<Actor> list = this.actorManageService.listActors(actor, page);
		request.put("totalPage", this.totalPage);     //������ҳ����ҳ��
		request.put("currentPage", this.currentPage); //���浱ǰҳ��ҳ��
		request.put("actors", list);
		return SUCCESS;
	}
	
	//�½�һ��actor������
	public String newActor(){
		
		this.actorManageService.newActor(actor);
		return SUCCESS;
	}
	
	//�༭actor������
	public String updateActor(){
		
		
		this.actorManageService.updateActor(actor);
		return SUCCESS;
	}
	
	//ɾ��һ��actor
	public String deleteActor(){
		
		this.actorManageService.deleteActor(actorIdString);
		return SUCCESS;
	}
	
	//���actorId�Ƿ��Ѿ�����
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
