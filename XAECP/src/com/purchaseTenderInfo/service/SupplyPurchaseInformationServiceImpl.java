package com.purchaseTenderInfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Page;
import com.model.ProductType;
import com.model.SupplyPurchaseInformation;
import com.purchaseTenderInfo.dao.SupplyPurchaseInformationDao;

public class SupplyPurchaseInformationServiceImpl extends SqlMapClientDaoSupport implements SupplyPurchaseInformationService{

	private SupplyPurchaseInformationDao supplyPurchaseInformationDao;
	public List<SupplyPurchaseInformation> listSupplyPurchaseInformation(SupplyPurchaseInformation s) {
		
		return this.supplyPurchaseInformationDao.listSupplyPurchaseInformation(s);
	}
	public SupplyPurchaseInformationDao getSupplyPurchaseInformationDao() {
		return supplyPurchaseInformationDao;
	}
	public void setSupplyPurchaseInformationDao(
			SupplyPurchaseInformationDao supplyPurchaseInformationDao) {
		this.supplyPurchaseInformationDao = supplyPurchaseInformationDao;
	}
	public List<ProductType> selectProductType() {
		
		return this.supplyPurchaseInformationDao.selectProductType();
	}
	public void savePurchaseTender(SupplyPurchaseInformation s) {
		
		this.supplyPurchaseInformationDao.savePurchaseTender(s);
	}
	public String getUserNameByUserId(String userId) {
		
		return this.supplyPurchaseInformationDao.getUserNameByUserId(userId);
	}
	public void updatePurchaseTender(SupplyPurchaseInformation s) {
		
		this.supplyPurchaseInformationDao.updatePurchaseTender(s);
	}
	public void deletePurchaseTenderInfo(String idList) {
		
		for(int i=0;i<idList.split(",").length;i++){
			this.supplyPurchaseInformationDao.deletePurchaseTenderInfo(idList.split(",")[i]);

		}
	}
	public List<SupplyPurchaseInformation> listAllSupplyPurchaseInformation(Integer number,Integer start){
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("number", number);
		map.put("start", start);
		return this.supplyPurchaseInformationDao.listAllSupplyPurchaseInformation(map);
	}
	public void visitNumAddOne(Integer id) {
		
		this.supplyPurchaseInformationDao.visitNumAddOne(id);
	}
	public List<SupplyPurchaseInformation> listSupplyPurchaseInformation(
			SupplyPurchaseInformation supplyPurchaseInformation, Page page) {
		return this.supplyPurchaseInformationDao.listSupplyPurchaseInformation(supplyPurchaseInformation, page);
	}
	public Integer purchaseTenderInfoTotalCount(
			SupplyPurchaseInformation supplyPurchaseInformation) {
		return this.supplyPurchaseInformationDao.purchaseTenderInfoTotalCount(supplyPurchaseInformation);
	}
	public Integer homeAllCaigouInfoTotalCount() {
		return this.supplyPurchaseInformationDao.homeAllCaigouInfoTotalCount();
	}
	public List<SupplyPurchaseInformation> homeListAllCaigouInfo(Page page) {
		return this.supplyPurchaseInformationDao.homeListAllCaigouInfo(page);
	}
}