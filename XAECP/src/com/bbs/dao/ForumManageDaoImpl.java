package com.bbs.dao;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.BBSSubject;

public class ForumManageDaoImpl extends SqlMapClientDaoSupport implements ForumManageDao {

	public void addBBSSubject(BBSSubject su) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().insert("BBSSubject.addBBSSubject", su);
	}

}
