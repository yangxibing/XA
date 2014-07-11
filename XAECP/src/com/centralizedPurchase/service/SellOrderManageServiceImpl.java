package com.centralizedPurchase.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.centralizedPurchase.dao.CentralizedPlanedPurchaseDao;
import com.centralizedPurchase.dao.SellOrderManageDao;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.Supplier;

public class SellOrderManageServiceImpl implements SellOrderManageService{

	private SellOrderManageDao sellOrderManageDao;
	private CentralizedPlanedPurchaseDao  centralizedPlanedPurchaseDao;
	public List<PurchaseOrder> listOrders(PurchaseOrder order) {
		List<PurchaseOrder> list=this.sellOrderManageDao.listOrders(order);
		for(int i=0;i<list.size();i++){
			String partnerName=this.sellOrderManageDao.getNameByPurchaseId(list.get(i).getPurchaserId());
			list.get(i).setPurchaserName(partnerName);
			Double orderRate=this.sellOrderManageDao.getOrderRateByPId(list.get(i).getPurchaserId());
			list.get(i).setOrderRate(orderRate);
			list.get(i).setOrderStateName(getValueByKey(list.get(i).getOrderState()));
			list.get(i).setOwnOrder(orderRate*list.get(i).getTotalPrice());
			
		}
		return list;
	}
	
	public void saveOrder(PurchaseOrder order) {
		
		this.sellOrderManageDao.saveOrder(order);
	}
	
	private String getValueByKey(int id){
		switch(id){
			case 0:return "未提交";
			case 1:return "订单提交未付定金";
			case 2:return "订单提交已付定金";
			case 3:return "取消";
			case 4:return "已经确认发货";
			case 5:return "已经确认到货未支付货款";
			case 6:return "交易完成";
			case 7:return "申请退货";
			case 8:return "退货收货";
			case 9:return "退货成功";
			default:return "出错";
		}
	}
	
	public SellOrderManageDao getSellOrderManageDao() {
		return sellOrderManageDao;
	}
	public void setSellOrderManageDao(SellOrderManageDao sellOrderManageDao) {
		this.sellOrderManageDao = sellOrderManageDao;
	}

	public void assureDelivery(String purchaseOrderId) {
		
		this.sellOrderManageDao.assureDelivery(purchaseOrderId);
	}

	public PurchaseOrder getPurchaseOrderById(String id) {
		
		PurchaseOrder po= this.sellOrderManageDao.getPurchaseOrderById(id);
		po.setPurchaserName(this.sellOrderManageDao.getNameByPurchaseId(po.getPurchaserId()));
		po.setOwnOrder(po.getTotalPrice()*this.sellOrderManageDao.getOrderRateByPId(po.getPurchaserId()));
		return po;
	}

	public List<Supplier> selectLogistics() {
		
		return this.sellOrderManageDao.selectLogistics();
	}

	public List<GoodsAddress> sendGoodsAddress(String userId,int sendOrReceive) {
		Map<String ,String > map=new HashMap<String,String>();
		map.put("userId", userId);
		map.put("sendOrReceive", String.valueOf(sendOrReceive));
		return this.sellOrderManageDao.sendGoodsAddress(map);
	}

	public void defaultAddress(String addresses) {
		
		String[] address=addresses.split(",");
		String[] elseAddress=address[0].split("-");
		String defaultAddress=address[1];
		for(int i=0;i<elseAddress.length;i++){
			this.sellOrderManageDao.elseAddress(elseAddress[i]);
		}
		this.sellOrderManageDao.defaultAddress(defaultAddress);
	}

	public void assureSendGoods(PurchaseOrder order) {
		
		this.sellOrderManageDao.assureSendGoods(order);
	}


	public List<Supplier> getAllPurchasers() {
		// TODO Auto-generated method stub
		return this.sellOrderManageDao.getAllPurchasers();
	}

	public void assuerGetGoods(String purchaseOrderId) {
		
		 this.sellOrderManageDao.assuerGetGoods(purchaseOrderId);
	}

	public void assuerPayGoods(String purchaseOrderId) {
		
		this.sellOrderManageDao.assuerPayGoods(purchaseOrderId);
		int count=0;
		count=this.sellOrderManageDao.getCountByPOId(purchaseOrderId);
		if(count==0){
			this.sellOrderManageDao.CPIIdComplete(purchaseOrderId);
		}
	}

	public void updateProduct(String product,String s) {
		String [] str=product.split("@");
		for(int i=0;i<str.length;i++){
			Map<String,String> map=new HashMap<String,String>();
			map.put("productId", str[i].split(",")[0].split("-")[0]);
			map.put("number", str[i].split(",")[1]);
			map.put("flag",s);
			this.sellOrderManageDao.updateProduct(map);
		}
	}

	public Double getOrderRateByPId(String purchaserId) {
		return this.sellOrderManageDao.getOrderRateByPId(purchaserId);
	}

	public void updatePurchaseOrderAndDetail(PurchaseOrder purchaseOrder, String products) {
		int purchaseOrderId=this.sellOrderManageDao.insertPurchaseOrder(purchaseOrder);
		String [] product=products.split(",");
		for(int i=0;i<product.length;i++){
			Map<String,String> map = new HashMap<String, String>();
			map.put("purchaseOrderId", String.valueOf(purchaseOrderId));
			map.put("productId", product[i].split("-")[0]);
			map.put("measureUnit", product[i].split("-")[1]);
			map.put("price", product[i].split("-")[2]);
			map.put("number", product[i].split("-")[3]);
			this.sellOrderManageDao.insertPurchaseOrderDetail(map);
		}
		//检查当前的集中采购所有的订单需求状态是否都为“需求已确认”，或者取消。若是则更新集中采购信息表的状态4:需求已确认
		if(this.centralizedPlanedPurchaseDao.selectCount(Integer.parseInt(purchaseOrder.getCPIId()))==0){
			Map<String, String> map = new HashMap<String, String>();
			map.put("CPIId",String.valueOf(purchaseOrder.getCPIId()));
			map.put("state",String.valueOf(4) );
			this.centralizedPlanedPurchaseDao.updateCPI(map);
		}
	}

	public CentralizedPlanedPurchaseDao getCentralizedPlanedPurchaseDao() {
		return centralizedPlanedPurchaseDao;
	}

	public void setCentralizedPlanedPurchaseDao(
			CentralizedPlanedPurchaseDao centralizedPlanedPurchaseDao) {
		this.centralizedPlanedPurchaseDao = centralizedPlanedPurchaseDao;
	}

	public Integer baseSellOrderTotalCount(PurchaseOrder purchaseOrder) {
		return this.sellOrderManageDao.baseSellOrderTotalCount(purchaseOrder);
	}

	public List<PurchaseOrder> listOrders(PurchaseOrder purchaseOrder, Page page) {
		List<PurchaseOrder> list=this.sellOrderManageDao.listOrders(purchaseOrder, page);
		for(int i=0;i<list.size();i++){
			String partnerName=this.sellOrderManageDao.getNameByPurchaseId(list.get(i).getPurchaserId());
			list.get(i).setPurchaserName(partnerName);
			Double orderRate=this.sellOrderManageDao.getOrderRateByPId(list.get(i).getPurchaserId());
			list.get(i).setOrderRate(orderRate);
			list.get(i).setOrderStateName(getValueByKey(list.get(i).getOrderState()));
			list.get(i).setOwnOrder(orderRate*list.get(i).getTotalPrice());		
		}
		return list;
	}
}
