package com.baseInformation.dao;

import java.util.List;

import com.model.NewsBulletin;
import com.model.Page;

public interface NewsBulletinDao {

	public List<NewsBulletin> getNewsBulletinList(NewsBulletin news);
	public List<NewsBulletin> getNewsBulletinList(NewsBulletin news, Page page);
	public Integer newsTotalCount(NewsBulletin news);
	public void deleteNewsBulletinById(String id);
	public NewsBulletin getNewsBulletinById(String id);
	public void addNewsBulletin(NewsBulletin news);
	public int updateNewsBulletin(NewsBulletin news);
	public int visitNumberPlusPuls(String id);
}
