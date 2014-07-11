package com.supplyGoodsInfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model.Page;
import com.model.ProductType;
import com.model.SupplyPurchaseInformation;
import com.supplyGoodsInfo.dao.SupplyGoodsInfoDao;

public class SupplyGoodsInfoServiceImpl implements SupplyGoodsInfoService {

	private SupplyGoodsInfoDao supplyGoodsInfoDao;
	
	public List<SupplyPurchaseInformation> listSupplyGoodsInfo(
			SupplyPurchaseInformation supplyGoodsInfo) {
		return supplyGoodsInfoDao.listSupplyGoodsInfo(supplyGoodsInfo);
	}

	public SupplyGoodsInfoDao getSupplyGoodsInfoDao() {
		return supplyGoodsInfoDao;
	}

	public void setSupplyGoodsInfoDao(SupplyGoodsInfoDao supplyGoodsInfoDao) {
		this.supplyGoodsInfoDao = supplyGoodsInfoDao;
	}

	public void deleteSupplyGoodsInfo(String supplyGoodsInfoList) {
		// TODO Auto-generated method stub
		String[] deleteIdArray = supplyGoodsInfoList.split(",");
		for (int i=0; i< deleteIdArray.length; i++) {
			this.supplyGoodsInfoDao.deleteSupplyGoodsInfo(deleteIdArray[i]);
		}
	}

	public List<ProductType> selectProductType() {
		// TODO Auto-generated method stub
		return this.supplyGoodsInfoDao.selectProductType();
	}

	public void addSupplyGoodsInfo(SupplyPurchaseInformation supplyGoodsInfo) {
		// TODO Auto-generated method stub
		this.supplyGoodsInfoDao.addSupplyGoodsInfo(supplyGoodsInfo);
	}

	public String getUserNameById(String userIdInSession) {
		// TODO Auto-generated method stub
		return this.supplyGoodsInfoDao.getUserNameById(userIdInSession);
	}

	public SupplyPurchaseInformation getSupplyGoodsInfoById(Integer id) {
		// TODO Auto-generated method stub
		return this.supplyGoodsInfoDao.getSupplyGoodsInfoById(id);
	}

	public void updateSupplyGoodsInfo(SupplyPurchaseInformation s) {
		// TODO Auto-generated method stub
		this.supplyGoodsInfoDao.updateSupplyGoodsInfo(s);
	}

	public List<SupplyPurchaseInformation> listAllSupplyGoodsInfo(
			Integer number, Integer start) {
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("number", number);
		map.put("start", start);
		return this.supplyGoodsInfoDao.listAllSupplyGoodsInfo(map);
	}

	public void visitNumAddOne(Integer id) {
		// TODO Auto-generated method stub
		this.supplyGoodsInfoDao.visitNumAddOne(id);
	}

	public List<SupplyPurchaseInformation> listSupplyGoodsInfo(
			SupplyPurchaseInformation supplyGoodsInfo, Page page) {
		return this.supplyGoodsInfoDao.listSupplyGoodsInfo(supplyGoodsInfo, page);
	}

	public Integer supplyGoodsInfoTotalCount(
			SupplyPurchaseInformation supplyGoodsInfo) {
		return this.supplyGoodsInfoDao.supplyGoodsInfoTotalCount(supplyGoodsInfo);
	}

	public List<SupplyPurchaseInformation> listAllSupplyGoodsInfo(Page page) {
		return this.supplyGoodsInfoDao.listAllSupplyGoodsInfo(page);
	}

	public Integer supplyGoodsInfoAllTotalCount() {
		return this.supplyGoodsInfoDao.supplyGoodsInfoAllTotalCount();
	}
	
	
}
