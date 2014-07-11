package com.systemManage.service;

import java.util.List;

import com.model.Page;
import com.model.XALog;

public interface LogLookupService {

	public List<XALog> getXAUserLogInfoByLog(XALog xalog);
	public List<XALog> getXAUserLogInfoByLog(XALog xalog, Page page);
	public Integer xalogTotalCount(XALog xalog);
}
