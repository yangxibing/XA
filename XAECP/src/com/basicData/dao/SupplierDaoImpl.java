package com.basicData.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Page;
import com.model.Supplier;
import com.model.SupplierProduct;

public class SupplierDaoImpl extends SqlMapClientDaoSupport implements SupplierDao{


	public List<Supplier> listSupplier(Supplier su, Page page) {
		
		return (List<Supplier>)this.getSqlMapClientTemplate().queryForList("supplier.listSupplier", su, page.getStart(),page.getRowCount());	
	}
	//列出supplier的总数目，分页用
	public Integer supplierCount(Supplier su){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("supplier.supplierCount", su);
	}
	public void addSupplier(Supplier su) {
		this.getSqlMapClientTemplate().insert("supplier.addSupplier", su);
	}
	public void deleteSupplier(String partnerId) {
		Map<String,String> map=new HashMap<String,String>();
		map.put("partnerId", partnerId);
		this.getSqlMapClientTemplate().delete("supplier.deleteSupplier",map);
	}
	public Supplier selectSupplier(String partnerId) {
		Map<String,String> map=new HashMap<String,String>();
		map.put("partnerId", partnerId);
		return (Supplier) this.getSqlMapClientTemplate().queryForObject("supplier.selectSupplier", map);
	}
	public void updateSupplier(Supplier supplier) {
		
		this.getSqlMapClientTemplate().update("supplier.updateSupplier", supplier);
	}
	public List<SupplierProduct> productDetail(String partnerId) {
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("partnerId", partnerId);
		return this.getSqlMapClientTemplate().queryForList("supplierProduct.productDetail", map);
	}
	public List<Supplier> homeListSupplierMore(Page page) {
		return (List<Supplier>)this.getSqlMapClientTemplate().queryForList("supplier.homeListSupplierMore", page.getStart(),page.getRowCount());	
	}
}
