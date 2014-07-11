package com.supplyGoodsInfo.dao;

import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Page;
import com.model.ProductType;
import com.model.SupplyPurchaseInformation;

public class SupplyGoodsInfoDaoImpl extends SqlMapClientDaoSupport implements
		SupplyGoodsInfoDao {

	public List<SupplyPurchaseInformation> listSupplyGoodsInfo(
			SupplyPurchaseInformation supplyGoodsInfo) {

		System.out.println("供应商供货信息发布管理 查询供货信息列表 ");
		List<SupplyPurchaseInformation> list = this.getSqlMapClientTemplate().queryForList(
				"supplyPurchaseInformation.listSupplyGoodsInfo",
				supplyGoodsInfo);
		System.out.println("list.size() = " + list.size());
		return list;
	}

	public void deleteSupplyGoodsInfo(String supplyGoodsInfoId) {
		// TODO Auto-generated method stub
		System.out.println("供应商供货信息发布管理  删除 供应商供货id="+supplyGoodsInfoId);
		this.getSqlMapClientTemplate().delete("supplyPurchaseInformation.deleteSupplyGoodsInfo", supplyGoodsInfoId);
		System.out.println("删除成功");
	}

	
	public List<ProductType> selectProductType() {
		return this.getSqlMapClientTemplate().queryForList("supplyPurchaseInformation.selectProductType");
	}

	public void addSupplyGoodsInfo(SupplyPurchaseInformation supplyGoodsInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().insert("supplyPurchaseInformation.addSupplyGoodsInfo", supplyGoodsInfo);
	}

	public String getUserNameById(String userIdInSession) {
		return (String) this.getSqlMapClientTemplate().queryForObject("supplyPurchaseInformation.getUserNameByUserId",userIdInSession);
	}

	public SupplyPurchaseInformation getSupplyGoodsInfoById(Integer id) {
		return (SupplyPurchaseInformation)this.getSqlMapClientTemplate().queryForObject("supplyPurchaseInformation.getSupplyGoodsInfoById", id);
	}

	public void updateSupplyGoodsInfo(SupplyPurchaseInformation s) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().update("supplyPurchaseInformation.updateSupplyGoodsInfo", s);
	}

	public List<SupplyPurchaseInformation> listAllSupplyGoodsInfo(
			Map<String, Integer> map) {
		List<SupplyPurchaseInformation> list =  this.getSqlMapClientTemplate().queryForList("supplyPurchaseInformation.listAllSupplyGoodsInfo", map);
		return list;
		
	}

	public void visitNumAddOne(Integer id) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().update("supplyPurchaseInformation.visitNumAddOne", id);
	}

	public List<SupplyPurchaseInformation> listSupplyGoodsInfo(
			SupplyPurchaseInformation supplyGoodsInfo, Page page) {
		List<SupplyPurchaseInformation> list = this.getSqlMapClientTemplate().queryForList(
				"supplyPurchaseInformation.listSupplyGoodsInfo",
				supplyGoodsInfo, page.getStart(), page.getRowCount());
		return list;
	}

	public Integer supplyGoodsInfoTotalCount(
			SupplyPurchaseInformation supplyGoodsInfo) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("supplyPurchaseInformation.supplyGoodsInfoTotalCount", supplyGoodsInfo);
	}

	public List<SupplyPurchaseInformation> listAllSupplyGoodsInfo(Page page) {
		List<SupplyPurchaseInformation> list = this.getSqlMapClientTemplate().queryForList(
				"supplyPurchaseInformation.listAllSupplyGoodsInfoForMore", page.getStart(), page.getRowCount());
		return list;
	}

	public Integer supplyGoodsInfoAllTotalCount() {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("supplyPurchaseInformation.supplyGoodsInfoAllTotalCount");
	}
}
