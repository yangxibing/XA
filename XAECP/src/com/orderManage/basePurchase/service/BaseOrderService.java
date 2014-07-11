package com.orderManage.basePurchase.service;

import java.util.List;

import com.model.BaseOrder;
import com.model.BaseOrderDetail;
import com.model.CentralizedPlanedPurchase;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.Supplier;
import com.model.SupplierProduct;

public interface BaseOrderService {
	
	/**
	 * 根据组合条件查询基地订单列表
	 * @param bo
	 * @return
	 */
	public List<BaseOrder> listBaseOrder(BaseOrder bo);
	
	/**
	 * 删除基地订单列表
	 * @param baseOrderIdListForDel
	 */
	public void deleteBaseOrder(String baseOrderIdListForDel);
	
	/**
	 * 获取供应商列表
	 * @return
	 */
	public List<Supplier> querySupplierList();
	
	/**
	 * 获取集中采购列表
	 */
	public List<CentralizedPlanedPurchase> queryCentralizedPurchaseList();
	
	/**
	 * 获取计划采购列表
	 * @return
	 */
	public List<CentralizedPlanedPurchase> queryPlanedPurchaseList();
	
	/**
	 * 根据基地登录的用户名获取对应他的收货地址列表
	 */
	public List<GoodsAddress> queryGoodsAddressList(GoodsAddress address);
	
	/**
	 * 根据基地采购订单号获得订单详细信息（是否有集中采购，计划采购）
	 */
	public BaseOrder getBaseOrderById(String baseOrderId);
	
	/**
	 * 根据基地采购订单号获取订单内的产品详情列表 
	 */
	public List<BaseOrderDetail> listProductDetailByOrderId(String baseOrderId);
	
	/**
	 * 获取供应商产品列表
	 * @return
	 */
	public List<SupplierProduct> querySupplierProductList();
	
	
	/**
	 * 根据已提交订单的id号找到查询收货地址详细信息
	 * @param baseOrderId
	 * @return
	 */
	public GoodsAddress getReceiveGoodsAddressByOrderId(String baseOrderId);
	
	
	/**
	 * 增加一个基地订单，并返回新建订单的id
	 */
	public String addBaseOrder(BaseOrder bo);
	
	
	/**
	 * 根据订单id增加产品detail列表
	 * @param baseOrderProductAddList
	 * @param pk
	 */
	public void addBaseOrderDetail(String baseOrderProductAddList, String pk);
	
	
	/**
	 * 更新一个订单
	 */
	public void updateBaseOrder(BaseOrder baseOrder);
	
	/**
	 * 更新一个订单(更新订单详情)，合并原始的产品列表和新建的产品列表
	 */
	
	public void updateBaseOrderDetail(String add, String original, String pk);
	
	/**
	 * 更新订单状态
	 */
	public void updateBaseOrderState(BaseOrder baseOrder);
	
	/**
	 * 更新定金状态
	 */
	public void updateBaseOrderDepositState(BaseOrder baseOrder);
	
	/**
	 * 更新产品表
	 */
	public void updateBaseProduct(List<BaseOrderDetail> list);
	
	/**
	 * 更新订单退款信息
	 */
	public void updateBaseOrderRefund(BaseOrder order);
	
	/**
	 * 申请退货时更新订单明细中退货数量
	 */
	public void updateBaseOrderDetailReject(String id, String list);
	
	
	/**
	 * 取消一个订单，如果当前订单状态为“订单提交未支付定金”或“订单提交已支付定金”，右侧“编辑”按钮变更为“订单详情”和“取消”。点击“取消”可以将订单状态变更为“取消”
	 */
	public void cancelBaseOrder(BaseOrder order);

	public Integer baseOrderTotalCount(BaseOrder baseOrder);

	public List<BaseOrder> listBaseOrder(BaseOrder baseOrder, Page page);

	public List<SupplierProduct> querySupplierProductList(String supplierId);

	public BaseOrder logisticsInformation(String baseOrderId);
}
