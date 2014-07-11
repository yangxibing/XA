package com.basicData.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Page;
import com.model.Supplier;
import com.model.SupplierProduct;
import com.model.SupplierProductPrice;

public class SupplierProductDaoImpl extends SqlMapClientDaoSupport implements SupplierProductDao{

	public void addSupplierProduct(SupplierProduct su) {
		
		this.getSqlMapClientTemplate().insert("supplierProduct.addSupplierProduct", su);
	}

	public SupplierProduct selectSupplierProduct(String productId) {
		
		Map<String,String> map=new HashMap<String,String>();
		map.put("productId", productId);
		return (SupplierProduct) this.getSqlMapClientTemplate().queryForObject("supplierProduct.selectSupplierProduct",map );
	}

	public void updateSupplierProduct(SupplierProduct su) {
		this.getSqlMapClientTemplate().update("supplierProduct.updateSupplierProduct",su );
	}

	public List<SupplierProduct> selectProductBySupplierId(SupplierProduct su) {
		
		return this.getSqlMapClientTemplate().queryForList("supplierProduct.selectProductBySupplierId",su );
	}

	public void deleteSupplierProduct(String productId) {
		Map<String,String> map=new HashMap<String,String>();
		map.put("productId", productId);
		this.getSqlMapClientTemplate().delete("supplierProduct.deleteSupplierProduct",map);
	}

	public List<SupplierProduct> listSupplierProduct(SupplierProduct su) {
		
		return this.getSqlMapClientTemplate().queryForList("supplierProduct.listSupplierProduct", su);
	}

	public List<SupplierProductPrice> productPrice(String productId, Page page) {
		
		Map<String ,String> map=new HashMap<String,String>();
		map.put("productId", productId);
		return this.getSqlMapClientTemplate().queryForList("productPrice", map, page.getStart(), page.getRowCount());
	}

	public List<SupplierProduct> listSupplierProduct(
			SupplierProduct supplierProduct, Page page) {

		return this.getSqlMapClientTemplate().queryForList("supplierProduct.listSupplierProduct", supplierProduct, page.getStart(), page.getRowCount());
		
	}

	public Integer supplierProductTotalCount(SupplierProduct supplierProduct) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("supplierProduct.supplierProductTotalCount", supplierProduct);
	}
	
	public Integer priceTotalCount(String productId){
		
		return (Integer) this.getSqlMapClientTemplate().queryForObject("priceTotalCount", productId);
	}

}
