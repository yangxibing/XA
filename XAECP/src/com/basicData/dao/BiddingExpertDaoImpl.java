package com.basicData.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.BiddingExpert;
import com.model.Page;

public class BiddingExpertDaoImpl extends SqlMapClientDaoSupport implements BiddingExpertDao {

	public List<BiddingExpert> queryExpert(BiddingExpert expert) {
		List<BiddingExpert> list = this.getSqlMapClientTemplate().queryForList("biddingExpert.queryExpert", expert);
		return list;
	}
	
	public List<BiddingExpert> queryExpert(BiddingExpert expert, Page page){
		List<BiddingExpert> list = this.getSqlMapClientTemplate().queryForList("biddingExpert.queryExpert", expert, page.getStart(), page.getRowCount());
		return list;		
	}
	
	public Integer purchaserTotalCount(BiddingExpert expert){
		return (Integer)this.getSqlMapClientTemplate().queryForObject("biddingExpert.purchaserTotalCount", expert);
	}

	public void deleteExpert(String id) {
		this.getSqlMapClientTemplate().delete("biddingExpert.deleteExpertById", id);
	}

	public void addExpert(BiddingExpert expert) {
		this.getSqlMapClientTemplate().insert("biddingExpert.addExpert", expert);
	}
	
	public void updateExpert(BiddingExpert expert){
		this.getSqlMapClientTemplate().update("biddingExpert.updateExpert", expert);
	}

	public BiddingExpert getExpertById(String id) {
		BiddingExpert expert = (BiddingExpert) this.getSqlMapClientTemplate().queryForObject("biddingExpert.getExpertById", id);
		if(expert.getBirthday()!= null && expert.getBirthday()!=""){
			expert.setBirthday(expert.getBirthday().split(" ")[0]);			
		}
		return expert;
	}
}
