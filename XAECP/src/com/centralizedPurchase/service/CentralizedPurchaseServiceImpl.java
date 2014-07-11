package com.centralizedPurchase.service;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.centralizedPurchase.dao.CentralizedPurchaseDao;
import com.model.CentralizedPlanedPurchase;
import com.model.CentralizedPurchaseDemand;
import com.model.CentralizedPurchaseSupplyPrice;
import com.model.Page;
import com.model.ProductType;
import com.model.PurchaseOrder;
import com.model.SupplierProduct;

public class CentralizedPurchaseServiceImpl implements CentralizedPurchaseService {
	
	private CentralizedPurchaseDao centralizedPurchaseDao;
	
	/**
	 * ��ȡ���вɹ���Ϣ����
	 */
	public String getCentralizedPurchaseTitleList(){
		CentralizedPlanedPurchase purchase = new CentralizedPlanedPurchase();
		purchase.setCentraOrplaned(false);
		List<CentralizedPlanedPurchase> list = this.centralizedPurchaseDao.getCentralizedPurchaseTitleList(purchase);
		
		String titleList = "";
		if(list.size() > 0){
			int index=0;
			for(; index<list.size()-1; index++){
				titleList += list.get(index).getCpPurchaseInfoId() + " " + list.get(index).getCpPurchaseInfoTitle() + ",";
			}
			titleList += list.get(index).getCpPurchaseInfoId() + " " + list.get(index).getCpPurchaseInfoTitle();
		}
		return titleList;
	}
	
	/**
	 * ��ȡ��Ʒ�����б�
	 */
	public String getProductTypeList(){
		ProductType type = new ProductType();
		List<ProductType> list = this.centralizedPurchaseDao.getProductTypeList(type);
		
		String productTypeList = "";
		if(list.size() > 0){
			int index = 0;
			for(; index<list.size()-1; index++){
				productTypeList += list.get(index).getProductTypeId() + " " + list.get(index).getProductTypeName() + ",";
			}
			productTypeList += list.get(index).getProductTypeId() + " " + list.get(index).getProductTypeName();
		}
		return productTypeList;
	}
	
	/**
	 * ��ȡ��ʼʱ��������Ʒ���������б�
	 */
	public ProductType getProductTypeTreeList(){
		ProductType type = new ProductType();
		type.setParentProductTypeId("NULL");
		type = this.centralizedPurchaseDao.getProductListByParantId(type).get(0);
		
		ProductType temp = new ProductType();
		temp.setParentProductTypeId(type.getProductTypeId());
		type.setChildrenList(this.centralizedPurchaseDao.getProductListByParantId(temp));
		return type;
	}
	
	/**
	 * ��ȡĳһ��Ʒ���͵�����ֱ��������
	 */
	public List<ProductType> getProductTypeTreeBranch(String id){
		ProductType type = new ProductType();
		type.setParentProductTypeId(id);
		return this.centralizedPurchaseDao.getProductListByParantId(type);
	}
	
	/**
	 * ��ȡ���вɹ���Ϣ�б�
	 * @return
	 */
	public List<CentralizedPlanedPurchase> getCentralizedPurchaseList(CentralizedPlanedPurchase purchase){
		purchase.setCentraOrplaned(false);
		List<CentralizedPlanedPurchase> list = this.centralizedPurchaseDao.getCentralizedPurchaseList(purchase);
		for(int index=0; index<list.size(); index++){
			if(list.get(index).getDeadline()!=null && list.get(index).getDeadline().trim().length()!=0){
				list.get(index).setDeadline(list.get(index).getDeadline().split(" ")[0]);
			}
			if(list.get(index).getPublishDate()!=null && list.get(index).getPublishDate().trim().length()!=0){
				list.get(index).setPublishDate(list.get(index).getPublishDate().split(" ")[0]);
			}
		}
		return list;
	}
	
	public List<CentralizedPlanedPurchase> getCentralizedPurchaseList(CentralizedPlanedPurchase purchase, Page page){
		purchase.setCentraOrplaned(false);
		List<CentralizedPlanedPurchase> list = this.centralizedPurchaseDao.getCentralizedPurchaseList(purchase, page);
		for(int index=0; index<list.size(); index++){
			if(list.get(index).getDeadline()!=null && list.get(index).getDeadline().trim().length()!=0){
				list.get(index).setDeadline(list.get(index).getDeadline().split(" ")[0]);
			}
			if(list.get(index).getPublishDate()!=null && list.get(index).getPublishDate().trim().length()!=0){
				list.get(index).setPublishDate(list.get(index).getPublishDate().split(" ")[0]);
			}
		}
		return list;		
	}
	
