package com.basicData.dao;

import java.util.List;

import com.model.Page;
import com.model.SupplierProduct;

public interface ProductCatalogDao {
	public List<SupplierProduct> listProduct(SupplierProduct sp);
	public List<SupplierProduct> listProduct(SupplierProduct sp, Page page);
	public Integer productTotalCount(SupplierProduct sp);
}
