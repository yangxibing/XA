package com.basicData.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.SupplierProductPrice;

public class ProductPriceDaoImpl extends SqlMapClientDaoSupport implements ProductPriceDao{

	public void addPrice(SupplierProductPrice su) {
		
		this.getSqlMapClientTemplate().insert("addPrice",su);
	}

	public SupplierProductPrice selectPrice(SupplierProductPrice su) {
		
		return (SupplierProductPrice) this.getSqlMapClientTemplate().queryForObject("selectPrice", su);
	}

	public void updatePrice(SupplierProductPrice su) {
		
		this.getSqlMapClientTemplate().update("updatePrice", su);
	}

	public void deletePrice(String productId,String number) {
		Map<String,String> map=new HashMap<String,String>();
		map.put("productId", productId);
		map.put("number", number);
		this.getSqlMapClientTemplate().delete("deletePrice",map);
	}

}
