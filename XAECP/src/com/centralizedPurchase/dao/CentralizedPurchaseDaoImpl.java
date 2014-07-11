package com.centralizedPurchase.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.CentralizedPlanedPurchase;
import com.model.CentralizedPurchaseDemand;
import com.model.CentralizedPurchaseSupplyPrice;
import com.model.Page;
import com.model.ProductType;
import com.model.PurchaseOrder;
import com.model.SupplierProduct;

public class CentralizedPurchaseDaoImpl extends SqlMapClientDaoSupport implements CentralizedPurchaseDao {

	public List<CentralizedPlanedPurchase> getCentralizedPurchaseList(CentralizedPlanedPurchase purchase){
		return this.getSqlMapClientTemplate().queryForList("centralizedPurchase.getCentralizedPurchase", purchase);
	}
	
	public List<CentralizedPlanedPurchase> getCentralizedPurchaseList(CentralizedPlanedPurchase purchase, Page page){
		return this.getSqlMapClientTemplate().queryForList("centralizedPurchase.getCentralizedPurchase", purchase, page.getStart(), page.getRowCount());
	}
	
	public Integer centralizedPurchaseTotalCount(CentralizedPlanedPurchase purchase){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("centralizedPurchase.centralizedPurchaseTotalCount", purchase);
	}
	
	public List<CentralizedPlanedPurchase> getCentralizedPurchaseTitleList(CentralizedPlanedPurchase purchase){
		return this.getSqlMapClientTemplate().queryForList("centralizedPurchase.getCentralizedPurchaseTitleList", purchase);
	}
	
	public List<ProductType> getProductTypeList(ProductType type){
		return this.getSqlMapClientTemplate().queryForList("centralizedPurchase.getProductTypeList", type);
	}
	
	public List<ProductType> getProductListByParantId(ProductType type){
		return this.getSqlMapClientTemplate().queryForList("centralizedPurchase.getProductListByParantId", type);
	}
	
	public void deleteCentralizedPurchaseById(String id){
		this.getSqlMapClientTemplate().delete("centralizedPurchase.deleteCentralizedPurchaseById", id);
	}
	
	public CentralizedPlanedPurchase getCentralizedPurchaseById(String id){
		return (CentralizedPlanedPurchase) this.getSqlMapClientTemplate().queryForObject("centralizedPurchase.getCentralizedPurchaseById", id);
	}
	
	public void addCentralizedPurchase(CentralizedPlanedPurchase purchase){
		this.getSqlMapClientTemplate().insert("centralizedPurchase.addCentralizedPurchase", purchase);
	}
	
	public int updateCentralizedPurchase(CentralizedPlanedPurchase purchase){
		return this.getSqlMapClientTemplate().update("centralizedPurchase.updateCentralizedPurchase", purchase);
	}
	
	public List<CentralizedPurchaseDemand> getCentralizedPurchaseDemandList(CentralizedPurchaseDemand demand){
		return this.getSqlMapClientTemplate().queryForList("centralizedPurchase.getCentralizedPurchaseDemandList", demand);
	}
	
	public int updateCentralizedPurchaseDemandState(CentralizedPurchaseDemand demand){
		return this.getSqlMapClientTemplate().update("centralizedPurchase.updateCentralizedPurchaseDemandState", demand);
	}
	
	public int updateCentralizedPurchaseCombineNumber(CentralizedPlanedPurchase purchase){
		return this.getSqlMapClientTemplate().update("centralizedPurchase.updateCentralizedPurchaseCombineNumber", purchase);
	}
	
	public int updateCentralizedPurchaseState(CentralizedPlanedPurchase purchase){
		return this.getSqlMapClientTemplate().update("centralizedPurchase.updateCentralizedPurchaseState", purchase);
	}
	
	public void addCentralizedPurchaseDemand(CentralizedPurchaseDemand demand){
		this.getSqlMapClientTemplate().insert("centralizedPurchase.addCentralizedPurchaseDemand", demand);
	}
	
	public List<SupplierProduct> getProductListByType(String id){
		return this.getSqlMapClientTemplate().queryForList("centralizedPurchase.getProductListByType", id);
	}
	
	public void addCentralizedPurchaseSupplyPrice(CentralizedPurchaseSupplyPrice price){
		this.getSqlMapClientTemplate().insert("centralizedPurchase.addCentralizedPurchaseSupplyPrice", price);
	}
	
	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder order){
		return this.getSqlMapClientTemplate().queryForList("purchaseOrder.queryPurchaseOrder", order);
	}
	
	public List<CentralizedPurchaseSupplyPrice> getCentralizedPurchaseSupplyPriceList(String id){
		return this.getSqlMapClientTemplate().queryForList("centralizedPurchase.getCentralizedPurchaseSupplyPriceList", id);
	}
	
	public Integer countCentralizedPurchaseDemand(CentralizedPurchaseDemand demand){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("centralizedPurchase.countCentralizedPurchaseDemand", demand);
	}
}
