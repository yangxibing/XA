package com.systemManage.dao;

import java.util.List;

import com.model.Page;
import com.model.XALog;

public interface LogLookupDao {
	public List<XALog> getXAUserLogInfoByLog(XALog xalog);
	public List<XALog> getXAUserLogInfoByLog(XALog xalog, Page page);
	public Integer xalogTotalCount(XALog xalog);
}
