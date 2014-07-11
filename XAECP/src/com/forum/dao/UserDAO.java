package com.forum.dao;

import com.model.User;



public interface UserDAO {

	public void save(User user);
	public User load(String username);
	public boolean exists(User user);
	public String getPasswordMD5(User user);
	public User queryById(int id);
	public boolean insertImagepath(User user);
}
