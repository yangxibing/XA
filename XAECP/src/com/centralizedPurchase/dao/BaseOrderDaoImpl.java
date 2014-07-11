package com.centralizedPurchase.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.BaseOrder;
import com.model.BaseOrderDetail;
import com.model.Page;
import com.model.Product;
import com.model.SupplierProduct;

public class BaseOrderDaoImpl extends SqlMapClientDaoSupport implements BaseOrderDao{

	public List<BaseOrder> listSupplierOrders(BaseOrder baseOrder) {
		
		return this.getSqlMapClientTemplate().queryForList("baseOrder.listSupplierOrders", baseOrder);
	}

	public List<BaseOrderDetail> getProductByOrderId(String baseOrderId) {
		
		return this.getSqlMapClientTemplate().queryForList("baseOrderDetail.getProductByOrderId", baseOrderId);
	}

	public List<SupplierProduct> getProductBySupplierId(String supplierId) {
		
		return this.getSqlMapClientTemplate().queryForList("baseOrder.getProductBySupplierId", supplierId);
	}

	public SupplierProduct selectProductByPId(String productId) {
		
		return (SupplierProduct) this.getSqlMapClientTemplate().queryForObject("baseOrder.selectProductByPId",productId);
	}

	public void updateBaseOrder(BaseOrder baseOrder) {
		
		this.getSqlMapClientTemplate().update("baseOrder.updateBaseOrder", baseOrder);
	}

	/*public Integer selectProductCount(String productId, String baseOrderId) {
		
		Map<String, String> map=new HashMap<String,String>();
		map.put("productId",productId);
		map.put("baseOrderId", baseOrderId);
		return (Integer) this.getSqlMapClientTemplate().queryForObject("baseOrder.selectProductCount",map);
	}*/

	public void updateBaseOrderDetail(Map<String,String> map) {
		
		this.getSqlMapClientTemplate().update("baseOrder.updateBaseOrderDetail", map);
	}
/*
	public void insertBaseOrderDetail(Map<String, String> map) {
		
		this.getSqlMapClientTemplate().insert("baseOrder.insertBaseOrderDetail", map);
	}*/

	public BaseOrder getBaseOrderById(String id) {
		// TODO Auto-generated method stub
		return (BaseOrder) this.getSqlMapClientTemplate().queryForObject("baseOrder.assureForm",id);
	}
	
	public List<BaseOrderDetail> selectProduct(String purId) {
		
		return this.getSqlMapClientTemplate().queryForList("baseOrderDetail.getProductByOrderId", purId);
	}

	public void assureSendGoods(BaseOrder order) {
		
		this.getSqlMapClientTemplate().update("baseOrder.assureSendGoods", order);

	}

	public void assuerGetReturnGoods(String baseOrderId, String state) {
		Map<String ,String> map=new HashMap<String,String>();
		map.put("baseOrderId", baseOrderId);
		map.put("state", state);
		this.getSqlMapClientTemplate().update("baseOrder.assuerGetReturnGoods",map);
	}

	public void updateActualRefund(BaseOrder baseOrder) {
		this.getSqlMapClientTemplate().update("baseOrder.updateActualRefund", baseOrder);
	}

	public List<BaseOrder> listSupplierOrders(BaseOrder baseOrder, Page page) {
		return this.getSqlMapClientTemplate().queryForList("baseOrder.listSupplierOrders", baseOrder, page.getStart(), page.getRowCount());
	}

	public Integer supplierOrderTotalCount(BaseOrder baseOrder) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("baseOrder.supplierOrderTotalCount", baseOrder);
	}
}
