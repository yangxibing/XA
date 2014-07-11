package com.systemManage.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Actor;
import com.model.Page;
import com.model.Supplier;
import com.model.XALog;
import com.model.XAUser;

public class UserManageDaoImpl extends SqlMapClientDaoSupport implements UserManageDao{

	public List<Supplier> getSupplierList(Supplier supplier){
		return this.getSqlMapClientTemplate().queryForList("systemManage.listPartner", supplier);
	}
	
	public List<Actor> getActorList(Actor actor){
		return this.getSqlMapClientTemplate().queryForList("systemManage.listActor", actor);
	}
	
	public void addXAUser(XAUser user){
		this.getSqlMapClientTemplate().insert("systemManage.addXAUser", user);
	}
	
	public int updateXAUser(XAUser user){
		return this.getSqlMapClientTemplate().update("systemManage.updateXAUser", user);
	}
	
	public int updateXAUserState(XAUser user){
		return this.getSqlMapClientTemplate().update("systemManage.updateXAUserState", user);
	}
	
	public List<XAUser> getXAUserList(XAUser user){
		return this.getSqlMapClientTemplate().queryForList("systemManage.getXAUserList", user);
	}
	
	public List<XAUser> getXAUserList(XAUser user, Page page){
		return this.getSqlMapClientTemplate().queryForList("systemManage.getXAUserList", user, page.getStart(), page.getRowCount());
	}
	
	public Integer userTotalCount(XAUser user){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("systemManage.userTotalCount", user);
	}
	
	public List<XAUser> getXAUserListLogin(XAUser user){
		return this.getSqlMapClientTemplate().queryForList("systemManage.getXAUserListLogin", user);
	}
	
	public void deleteUserById(String id){
		this.getSqlMapClientTemplate().delete("systemManage.deleteUserById", id);
	}
	
	public XAUser getXAUserById(String id){
		return (XAUser) this.getSqlMapClientTemplate().queryForObject("systemManage.getXAUserById", id);
	}
	
	public int updateXAUserPassword(XAUser user){
		return this.getSqlMapClientTemplate().update("systemManage.updateXAUserPassword", user);
	}
	
	public void addXALog(XALog xalog){
		this.getSqlMapClientTemplate().insert("XALog.addXALog", xalog);
	}
	
	public XAUser passwordFindBack(XAUser user){
		
			return (XAUser) this.getSqlMapClientTemplate().queryForObject("systemManage.passwordFindBack", user);

	}


	public Integer countUserWithSpecifyPasswod(XAUser user){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("systemManage.countUserWithSpecifyPasswod", user);
	}

}
