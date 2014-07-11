package com.forum.service;

import com.forum.dao.UserDAO;
import com.model.User;

public class UserServiceImpl implements UserService{

	private UserDAO userDao;
	public UserDAO getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}

	public void addUser(User user) {	
		
	}

	public User loadUser(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean verifyUser(User user) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean insertImagePath(User user) {
		this.userDao.insertImagepath(user);
		return true;
	}

}
