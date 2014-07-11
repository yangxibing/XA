package com.basicData.service;

import java.util.List;

import com.model.SupplierProductPrice;

public interface ProductPriceService {

	public void addPrice(SupplierProductPrice su);
	public SupplierProductPrice selectPrice(SupplierProductPrice su);
	public void updatePrice(SupplierProductPrice su);
	public void deletePrice(String productId,String numberList);
}
