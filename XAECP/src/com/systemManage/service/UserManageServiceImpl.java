package com.systemManage.service;

import java.util.List;

import com.model.Actor;
import com.model.Page;
import com.model.Supplier;
import com.model.XALog;
import com.model.XAUser;
import com.systemManage.dao.UserManageDao;

public class UserManageServiceImpl implements UserManageService{

	private UserManageDao userManageDao;

	/**
	 * 获取指定类型的合作伙伴：合作伙伴类型由参数属性确定
	 */
	public List<Supplier> getSupplierList(Supplier supplier){
		return this.userManageDao.getSupplierList(supplier);
	}
	
	/**
	 * 获取符合条件的角色：条件由参数决定
	 */
	public List<Actor> getActorList(Actor actor){
		return this.userManageDao.getActorList(actor);
	}
	
	/**
	 * 注册用户
	 */
	public void purchaserRegisterSubmit(XAUser user){
		this.userManageDao.addXAUser(user);
	}
	
	/**
	 * 获取符合条件的用户列表：条件由参数的属性指定
	 */
	public List<XAUser> getXAUserList(XAUser user){
		return this.userManageDao.getXAUserList(user);
	}
	
	public List<XAUser> getXAUserList(XAUser user, Page page){
		return this.userManageDao.getXAUserList(user, page);
	}
	
	public Integer userTotalCount(XAUser user){
		return this.userManageDao.userTotalCount(user);
	}
	
	public List<XAUser> getXAUserListLogin(XAUser user){
		return this.userManageDao.getXAUserListLogin(user);
	}
	
	/**
	 * 根据用户代码组成的字符串序列删除指定用户
	 */
	public void deleteSelectedUser(String userList){
		String[] list = userList.split(",");
		for(int index=0; index<list.length; index++){
			this.userManageDao.deleteUserById(list[index]);
		}
	}
	
	/**
	 * 根据id查找用户
	 */
	public XAUser getXAUserById(String id){
		return this.userManageDao.getXAUserById(id);
	}
	
	/**
	 * 插入新用户
	 */
	public void addXAUser(XAUser user){
		this.userManageDao.addXAUser(user);
	}
	
	/**
	 * 更新用户
	 */
	public void updateXAUser(XAUser user){
		this.userManageDao.updateXAUser(user);
	}
	
	/**
	 * 审批申请注册的用户
	 */
	public void checkRegisterApply(XAUser user){
		this.userManageDao.updateXAUserState(user);
	}
	
	/**
	 * 修改用户密码
	 */
	public void modifyPassword(XAUser user){
		this.userManageDao.updateXAUserPassword(user);
	}
	
	/**
	 * 插入登录记录
	 */
	public void addXALog(XALog xalog){
		this.userManageDao.addXALog(xalog);
	}
	
	public XAUser passwordFindBack(XAUser user){
		
		return this.userManageDao.passwordFindBack(user);
	}
	
	/**
	 * Getter and Setter for member
	 * @return
	 */
	public UserManageDao getUserManageDao() {
		return userManageDao;
	}

	public void setUserManageDao(UserManageDao userManageDao) {
		this.userManageDao = userManageDao;
	}
	
	
	public Integer countUserWithSpecifyPasswod(XAUser user){
		return this.userManageDao.countUserWithSpecifyPasswod(user);
	}
}
