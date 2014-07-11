package com.centralizedPurchase.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Enquiry;
import com.model.Page;
import com.model.ProductType;
import com.model.Quote;

public class EnquiryDaoImpl extends SqlMapClientDaoSupport implements EnquiryDao {
	
	public List<ProductType> getProductTypeInEnquiry(){
		List<ProductType> list = this.getSqlMapClientTemplate().queryForList("enquiry.getProductTypeInEnquiry");
		return list;
	}
	
	public List<ProductType> getProductListByParantId(ProductType type){
		return this.getSqlMapClientTemplate().queryForList("centralizedPurchase.getProductListByParantId", type);
	}
	
	public List<Enquiry> queryEnquiry(Enquiry enquiry){
		List<Enquiry> list = this.getSqlMapClientTemplate().queryForList("enquiry.queryEnquiry", enquiry);
		return list;
	}
	
	public List<Enquiry> queryEnquiry(Enquiry enquiry, Page page){
		List<Enquiry> list = this.getSqlMapClientTemplate().queryForList("enquiry.queryEnquiry", enquiry, page.getStart(), page.getRowCount());
		return list;		
	}
	
	public Integer enquiryTotalCount(Enquiry enquiry){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("enquiry.enquiryTotalCount", enquiry);
	}
	
	public Enquiry getEnquiryById(String id){
		Enquiry enquiry = (Enquiry) this.getSqlMapClientTemplate().queryForObject("enquiry.getEnquiryById", id);
		return enquiry;
	}
	
	public void addEnquiry(Enquiry enquiry){
		this.getSqlMapClientTemplate().insert("enquiry.addEnquiry", enquiry);
	}
	
	public void updateEnquiry(Enquiry enquiry){
		this.getSqlMapClientTemplate().update("enquiry.updateEnquiry", enquiry);
	}
	
	public void deleteEnquiryById(String id){
		this.getSqlMapClientTemplate().delete("enquiry.deleteEnquiryById", id);
	}
	
	public List<Quote> getQuotesInEnquiry(Quote quote){
		List<Quote> list = this.getSqlMapClientTemplate().queryForList("enquiry.getQuotesInEnquiry", quote);
		return list;
	}
	
	public void selectedQuoteById(String id){
		this.getSqlMapClientTemplate().update("enquiry.selectedQuoteById", id);
	}
	
	public void updateEnquiryState(Enquiry enquiry){
		this.getSqlMapClientTemplate().update("enquiry.updateEnquiryState", enquiry);
	}
}
