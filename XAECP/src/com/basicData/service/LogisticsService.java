package com.basicData.service;

import java.util.List;

import com.model.Page;
import com.model.Supplier;

public interface LogisticsService {
	
	public List<Supplier> listLogistics(Supplier su);
	
	public List<Supplier> listLogistics(Supplier su, Page page);
	
	public Integer logisticsTotalCount(Supplier su);
	
	public void addLogistics(Supplier su);
	
	
	public void updateLogistics(Supplier su);
	
	
	public Supplier getLogisticsById(String id);
	
	public void deleteLogistics(String logisticsList);
}
