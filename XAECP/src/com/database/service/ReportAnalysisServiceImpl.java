package com.database.service;

import java.util.List;

import com.database.dao.ReportAnalysisDao;
import com.model.BaseOrder;
import com.model.PurchaseOrder;
import com.model.ReportAnalysis;

public class ReportAnalysisServiceImpl implements ReportAnalysisService {
	private ReportAnalysisDao reportAnalysisDao;

	public List<ReportAnalysis> purchaserReportAnalysis(PurchaseOrder order){
		return this.reportAnalysisDao.purchaserReportAnalysis(order);
	}
	
	public List<ReportAnalysis> baseReportAnalysis(BaseOrder order){
		return this.reportAnalysisDao.baseReportAnalysis(order);
	}
	
	public ReportAnalysisDao getReportAnalysisDao() {
		return reportAnalysisDao;
	}

	public void setReportAnalysisDao(ReportAnalysisDao reportAnalysisDao) {
		this.reportAnalysisDao = reportAnalysisDao;
	}
}