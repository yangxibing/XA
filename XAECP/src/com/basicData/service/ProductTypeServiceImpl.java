package com.basicData.service;

import java.util.List;

import com.basicData.dao.ProductTypeDao;
import com.model.Page;
import com.model.ProductType;

public class ProductTypeServiceImpl implements ProductTypeService {

	private ProductTypeDao productTypeDao;
	
	public ProductTypeDao getProductTypeDao() {
		return productTypeDao;
	}

	public void setProductTypeDao(ProductTypeDao productTypeDao) {
		this.productTypeDao = productTypeDao;
	}

	public List<ProductType> listProductType(ProductType pt) {	
		return this.productTypeDao.listProductType(pt);
	}

	public boolean addProductType(ProductType pt) {
		this.productTypeDao.addProductType(pt);
		return true;
	}

	public boolean deleteProductType(String deleteProTypeIdList) {
		String[] deleteIdArray = deleteProTypeIdList.split(",");
		for (int i=0; i< deleteIdArray.length; i++) {
			this.productTypeDao.deleteProductTypeById(deleteIdArray[i]);
		}
		
		return false;
	}

	public ProductType queryProductType(ProductType pt) {
		return this.productTypeDao.queryProductType(pt);
	}

	public boolean updateProductType(ProductType pt) {
		return this.productTypeDao.updateProductType(pt);
	}

	public List<ProductType> getAllProductType() {
		return this.productTypeDao.getAllProductType();
	}

	public List<ProductType> listProductType(ProductType pt, Page page) {
		return this.productTypeDao.listProductType(pt, page);
	}

	public Integer productTypeTotalCount(ProductType productType) {
		return this.productTypeDao.productTypeTotalCount(productType);
	}
	
	
}