	/**
	 * ��ȡ���вɹ�������
	 */
	public Integer centralizedPurchaseTotalCount(CentralizedPlanedPurchase purchase){
		purchase.setCentraOrplaned(false);
		return this.centralizedPurchaseDao.centralizedPurchaseTotalCount(purchase);
	}
	
	/**
	 *ɾ��δ�����ļ��вɹ���Ϣ
	 */
	public void deleteCentralizedPurchase(String deleteList){
		String[] list = deleteList.split(",");
		for(int index=0; index<list.length; index++){
			this.centralizedPurchaseDao.deleteCentralizedPurchaseById(list[index]);
		}
	}
	
	/**
	 * ���ݼ��вɹ������ȡ���вɹ�����
	 * @throws ParseException 
	 */
	public CentralizedPlanedPurchase getCentralizedPurchaseById(String id){
		CentralizedPlanedPurchase purchase = this.centralizedPurchaseDao.getCentralizedPurchaseById(id);
		if(purchase.getDeadline() != null && purchase.getDeadline().trim().length() != 0){
			purchase.setDeadline(purchase.getDeadline().split(" ")[0]);
		}
		if(purchase.getPublishDate() != null && purchase.getPublishDate().trim().length() != 0){
			purchase.setPublishDate(purchase.getPublishDate().split(" ")[0]);
		}
		String interval = purchase.getPurchasePriceInterval();
		if(interval != null && interval.length() != 0){
			purchase.setPurchasePriceBegin(interval.split("-")[0]);
			if(purchase.getPurchasePriceBegin().equals("min")){
				purchase.setPurchasePriceBegin("");
			}
			purchase.setPurchasePriceEnd(interval.split("-")[1]);
			if(purchase.getPurchasePriceEnd().equals("max")){
				purchase.setPurchasePriceEnd("");
			}
			purchase.setPurchasePriceUnit(interval.split("-")[2]);
		}
		
		//�жϼ��вɹ���Ϣ�Ƿ������
		purchase.setApplyAvailable(new Short("0"));
		if(purchase.getDeadline() != null && purchase.getDeadline().trim().length() != 0){
			try {
				DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date deadline = format.parse(purchase.getDeadline());
				Date now = new Date();
				if(deadline.getTime() <= now.getTime()){
					purchase.setApplyAvailable(new Short("1"));
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(purchase.getCentralizedPurchaseState() != 1){
			purchase.setApplyAvailable(new Short("2"));
		}
		
		return purchase;
	}
	
	/**
	 * �����µļ��вɹ���Ϣ
	 */
	public void addCentralizedPurchase(CentralizedPlanedPurchase purchase){
		if(purchase.getPurchasePriceBegin() == null || purchase.getPurchasePriceBegin().trim().length() == 0){
			purchase.setPurchasePriceInterval("min");
		} else {
			purchase.setPurchasePriceInterval(purchase.getPurchasePriceBegin());
		}
		if(purchase.getPurchasePriceEnd() == null || purchase.getPurchasePriceEnd().trim().length() == 0){
			purchase.setPurchasePriceInterval(purchase.getPurchasePriceInterval() + "-max");
		} else {
			purchase.setPurchasePriceInterval(purchase.getPurchasePriceInterval() + "-" + purchase.getPurchasePriceEnd());
		}
		purchase.setPurchasePriceInterval(purchase.getPurchasePriceInterval() + "-" + purchase.getPurchasePriceUnit());
		
		this.centralizedPurchaseDao.addCentralizedPurchase(purchase);
	}
	
	/**
	 * �������еļ��вɹ���Ϣ
	 */
	public void updateCentralizedPurchase(CentralizedPlanedPurchase purchase){
		if(purchase.getPurchasePriceBegin() == null || purchase.getPurchasePriceBegin().trim().length() == 0){
			purchase.setPurchasePriceInterval("min");
		} else {
			purchase.setPurchasePriceInterval(purchase.getPurchasePriceBegin());
		}
		if(purchase.getPurchasePriceEnd() == null || purchase.getPurchasePriceEnd().trim().length() == 0){
			purchase.setPurchasePriceInterval(purchase.getPurchasePriceInterval() + "-max");
		} else {
			purchase.setPurchasePriceInterval(purchase.getPurchasePriceInterval() + "-" + purchase.getPurchasePriceEnd());
		}
		purchase.setPurchasePriceInterval(purchase.getPurchasePriceInterval() + "-" + purchase.getPurchasePriceUnit());
		
		this.centralizedPurchaseDao.updateCentralizedPurchase(purchase);
	}
	
	/**
	 * ���ݲ���ָ������������ȡ���вɹ���Ϣ��Ӧ�������б�
	 */
	public List<CentralizedPurchaseDemand> getCentralizedPurchaseDemandList(CentralizedPurchaseDemand demand){
		List<CentralizedPurchaseDemand> list = this.centralizedPurchaseDao.getCentralizedPurchaseDemandList(demand);
		for(int index=0; index<list.size(); index++){
			if(list.get(index).getReportDemandTime()!=null && list.get(index).getReportDemandTime().trim().length()!=0){
				list.get(index).setReportDemandTime(list.get(index).getReportDemandTime().split(" ")[0]);
			}
		}
		return list;
	}
	
	/**
	 * 
	 */
	public void addCentralizedPurchaseDemand(CentralizedPurchaseDemand demand){
		this.centralizedPurchaseDao.addCentralizedPurchaseDemand(demand);
	}
	
	/**
	 * ���¼��вɹ�����״̬
	 */
	public void updateCentralizedPurchaseDemandState(CentralizedPurchaseDemand demand){
		this.centralizedPurchaseDao.updateCentralizedPurchaseDemandState(demand);
	}
	
	/**
	 * ���¼��вɹ��ϲ��ƻ�����
	 */
	public void updateCentralizedPurchaseCombineNumber(CentralizedPlanedPurchase purchase){
		this.centralizedPurchaseDao.updateCentralizedPurchaseCombineNumber(purchase);
	}

	/**
	 * ���¼��вɹ���Ϣ״̬
	 */
	public void updateCentralizedPurchaseState(CentralizedPlanedPurchase purchase){
		this.centralizedPurchaseDao.updateCentralizedPurchaseState(purchase);
	}
	
	/**
	 * ���ݲ�Ʒ����id��ȡ��Ʒ�б�
	 * @return
	 */
	public List<SupplierProduct> getProductListByType(String id){
		return this.centralizedPurchaseDao.getProductListByType(id);
	}
	
	/**
	 * �����۸�󣬸��¼��вɹ���Ʒ�۸��
	 * @return
	 */
	public void publishPriceCommit(String id, String priceList){
		CentralizedPurchaseSupplyPrice price = new CentralizedPurchaseSupplyPrice();
		price.setCPIId(id);
		String[] list = priceList.split(",");
		for(int index=0; index<list.length; index++){
			price.setProductId(list[index].split(" ")[0]);
			price.setPrice(Double.parseDouble(list[index].split(" ")[1]));
			this.centralizedPurchaseDao.addCentralizedPurchaseSupplyPrice(price);
		}
	}
	
	public List<CentralizedPurchaseSupplyPrice> getCentralizedPurchaseSupplyPriceList(String id){
		return this.centralizedPurchaseDao.getCentralizedPurchaseSupplyPriceList(id);
	}
	
	/**
	 * ��ȡ��Ӧ���вɹ���ȫ���ɹ��̶���
	 */
	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder order){
		return this.centralizedPurchaseDao.queryPurchaseOrderList(order);
	}
	
	/**
	 * ���вɹ���������ǰ��ȡ����������������ж��Ƿ�������ü��вɹ���Ϣ
	 */
	public Integer countCentralizedPurchaseDemand(CentralizedPurchaseDemand demand){
		return this.centralizedPurchaseDao.countCentralizedPurchaseDemand(demand);
	}
	
	public CentralizedPurchaseDao getCentralizedPurchaseDao() {
		return centralizedPurchaseDao;
	}

	public void setCentralizedPurchaseDao(
			CentralizedPurchaseDao centralizedPurchaseDao) {
		this.centralizedPurchaseDao = centralizedPurchaseDao;
	}
}
