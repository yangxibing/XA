package com.systemManage.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.Page;
import com.model.XALog;

public class LogLookupDaoImpl extends SqlMapClientDaoSupport implements LogLookupDao {

	public List<XALog> getXAUserLogInfoByLog(XALog xalog){
		return this.getSqlMapClientTemplate().queryForList("XALog.getXAUserLogInfoByLog", xalog);
	}
	
	public List<XALog> getXAUserLogInfoByLog(XALog xalog, Page page){
		return this.getSqlMapClientTemplate().queryForList("XALog.getXAUserLogInfoByLog", xalog, page.getStart(), page.getRowCount());
	}
	
	public Integer xalogTotalCount(XALog xalog){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("XALog.xalogTotalCount", xalog);
	}
}
