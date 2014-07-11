package com.baseInformation.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Page;
import com.model.PriceQuotation;

public class PriceQuotationDaoImpl extends SqlMapClientDaoSupport implements PriceQuotationDao {

	@SuppressWarnings("unchecked")
	public List<PriceQuotation> queryPriceQuotation(PriceQuotation quotation) {
		List<PriceQuotation> list = this.getSqlMapClientTemplate().queryForList("priceQuotation.queryPriceQuotation", quotation);
		return list;
	}
	
	public List<PriceQuotation> queryPriceQuotation(PriceQuotation quotation, Page page){
		List<PriceQuotation> list = this.getSqlMapClientTemplate().queryForList("priceQuotation.queryPriceQuotation", quotation, page.getStart(), page.getRowCount());
		return list;		
	}
	
	public Integer quotationTotalCount(PriceQuotation quotation){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("priceQuotation.quotationTotalCount", quotation);
	}
	
	public List<PriceQuotation> getQuotationAddList(PriceQuotation quotation){
		List<PriceQuotation> list = this.getSqlMapClientTemplate().queryForList("priceQuotation.getQuotationAddList", quotation);
		return list;
	}
	
	public PriceQuotation getPriceQuotationById(String id){
		return (PriceQuotation) this.getSqlMapClientTemplate().queryForObject("priceQuotation.getPriceQuotationById", id);
	}

	public void addPriceQuotation(PriceQuotation quotation) {
		this.getSqlMapClientTemplate().insert("priceQuotation.addPriceQuotation", quotation);
	}
	
	public void updatePriceQuotation(PriceQuotation quotation){
		this.getSqlMapClientTemplate().update("priceQuotation.updatePriceQuotation", quotation);
	}
	
	public void deletePriceQuotationById(String id){
		this.getSqlMapClientTemplate().delete("priceQuotation.deletePriceQuotationById", id);
	}
}
