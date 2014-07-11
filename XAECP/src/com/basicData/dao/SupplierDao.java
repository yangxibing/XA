package com.basicData.dao;

import java.util.List;

import com.model.Page;
import com.model.Supplier;
import com.model.SupplierProduct;

public interface SupplierDao {

	public List<Supplier> listSupplier(Supplier su, Page page);
	public Integer supplierCount(Supplier su);
	public void addSupplier(Supplier su);
	public void deleteSupplier(String partnerId);
	public Supplier selectSupplier(String partnerId);
	public void updateSupplier(Supplier supplier);
	public List<SupplierProduct> productDetail(String partnerId);
	public List<Supplier> homeListSupplierMore(Page page);
}
