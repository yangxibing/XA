package com.basicData.service;

import java.util.List;

import com.basicData.dao.LogisticsDao;
import com.model.Page;
import com.model.Supplier;

public class LogisticsServiceImpl implements LogisticsService{

	private LogisticsDao logisticsDao;
	public void addLogistics(Supplier su) {
		logisticsDao.addLogistics(su);	
	}

	public void deleteLogistics(String logisticsList) {
		String[] deleteIdArray = logisticsList.split(",");
		for (int i=0; i< deleteIdArray.length; i++) {
			this.logisticsDao.deleteLogistics(deleteIdArray[i]);
		}
	}

	public Supplier getLogisticsById(String id) {
		return logisticsDao.getLogisticsById(id);
	}

	public List<Supplier> listLogistics(Supplier su) {
		return logisticsDao.listLogistics(su);
	}

	public void updateLogistics(Supplier su) {
		logisticsDao.updateLogistics(su);
	}

	public LogisticsDao getLogisticsDao() {
		return logisticsDao;
	}

	public void setLogisticsDao(LogisticsDao logisticsDao) {
		this.logisticsDao = logisticsDao;
	}

	public List<Supplier> listLogistics(Supplier su, Page page) {
		return this.logisticsDao.listLogistics(su, page);
		
	}

	public Integer logisticsTotalCount(Supplier su) {
		return this.logisticsDao.logisticsTotalCount(su);
	}
	
	

}
