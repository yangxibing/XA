package com.database.service;

import java.util.List;

import com.model.BaseOrder;
import com.model.PurchaseOrder;
import com.model.ReportAnalysis;

public interface ReportAnalysisService {
	public List<ReportAnalysis> purchaserReportAnalysis(PurchaseOrder order);
	public List<ReportAnalysis> baseReportAnalysis(BaseOrder order);
}
