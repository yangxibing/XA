package com.orderManage.basePurchase.dao;

import java.util.List;

import com.model.BaseOrder;
import com.model.BaseOrderDetail;
import com.model.CentralizedPlanedPurchase;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.Supplier;
import com.model.SupplierProduct;

public interface BaseOrderDao {
	public List<BaseOrder> listBaseOrder(BaseOrder bo);
	public void deleteBaseOrder(String baseOrderIdForDel);
	public List<Supplier> querySupplierList();
	public List<CentralizedPlanedPurchase> queryCentralizedPurchaseList();
	public List<CentralizedPlanedPurchase> queryPlanedPurchaseList();
	public List<GoodsAddress> queryGoodsAddressList(GoodsAddress address);
	public BaseOrder getBaseOrderById(String baseOrderId);
	public List<BaseOrderDetail> listProductDetailByOrderId(String baseOrderId);
	public List<SupplierProduct> querySupplierProductList();
	public GoodsAddress getReceiveGoodsAddressByOrderId(String baseOrderId);
	public int updateBaseOrderState(BaseOrder baseOrder);
	public int updateBaseOrderDepositState(BaseOrder baseOrder);
	public int updateBaseProduct(BaseOrderDetail detail);
	public int updateBaseOrderRefund(BaseOrder order);
	public int updateBaseOrderDetailReject(BaseOrderDetail detail);
	public void addBaseProduct(BaseOrderDetail detail);
	public void cancelBaseOrder(BaseOrder order);
	public String addBaseOrder(BaseOrder bo);
	public void addBaseOrderDetail(BaseOrderDetail orderdetail);
	public void updateBaseOrder(BaseOrder baseOrder);
	public void updateBaseOrderDetail(BaseOrderDetail baseOrderDetail);
	
	public Integer baseOrderTotalCount(BaseOrder baseOrder);

	public List<BaseOrder> listBaseOrder(BaseOrder baseOrder, Page page);
	public List<SupplierProduct> querySupplierProductList(String supplierId);
	
	public BaseOrder logisticsInformation(String baseOrderId);
}
