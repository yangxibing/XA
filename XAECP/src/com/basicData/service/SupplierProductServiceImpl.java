package com.basicData.service;

import java.util.ArrayList;
import java.util.List;

import com.basicData.dao.SupplierProductDao;
import com.model.Page;
import com.model.SupplierProduct;
import com.model.SupplierProductPrice;

public class SupplierProductServiceImpl implements SupplierProductService{

	private SupplierProductDao supplierProductDao;

	public void addSupplierProduct(SupplierProduct su) {
		this.supplierProductDao.addSupplierProduct(su);
	}
	

	public SupplierProductDao getSupplierProductDao() {
		return supplierProductDao;
	}

	public void setSupplierProductDao(SupplierProductDao supplierProductDao) {
		this.supplierProductDao = supplierProductDao;
	}


	public SupplierProduct selectSupplierProduct(String productId) {
		
		return this.getSupplierProductDao().selectSupplierProduct(productId);
	}


	public void updateSupplierProduct(SupplierProduct su) {
		
		this.getSupplierProductDao().updateSupplierProduct(su);
	}


	public List<SupplierProduct> selectProductBySupplierId(SupplierProduct su) {
		
		return this.supplierProductDao.selectProductBySupplierId(su);
	}
	public void deleteSupplierProduct(String partnerIdList) {
		String[] list=partnerIdList.split(",");
		for(int i=0;i<list.length;i++){
			System.out.println(list[i]);
			this.supplierProductDao.deleteSupplierProduct(list[i]);
		}
	}


	public List<SupplierProduct> listSupplierProduct(SupplierProduct su) {
		
		return this.supplierProductDao.listSupplierProduct(su);
	}


	public List<SupplierProductPrice> productPrice(String productId, Page page) {
		
		return this.supplierProductDao.productPrice(productId, page);
	}
	
	public Integer priceTotalCount(String productId){
		
		return this.supplierProductDao.priceTotalCount(productId);
	}

	public List<SupplierProduct> listSupplierProduct(
			SupplierProduct supplierProduct, Page page) {
		try{
		return this.supplierProductDao.listSupplierProduct(supplierProduct, page);
		}catch(Exception e){
			e.printStackTrace();
			return new ArrayList<SupplierProduct>();
		}
	}


	public Integer supplierProductTotalCount(SupplierProduct supplierProduct) {
		return this.supplierProductDao.supplierProductTotalCount(supplierProduct);
	}
	
	
}
