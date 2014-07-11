package com.centralizedPurchase.service;

import java.util.List;

import com.model.CentralizedPlanedPurchase;
import com.model.CentralizedPurchaseDemand;
import com.model.CentralizedPurchaseSupplyPrice;
import com.model.Page;
import com.model.ProductType;
import com.model.PurchaseOrder;
import com.model.SupplierProduct;

public interface CentralizedPurchaseService {
	
	public String getCentralizedPurchaseTitleList();
	public Integer centralizedPurchaseTotalCount(CentralizedPlanedPurchase purchase);
	public String getProductTypeList();
	public ProductType getProductTypeTreeList();
	public List<ProductType> getProductTypeTreeBranch(String id);
	public List<CentralizedPlanedPurchase> getCentralizedPurchaseList(CentralizedPlanedPurchase purchase);
	public List<CentralizedPlanedPurchase> getCentralizedPurchaseList(CentralizedPlanedPurchase purchase, Page page);
	public void deleteCentralizedPurchase(String deleteList);
	public CentralizedPlanedPurchase getCentralizedPurchaseById(String id);
	public void addCentralizedPurchase(CentralizedPlanedPurchase purchase);
	public void updateCentralizedPurchase(CentralizedPlanedPurchase purchase);
	public List<CentralizedPurchaseDemand> getCentralizedPurchaseDemandList(CentralizedPurchaseDemand demand);
	public void addCentralizedPurchaseDemand(CentralizedPurchaseDemand demand);
	public void updateCentralizedPurchaseDemandState(CentralizedPurchaseDemand demand);
	public void updateCentralizedPurchaseCombineNumber(CentralizedPlanedPurchase purchase);
	public void updateCentralizedPurchaseState(CentralizedPlanedPurchase purchase);
	public List<SupplierProduct> getProductListByType(String id);
	public void publishPriceCommit(String id, String priceList);
	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder order);
	public List<CentralizedPurchaseSupplyPrice> getCentralizedPurchaseSupplyPriceList(String id);
	public Integer countCentralizedPurchaseDemand(CentralizedPurchaseDemand demand);
}
