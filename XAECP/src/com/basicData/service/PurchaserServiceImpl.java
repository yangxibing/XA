package com.basicData.service;

import java.util.List;

import com.basicData.dao.PurchaserDao;
import com.model.Page;
import com.model.Supplier;

public class PurchaserServiceImpl implements PurchaserService{
	
	private PurchaserDao purchaserDao;

	public void addPurchaser(Supplier su) {
		this.purchaserDao.addPurchaser(su);
	}
	
	public void deletePurchasers(String purchaserList){
		String[] idArray = purchaserList.split(",");
		for(int index=0; index<idArray.length; index++){
			this.purchaserDao.deletePurchaser(idArray[index]);
		}
	}

	public List<Supplier> listPurchaser(Supplier su) {
		return this.purchaserDao.listPurchaser(su);
	}
	
	public List<Supplier> listPurchaser(Supplier su, Page page){
		return this.purchaserDao.listPurchaser(su, page);
	}
	
	/**
	 * 采购商总数
	 */
	public Integer purchaserTotalCount(Supplier purchaser){
		return this.purchaserDao.purchaserTotalCount(purchaser);
	}

	public void updatePurchaser(Supplier su) {
		this.purchaserDao.updatePurchaser(su);
	}
	
	public Supplier getIndexPurchaser(String id){
		return this.purchaserDao.getIndexPurchaser(id);
	}

	/**
	 * @return the purchaserDao
	 */
	public PurchaserDao getPurchaserDao() {
		return purchaserDao;
	}

	/**
	 * @param purchaserDao the purchaserDao to set
	 */
	public void setPurchaserDao(PurchaserDao purchaserDao) {
		this.purchaserDao = purchaserDao;
	}
}
