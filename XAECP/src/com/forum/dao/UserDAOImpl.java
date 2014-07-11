package com.forum.dao;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.User;

public class UserDAOImpl extends SqlMapClientDaoSupport implements UserDAO{

	public boolean exists(User user) {
		// TODO Auto-generated method stub
		return false;
	}

	public String getPasswordMD5(User user) {
		// TODO Auto-generated method stub
		return null;
	}

	public User load(String username) {
		User user=(User)this.getSqlMapClientTemplate().queryForObject("user.QueryUser",username);
		System.out.println(user.getName());
		return user;
	}

	public void save(User user) {
		// TODO Auto-generated method stub
		
	}

	public User queryById(int userId) {	
		return (User)this.getSqlMapClientTemplate().queryForObject("user.queryById", userId);
	}

	public boolean insertImagepath(User user) {
		this.getSqlMapClientTemplate().update("user.insertImagePath",user);
		return true;
	}
}
