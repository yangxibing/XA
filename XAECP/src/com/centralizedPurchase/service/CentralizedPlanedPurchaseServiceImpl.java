package com.centralizedPurchase.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.centralizedPurchase.dao.CentralizedPlanedPurchaseDao;
import com.model.CentralizedPlanedPurchase;
import com.model.CentralizedPurchaseSupplyPrice;
import com.model.Page;

public class CentralizedPlanedPurchaseServiceImpl implements CentralizedPlanedPurchaseService{

	private CentralizedPlanedPurchaseDao centralizedPlanedPurchaseDao;
	public List<CentralizedPlanedPurchase> listCPR(String purchaserId) {
		
		List<CentralizedPlanedPurchase> list = this.centralizedPlanedPurchaseDao.listCPR(purchaserId);
		for(int i=0;i<list.size();i++){
			list.get(i).setDemandStateName(getNameById(list.get(i).getDemandState()));
		}
		return list;
	}
	public List<CentralizedPurchaseSupplyPrice> selectProductsByCPIIdAndSupplierId(
			String purchaserId, String CPIId) {
		Map<String ,String> map = new HashMap<String, String>();
		map.put("purchaserId", purchaserId);
		map.put("CPIId", CPIId);
		
		return this.centralizedPlanedPurchaseDao.selectProductsByCPIIdAndSupplierId(map);
	}
	
	private String getNameById(String id){
		switch(Integer.parseInt(id)){
			case 0:return "需求已提交";
			case 1:return "需求已合并";
			case 2:return "价格已发布";
			case 3:return "取消";
			case 4:return "需求已确认";
			default: return "出错";
		}
	}
	
	private String getCPIStateById(short id){
		switch(id){
			case 0:return "未发布";
			case 1:return "信息已发布";
			case 2:return "需求已合并";
			case 3:return "价格发布";
			case 4:return "需求已确认";
			case 5:return "购买中";
			case 6:return "完成";
			default:return "";
		}
	}
	public CentralizedPlanedPurchaseDao getCentralizedPlanedPurchaseDao() {
		return centralizedPlanedPurchaseDao;
	}
	
	public void setCentralizedPlanedPurchaseDao(
			CentralizedPlanedPurchaseDao centralizedPlanedPurchaseDao) {
		this.centralizedPlanedPurchaseDao = centralizedPlanedPurchaseDao;
	}
	public void updateDemandState(String CPIId, String purchaserId,
			String demandState) {
		Map<String, String> map = new HashMap<String,String>();
		map.put("CPIId", CPIId);
		map.put("purchaserId", purchaserId);
		map.put("demandState",demandState);
		this.centralizedPlanedPurchaseDao.updateDemandState(map);
	}
	public CentralizedPlanedPurchase getCPIByCPIId(String CPIId) {
		
		CentralizedPlanedPurchase c =  this.centralizedPlanedPurchaseDao.getCPIByCPIId(CPIId);
		c.setCentralizedPurchaseStateName(getCPIStateById(c.getCentralizedPurchaseState()));
		return c;
	}
	public Integer CPRTotalCount(String purchaserId) {
		return this.centralizedPlanedPurchaseDao.CPRTotalCount(purchaserId);
	}
	public List<CentralizedPlanedPurchase> listCPR(String purchaserId, Page page) {
		List<CentralizedPlanedPurchase> list = this.centralizedPlanedPurchaseDao.listCPR(purchaserId, page);
		for(int i=0;i<list.size();i++){
			list.get(i).setDemandStateName(getNameById(list.get(i).getDemandState()));
		}
		return list;
	}
}
