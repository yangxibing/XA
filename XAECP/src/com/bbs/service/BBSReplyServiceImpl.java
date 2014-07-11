package com.bbs.service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.bbs.dao.BBSReplyDao;
import com.model.BBSReply;
import com.model.BBSSubject;
import com.model.Page;

public class BBSReplyServiceImpl implements BBSReplyService {

	private BBSReplyDao bbsReplyDao;
	
	/**
	 * 获取论坛首页的最新帖、最热帖、推荐帖列表
	 */
	public List<BBSSubject> bbsHomeNewSubjectList(){
		return this.bbsReplyDao.bbsHomeNewSubjectList();
	}
	public List<BBSSubject> bbsHomeHotSubjectList(){
		return this.bbsReplyDao.bbsHomeHotSubjectList();
	}
	public List<BBSSubject> bbsHomeRecommendSubjectList(){
		return this.bbsReplyDao.bbsHomeRecommendSubjectList();
	}
	
	/**
	 * 获取更多的最新帖、最热帖、推荐帖列表
	 */
	public List<BBSSubject> bbsMoreNewSubjectList(){
		return this.bbsReplyDao.bbsMoreNewSubjectList();
	}
	public Integer bbsReplyNewTotalCount(){
		return this.bbsReplyDao.bbsReplyNewTotalCount();
	}
	public List<BBSSubject> bbsMoreNewSubjectList(Page page){
		return this.bbsReplyDao.bbsMoreNewSubjectList(page);
	}
	public List<BBSSubject> bbsMoreHotSubjectList(){
		return this.bbsReplyDao.bbsMoreHotSubjectList();
	}
	public Integer bbsReplyHotTotalCount(){
		return this.bbsReplyDao.bbsReplyHotTotalCount();
	}
	public List<BBSSubject> bbsMoreHotSubjectList(Page page){
		return this.bbsReplyDao.bbsMoreHotSubjectList(page);
	}
	
	/**
	 * 论坛回复页面数据获取：主题内容及回复内容
	 */	
	public BBSSubject getBBSSubjectById(String id){
		return this.bbsReplyDao.getBBSSubjectById(id);
	}
	
	public List<BBSReply> getBBSReplyBySubjectId(String subjectId){
		return this.bbsReplyDao.getBBSReplyBySubjectId(subjectId);
	}
	
	public List<BBSReply> getBBSReplyBySubjectId(String subjectId, Page page){
		return this.bbsReplyDao.getBBSReplyBySubjectId(subjectId, page);
	}
	
	public Integer bbsReplyTotalCount(String id){
		return this.bbsReplyDao.bbsReplyTotalCount(id);
	}
	
	public Integer bbsSubjectTotalCount(String title){
		return this.bbsReplyDao.bbsSubjectTotalCount(title);
	}
	
	public List<BBSSubject> getBBSSubjectByTitle(String title, Page page){
		return this.bbsReplyDao.getBBSSubjectByTitle(title, page);
	}
	
	/**
	 *  用户回复提交
	 */
	public BBSReply submitBBSReply(BBSReply bbsReply){
		String id = this.bbsReplyDao.insertBBSReply(bbsReply);
		return this.bbsReplyDao.getBBSReplyById(id);
	}
	
	/**
	 * 主题回复次数自增
	 */
	public void bbsSubjectReplyPlusPlus(String id){
		this.bbsReplyDao.bbsSubjectReplyPlusPlus(id);
	}
	
	/**
	 * 主题读次数自增
	 */
	public void bbsSubjectReadPlusPlus(String id){
		this.bbsReplyDao.bbsSubjectReadPlusPlus(id);
	}
	
	/**
	 * 推荐帖处理
	 */
	public void recommendSubject(String id){
		this.bbsReplyDao.recommendSubject(id);
	}
	
	public void cancelRecommendSubject(String id){
		this.bbsReplyDao.cancelRecommendSubject(id);
	}
	
	/**
	 * 删除帖
	 */
	public void removeBBSSubject(String id){
		this.bbsReplyDao.removeBBSSubjectById(id);
	}
	
	/**
	 * 删除回复
	 */
	public void removeSubjectReply(BBSReply bbsReply){
		this.bbsReplyDao.removeSubjectReply(bbsReply);
	}

	//Getter and Setter
	public BBSReplyDao getBbsReplyDao() {
		return bbsReplyDao;
	}

	public void setBbsReplyDao(BBSReplyDao bbsReplyDao) {
		this.bbsReplyDao = bbsReplyDao;
	}
}
