package com.centralizedPurchase.dao;

import java.util.List;

import com.model.PurchaseOrderDetail;

public interface PurchaseOrderDetailDao {

	public  List<PurchaseOrderDetail> selectProduct(String purId);
	public String getProductNameById(String id);
}
