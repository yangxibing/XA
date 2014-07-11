package com.basicData.dao;

import java.util.List;

import com.model.Page;
import com.model.ProductType;

public interface ProductTypeDao {
	public List<ProductType> listProductType(ProductType pt);
	public ProductType queryProductType(ProductType pt);
	public boolean addProductType(ProductType pt);
	public boolean deleteProductTypeById(String productId);
	public boolean updateProductType(ProductType pt);
	public List<ProductType> getAllProductType();
	public Integer productTypeTotalCount(ProductType productType);
	public List<ProductType> listProductType(ProductType pt, Page page);
}
