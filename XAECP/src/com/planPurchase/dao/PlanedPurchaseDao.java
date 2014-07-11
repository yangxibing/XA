package com.planPurchase.dao;

import java.util.List;

import com.model.CentralizedPlanedPurchase;
import com.model.Page;

public interface PlanedPurchaseDao {

	public List<CentralizedPlanedPurchase> listPlanedPurchaseInfo(CentralizedPlanedPurchase su);
	
	
	public void addPlanedPurchaseInfo(CentralizedPlanedPurchase su);
	
	
	public void updatePlanedPurchaseInfo(CentralizedPlanedPurchase su);
	
	
	
	public CentralizedPlanedPurchase getPlanedPurchaseInfoById(String id);
	
	
	
	public void deletePlanedPurchaseInfoById(String planedPurchaseId);
	
	
	public Integer planedPurchaseInfoTotalCount(
			CentralizedPlanedPurchase planedPurchase);

	public List<CentralizedPlanedPurchase> listPlanedPurchaseInfo(
			CentralizedPlanedPurchase planedPurchase, Page page);
}
