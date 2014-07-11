package com.basicData.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Page;
import com.model.ProductType;

public class ProductTypeDaoImpl extends SqlMapClientDaoSupport implements ProductTypeDao {

	@SuppressWarnings("unchecked")
	public List<ProductType> listProductType(ProductType pt) {
		return (List<ProductType>)this.getSqlMapClientTemplate().queryForList("productType.listProductType", pt);
	}

	public ProductType queryProductType(ProductType pt) {		
		return (ProductType)this.getSqlMapClientTemplate().queryForObject("productType.queryProductType", pt);
	}
	
	public boolean addProductType(ProductType pt) {
		this.getSqlMapClientTemplate().insert("productType.addProductType", pt);
		return true;
	}

	public boolean deleteProductTypeById(String productTypeId) {	
		this.getSqlMapClientTemplate().delete("productType.deleteProductType", productTypeId);
		return true;
	}

	public boolean updateProductType(ProductType pt) {
		this.getSqlMapClientTemplate().update("productType.updateProductType", pt);
		return true;
	}

	public List<ProductType> getAllProductType() {
		return (List<ProductType>)this.getSqlMapClientTemplate().queryForList("productType.getAllProductType");
	}

	public List<ProductType> listProductType(ProductType pt, Page page) {
		return (List<ProductType>)this.getSqlMapClientTemplate().queryForList("productType.listProductType", pt, page.getStart(), page.getRowCount());
	}

	public Integer productTypeTotalCount(ProductType productType) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("productType.productTypeTotalCount", productType);
	}
}
