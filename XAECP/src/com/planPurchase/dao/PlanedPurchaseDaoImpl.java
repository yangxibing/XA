package com.planPurchase.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.CentralizedPlanedPurchase;
import com.model.Page;

public class PlanedPurchaseDaoImpl extends SqlMapClientDaoSupport implements PlanedPurchaseDao {

	public void addPlanedPurchaseInfo(CentralizedPlanedPurchase su) {
		System.out.println("insert into CentralizedPlanedPurchase 计划采购信息id = "+ su.getCpPurchaseInfoId());
		this.getSqlMapClientTemplate().insert("planedPurchase.addPlanedPurchaseInfo", su);
		System.out.println("增加采购信息完成");
	}

	public void deletePlanedPurchaseInfoById(String planedPurchaseId) {
		this.getSqlMapClientTemplate().delete("planedPurchase.deletePlanedPurchaseInfoById", planedPurchaseId);
	}

	public CentralizedPlanedPurchase getPlanedPurchaseInfoById(String id) {
		System.out.println("query from CentralizedPlanedPurchase where id = "+ id);
		CentralizedPlanedPurchase cp = (CentralizedPlanedPurchase) this.getSqlMapClientTemplate().queryForObject("planedPurchase.getPlanedPurchaseInfoById",id);
		System.out.println(cp.getCpPurchaseInfoId()+" "+cp.getCpPurchaseInfoTitle()+" "+ cp.getProductTypeId());
		return cp;
	}

	@SuppressWarnings("unchecked")
	public List<CentralizedPlanedPurchase> listPlanedPurchaseInfo(
			CentralizedPlanedPurchase su) {
		List<CentralizedPlanedPurchase> list = this.getSqlMapClientTemplate().queryForList("planedPurchase.listPlanedPurchaseInfo", su);
		return list;
	}

	public void updatePlanedPurchaseInfo(CentralizedPlanedPurchase su) {
		System.out.println("update from CentralizedPlanedPurchase where id = "+ su.getCpPurchaseInfoId());
		this.getSqlMapClientTemplate().update("planedPurchase.updatePlanedPurchaseInfo", su);
		System.out.println("计划采购信息更新完成");
	}

	public List<CentralizedPlanedPurchase> listPlanedPurchaseInfo(
			CentralizedPlanedPurchase planedPurchase, Page page) {
		List<CentralizedPlanedPurchase> list = this.getSqlMapClientTemplate().queryForList("planedPurchase.listPlanedPurchaseInfo", planedPurchase, page.getStart(), page.getRowCount());
		return list;
	}

	public Integer planedPurchaseInfoTotalCount(
			CentralizedPlanedPurchase planedPurchase) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("planedPurchase.planedPurchaseInfoTotalCount", planedPurchase);
	}
}