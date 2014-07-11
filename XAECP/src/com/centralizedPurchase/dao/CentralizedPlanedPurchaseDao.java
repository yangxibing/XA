package com.centralizedPurchase.dao;

import java.util.List;
import java.util.Map;

import com.model.BaseOrder;
import com.model.CentralizedPlanedPurchase;
import com.model.CentralizedPurchaseSupplyPrice;
import com.model.Page;

public interface CentralizedPlanedPurchaseDao {

	public List<CentralizedPlanedPurchase> listCPR(String purchaserId);
	public List<CentralizedPurchaseSupplyPrice> selectProductsByCPIIdAndSupplierId(Map map);
	public void updateDemandState(Map map);
	public Integer selectCount(Integer CPIId);
	public void updateCPI(Map map);
	public  CentralizedPlanedPurchase getCPIByCPIId(String CPIId);
	public List<CentralizedPlanedPurchase> listCPR(String purchaserId, Page page);
	public Integer CPRTotalCount(String purchaserId);
}
