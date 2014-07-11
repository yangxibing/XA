package com.basicData.service;

import java.util.List;

import com.model.Page;
import com.model.ProductType;

public interface ProductTypeService {
	public List<ProductType> listProductType(ProductType pt);
	
	public ProductType queryProductType(ProductType pt);
	public boolean addProductType(ProductType pt);
	public boolean updateProductType(ProductType pt);
	public boolean deleteProductType(String deleteProTypeIdList);
	public List<ProductType> getAllProductType();
	public Integer productTypeTotalCount(ProductType productType);
	public List<ProductType> listProductType(ProductType pt, Page page);
}
