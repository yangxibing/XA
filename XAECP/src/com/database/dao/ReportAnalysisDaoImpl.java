package com.database.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.BaseOrder;
import com.model.PurchaseOrder;
import com.model.ReportAnalysis;

public class ReportAnalysisDaoImpl extends SqlMapClientDaoSupport implements ReportAnalysisDao{
	public List<ReportAnalysis> purchaserReportAnalysis(PurchaseOrder order){
		return this.getSqlMapClientTemplate().queryForList("reportAnalysis.purchaserReportAnalysis", order);
	}
	
	public List<ReportAnalysis> baseReportAnalysis(BaseOrder order){
		return this.getSqlMapClientTemplate().queryForList("reportAnalysis.baseReportAnalysis", order);
	}
}
