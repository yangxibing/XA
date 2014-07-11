package com.basicData.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Page;
import com.model.Supplier;

public class PurchaserDaoImpl extends SqlMapClientDaoSupport implements PurchaserDao{

	public void addPurchaser(Supplier su) {
		this.getSqlMapClientTemplate().insert("purchaser.addPurchaser", su);
	}

	public List<Supplier> listPurchaser(Supplier su) {
		List<Supplier> list = this.getSqlMapClientTemplate().queryForList("purchaser.listPurchaser", su);
		return list;
	}
	
	public List<Supplier> listPurchaser(Supplier su, Page page){
		return this.getSqlMapClientTemplate().queryForList("purchaser.listPurchaser", su, page.getStart(), page.getRowCount());
	}
	
	public Integer purchaserTotalCount(Supplier purchaser){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("purchaser.purchaserTotalCount", purchaser);
	}

	public void updatePurchaser(Supplier su) {
		this.getSqlMapClientTemplate().update("purchaser.updatePurchaser", su);
	}
	
	public Supplier getIndexPurchaser(String id){
		return (Supplier) this.getSqlMapClientTemplate().queryForObject("purchaser.getPurchaserById", id);
	}

	public void deletePurchaser(String id) {
		this.getSqlMapClientTemplate().delete("purchaser.deletePurchaserById", id);
	}
}
