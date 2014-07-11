package com.centralizedPurchase.dao;

import java.util.List;
import java.util.Map;

import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.Supplier;

public interface SellOrderManageDao {

	public List<PurchaseOrder> listOrders(PurchaseOrder order);
	public String getNameByPurchaseId(String id);
	public Double getOrderRateByPId(String id);
	public void saveOrder(PurchaseOrder order);
	public void assureDelivery(String purchaseOrderId);
	public PurchaseOrder getPurchaseOrderById(String id);
	public List<Supplier> selectLogistics();
	public List<GoodsAddress> sendGoodsAddress(Map map);
	public void elseAddress(String addressId);
	public void defaultAddress(String addressId);
	public void assureSendGoods(PurchaseOrder order);
	public List<Supplier> getAllPurchasers();
	public void assuerGetGoods(String purchaseOrderId);
	public void assuerPayGoods(String purchaseOrderId);
	public Integer getCountByPOId(String purchaseOrderId);
	public void CPIIdComplete(String purchaseOrderId);
	public void updateProduct(Map map);
	public Integer insertPurchaseOrder(PurchaseOrder purchaseOrder);
	public void insertPurchaseOrderDetail(Map map);
	
	public Integer baseSellOrderTotalCount(PurchaseOrder purchaseOrder);
	public List<PurchaseOrder> listOrders(PurchaseOrder purchaseOrder, Page page);
}
