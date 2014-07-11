package com.centralizedPurchase.dao;

import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.BaseOrder;
import com.model.CentralizedPlanedPurchase;
import com.model.CentralizedPurchaseSupplyPrice;
import com.model.Page;

public class CentralizedPlanedPurchaseDaoImpl extends SqlMapClientDaoSupport implements CentralizedPlanedPurchaseDao{

	public List<CentralizedPlanedPurchase> listCPR(String purchaserId) {
		
		return this.getSqlMapClientTemplate().queryForList("centralizedPlanedPurchase.listCPR", purchaserId);
	}

	public List<CentralizedPurchaseSupplyPrice> selectProductsByCPIIdAndSupplierId(Map map) {
		
		return this.getSqlMapClientTemplate().queryForList("centralizedPlanedPurchase.selectProductsByCPIIdAndSupplierId", map);
	}

	public void updateDemandState(Map map) {
		this.getSqlMapClientTemplate().update("centralizedPlanedPurchase.updateDemandState", map);
	}

	public Integer selectCount(Integer CPIId) {
		
		return (Integer) this.getSqlMapClientTemplate().queryForObject("centralizedPlanedPurchase.selectCount",CPIId);
	}

	public void updateCPI(Map map) {
		this.getSqlMapClientTemplate().update("centralizedPlanedPurchase.updateCPI", map);
	}

	public CentralizedPlanedPurchase getCPIByCPIId(String CPIId) {
		
		return (CentralizedPlanedPurchase) this.getSqlMapClientTemplate().queryForObject("centralizedPlanedPurchase.getCPIByCPIId", CPIId);
	}

	public Integer CPRTotalCount(String purchaserId) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("centralizedPlanedPurchase.CPRTotalCount", purchaserId);
	}

	public List<CentralizedPlanedPurchase> listCPR(String purchaserId, Page page) {
		return this.getSqlMapClientTemplate().queryForList("centralizedPlanedPurchase.listCPR", purchaserId, page.getStart(), page.getRowCount());
	}

}
