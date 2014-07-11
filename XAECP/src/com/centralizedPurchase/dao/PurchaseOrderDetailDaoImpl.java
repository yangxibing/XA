package com.centralizedPurchase.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.PurchaseOrderDetail;

public class PurchaseOrderDetailDaoImpl extends SqlMapClientDaoSupport implements PurchaseOrderDetailDao{

	public List<PurchaseOrderDetail> selectProduct(String purId) {
		
		return this.getSqlMapClientTemplate().queryForList("selectProducts", purId);
	}

	public String getProductNameById(String id) {
		
		return (String) this.getSqlMapClientTemplate().queryForObject("getProductNameById", id);
	}
}
