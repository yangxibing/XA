package com.bbs.service;

import com.model.BBSUser;

public interface UserMangeServiceBBS {
	boolean registerUser(BBSUser user);

	boolean checkUserAccount(String loginAccount);
	
	boolean bbsUserLogin(BBSUser user);
	
	BBSUser queryUserByAccount(String loginAccount);
}
