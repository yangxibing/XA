package com.planPurchase.service;

import java.util.List;

import com.model.CentralizedPlanedPurchase;
import com.model.Page;
import com.planPurchase.dao.PlanedPurchaseDao;

public class PlanedPurchaseServiceImpl implements PlanedPurchaseService{

	private PlanedPurchaseDao planedPurchaseDao;
	
	
	public PlanedPurchaseDao getPlanedPurchaseDao() {
		return planedPurchaseDao;
	}

	public void setPlanedPurchaseDao(PlanedPurchaseDao planedPurchaseDao) {
		this.planedPurchaseDao = planedPurchaseDao;
	}

	public void addPlanedPurchaseInfo(CentralizedPlanedPurchase su) {
		planedPurchaseDao.addPlanedPurchaseInfo(su);	
	}

	public void deletePlanedPurchaseInfo(String planedPurchaseList) {
		String[] array = planedPurchaseList.split(",");
		for (int i = 0; i < array.length; i++) {
			planedPurchaseDao.deletePlanedPurchaseInfoById(array[i]);
		}	
	}

	public CentralizedPlanedPurchase getPlanedPurchaseInfoById(String id) {
		return planedPurchaseDao.getPlanedPurchaseInfoById(id);
	}

	public List<CentralizedPlanedPurchase> listPlanedPurchaseInfo(
			CentralizedPlanedPurchase su) {
		return planedPurchaseDao.listPlanedPurchaseInfo(su);
	}

	public void updatePlanedPurchaseInfo(CentralizedPlanedPurchase su) {
		planedPurchaseDao.updatePlanedPurchaseInfo(su);
	}

	public List<CentralizedPlanedPurchase> listPlanedPurchaseInfo(
			CentralizedPlanedPurchase planedPurchase, Page page) {
		return this.planedPurchaseDao.listPlanedPurchaseInfo(planedPurchase, page);
	}

	public Integer planedPurchaseInfoTotalCount(
			CentralizedPlanedPurchase planedPurchase) {
		return this.planedPurchaseDao.planedPurchaseInfoTotalCount(planedPurchase);
	}
}
