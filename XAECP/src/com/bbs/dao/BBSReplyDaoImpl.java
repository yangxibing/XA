package com.bbs.dao;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.BBSReply;
import com.model.BBSSubject;
import com.model.Page;

public class BBSReplyDaoImpl extends SqlMapClientDaoSupport implements BBSReplyDao {

	public List<BBSSubject> bbsHomeNewSubjectList(){
		return this.getSqlMapClientTemplate().queryForList("BBSReply.bbsHomeNewSubjectList");
	}
	
	public List<BBSSubject> bbsHomeHotSubjectList(){
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		Date now = cal.getTime();
		return this.getSqlMapClientTemplate().queryForList("BBSReply.bbsHomeHotSubjectList", now);
	}
	
	public List<BBSSubject> bbsHomeRecommendSubjectList(){
		return this.getSqlMapClientTemplate().queryForList("BBSReply.bbsHomeRecommendSubjectList");
	}
	
	public List<BBSSubject> bbsMoreNewSubjectList(){
		return this.getSqlMapClientTemplate().queryForList("BBSReply.bbsMoreNewSubjectList");
	}
	public Integer bbsReplyNewTotalCount(){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("BBSReply.bbsReplyNewTotalCount");
	}
	public List<BBSSubject> bbsMoreNewSubjectList(Page page){
		return this.getSqlMapClientTemplate().queryForList("BBSReply.bbsMoreNewSubjectList", page.getStart(), page.getRowCount());
	}
	public List<BBSSubject> bbsMoreHotSubjectList(){
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		Date now = cal.getTime();
		return this.getSqlMapClientTemplate().queryForList("BBSReply.bbsMoreHotSubjectList", now);
	}
	
	public Integer bbsReplyHotTotalCount(){
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		Date now = cal.getTime();
		return (Integer)this.getSqlMapClientTemplate().queryForObject("BBSReply.bbsReplyHotTotalCount", now);		
	}
	public List<BBSSubject> bbsMoreHotSubjectList(Page page){
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		Date now = cal.getTime();
		return this.getSqlMapClientTemplate().queryForList("BBSReply.bbsMoreHotSubjectList", now, page.getStart(), page.getRowCount());
	}
	
	public BBSSubject getBBSSubjectById(String id){
		return (BBSSubject) this.getSqlMapClientTemplate().queryForObject("BBSReply.getBBSSubjectById", id);
	}
	
	public List<BBSReply> getBBSReplyBySubjectId(String subjectId){
		return this.getSqlMapClientTemplate().queryForList("BBSReply.getBBSReplyBySubjectId", subjectId);
	}
	
	public List<BBSReply> getBBSReplyBySubjectId(String subjectId, Page page){
		return this.getSqlMapClientTemplate().queryForList("BBSReply.getBBSReplyBySubjectId", subjectId, page.getStart(), page.getRowCount());
	}
	
	public Integer bbsReplyTotalCount(String id){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("BBSReply.bbsReplyTotalCount", id);
	}
	
	public Integer bbsSubjectTotalCount(String title){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("BBSReply.bbsSubjectTotalCount", title);
	}
	
	public List<BBSSubject> getBBSSubjectByTitle(String title, Page page){
		return this.getSqlMapClientTemplate().queryForList("BBSReply.getBBSSubjectByTitle", title, page.getStart(), page.getRowCount());
	}
	
	public String insertBBSReply(BBSReply bbsReply){
		return (String) this.getSqlMapClientTemplate().insert("BBSReply.insertBBSReply", bbsReply);
	}
	
	public BBSReply getBBSReplyById(String id){
		return (BBSReply) this.getSqlMapClientTemplate().queryForObject("BBSReply.getBBSReplyById", id);
	}
	
	public int bbsSubjectReadPlusPlus(String id){
		return this.getSqlMapClientTemplate().update("BBSReply.bbsSubjectReadPlusPlus", id);
	}
	
	public int bbsSubjectReplyPlusPlus(String id){
		return this.getSqlMapClientTemplate().update("BBSReply.bbsSubjectReplyPlusPlus", id);
	}
	
	public int recommendSubject(String id){
		return this.getSqlMapClientTemplate().update("BBSReply.recommendSubject", id);
	}
	
	public int cancelRecommendSubject(String id){
		return this.getSqlMapClientTemplate().update("BBSReply.cancelRecommendSubject", id);
	}
	
	public void removeBBSSubjectById(String id){
		this.getSqlMapClientTemplate().delete("BBSReply.removeBBSSubjectById", id);
	}
	
	public void removeSubjectReply(BBSReply bbsReply){
		this.getSqlMapClientTemplate().delete("BBSReply.removeSubjectReply", bbsReply);
	}
}
