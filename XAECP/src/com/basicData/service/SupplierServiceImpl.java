package com.basicData.service;

import java.util.List;

import com.basicData.dao.SupplierDao;
import com.model.Page;
import com.model.Supplier;
import com.model.SupplierProduct;

public class SupplierServiceImpl implements SupplierService{

	private SupplierDao supplierDao;
	
	public List<Supplier> listSupplier(Supplier su, Page page) {
		
		return this.supplierDao.listSupplier(su, page);
	}
	public Integer supplierCount(Supplier su){
		return supplierDao.supplierCount( su);
	}
	public void addSupplier(Supplier su) {
		this.supplierDao.addSupplier(su);
	}
	public void deleteSupplier(String partnerIdList) {
		String[] list=partnerIdList.split(",");
		for(int i=0;i<list.length;i++){
			System.out.println(list[i]);
			this.supplierDao.deleteSupplier(list[i]);
		}
	}
	public Supplier selectSupplier(String partnerId){
		return this.supplierDao.selectSupplier(partnerId);
	}
	
	public SupplierDao getSupplierDao() {
		return supplierDao;
	}

	public void setSupplierDao(SupplierDao supplierDao) {
		this.supplierDao = supplierDao;
	}

	public void updateSupplier(Supplier supplier) {
		this.supplierDao.updateSupplier(supplier);
	}

	public List<SupplierProduct> productDetail(String partnerId) {
		
		return this.supplierDao.productDetail(partnerId);
	}
	public List<Supplier> homeListSupplierMore(Page page) {
		return this.supplierDao.homeListSupplierMore(page);
	}
}