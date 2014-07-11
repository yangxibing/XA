package com.centralizedPurchase.dao;

import java.util.List;

import com.model.CentralizedPlanedPurchase;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.PurchaseOrderDetail;
import com.model.Supplier;
import com.model.SupplierProduct;

public interface PurchaseOrderDao {

	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder purchaseOrder);
	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder purchaseOrder, Page page);
	public Integer purchaseOrderTotalCount(PurchaseOrder purchaseOrder);
	public int deletePurchaseOrderById(String id);
	public int deletePurchaseOrderDetailById(String id);
	public List<SupplierProduct> queryProductList();
	public Supplier getPurchaserById(String id);
	public List<GoodsAddress> queryGoodsAddressList(GoodsAddress address);
	public PurchaseOrder getPurchaseOrderById(String id);
	public PurchaseOrder getPurchaseOrderMoreById(String id);
	public List<PurchaseOrderDetail> queryPurchaseOrderDetailById(PurchaseOrderDetail detail);
	public String addPurchaseOrder(PurchaseOrder purchaseOrder);
	public void addPurchaseOrderDetail(PurchaseOrderDetail detail);
	public int updatePurchaseOrder(PurchaseOrder purchaseOrder);
	public int updatePurchaseOrderDetail(PurchaseOrderDetail detail);
	public GoodsAddress getGoodsAddressById(String id);
	public int updatePurchaseOrderState(PurchaseOrder order);
	public int updatePurchaseOrderDeposit(PurchaseOrder order);
	public PurchaseOrder logisticsInformation(String id);
	public int updateRejectedPurchaseOrder(PurchaseOrder purchaseOrder);
	public int updateRejectedPurchaseOrderDetail(PurchaseOrderDetail detail);
	public int evaluateForProductUpdate(PurchaseOrderDetail detail);
	public Integer countNonEndCentralizedPurchase(String cppid);
	public int updateCentralizedPurchaseStateToEnd(CentralizedPlanedPurchase purchase);
	public void updateSupplierIntegrityLevel(Supplier supplier);
	public SupplierProduct getSupplierProductByProductId(String id);
}
