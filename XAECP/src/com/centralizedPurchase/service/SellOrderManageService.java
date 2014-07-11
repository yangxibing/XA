package com.centralizedPurchase.service;

import java.util.List;

import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.Supplier;

public interface SellOrderManageService {

	public List<PurchaseOrder> listOrders(PurchaseOrder order);
	public void saveOrder(PurchaseOrder order);
	public void assureDelivery(String purchaseOrderId);
	public PurchaseOrder getPurchaseOrderById(String id);
	public List<Supplier> selectLogistics();
	public  List<GoodsAddress> sendGoodsAddress(String userId,int sendOrReceive);
	public void defaultAddress(String addresses);
	public void assureSendGoods(PurchaseOrder order);
	public List<Supplier> getAllPurchasers();
	public void assuerGetGoods(String purchaseOrderId);
	public void assuerPayGoods(String purchaseOrderId);
	public void updateProduct(String product,String s);
	public Double getOrderRateByPId(String purchaserId);
	public void updatePurchaseOrderAndDetail(PurchaseOrder purchaseOrder,String products);
	public Integer baseSellOrderTotalCount(PurchaseOrder purchaseOrder);
	public List<PurchaseOrder> listOrders(PurchaseOrder purchaseOrder, Page page);

}
