package com.centralizedPurchase.dao;

import java.util.List;

import com.model.CentralizedPlanedPurchase;
import com.model.CentralizedPurchaseDemand;
import com.model.CentralizedPurchaseSupplyPrice;
import com.model.Page;
import com.model.ProductType;
import com.model.PurchaseOrder;
import com.model.SupplierProduct;

public interface CentralizedPurchaseDao {
	
	public List<CentralizedPlanedPurchase> getCentralizedPurchaseList(CentralizedPlanedPurchase purchase);
	public List<CentralizedPlanedPurchase> getCentralizedPurchaseList(CentralizedPlanedPurchase purchase, Page page);
	public Integer centralizedPurchaseTotalCount(CentralizedPlanedPurchase purchase);
	public List<CentralizedPlanedPurchase> getCentralizedPurchaseTitleList(CentralizedPlanedPurchase purchase);
	public List<ProductType> getProductTypeList(ProductType type);
	public List<ProductType> getProductListByParantId(ProductType type);
	public void deleteCentralizedPurchaseById(String id);
	public CentralizedPlanedPurchase getCentralizedPurchaseById(String id);
	public void addCentralizedPurchase(CentralizedPlanedPurchase purchase);
	public int updateCentralizedPurchase(CentralizedPlanedPurchase purchase);
	public List<CentralizedPurchaseDemand> getCentralizedPurchaseDemandList(CentralizedPurchaseDemand demand);
	public int updateCentralizedPurchaseDemandState(CentralizedPurchaseDemand demand);
	public int updateCentralizedPurchaseCombineNumber(CentralizedPlanedPurchase purchase);
	public int updateCentralizedPurchaseState(CentralizedPlanedPurchase purchase);
	public void addCentralizedPurchaseDemand(CentralizedPurchaseDemand demand);
	public void addCentralizedPurchaseSupplyPrice(CentralizedPurchaseSupplyPrice price);
	public List<SupplierProduct> getProductListByType(String id);
	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder order);
	public List<CentralizedPurchaseSupplyPrice> getCentralizedPurchaseSupplyPriceList(String id);
	public Integer countCentralizedPurchaseDemand(CentralizedPurchaseDemand demand);
}
