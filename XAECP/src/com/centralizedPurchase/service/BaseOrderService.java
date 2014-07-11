package com.centralizedPurchase.service;

import java.util.List;

import com.model.BaseOrder;
import com.model.BaseOrderDetail;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.PurchaseOrderDetail;
import com.model.SupplierProduct;


public interface BaseOrderService {
	
	public List<BaseOrder> listSupplierOrders(BaseOrder baseOrder);
	public List<BaseOrderDetail> getProductByOrderId(String baseOrderId);
	public List<SupplierProduct> getProductBySupplierId(String supplierId);
	public SupplierProduct selectProductByPId(String productId);
	public void updateBaseOrder(BaseOrder baseOrder);
	public void updateBaseOrderDetail(String productString,String baseOrderId);
	public BaseOrder getBaseOrderById(String id);
	public List<BaseOrderDetail> selectProduct(String purId);
	public void assureSendGoods(BaseOrder order);
	public void assureGetReturnGoods(String baseOrderId,String state);
	public void updateActualRefund(BaseOrder baseOrder);
	public Integer supplierOrderTotalCount(BaseOrder baseOrder);
	public List<BaseOrder> listSupplierOrders(BaseOrder baseOrder, Page page);
}
