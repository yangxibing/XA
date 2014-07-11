package com.basicData.service;

import java.util.List;

import com.basicData.dao.ProductCatalogDao;
import com.model.Page;
import com.model.SupplierProduct;

public class ProductCatalogServiceImpl implements ProductCatalogService{

	private ProductCatalogDao productCatalogDao;
	
	public List<SupplierProduct> listProduct(SupplierProduct sp) {
		return productCatalogDao.listProduct(sp);
	}

	public ProductCatalogDao getProductCatalogDao() {
		return productCatalogDao;
	}

	public void setProductCatalogDao(ProductCatalogDao productCatalogDao) {
		this.productCatalogDao = productCatalogDao;
	}

	public List<SupplierProduct> listProduct(SupplierProduct sp, Page page) {
		return this.productCatalogDao.listProduct(sp, page);
	}

	public Integer productTotalCount(SupplierProduct sp) {
		return this.productCatalogDao.productTotalCount(sp);
	}
}
