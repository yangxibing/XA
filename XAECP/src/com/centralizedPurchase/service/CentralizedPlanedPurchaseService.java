package com.centralizedPurchase.service;

import java.util.List;

import com.model.CentralizedPlanedPurchase;
import com.model.CentralizedPurchaseSupplyPrice;
import com.model.Page;

public interface CentralizedPlanedPurchaseService {

	public List<CentralizedPlanedPurchase> listCPR(String purchaserId);
	public List<CentralizedPurchaseSupplyPrice> selectProductsByCPIIdAndSupplierId(String purchaserId,String CPIId);
	public void updateDemandState(String CPIId,String purchaserId,String demandState);
	public CentralizedPlanedPurchase getCPIByCPIId(String CPIId) ;
	public List<CentralizedPlanedPurchase> listCPR(String purchaserId, Page page);
	public Integer CPRTotalCount(String purchaserId);

}
