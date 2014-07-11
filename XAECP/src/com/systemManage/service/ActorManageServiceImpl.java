package com.systemManage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Actor;
import com.model.ActorFunction;
import com.model.FunctionTable;
import com.model.Page;
import com.systemManage.dao.ActorManageDao;

public class ActorManageServiceImpl extends SqlMapClientDaoSupport implements ActorManageService{

	private ActorManageDao actorManageDao;
	public List<Actor> listActors(Actor actor) {
		
		return this.actorManageDao.listActors(actor);
	}
	public void newActor(Actor actor) {
		
		this.actorManageDao.newActor(actor);
	}
	public ActorManageDao getActorManageDao() {
		return actorManageDao;
	}
	public void setActorManageDao(ActorManageDao actorManageDao) {
		this.actorManageDao = actorManageDao;
	}
	public void updateActor(Actor actor) {
		
		this.actorManageDao.updateActor(actor);
	}
	public void deleteActor(String string) {
		
		this.actorManageDao.deleteActor(string.substring(0, string.length()-1));
	}
	public int checkActorIdExist(String actorId) {
		
		return this.actorManageDao.checkActorIdExist(actorId);
	}
	public List<FunctionTable> listFunction(Actor actor) {
		
		return this.actorManageDao.listFunction(actor);
	}
	public void saveActorFunction(String actorId, String functionIds) {
		
		this.actorManageDao.deleteActorFunction(actorId);
		String [] f = functionIds.split(",");
		for(int i=0; i<f.length; i++){
			Map<String, String> map = new HashMap<String, String>();
			map.put("actorId", actorId);
			map.put("functionId", f[i]);
			this.actorManageDao.saveActorFunction(map);
		}
	}
	
	public Integer actorsTotalCount(Actor actor) {
		return this.actorManageDao.actorsTotalCount(actor);
	}
	
	public List<Actor> listActors(Actor actor, Page page) {
		return this.actorManageDao.listActors(actor, page);
	}
}
