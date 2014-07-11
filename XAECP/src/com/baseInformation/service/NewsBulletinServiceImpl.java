package com.baseInformation.service;

import java.util.List;

import com.baseInformation.dao.NewsBulletinDao;
import com.model.NewsBulletin;
import com.model.Page;

public class NewsBulletinServiceImpl implements NewsBulletinService {

	private NewsBulletinDao newsBulletinDao;

	/**
	 * 根据在参数中指定的条件，获取新闻、公告列表
	 */
	public List<NewsBulletin> getNewsBulletinList(NewsBulletin news){
		List<NewsBulletin> list = this.newsBulletinDao.getNewsBulletinList(news);
		for(int index=0; index<list.size(); index++){
			if(list.get(index).getPublishDate() != null && list.get(index).getPublishDate().trim().length() != 0){
				list.get(index).setPublishDate(list.get(index).getPublishDate().split(" ")[0]);
			}
		}
		return list;
	}
	
	public List<NewsBulletin> getNewsBulletinList(NewsBulletin news, Page page){
		List<NewsBulletin> list = this.newsBulletinDao.getNewsBulletinList(news, page);
		for(int index=0; index<list.size(); index++){
			if(list.get(index).getPublishDate() != null && list.get(index).getPublishDate().trim().length() != 0){
				list.get(index).setPublishDate(list.get(index).getPublishDate().split(" ")[0]);
			}
		}
		return list;		
	}
	
	public Integer newsTotalCount(NewsBulletin news){
		return this.newsBulletinDao.newsTotalCount(news);
	}
	
	/**
	 * 根据新闻公告的id集合删除新闻公告
	 */
	public void deleteNewsBulletin(String idList){
		String[] list = idList.split(",");
		for(int index=0; index<list.length; index++){
			this.newsBulletinDao.deleteNewsBulletinById(list[index]);
		}
	}
	
	/**
	 * 根据id获取新闻、公告对象
	 */
	public NewsBulletin getNewsBulletinById(String id){
		NewsBulletin news = this.newsBulletinDao.getNewsBulletinById(id);
		if(news.getPublishDate() != null && news.getPublishDate().trim().length() != 0){
			news.setPublishDate(news.getPublishDate().split(" ")[0]);
		}
		return news;
	}
	
	/**
	 * 更新新闻公告访问次数
	 */
	public void visitNumberPlusPuls(String id){
		this.newsBulletinDao.visitNumberPlusPuls(id);
	}
	
	/**
	 * 添加新的新闻、公告
	 */
	public void addNewsBulletin(NewsBulletin news){
		this.newsBulletinDao.addNewsBulletin(news);
	}
	
	/**
	 * 更新新闻、广告
	 */
	public void updateNewsBulletin(NewsBulletin news){
		this.newsBulletinDao.updateNewsBulletin(news);
	}
	
	/**
	 * Getter and Setter for the private member.
	 * @return
	 */
	public NewsBulletinDao getNewsBulletinDao() {
		return newsBulletinDao;
	}

	public void setNewsBulletinDao(NewsBulletinDao newsBulletinDao) {
		this.newsBulletinDao = newsBulletinDao;
	}
}
