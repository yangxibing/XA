package com.baseInformation.service;

import java.util.List;

import com.model.NewsBulletin;
import com.model.Page;

public interface NewsBulletinService {
	
	public List<NewsBulletin> getNewsBulletinList(NewsBulletin news);
	public List<NewsBulletin> getNewsBulletinList(NewsBulletin news, Page page);
	public Integer newsTotalCount(NewsBulletin news);
	public void deleteNewsBulletin(String idList);
	public NewsBulletin getNewsBulletinById(String id);
	public void addNewsBulletin(NewsBulletin news);
	public void updateNewsBulletin(NewsBulletin news);
	public void visitNumberPlusPuls(String id);
}
