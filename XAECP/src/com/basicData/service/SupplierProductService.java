package com.basicData.service;

import java.util.List;

import com.model.Page;
import com.model.SupplierProduct;
import com.model.SupplierProductPrice;

public interface SupplierProductService {

	public void addSupplierProduct(SupplierProduct su);
	public SupplierProduct selectSupplierProduct(String productId);
	public void updateSupplierProduct(SupplierProduct su);
	public List<SupplierProduct> selectProductBySupplierId(SupplierProduct su);
	public void deleteSupplierProduct(String partnerIdList);
	public List<SupplierProduct> listSupplierProduct(SupplierProduct su);
	public List<SupplierProductPrice> productPrice(String productId, Page page);
	public Integer priceTotalCount(String productId);
	public Integer supplierProductTotalCount(SupplierProduct supplierProduct);
	public List<SupplierProduct> listSupplierProduct(SupplierProduct supplierProduct, Page page);
}
