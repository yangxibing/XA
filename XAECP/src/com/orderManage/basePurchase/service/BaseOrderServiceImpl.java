package com.orderManage.basePurchase.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model.BaseOrder;
import com.model.BaseOrderDetail;
import com.model.CentralizedPlanedPurchase;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.Supplier;
import com.model.SupplierProduct;
import com.orderManage.basePurchase.dao.BaseOrderDao;

public class BaseOrderServiceImpl implements BaseOrderService {

	private BaseOrderDao baseOrderDaoForBase;
	
	public List<BaseOrder> listBaseOrder(BaseOrder bo) {
		return baseOrderDaoForBase.listBaseOrder(bo);
	}
	
	

	public void deleteBaseOrder(String baseOrderIdListForDel) {
		String[] deleteIdArray = baseOrderIdListForDel.split(",");
		for (int i=0; i< deleteIdArray.length; i++) {
			this.baseOrderDaoForBase.deleteBaseOrder(deleteIdArray[i]);
		}
	}

	public List<Supplier> querySupplierList() {
		return this.baseOrderDaoForBase.querySupplierList();
	}

	public List<CentralizedPlanedPurchase> queryCentralizedPurchaseList() {
		return this.baseOrderDaoForBase.queryCentralizedPurchaseList();
	}

	public List<CentralizedPlanedPurchase> queryPlanedPurchaseList() {
		return this.baseOrderDaoForBase.queryPlanedPurchaseList();
	}

	public List<GoodsAddress> queryGoodsAddressList(GoodsAddress address) {
		return this.baseOrderDaoForBase.queryGoodsAddressList(address);
	}

	public BaseOrder getBaseOrderById(String baseOrderId) {
		BaseOrder order = this.baseOrderDaoForBase.getBaseOrderById(baseOrderId);
		if(order.getDeliverDate() != null && order.getDeliverDate() != ""){
			order.setDeliverDate(order.getDeliverDate().split(" ")[0]);	
		}
		return order;
	}
	
	public void updateBaseOrderState(BaseOrder baseOrder){
		this.baseOrderDaoForBase.updateBaseOrderState(baseOrder);
	}
	
	public void updateBaseOrderDepositState(BaseOrder baseOrder){
		this.baseOrderDaoForBase.updateBaseOrderDepositState(baseOrder);
	}
	
	public void updateBaseProduct(List<BaseOrderDetail> list){
		BaseOrderDetail detail;
		for(int index=0; index<list.size(); index++){
			detail = list.get(index);
			if(this.baseOrderDaoForBase.updateBaseProduct(detail) == 0){
				this.baseOrderDaoForBase.addBaseProduct(detail);
			}
		}
	}
	
	public void updateBaseOrderRefund(BaseOrder order){
		this.baseOrderDaoForBase.updateBaseOrderRefund(order);
	}
	
	public void updateBaseOrderDetailReject(String id, String list){
		String[] rejectList = list.split(",");
		BaseOrderDetail detail = new BaseOrderDetail();
		detail.setBaseOrderId(id);
		for(int index=0; index < rejectList.length; index++){
			if(rejectList[index].split(" ").length == 2){
				detail.setProductId(rejectList[index].split(" ")[0]);
				detail.setReturnNumber(Double.parseDouble(rejectList[index].split(" ")[1]));
				this.baseOrderDaoForBase.updateBaseOrderDetailReject(detail);
			}
		}
	}

	public List<BaseOrderDetail> listProductDetailByOrderId(String baseOrderId) {
		return this.baseOrderDaoForBase.listProductDetailByOrderId(baseOrderId);
	}

	public List<SupplierProduct> querySupplierProductList() {
		return this.baseOrderDaoForBase.querySupplierProductList();
	}

	public GoodsAddress getReceiveGoodsAddressByOrderId(String baseOrderId) {
		return this.baseOrderDaoForBase.getReceiveGoodsAddressByOrderId(baseOrderId);
	}

	
	public String addBaseOrder(BaseOrder bo) {
		return this.baseOrderDaoForBase.addBaseOrder(bo);
	}

