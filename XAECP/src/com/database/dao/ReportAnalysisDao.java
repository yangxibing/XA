package com.database.dao;

import java.util.List;

import com.model.BaseOrder;
import com.model.PurchaseOrder;
import com.model.ReportAnalysis;

public interface ReportAnalysisDao {
	public List<ReportAnalysis> purchaserReportAnalysis(PurchaseOrder order);
	public List<ReportAnalysis> baseReportAnalysis(BaseOrder order);
}
