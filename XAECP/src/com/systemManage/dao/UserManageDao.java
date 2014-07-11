package com.systemManage.dao;

import java.util.List;

import com.model.Actor;
import com.model.Page;
import com.model.Supplier;
import com.model.XALog;
import com.model.XAUser;

public interface UserManageDao {
	
	public List<Supplier> getSupplierList(Supplier supplier);
	public List<Actor> getActorList(Actor actor);
	public void addXAUser(XAUser user);
	public List<XAUser> getXAUserList(XAUser user);
	public List<XAUser> getXAUserList(XAUser user, Page page);
	public Integer userTotalCount(XAUser user);
	public List<XAUser> getXAUserListLogin(XAUser user);
	public void deleteUserById(String id);
	public XAUser getXAUserById(String id);
	public int updateXAUser(XAUser user);
	public int updateXAUserState(XAUser user);
	public int updateXAUserPassword(XAUser user);
	public void addXALog(XALog xalog);
	public XAUser passwordFindBack(XAUser user);
	public Integer countUserWithSpecifyPasswod(XAUser user);

}
