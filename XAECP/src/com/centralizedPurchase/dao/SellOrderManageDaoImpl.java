package com.centralizedPurchase.dao;

import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.Supplier;

public class SellOrderManageDaoImpl extends SqlMapClientDaoSupport implements SellOrderManageDao{

	public List<PurchaseOrder> listOrders(PurchaseOrder order) {
		
		return this.getSqlMapClientTemplate().queryForList("listOrders", order);
	}

	public String getNameByPurchaseId(String id) {
		
		return (String) this.getSqlMapClientTemplate().queryForObject("getNameByPurchaseId",id);
	}

	public Double getOrderRateByPId(String id) {
		
		return (Double) this.getSqlMapClientTemplate().queryForObject("getOrderRateByPId",id);
	}

	public void saveOrder(PurchaseOrder order) {
		
		this.getSqlMapClientTemplate().update("saveOrder", order);
	}

	public void assureDelivery(String purchaseOrderId) {
		
		this.getSqlMapClientTemplate().update("assureDelivery", purchaseOrderId);
	}

	public PurchaseOrder getPurchaseOrderById(String id) {
		
		return (PurchaseOrder) this.getSqlMapClientTemplate().queryForObject("assureForm",id);
	}

	public List<Supplier> selectLogistics() {
		
		return this.getSqlMapClientTemplate().queryForList("supplier.selectLogistics");
	}

	public List<GoodsAddress> sendGoodsAddress(Map map) {
		
		return this.getSqlMapClientTemplate().queryForList("selectGoodsAddress", map);
	}

	public void defaultAddress(String addressId) {
		
		this.getSqlMapClientTemplate().update("defaultAddress", addressId);
	}

	public void elseAddress(String addressId) {

		this.getSqlMapClientTemplate().update("elseAddress", addressId);

	}

	public void assureSendGoods(PurchaseOrder order) {
		
		this.getSqlMapClientTemplate().update("assureSendGoods", order);
	}

	public List<Supplier> getAllPurchasers() {
		
		return this.getSqlMapClientTemplate().queryForList("getAllSuppliers");
	}

	public void assuerGetGoods(String purchaseOrderId) {
		
		this.getSqlMapClientTemplate().update("assuerGetGoods",purchaseOrderId);
	}

	public void assuerPayGoods(String purchaseOrderId) {
		
		this.getSqlMapClientTemplate().update("assuerPayGoods",purchaseOrderId);
	}

	public Integer getCountByPOId(String purchaseOrderId) {
		
		int a= (Integer) this.getSqlMapClientTemplate().queryForObject("getCountByPOId", purchaseOrderId);
		return a;
	}

	public void CPIIdComplete(String purchaseOrderId) {
		
		this.getSqlMapClientTemplate().update("CPIIdComplete", purchaseOrderId);
	}

	public void updateProduct(Map map) {
		
		this.getSqlMapClientTemplate().update("SellOrderManageupdateProduct", map);
	}

	public Integer insertPurchaseOrder(PurchaseOrder purchaseOrder) {
		
		return (Integer) this.getSqlMapClientTemplate().queryForObject("insertPurchaseOrder", purchaseOrder);
	}

	public void insertPurchaseOrderDetail(Map map) {
		
		this.getSqlMapClientTemplate().update("insertPurchaseOrderDetail", map);
	}

	public Integer baseSellOrderTotalCount(PurchaseOrder purchaseOrder) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("baseSellOrderTotalCount", purchaseOrder);
	}

	public List<PurchaseOrder> listOrders(PurchaseOrder purchaseOrder, Page page) {
		return this.getSqlMapClientTemplate().queryForList("listOrders", purchaseOrder, page.getStart(), page.getRowCount());
	}

}
