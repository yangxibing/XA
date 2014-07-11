package com.systemManage.dao;

import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Actor;
import com.model.ActorFunction;
import com.model.FunctionTable;
import com.model.Page;

public class ActorManageDaoImpl extends SqlMapClientDaoSupport implements ActorManageDao{

	public List<Actor> listActors(Actor actor) {
		
		return this.getSqlMapClientTemplate().queryForList("actor.listActors", actor);
	}

	public void newActor(Actor actor) {
		
		this.getSqlMapClientTemplate().insert("actor.newActor", actor);
	}

	public void updateActor(Actor actor) {
		
		this.getSqlMapClientTemplate().update("actor.updateActor", actor);
	}

	public void deleteActor(String string) {
		
		this.getSqlMapClientTemplate().delete("actor.deleteActor", string);
	}

	public int checkActorIdExist(String actorId) {
		
		return (Integer) this.getSqlMapClientTemplate().queryForObject("actor.checkActorIdExist", actorId);
	}

	public List<FunctionTable> listFunction(Actor actor) {
		
		return this.getSqlMapClientTemplate().queryForList("actor.listFunction", actor);
	}

	public void saveActorFunction(Map map) {
		
		
		 this.getSqlMapClientTemplate().insert("actor.saveActorFunction" ,map);
	}

	public void deleteActorFunction(String actorId) {
		
		this.getSqlMapClientTemplate().delete("actor.deleteActorFunction", actorId);
	}

	public Integer actorsTotalCount(Actor actor) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("actor.actorsTotalCount", actor);
	}

	public List<Actor> listActors(Actor actor, Page page) {
		return this.getSqlMapClientTemplate().queryForList("actor.listActors", actor, page.getStart(), page.getRowCount());
	}

	

}
