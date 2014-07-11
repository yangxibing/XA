package com.forum.service;

import com.model.User;

public interface UserService {

	public void addUser(User user);
	public User loadUser(String username);
	public boolean verifyUser(User user);
	public boolean insertImagePath(User user);
}
