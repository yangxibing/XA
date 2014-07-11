package com.bbs.dao;

import java.util.List;

import com.model.BBSReply;
import com.model.BBSSubject;
import com.model.Page;

public interface BBSReplyDao {

	public List<BBSSubject> bbsHomeNewSubjectList();
	public List<BBSSubject> bbsHomeHotSubjectList();
	public List<BBSSubject> bbsHomeRecommendSubjectList();
	
	public List<BBSSubject> bbsMoreNewSubjectList();
	public Integer bbsReplyNewTotalCount();
	public List<BBSSubject> bbsMoreNewSubjectList(Page page);
	public List<BBSSubject> bbsMoreHotSubjectList();
	public Integer bbsReplyHotTotalCount();
	public List<BBSSubject> bbsMoreHotSubjectList(Page page);
	
	public BBSSubject getBBSSubjectById(String id);
	public List<BBSReply> getBBSReplyBySubjectId(String subjectId);
	public List<BBSReply> getBBSReplyBySubjectId(String subjectId, Page page);
	public Integer bbsReplyTotalCount(String id);
	
	public Integer bbsSubjectTotalCount(String title);
	public List<BBSSubject> getBBSSubjectByTitle(String title, Page page);
	
	public String insertBBSReply(BBSReply bbsReply);
	public BBSReply getBBSReplyById(String id);
	public int bbsSubjectReadPlusPlus(String id);
	public int bbsSubjectReplyPlusPlus(String id);
	public int recommendSubject(String id);
	public int cancelRecommendSubject(String id);
	
	public void removeBBSSubjectById(String id);
	public void removeSubjectReply(BBSReply bbsReply);
}