	public void cancelBaseOrder(BaseOrder order) {
		this.baseOrderDaoForBase.cancelBaseOrder(order);
	}

	public void addBaseOrderDetail(String list, String pk) {
		String[] addList = list.split(",");
		Map<String, Double> addMap = new HashMap<String, Double>();
		if(list != null && list.length() != 0 && list.trim().length() != 0){
			for(int index=0; index<addList.length; index++){
				int end = addList[index].lastIndexOf(" ");
				String key = addList[index].substring(0, end);
				Double value = Double.parseDouble(addList[index].substring(end+1));
				if(addMap.containsKey(key) == true){
					addMap.put(key, addMap.get(key)+value);
				} else {
					addMap.put(key, value);
				}
			}
		}
		
		BaseOrderDetail detail = new BaseOrderDetail();
		detail.setBaseOrderId(pk);		
		for(String key : addMap.keySet()){
			detail.setProductId(key.split(" ")[0]);
			detail.setMeasureUnit(key.split(" ")[2]);
			detail.setPrice(Double.parseDouble(key.split(" ")[3]));
			detail.setNumber(addMap.get(key));
			this.baseOrderDaoForBase.addBaseOrderDetail(detail);
		}
		
	}

	public void updateBaseOrder(BaseOrder baseOrder) {
		// TODO Auto-generated method stub
		this.baseOrderDaoForBase.updateBaseOrder(baseOrder);
		
	}

	public void updateBaseOrderDetail(String add, String original, String pk) {
		// TODO Auto-generated method stub
		Map<String,Double> originalMap=new HashMap<String, Double>();
		//original != null && original != "" && original.trim() != ""
		if(original != null && original.length() != 0 && original.trim().length() != 0){
			String[] originalList = original.split(",");
			for(int index=0; index<originalList.length; index++){
				originalMap.put(originalList[index].split(" ")[0], Double.parseDouble(originalList[index].split(" ")[4]));
			}
		}

		String[] addList = add.split(",");
		Map<String, Double> addMap = new HashMap<String, Double>();
		if(add != null && add.length() != 0 && original.trim().length() != 0){
			for(int index=0; index<addList.length; index++){
				int end = addList[index].lastIndexOf(" ");
				String key = addList[index].substring(0, end);
				Double value = Double.parseDouble(addList[index].substring(end+1));
				if(addMap.containsKey(key) == true){
					addMap.put(key, addMap.get(key)+value);
				} else {
					addMap.put(key, value);
				}
			}
		}
		
		BaseOrderDetail detail = new BaseOrderDetail();
		detail.setBaseOrderId(pk);		
		for(String key : addMap.keySet()){
			detail.setProductId(key.split(" ")[0]);
			detail.setMeasureUnit(key.split(" ")[2]);
			detail.setPrice(Double.parseDouble(key.split(" ")[3]));
			detail.setNumber(addMap.get(key));
			if(originalMap.containsKey(detail.getProductId())== true){
				detail.setNumber(detail.getNumber()+ originalMap.get(detail.getProductId()));
				this.baseOrderDaoForBase.updateBaseOrderDetail(detail);
			} else {
				this.baseOrderDaoForBase.addBaseOrderDetail(detail);
			}
		}
	}



	public BaseOrderDao getBaseOrderDaoForBase() {
		return baseOrderDaoForBase;
	}



	public void setBaseOrderDaoForBase(BaseOrderDao baseOrderDaoForBase) {
		this.baseOrderDaoForBase = baseOrderDaoForBase;
	}



	public Integer baseOrderTotalCount(BaseOrder baseOrder) {
		return (Integer)this.baseOrderDaoForBase.baseOrderTotalCount(baseOrder);
	}



	public List<BaseOrder> listBaseOrder(BaseOrder baseOrder, Page page) {
		return this.baseOrderDaoForBase.listBaseOrder(baseOrder, page);
	}



	public List<SupplierProduct> querySupplierProductList(String supplierId) {
		return this.baseOrderDaoForBase.querySupplierProductList(supplierId);
	}



	public BaseOrder logisticsInformation(String baseOrderId) {
		return this.baseOrderDaoForBase.logisticsInformation(baseOrderId);
	}
}
