package com.bbs.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.BBSUser;

public class UserManageDaoImplBBS extends SqlMapClientDaoSupport implements UserManageDaoBBS {

	public boolean checkUserAccount(String loginAccount) {
		List<BBSUser> result = (List<BBSUser>)this.getSqlMapClientTemplate().queryForList("BBSUser.checkUserAccount", loginAccount);
		if ( result != null && result.size() > 0) {
			return true;
		}
		return false;
	}

	public boolean registerUser(BBSUser user) {
		this.getSqlMapClientTemplate().insert("BBSUser.registerUser", user);
		return true;
	}

	public boolean bbsUserLogin(BBSUser user) {
		
		List<BBSUser> bbsUserlist= this.getSqlMapClientTemplate().queryForList("BBSUser.BBSUserListLogin", user);
		if(bbsUserlist!= null && bbsUserlist.size()==1) {
			return true;
		} else {
//			List<BBSUser> userlist= this.getSqlMapClientTemplate().queryForList("BBSUser.XAUserListLogin", user);
//			if(userlist != null && userlist.size() == 1) {
//				return true;
//			}
		}
		return false;
	}

	public BBSUser queryUserByAccount(String loginAccount) {
		BBSUser bbsUser = (BBSUser)this.getSqlMapClientTemplate().queryForObject("BBSUser.queryUserByAccount", loginAccount);
		return bbsUser;
	}
}
