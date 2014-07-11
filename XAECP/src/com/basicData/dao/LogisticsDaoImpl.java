package com.basicData.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Page;
import com.model.Supplier;

public class LogisticsDaoImpl extends SqlMapClientDaoSupport implements LogisticsDao {

	public void addLogistics(Supplier su) {
		this.getSqlMapClientTemplate().insert("logistics.addLogistics", su);	
	}

	public void deleteLogistics(String logisticsId) {
		this.getSqlMapClientTemplate().delete("logistics.deleteLogistics", logisticsId);
	}

	public Supplier getLogisticsById(String id) {
		return (Supplier)this.getSqlMapClientTemplate().queryForObject("logistics.getLogisticsById", id);
	}

	public List<Supplier> listLogistics(Supplier su) {
		List<Supplier> list = this.getSqlMapClientTemplate().queryForList("logistics.listLogistics", su);
		return list;
	}

	public void updateLogistics(Supplier su) {	
		this.getSqlMapClientTemplate().update("logistics.updateLogistics", su);
	}

	public List<Supplier> listLogistics(Supplier su, Page page) {
		List<Supplier> list = this.getSqlMapClientTemplate().queryForList("logistics.listLogistics", su, page.getStart(), page.getRowCount());
		return list;
	}

	public Integer logisticsTotalCount(Supplier su) {
		return (Integer) this.getSqlMapClientTemplate().queryForObject("logistics.logisticsTotalCount", su);
	}
}
