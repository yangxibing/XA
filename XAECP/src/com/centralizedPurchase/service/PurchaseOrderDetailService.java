package com.centralizedPurchase.service;

import java.util.List;

import com.model.PurchaseOrderDetail;

public interface PurchaseOrderDetailService {

	public List<PurchaseOrderDetail> selectProduct(String purId);
}
