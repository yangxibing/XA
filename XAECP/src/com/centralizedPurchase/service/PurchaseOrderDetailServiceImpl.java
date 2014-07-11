package com.centralizedPurchase.service;

import java.util.List;

import com.centralizedPurchase.dao.PurchaseOrderDetailDao;
import com.model.PurchaseOrderDetail;

public class PurchaseOrderDetailServiceImpl implements PurchaseOrderDetailService{

	private PurchaseOrderDetailDao purchaseOrderDetailDao;
	public List<PurchaseOrderDetail> selectProduct(String purId) {
		
		List<PurchaseOrderDetail> list= this.purchaseOrderDetailDao.selectProduct(purId);
		for(int i=0;i<list.size();i++){
			list.get(i).setAllPrice(list.get(i).getPrice()*list.get(i).getNumber());
			String name=this.purchaseOrderDetailDao.getProductNameById(list.get(i).getProductId());
			list.get(i).setIdName(list.get(i).getProductId()+"-"+name);
		}
		return list;
	}
	public PurchaseOrderDetailDao getPurchaseOrderDetailDao() {
		return purchaseOrderDetailDao;
	}
	public void setPurchaseOrderDetailDao(
			PurchaseOrderDetailDao purchaseOrderDetailDao) {
		this.purchaseOrderDetailDao = purchaseOrderDetailDao;
	}

}
