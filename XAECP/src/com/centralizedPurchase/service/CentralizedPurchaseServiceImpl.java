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
	 * 获取集中采购信息标题
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
	 * 获取产品类型列表
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
	 * 获取初始时的两级产品类型下拉列表
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
	 * 获取某一产品类型的所有直接子类型
	 */
	public List<ProductType> getProductTypeTreeBranch(String id){
		ProductType type = new ProductType();
		type.setParentProductTypeId(id);
		return this.centralizedPurchaseDao.getProductListByParantId(type);
	}
	
	/**
	 * 获取集中采购信息列表
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
	 * 获取集中采购总行数
	 */
	public Integer centralizedPurchaseTotalCount(CentralizedPlanedPurchase purchase){
		purchase.setCentraOrplaned(false);
		return this.centralizedPurchaseDao.centralizedPurchaseTotalCount(purchase);
	}
	
	/**
	 *删除未发布的集中采购信息
	 */
	public void deleteCentralizedPurchase(String deleteList){
		String[] list = deleteList.split(",");
		for(int index=0; index<list.length; index++){
			this.centralizedPurchaseDao.deleteCentralizedPurchaseById(list[index]);
		}
	}
	
	/**
	 * 根据集中采购代码获取集中采购对象
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
		
		//判断集中采购信息是否可申请
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
	 * 增加新的集中采购信息
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
	 * 更新已有的集中采购信息
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
	 * 根据参数指定的条件，获取集中采购信息对应的需求列表
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
	 * 更新集中采购需求状态
	 */
	public void updateCentralizedPurchaseDemandState(CentralizedPurchaseDemand demand){
		this.centralizedPurchaseDao.updateCentralizedPurchaseDemandState(demand);
	}
	
	/**
	 * 更新集中采购合并计划数量
	 */
	public void updateCentralizedPurchaseCombineNumber(CentralizedPlanedPurchase purchase){
		this.centralizedPurchaseDao.updateCentralizedPurchaseCombineNumber(purchase);
	}

	/**
	 * 更新集中采购信息状态
	 */
	public void updateCentralizedPurchaseState(CentralizedPlanedPurchase purchase){
		this.centralizedPurchaseDao.updateCentralizedPurchaseState(purchase);
	}
	
	/**
	 * 根据产品类型id获取产品列表
	 * @return
	 */
	public List<SupplierProduct> getProductListByType(String id){
		return this.centralizedPurchaseDao.getProductListByType(id);
	}
	
	/**
	 * 发布价格后，更新集中采购产品价格表
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
	 * 获取对应集中采购的全部采购商订单
	 */
	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder order){
		return this.centralizedPurchaseDao.queryPurchaseOrderList(order);
	}
	
	/**
	 * 集中采购需求申请前获取需求申请次数，以判断是否申请过该集中采购信息
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
