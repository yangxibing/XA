package com.basicData.dao;

import java.util.List;

import com.model.Page;
import com.model.Supplier;

public interface PurchaserDao {

	public List<Supplier> listPurchaser(Supplier su);
	public List<Supplier> listPurchaser(Supplier su, Page page);
	public Integer purchaserTotalCount(Supplier purchaser);
	public void addPurchaser(Supplier su);
	public void updatePurchaser(Supplier su);
	public Supplier getIndexPurchaser(String id);
	public void deletePurchaser(String id);
}
