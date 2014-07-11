package com.centralizedPurchase.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.centralizedPurchase.dao.BaseOrderDao;
import com.centralizedPurchase.dao.PurchaseOrderDetailDao;
import com.model.BaseOrder;
import com.model.BaseOrderDetail;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.PurchaseOrderDetail;
import com.model.SupplierProduct;

public class BaseOrderServiceImpl implements BaseOrderService {

	private BaseOrderDao baseOrderDao;
	private PurchaseOrderDetailDao purchaseOrderDetailDao;
	public List<BaseOrder> listSupplierOrders(BaseOrder baseOrder) {
		
		List<BaseOrder> list= this.baseOrderDao.listSupplierOrders(baseOrder);
		for(int i=0;i<list.size();i++){
			list.get(i).setOrderStateName(getValueByKey(list.get(i).getOrderState()));
		}
		return list;
	}
	
	public List<BaseOrderDetail> getProductByOrderId(String baseOrderId) {
		
		List<BaseOrderDetail> list=this.baseOrderDao.getProductByOrderId(baseOrderId);
		for(int i=0;i<list.size();i++){
			list.get(i).setIdName(list.get(i).getProductId()+"-"+this.purchaseOrderDetailDao.getProductNameById(list.get(i).getProductId()));
		}
		return list;
	}
	public List<SupplierProduct> getProductBySupplierId(String supplierId){
		return this.baseOrderDao.getProductBySupplierId(supplierId);
	}
	public SupplierProduct selectProductByPId(String productId){
		return this.baseOrderDao.selectProductByPId(productId);
	}

	public BaseOrderDao getBaseOrderDao() {
		return baseOrderDao;
	}
	public void setBaseOrderDao(BaseOrderDao baseOrderDao) {
		this.baseOrderDao = baseOrderDao;
	}

	private String getValueByKey(int id){
		switch(id){
			case 0:return "δ�ύ";
			case 1:return "�����ύδ������";
			case 2:return "�����ύ�Ѹ�����";
			case 3:return "ȡ��";
			case 4:return "�Ѿ�ȷ�Ϸ���";
			case 5:return "�Ѿ�ȷ�ϵ���δ֧������";
			case 6:return "�������";
			case 7:return "�����˻�";
			case 8:return "�˻��ջ�";
			case 9:return "�˻��ɹ�";
			default:return "����";
		}
	}

	public PurchaseOrderDetailDao getPurchaseOrderDetailDao() {
		return purchaseOrderDetailDao;
	}

	public void setPurchaseOrderDetailDao(
			PurchaseOrderDetailDao purchaseOrderDetailDao) {
		this.purchaseOrderDetailDao = purchaseOrderDetailDao;
	}

	public void updateBaseOrder(BaseOrder baseOrder) {
		
		this.baseOrderDao.updateBaseOrder(baseOrder);
	}

	public void updateBaseOrderDetail(String productString,String baseOrderId) {
		String [] ps=productString.split("@");
		String productId="";
		Map<String,String> map=new HashMap<String,String>();
		for(int i=0;i<ps.length;i++){
			productId=ps[i].split(",")[0].split("-")[0];
			map.put("baseOrderId", baseOrderId);
			map.put("productId", productId);
			map.put("measureUnit", ps[i].split(",")[1]);
			map.put("price", ps[i].split(",")[2]);
			map.put("number", ps[i].split(",")[3]);
			this.baseOrderDao.updateBaseOrderDetail(map);
			
		}
	}

	public BaseOrder getBaseOrderById(String id) {
		BaseOrder po= this.baseOrderDao.getBaseOrderById(id);
		return po;
	}
	
	public List<BaseOrderDetail> selectProduct(String purId) {
		
		List<BaseOrderDetail> list= this.baseOrderDao.selectProduct(purId);
		for(int i=0;i<list.size();i++){
			list.get(i).setAllPrice(list.get(i).getPrice()*list.get(i).getNumber());
			String name=this.purchaseOrderDetailDao.getProductNameById(list.get(i).getProductId());
			list.get(i).setIdName(list.get(i).getProductId()+"-"+name);
		}
		return list;
	}

	public void assureSendGoods(BaseOrder order) {
		
		this.baseOrderDao.assureSendGoods(order);
	}

	public void assureGetReturnGoods(String baseOrderId, String state) {
		
		this.baseOrderDao.assuerGetReturnGoods(baseOrderId, state);
	}

	public void updateActualRefund(BaseOrder baseOrder) {
		this.baseOrderDao.updateActualRefund(baseOrder);
	}

	public List<BaseOrder> listSupplierOrders(BaseOrder baseOrder, Page page) {
		List<BaseOrder> list= this.baseOrderDao.listSupplierOrders(baseOrder, page);
		for(int i=0;i<list.size();i++){
			list.get(i).setOrderStateName(getValueByKey(list.get(i).getOrderState()));
		}
		return list;
	}

	public Integer supplierOrderTotalCount(BaseOrder baseOrder) {
		return this.baseOrderDao.supplierOrderTotalCount(baseOrder);
	}
	
}
