package com.basicData.service;

import java.util.List;

import com.basicData.dao.ProductPriceDao;
import com.model.SupplierProductPrice;

public class ProductPriceServiceImpl implements ProductPriceService{

	private ProductPriceDao productPriceDao;
	
	public void addPrice(SupplierProductPrice su) {
		this.productPriceDao.addPrice(su);
	}
	
	public ProductPriceDao getProductPriceDao() {
		return productPriceDao;
	}
	public void setProductPriceDao(ProductPriceDao productPriceDao) {
		this.productPriceDao = productPriceDao;
	}

	public SupplierProductPrice selectPrice(SupplierProductPrice su) {
		
		return this.productPriceDao.selectPrice(su);
	}

	public void updatePrice(SupplierProductPrice su) {
		this.productPriceDao.updatePrice(su);
	}

	public void deletePrice(String productId,String numberList) {
		
		String []num=numberList.split(",");
		for(int i=0;i<num.length;i++){
			this.productPriceDao.deletePrice(productId,num[i]);
		}
	}

}
