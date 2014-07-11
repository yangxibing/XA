package com.baseInformation.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.NewsBulletin;
import com.model.Page;

public class NewsBulletinDaoImpl extends SqlMapClientDaoSupport implements NewsBulletinDao {

	public List<NewsBulletin> getNewsBulletinList(NewsBulletin news){
		return this.getSqlMapClientTemplate().queryForList("newsBulletin.getNewsBulletinList", news);
	}
	
	public List<NewsBulletin> getNewsBulletinList(NewsBulletin news, Page page){
		return this.getSqlMapClientTemplate().queryForList("newsBulletin.getNewsBulletinList", news, page.getStart(), page.getRowCount());
	}
	
	public Integer newsTotalCount(NewsBulletin news){
		return (Integer)this.getSqlMapClientTemplate().queryForObject("newsBulletin.newsTotalCount", news);
	}
	
	public void deleteNewsBulletinById(String id){
		this.getSqlMapClientTemplate().delete("newsBulletin.deleteNewsBulletinById", id);
	}
	
	public NewsBulletin getNewsBulletinById(String id){
		return (NewsBulletin) this.getSqlMapClientTemplate().queryForObject("newsBulletin.getNewsBulletinById", id);
	}
	
	public void addNewsBulletin(NewsBulletin news){
		this.getSqlMapClientTemplate().insert("newsBulletin.addNewsBulletin", news);
	}
	
	public int updateNewsBulletin(NewsBulletin news){
		return this.getSqlMapClientTemplate().update("newsBulletin.updateNewsBulletin", news);
	}
	
	public int visitNumberPlusPuls(String id){
		return this.getSqlMapClientTemplate().update("newsBulletin.visitNumberPlusPuls", id);
	}
}
