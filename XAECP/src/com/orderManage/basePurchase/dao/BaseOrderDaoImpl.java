package com.orderManage.basePurchase.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.BaseOrder;
import com.model.BaseOrderDetail;
import com.model.CentralizedPlanedPurchase;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.Supplier;
import com.model.SupplierProduct;

public class BaseOrderDaoImpl extends SqlMapClientDaoSupport implements BaseOrderDao{

	@SuppressWarnings("unchecked")
	public List<BaseOrder> listBaseOrder(BaseOrder bo) {
		System.out.println("采购订单管理-（基地）对供应商 -订单组合条件查询");
		List<BaseOrder> list = (List<BaseOrder>)this.getSqlMapClientTemplate().queryForList("baseOrderForBase.listBaseOrder", bo);
		return list;
	}

	public void deleteBaseOrder(String baseOrderIdForDel) {
		System.out.println("采购订单管理-（基地）对供应商 -删除未提交订单id="+baseOrderIdForDel);
		this.getSqlMapClientTemplate().delete("baseOrderForBase.deleteBaseOrder", baseOrderIdForDel);
	}

	public List<Supplier> querySupplierList() {
		System.out.println("获取供应商下拉列表－查询供应商列表");
		List<Supplier> list = this.getSqlMapClientTemplate().queryForList("baseOrderForBase.querySupplierList");
		return list;
	}

	public List<CentralizedPlanedPurchase> queryCentralizedPurchaseList() {
		System.out.println("获取集中采购代码下拉列表");
		List<CentralizedPlanedPurchase> list = this.getSqlMapClientTemplate().queryForList("baseOrderForBase.queryCentralizedPurchaseList");
		return list;
	}

	public List<CentralizedPlanedPurchase> queryPlanedPurchaseList() {
		System.out.println("获取计划采购代码下拉列表");
		List<CentralizedPlanedPurchase> list = this.getSqlMapClientTemplate().queryForList("baseOrderForBase.queryPlanedPurchaseList");
		return list;
	}
	
	public List<GoodsAddress> queryGoodsAddressList(GoodsAddress address){
		System.out.println("获取基地收货地址列表");
		List<GoodsAddress> list = this.getSqlMapClientTemplate().queryForList("goodsAddress.queryGoodsAddressList", address);
		System.out.println("基地收货地址列表size ＝ " +list.size());
		return list;
	}

	public BaseOrder getBaseOrderById(String baseOrderId) {
		System.out.println("根据基地订单id获取订单详情 id = "+ baseOrderId);
		return (BaseOrder) this.getSqlMapClientTemplate().queryForObject("baseOrderForBase.getBaseOrderById", baseOrderId);
	}

	public List<BaseOrderDetail> listProductDetailByOrderId(String baseOrderId) {
		System.out.println("根据基地订单id获取订单详情产品列表 id = " + baseOrderId);
		List<BaseOrderDetail> list = this.getSqlMapClientTemplate().queryForList("baseOrderDetail.listBaseOrderDetail", baseOrderId);
		System.out.println("订单产品明细列表size ＝ " +list.size());
		return list;
	}

	public List<SupplierProduct> querySupplierProductList() {
		System.out.println("获取供应商产品列表");
		List<SupplierProduct> list = this.getSqlMapClientTemplate().queryForList("supplierProduct.querySupplierProductList");
		System.out.println("供应商产品列表size ＝ " +list.size());
		return list;
	}

	public GoodsAddress getReceiveGoodsAddressByOrderId(String baseOrderId) {
		System.out.println("根据已提交订单的id号找到查询收货地址详细信息id="+baseOrderId);
		GoodsAddress ga = (GoodsAddress) this.getSqlMapClientTemplate().queryForObject("baseOrderForBase.getReceiveGoodsAddressByOrderId", baseOrderId);
		return ga;
	}
	
	public int updateBaseOrderState(BaseOrder baseOrder){
		return this.getSqlMapClientTemplate().update("baseOrderForBase.updateBaseOrderState", baseOrder);
	}
	
	public int updateBaseOrderDepositState(BaseOrder baseOrder){
		return this.getSqlMapClientTemplate().update("baseOrderForBase.updateBaseOrderDepositState", baseOrder);
	}
	
	public int updateBaseProduct(BaseOrderDetail detail){
		return this.getSqlMapClientTemplate().update("baseOrderDetail.updateBaseProduct", detail);
	}
	
	public int updateBaseOrderRefund(BaseOrder order){
		return this.getSqlMapClientTemplate().update("baseOrderForBase.updateBaseOrderRefund", order);
	}
	
	public int updateBaseOrderDetailReject(BaseOrderDetail detail){
		return this.getSqlMapClientTemplate().update("baseOrderDetail.updateBaseOrderDetailReject", detail);
	}
	
	public void addBaseProduct(BaseOrderDetail detail){
		this.getSqlMapClientTemplate().insert("baseOrderDetail.addBaseProduct", detail);
	}

	//取消一个基地订单，如果基地订单状态处于订单提交未支付定金或订单提交已支付定金，可以取消订单，定金不返还
	public void cancelBaseOrder(BaseOrder order) {
		System.out.println("取消订单 只是改变订单的状态 BaseorderId=" + order.getBaseOrderId());
		this.getSqlMapClientTemplate().update("baseOrderForBase.updateBaseOrderState", order);
	}

	//增加一个订单
	public String addBaseOrder(BaseOrder bo) {
		String str = (String) this.getSqlMapClientTemplate().insert("baseOrderForBase.addBaseOrder", bo);
		return str;
	}

	//增加一个订单详情
	public void addBaseOrderDetail(BaseOrderDetail orderdetail) {
		this.getSqlMapClientTemplate().insert("baseOrderDetail.addBaseOrderDetail", orderdetail);
	}

	//更新一个订单
	public void updateBaseOrder(BaseOrder baseOrder) {
		System.out.println("更新一个订单  订单baseOrderId="+baseOrder.getBaseOrderId());
		this.getSqlMapClientTemplate().update("baseOrderForBase.updateBaseOrder",baseOrder);
		
	}

	//更新订单详情
	public void updateBaseOrderDetail(BaseOrderDetail baseOrderDetail) {
		// TODO Auto-generated method stub
		System.out.println("更新基地订单详情 ");
		this.getSqlMapClientTemplate().update("baseOrderDetail.updateBaseOrderDetail", baseOrderDetail);
		
	}

	public Integer baseOrderTotalCount(BaseOrder baseOrder) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("baseOrderForBase.baseOrderTotalCount", baseOrder);
	}

	public List<BaseOrder> listBaseOrder(BaseOrder baseOrder, Page page) {
		List<BaseOrder> list = (List<BaseOrder>)this.getSqlMapClientTemplate().queryForList("baseOrderForBase.listBaseOrder", baseOrder, page.getStart(), page.getRowCount());
		return list;
	}

	public List<SupplierProduct> querySupplierProductList(String supplierId) {
		List<SupplierProduct> list = this.getSqlMapClientTemplate().queryForList("supplierProduct.querySupplierProductListForS", supplierId);
		return list;
	}

	public BaseOrder logisticsInformation(String baseOrderId) {
		return (BaseOrder) this.getSqlMapClientTemplate().queryForObject("baseOrderForBase.getLogisticsInfoForBase", baseOrderId);
	}
}

