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
	 * ��ȡָ�����͵ĺ�����飺������������ɲ�������ȷ��
	 */
	public List<Supplier> getSupplierList(Supplier supplier){
		return this.userManageDao.getSupplierList(supplier);
	}
	
	/**
	 * ��ȡ���������Ľ�ɫ�������ɲ�������
	 */
	public List<Actor> getActorList(Actor actor){
		return this.userManageDao.getActorList(actor);
	}
	
	/**
	 * ע���û�
	 */
	public void purchaserRegisterSubmit(XAUser user){
		this.userManageDao.addXAUser(user);
	}
	
	/**
	 * ��ȡ�����������û��б������ɲ���������ָ��
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
	 * �����û�������ɵ��ַ�������ɾ��ָ���û�
	 */
	public void deleteSelectedUser(String userList){
		String[] list = userList.split(",");
		for(int index=0; index<list.length; index++){
			this.userManageDao.deleteUserById(list[index]);
		}
	}
	
	/**
	 * ����id�����û�
	 */
	public XAUser getXAUserById(String id){
		return this.userManageDao.getXAUserById(id);
	}
	
	/**
	 * �������û�
	 */
	public void addXAUser(XAUser user){
		this.userManageDao.addXAUser(user);
	}
	
	/**
	 * �����û�
	 */
	public void updateXAUser(XAUser user){
		this.userManageDao.updateXAUser(user);
	}
	
	/**
	 * ��������ע����û�
	 */
	public void checkRegisterApply(XAUser user){
		this.userManageDao.updateXAUserState(user);
	}
	
	/**
	 * �޸��û�����
	 */
	public void modifyPassword(XAUser user){
		this.userManageDao.updateXAUserPassword(user);
	}
	
	/**
	 * �����¼��¼
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
