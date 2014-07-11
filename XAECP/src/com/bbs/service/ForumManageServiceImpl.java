package com.bbs.service;

import com.bbs.dao.ForumManageDao;
import com.model.BBSSubject;

public class ForumManageServiceImpl implements ForumManageService {

	private ForumManageDao forumManageDao;
	public void addBBSSubject(BBSSubject su) {
		this.forumManageDao.addBBSSubject(su);
	}
	public ForumManageDao getForumManageDao() {
		return forumManageDao;
	}
	public void setForumManageDao(ForumManageDao forumManageDao) {
		this.forumManageDao = forumManageDao;
	}
}
