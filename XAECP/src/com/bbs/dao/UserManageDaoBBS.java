package com.bbs.dao;

import com.model.BBSUser;

public interface UserManageDaoBBS {
	boolean registerUser(BBSUser user);

	boolean checkUserAccount(String loginAccount);
	
	boolean bbsUserLogin(BBSUser user);
	
	BBSUser queryUserByAccount(String loginAccount);
}
