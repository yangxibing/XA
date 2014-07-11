package com.centralizedPurchase.dao;

import java.util.List;
import java.util.Map;

import com.model.BaseOrder;
import com.model.BaseOrderDetail;
import com.model.Page;
import com.model.Product;
import com.model.SupplierProduct;


public interface BaseOrderDao {
	
	public List<BaseOrder> listSupplierOrders(BaseOrder baseOrder);
	public List<BaseOrderDetail> getProductByOrderId(String baseOrderId);
	public List<SupplierProduct> getProductBySupplierId(String supplierId);
	public SupplierProduct selectProductByPId(String productId);
	public void updateBaseOrder(BaseOrder baseOrder);
	//public Integer selectProductCount(String productId,String baseOrderId);
	public void updateBaseOrderDetail(Map<String, String> map);
	//public void insertBaseOrderDetail(Map<String, String> map);
	public BaseOrder getBaseOrderById(String id);
	public  List<BaseOrderDetail> selectProduct(String purId);
	public void assureSendGoods(BaseOrder order);
	public void assuerGetReturnGoods(String baseOrderId,String state);
	public void updateActualRefund(BaseOrder baseOrder);
	
	public Integer supplierOrderTotalCount(BaseOrder baseOrder);
	public List<BaseOrder> listSupplierOrders(BaseOrder baseOrder, Page page);
}
