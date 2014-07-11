package com.purchaseTenderInfo.dao;

import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Page;
import com.model.ProductType;
import com.model.SupplyPurchaseInformation;

public class SupplyPurchaseInformationDaoImpl extends SqlMapClientDaoSupport implements SupplyPurchaseInformationDao{

	public List<SupplyPurchaseInformation> listSupplyPurchaseInformation(SupplyPurchaseInformation s) {
		
		return this.getSqlMapClientTemplate().queryForList("supplyPurchaseInformation.listSupplyPurchaseInformation",s);
	}

	public List<ProductType> selectProductType() {
		
		return this.getSqlMapClientTemplate().queryForList("supplyPurchaseInformation.selectProductType");
	}

	public void savePurchaseTender(SupplyPurchaseInformation s) {
		
		this.getSqlMapClientTemplate().insert("supplyPurchaseInformation.savePurchaseTender", s);
	}

	public String getUserNameByUserId(String userId) {
		
		return (String) this.getSqlMapClientTemplate().queryForObject("supplyPurchaseInformation.getUserNameByUserId",userId);
	}

	public void updatePurchaseTender(SupplyPurchaseInformation s) {
		
		this.getSqlMapClientTemplate().update("supplyPurchaseInformation.updatePurchaseTender", s);
	}

	public void deletePurchaseTenderInfo(String id) {
		
		this.getSqlMapClientTemplate().delete("supplyPurchaseInformation.deletePurchaseTenderInfo", id);
	}

	public List<SupplyPurchaseInformation> listAllSupplyPurchaseInformation(Map map) {
		
		List<SupplyPurchaseInformation> list =  this.getSqlMapClientTemplate().queryForList("supplyPurchaseInformation.listAllSupplyPurchaseInformation", map);
		return list;
	}

	public void visitNumAddOne(Integer id) {
		
		this.getSqlMapClientTemplate().update("supplyPurchaseInformation.visitNumAddOne", id);
	}

	public List<SupplyPurchaseInformation> listSupplyPurchaseInformation(
			SupplyPurchaseInformation supplyPurchaseInformation, Page page) {
		return this.getSqlMapClientTemplate().queryForList("supplyPurchaseInformation.listSupplyPurchaseInformation",supplyPurchaseInformation, page.getStart(), page.getRowCount());
	}

	public Integer purchaseTenderInfoTotalCount(
			SupplyPurchaseInformation supplyPurchaseInformation) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("supplyPurchaseInformation.purchaseTenderInfoTotalCount", supplyPurchaseInformation);
	}

	public Integer homeAllCaigouInfoTotalCount() {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("supplyPurchaseInformation.homeAllCaigouInfoTotalCount");
	}

	public List<SupplyPurchaseInformation> homeListAllCaigouInfo(Page page) {
		return this.getSqlMapClientTemplate().queryForList("supplyPurchaseInformation.homeListAllCaigouInfo", page.getStart(), page.getRowCount());
	}

}
