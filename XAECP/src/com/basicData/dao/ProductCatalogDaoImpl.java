package com.basicData.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Page;
import com.model.SupplierProduct;

public class ProductCatalogDaoImpl extends SqlMapClientDaoSupport implements ProductCatalogDao {

	public List<SupplierProduct> listProduct(SupplierProduct sp) {
		List<SupplierProduct> list = this.getSqlMapClientTemplate().queryForList("supplierProduct.listProduct", sp);
		return list;
	}

	public List<SupplierProduct> listProduct(SupplierProduct sp, Page page) {
		List<SupplierProduct> list = this.getSqlMapClientTemplate().queryForList("supplierProduct.listProduct", sp, page.getStart(), page.getRowCount());
		return list;
	}

	public Integer productTotalCount(SupplierProduct sp) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("supplierProduct.productTotalCount", sp);
	}

}
