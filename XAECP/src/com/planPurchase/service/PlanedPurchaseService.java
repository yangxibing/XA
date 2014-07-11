package com.planPurchase.service;

import java.util.List;

import com.model.CentralizedPlanedPurchase;
import com.model.Page;

public interface PlanedPurchaseService {
	
	public List<CentralizedPlanedPurchase> listPlanedPurchaseInfo(CentralizedPlanedPurchase su);
	
	
	public void addPlanedPurchaseInfo(CentralizedPlanedPurchase su);
	
	
	public void updatePlanedPurchaseInfo(CentralizedPlanedPurchase su);
	
	
	public CentralizedPlanedPurchase getPlanedPurchaseInfoById(String string);
	
	
	
	public void deletePlanedPurchaseInfo(String planedPurchaseList);

	public Integer planedPurchaseInfoTotalCount(
			CentralizedPlanedPurchase planedPurchase);

	public List<CentralizedPlanedPurchase> listPlanedPurchaseInfo(
			CentralizedPlanedPurchase planedPurchase, Page page);
}
