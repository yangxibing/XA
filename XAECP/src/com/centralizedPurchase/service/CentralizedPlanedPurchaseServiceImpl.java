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
			case 0:return "�������ύ";
			case 1:return "�����Ѻϲ�";
			case 2:return "�۸��ѷ���";
			case 3:return "ȡ��";
			case 4:return "������ȷ��";
			default: return "����";
		}
	}
	
	private String getCPIStateById(short id){
		switch(id){
			case 0:return "δ����";
			case 1:return "��Ϣ�ѷ���";
			case 2:return "�����Ѻϲ�";
			case 3:return "�۸񷢲�";
			case 4:return "������ȷ��";
			case 5:return "������";
			case 6:return "���";
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
