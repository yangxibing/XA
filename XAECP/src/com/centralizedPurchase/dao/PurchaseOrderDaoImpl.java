package com.centralizedPurchase.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.CentralizedPlanedPurchase;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.PurchaseOrderDetail;
import com.model.Supplier;
import com.model.SupplierProduct;

public class PurchaseOrderDaoImpl extends SqlMapClientDaoSupport implements PurchaseOrderDao{
	
	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder purchaseOrder){
		List<PurchaseOrder> list = this.getSqlMapClientTemplate().queryForList("purchaseOrder.queryPurchaseOrder", purchaseOrder);
		return list;
	}
	
	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder purchaseOrder, Page page){
		List<PurchaseOrder> list = this.getSqlMapClientTemplate().queryForList("purchaseOrder.queryPurchaseOrder", purchaseOrder, page.getStart(), page.getRowCount());
		return list;		
	}
	
	public Integer purchaseOrderTotalCount(PurchaseOrder purchaseOrder){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("purchaseOrder.purchaseOrderTotalCount", purchaseOrder);
	}
	
	public int deletePurchaseOrderById(String id){
		return this.getSqlMapClientTemplate().delete("purchaseOrder.deletePurchaseOrderById", id);
	}
	
	public int deletePurchaseOrderDetailById(String id){
		return this.getSqlMapClientTemplate().delete("purchaseOrder.deletePurchaseOrderDetailById", id);
	}
	
	public List<SupplierProduct> queryProductList(){
		return this.getSqlMapClientTemplate().queryForList("purchaseOrder.queryProductList");
	}
	
	public Supplier getPurchaserById(String id){
		return (Supplier) this.getSqlMapClientTemplate().queryForObject("purchaser.getPurchaserById", id);
	}
	
	public List<GoodsAddress> queryGoodsAddressList(GoodsAddress address){
		List list = this.getSqlMapClientTemplate().queryForList("goodsAddress.queryGoodsAddressList", address);
		return list;
	}
	
	public PurchaseOrder getPurchaseOrderById(String id){
		return (PurchaseOrder) this.getSqlMapClientTemplate().queryForObject("purchaseOrder.getPurchaseOrderById", id);
	}
	
	public PurchaseOrder getPurchaseOrderMoreById(String id){
		return (PurchaseOrder) this.getSqlMapClientTemplate().queryForObject("purchaseOrder.getPurchaseOrderMoreById", id);
	}
	
	public List<PurchaseOrderDetail> queryPurchaseOrderDetailById(PurchaseOrderDetail detail){
		List list = this.getSqlMapClientTemplate().queryForList("purchaseOrder.queryPurchaseOrderDetailById", detail);
		return list;
	}
	
	public String addPurchaseOrder(PurchaseOrder purchaseOrder){
		String str = (String) this.getSqlMapClientTemplate().insert("purchaseOrder.addPurchaseOrder", purchaseOrder);
		return str;
	}
	
	public void addPurchaseOrderDetail(PurchaseOrderDetail detail){
		this.getSqlMapClientTemplate().insert("purchaseOrder.addPurchaseOrderDetail", detail);
	}
	
	public int updatePurchaseOrder(PurchaseOrder purchaseOrder){
		return this.getSqlMapClientTemplate().update("purchaseOrder.updatePurchaseOrder", purchaseOrder);
	}
	
	public int updatePurchaseOrderDetail(PurchaseOrderDetail detail){
		return this.getSqlMapClientTemplate().update("purchaseOrder.updatePurchaseOrderDetail", detail);
	}
	
	public GoodsAddress getGoodsAddressById(String id){
		return (GoodsAddress) this.getSqlMapClientTemplate().queryForObject("goodsAddress.getGoodsAddressById", id);
	}
	
	public int updatePurchaseOrderState(PurchaseOrder order){
		return this.getSqlMapClientTemplate().update("purchaseOrder.updatePurchaseOrderState", order);
	}
	
	public int updatePurchaseOrderDeposit(PurchaseOrder order){
		return this.getSqlMapClientTemplate().update("purchaseOrder.updatePurchaseOrderDeposit", order);
	}

	public PurchaseOrder logisticsInformation(String id){
		return (PurchaseOrder) this.getSqlMapClientTemplate().queryForObject("purchaseOrder.getLogisticsInformation", id);
	}
	
	public int updateRejectedPurchaseOrder(PurchaseOrder purchaseOrder){
		return this.getSqlMapClientTemplate().update("purchaseOrder.updateRejectedPurchaseOrder", purchaseOrder);
	}
	
	public int updateRejectedPurchaseOrderDetail(PurchaseOrderDetail detail){
		return this.getSqlMapClientTemplate().update("purchaseOrder.updateRejectedPurchaseOrderDetail", detail);
	}
	
	public int evaluateForProductUpdate(PurchaseOrderDetail detail){
		return this.getSqlMapClientTemplate().update("purchaseOrder.evaluateForProductUpdate", detail);
	}
	
	public Integer countNonEndCentralizedPurchase(String cppid){
		return (Integer) this.getSqlMapClientTemplate().queryForObject("purchaseOrder.countNonEndCentralizedPurchase", cppid);
	}
	
	public int updateCentralizedPurchaseStateToEnd(CentralizedPlanedPurchase purchase){
		return this.getSqlMapClientTemplate().update("centralizedPurchase.updateCentralizedPurchaseState", purchase);
	}
	
	public void updateSupplierIntegrityLevel(Supplier supplier){
		this.getSqlMapClientTemplate().update("supplier.updateSupplierIntegrityLevel", supplier);
	}
	
	public SupplierProduct getSupplierProductByProductId(String id){
		return (SupplierProduct) this.getSqlMapClientTemplate().queryForObject("supplierProduct.getSupplierProductByProductId", id);
	}
}
