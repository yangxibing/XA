package com.basicData.dao;

import com.model.SupplierProductPrice;

public interface ProductPriceDao {

	public void addPrice(SupplierProductPrice su);
	public SupplierProductPrice selectPrice(SupplierProductPrice su);
	public void updatePrice(SupplierProductPrice su);
	public void deletePrice(String su,String n);
}
