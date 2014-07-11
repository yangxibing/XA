package com.systemManage.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import com.model.Page;
import com.model.XALog;
import com.systemManage.dao.LogLookupDao;

public class LogLookupServiceImpl implements LogLookupService {
	private LogLookupDao logLookupDao;

	/**
	 * 获取用户登录日志信息
	 */
	public List<XALog> getXAUserLogInfoByLog(XALog xalog){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			if(xalog.getBeginTime() != null && xalog.getBeginTime().length() != 0 && xalog.getBeginTime().trim().length() != 0){
				xalog.setBeginTimeDate(dateFormat.parse(xalog.getBeginTime()+" 00:00:00"));	
			}
			if(xalog.getEndTime() != null && xalog.getEndTime().length() != 0 && xalog.getEndTime().trim().length() != 0){
				xalog.setEndTimeDate(dateFormat.parse(xalog.getEndTime()+" 23:59:59"));
			}
			if(xalog.getBeginTimeDate()!=null && xalog.getEndTimeDate()!=null && xalog.getBeginTimeDate().getTime() > xalog.getEndTimeDate().getTime()){
				return null;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return this.logLookupDao.getXAUserLogInfoByLog(xalog);
	}
	
	public List<XALog> getXAUserLogInfoByLog(XALog xalog, Page page){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			if(xalog.getBeginTime() != null && xalog.getBeginTime().length() != 0 && xalog.getBeginTime().trim().length() != 0){
				xalog.setBeginTimeDate(dateFormat.parse(xalog.getBeginTime()+" 00:00:00"));	
			}
			if(xalog.getEndTime() != null && xalog.getEndTime().length() != 0 && xalog.getEndTime().trim().length() != 0){
				xalog.setEndTimeDate(dateFormat.parse(xalog.getEndTime()+" 23:59:59"));
			}
			if(xalog.getBeginTimeDate()!=null && xalog.getEndTimeDate()!=null && xalog.getBeginTimeDate().getTime() > xalog.getEndTimeDate().getTime()){
				return null;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return this.logLookupDao.getXAUserLogInfoByLog(xalog, page);		
	}
	
	public Integer xalogTotalCount(XALog xalog){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			if(xalog.getBeginTime() != null && xalog.getBeginTime().length() != 0 && xalog.getBeginTime().trim().length() != 0){
				xalog.setBeginTimeDate(dateFormat.parse(xalog.getBeginTime()+" 00:00:00"));	
			}
			if(xalog.getEndTime() != null && xalog.getEndTime().length() != 0 && xalog.getEndTime().trim().length() != 0){
				xalog.setEndTimeDate(dateFormat.parse(xalog.getEndTime()+" 23:59:59"));
			}
			if(xalog.getBeginTimeDate()!=null && xalog.getEndTimeDate()!=null && xalog.getBeginTimeDate().getTime() > xalog.getEndTimeDate().getTime()){
				return null;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return this.logLookupDao.xalogTotalCount(xalog);		
	}
	
	//Getter and Setter
	public LogLookupDao getLogLookupDao() {
		return logLookupDao;
	}

	public void setLogLookupDao(LogLookupDao logLookupDao) {
		this.logLookupDao = logLookupDao;
	}
}
