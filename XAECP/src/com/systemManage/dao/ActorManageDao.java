package com.systemManage.dao;

import java.util.List;
import java.util.Map;

import com.model.Actor;
import com.model.ActorFunction;
import com.model.FunctionTable;
import com.model.Page;

public interface ActorManageDao {

	public void newActor(Actor actor);
	public List<Actor> listActors(Actor actor);
	public void updateActor(Actor actor);
	public void deleteActor(String string);
	public int checkActorIdExist(String actorId);
	public List<FunctionTable> listFunction(Actor actor);
	public void saveActorFunction(Map map);
	public void deleteActorFunction(String actorId);
	
	public Integer actorsTotalCount(Actor actor);
	public List<Actor> listActors(Actor actor, Page page);
}
