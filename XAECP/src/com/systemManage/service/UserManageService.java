package com.systemManage.service;

import java.util.List;

import com.model.Actor;
import com.model.Page;
import com.model.Supplier;
import com.model.XALog;
import com.model.XAUser;

public interface UserManageService {

	public List<Supplier> getSupplierList(Supplier supplier);
	public void purchaserRegisterSubmit(XAUser user);
	public List<XAUser> getXAUserList(XAUser user);
	public List<XAUser> getXAUserList(XAUser user, Page page);
	public Integer userTotalCount(XAUser user);
	public List<XAUser> getXAUserListLogin(XAUser user);
	public List<Actor> getActorList(Actor actor);
	public void deleteSelectedUser(String userList);
	public XAUser getXAUserById(String id);
	public void addXAUser(XAUser user);
	public void updateXAUser(XAUser user);
	public void checkRegisterApply(XAUser user);
	public void modifyPassword(XAUser user);
	public void addXALog(XALog xalog);

	public XAUser passwordFindBack(XAUser user);

	public Integer countUserWithSpecifyPasswod(XAUser user);

}
