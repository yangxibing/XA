package com.basicData.service;

import java.util.List;

import com.model.Page;
import com.model.Supplier;

public interface PurchaserService {

	public List<Supplier> listPurchaser(Supplier su);
	public List<Supplier> listPurchaser(Supplier su, Page page);
	public Integer purchaserTotalCount(Supplier purchaser);
	public void addPurchaser(Supplier su);
	public void updatePurchaser(Supplier su);
	public Supplier getIndexPurchaser(String id);
	public void deletePurchasers(String purchaserList);
}
