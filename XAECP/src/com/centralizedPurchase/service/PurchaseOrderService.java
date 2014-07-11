package com.centralizedPurchase.service;

import java.util.List;

import com.model.CentralizedPlanedPurchase;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.PurchaseOrderDetail;
import com.model.Supplier;
import com.model.SupplierProduct;

public interface PurchaseOrderService {

	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder purchaseOrder);
	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder purchaseOrder, Page page);
	public Integer purchaseOrderTotalCount(PurchaseOrder purchaseOrder);
	public void deletePurchaseOrder(String purchaseOrderList);
	public String getProductInfo();
	public String getPurchaserInfo(String id);
	public String getAddressInfo(GoodsAddress address);
	public PurchaseOrder getPurchaseOrderById(String id);
	public PurchaseOrder getPurchaseOrderMoreById(String id);
	public String getPurchaseOrderInfo(String id);
	public String getPurchaseOrderDetailInfo(String id);
	public String addPurchaseOrder(PurchaseOrder purchaseOrder);
	public void addPurchaseOrderDetail(String list, String pk);
	public void updatePurchaseOrder(PurchaseOrder purchaseOrder);
	public void updatePurchaseOrderDetail(String add, String original, String pk);
	public String getGoodsAddressInfoById(String id);
	public void cancelPurchaseOrder(String id);
	public void comfirmReceiveGoodsUpdate(String id);
	public void payForGoodsUpdate(String id);
	public void payForDepositUpdate(PurchaseOrder order);
	public void evaluateForProductUpdate(PurchaseOrderDetail detail);
	public PurchaseOrder logisticsInformation(String id);
	public List<GoodsAddress> queryGoodsAddress(String userId);
	public List<PurchaseOrderDetail> queryPurchaseOrderDetail(String id);
	public void updateRejectedPurchaseOrder(PurchaseOrder purchaseOrder);
	public void updateRejectedPurchaseOrderDetail(String id, String rejectList);
	public Integer countNonEndCentralizedPurchase(String cppid);
	public void updateCentralizedPurchaseStateToEnd(CentralizedPlanedPurchase purchase);
	public SupplierProduct getSupplierProductByProductId(String id);
	public void updateSupplierIntegrityLevel(Supplier supplier);
}
