package com.orderManage.basePurchase.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.model.BaseOrder;
import com.model.BaseOrderDetail;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrderDetail;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.orderManage.basePurchase.service.BaseOrderService;

@SuppressWarnings("serial")
public class BaseOrderAction extends ActionSupport implements ModelDriven<BaseOrder>, RequestAware, SessionAware {
	
	private Map<String,Object> request;
	private Map<String,Object> session;
	private BaseOrderService baseOrderServiceForBase;               //调用service的方法
	private String baseOrderIdListForDel;                    //存要被删除的订单id列表
	private String userIdInSession;
	private String baseIdInSession;

	private BaseOrder baseOrder = new BaseOrder();           //用于接收用户提交参数或者充当返回对象
	private List<BaseOrderDetail> baseOrderProductDetail;    //存储订单详情中的产品列表
	private GoodsAddress receiveGoodsAddress;                       //用于在查看订单详情时，返回收货地址信息
	private BaseOrder baseOrderX;

	private String baseOrderProductAddList;                 //用于接收新增产品列表数据
	private String baseOrderProductOriginalList;            //用于接收点击编辑原始的产品列表数据
	private String rejectList;    //退货列表
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
		
	public BaseOrder getBaseOrderX() {
		return baseOrderX;
	}

	public void setBaseOrderX(BaseOrder baseOrderX) {
		this.baseOrderX = baseOrderX;
	}

	public List<BaseOrderDetail> getBaseOrderProductDetail() {
		return baseOrderProductDetail;
	}

	public void setBaseOrderProductDetail(
			List<BaseOrderDetail> baseOrderProductDetail) {
		this.baseOrderProductDetail = baseOrderProductDetail;
	}

	@JSON(serialize = false)
	public String getBaseOrderIdListForDel() {
		return baseOrderIdListForDel;
	}

	public void setBaseOrderIdListForDel(String baseOrderIdListForDel) {
		this.baseOrderIdListForDel = baseOrderIdListForDel;
	}

	@JSON(serialize = false)
	public BaseOrder getModel() {
		// TODO Auto-generated method stub
		return this.baseOrder;
	}

	public void setRequest(Map<String, Object> arg0) {
		// TODO Auto-generated method stub	
		request = arg0;
	}



	@JSON(serialize = false)
	public BaseOrder getBaseOrder() {
		return baseOrder;
	}

	public void setBaseOrder(BaseOrder baseOrder) {
		this.baseOrder = baseOrder;
	}

	@JSON(serialize = false)
	public Map<String, Object> getRequest() {
		return request;
	}
	
	
	/**
	 * 查询基地采购订单列表
	 * @return
	 */
	public String listBaseOrder() {
		Integer totalCount = this.baseOrderServiceForBase.baseOrderTotalCount(baseOrder);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<BaseOrder> list = this.baseOrderServiceForBase.listBaseOrder(baseOrder, page);
		request.put("totalPage", this.totalPage);     //保存总页数到页面
		request.put("currentPage", this.currentPage); //保存当前页到页面
		this.request.put("baseOrderVO", baseOrder);
		this.request.put("query", list);
		return SUCCESS;
	}
	
	/**
	 * 删除未提交的订单
	 * @return
	 */
	public String deleteBaseOrder() {
		this.baseOrderServiceForBase.deleteBaseOrder(baseOrderIdListForDel);
		return SUCCESS;
	}
	

	/**
	 * 点击编辑时需要调用的方法
	 * @return
	 */
	public String getBaseOrderById() {
		baseOrderX = this.baseOrderServiceForBase.getBaseOrderById(baseOrder.getBaseOrderId());
		baseOrderProductDetail = this.baseOrderServiceForBase.listProductDetailByOrderId(baseOrder.getBaseOrderId());
		return "baseOrderDetailForEdit";
	}
	
	/**
	 * 点击订单详情时提供一个订单号，返回采购订单基本信息，只返回一条收货地址信息，和订单中产品列表
	 * @return
	 */
	public String getBaseOrderDetail() {
		baseOrderX = this.baseOrderServiceForBase.getBaseOrderById(baseOrder.getBaseOrderId());
		receiveGoodsAddress = this.baseOrderServiceForBase.getReceiveGoodsAddressByOrderId(baseOrder.getBaseOrderId());
		baseOrderProductDetail = this.baseOrderServiceForBase.listProductDetailByOrderId(baseOrder.getBaseOrderId());
		return "baseOrderDetail";
	}	
	
	/**
	 * 新增一个订单
	 * @return
	 */
	public String addBaseOrder() {
		
		String pk = this.baseOrderServiceForBase.addBaseOrder(baseOrder);
		this.baseOrderServiceForBase.addBaseOrderDetail(baseOrderProductAddList, pk);
		return SUCCESS;
	}
	
	/**
	 * 更新一个订单
	 * @return
	 */
	public String updateBaseOrder() {
		this.baseOrderServiceForBase.updateBaseOrder(this.baseOrder);
		this.baseOrderServiceForBase.updateBaseOrderDetail(baseOrderProductAddList, baseOrderProductOriginalList, this.baseOrder.getBaseOrderId());
		return SUCCESS;
	}
	
	
	/**
	 * 取消一个订单,设置order的状态为取消状态
	 */
	public String cancelBaseOrder() {
		baseOrder.setOrderState(3);
		this.baseOrderServiceForBase.cancelBaseOrder(baseOrder);
		return SUCCESS;
	}
	
	/**
	 * 支付定金
	 * @return success 
	 */
	public String payForDepositBase(){
		List<BaseOrderDetail> list = this.baseOrderServiceForBase.listProductDetailByOrderId(this.baseOrder.getBaseOrderId());
		this.request.put("query", list);
		this.baseOrder = this.baseOrderServiceForBase.getBaseOrderById(this.baseOrder.getBaseOrderId());
		this.request.put("baseOrder", baseOrder);
		GoodsAddress goodsAddress = new GoodsAddress();
		goodsAddress = this.baseOrderServiceForBase.getReceiveGoodsAddressByOrderId(baseOrder.getBaseOrderId());
		this.request.put("goodsAddress", goodsAddress);
		return SUCCESS;
	}
	
	public String payForDepositBaseUpdate(){
		this.baseOrder = this.baseOrderServiceForBase.getBaseOrderById(this.baseOrder.getBaseOrderId());
		/*
		 * 调用第三方接口支付定金
		 */
		System.out.println("调用第三方接口支付定金: " + baseOrder.getDeposit());
		
		this.baseOrder.setOrderState(2);
		this.baseOrder.setDepositState(true);
		this.baseOrderServiceForBase.updateBaseOrderState(baseOrder);
		this.baseOrderServiceForBase.updateBaseOrderDepositState(baseOrder);
		return SUCCESS;
	}
	
	/**
	 * 确认到货
	 */
	public String comfirmReceiveGoodsBase(){
		List<BaseOrderDetail> list = this.baseOrderServiceForBase.listProductDetailByOrderId(this.baseOrder.getBaseOrderId());
		this.request.put("query", list);
		this.baseOrder = this.baseOrderServiceForBase.getBaseOrderById(this.baseOrder.getBaseOrderId());
		this.request.put("baseOrder", baseOrder);
		GoodsAddress goodsAddress = new GoodsAddress();
		goodsAddress = this.baseOrderServiceForBase.getReceiveGoodsAddressByOrderId(baseOrder.getBaseOrderId());
		this.request.put("goodsAddress", goodsAddress);
		return SUCCESS;		
	}
	
	public String comfirmReceiveGoodsBaseUpdate(){
		List<BaseOrderDetail> list = this.baseOrderServiceForBase.listProductDetailByOrderId(this.baseOrder.getBaseOrderId());
		this.baseOrderServiceForBase.updateBaseProduct(list);
		this.baseOrder.setOrderState(5);
		this.baseOrderServiceForBase.updateBaseOrderState(baseOrder);
		return SUCCESS;
	}
	
	/**
	 * 支付余款
	 * @return
	 */
	public String payForGoodsBase(){
		List<BaseOrderDetail> list = this.baseOrderServiceForBase.listProductDetailByOrderId(this.baseOrder.getBaseOrderId());
		this.request.put("query", list);
		this.baseOrder = this.baseOrderServiceForBase.getBaseOrderById(this.baseOrder.getBaseOrderId());
		this.request.put("baseOrder", baseOrder);
		GoodsAddress goodsAddress = new GoodsAddress();
		goodsAddress = this.baseOrderServiceForBase.getReceiveGoodsAddressByOrderId(baseOrder.getBaseOrderId());
		this.request.put("goodsAddress", goodsAddress);
		return SUCCESS;
	}
	
	public String payForGoodsBaseUpdate(){
		this.baseOrder = this.baseOrderServiceForBase.getBaseOrderById(this.baseOrder.getBaseOrderId());
		/*
		 * 调用第三方接口支付余款
		 */
		Double remainPayment = this.baseOrder.getTotalPrice();
		if(this.baseOrder.getDepositState() != null &&  this.baseOrder.getDepositState() == true){
			remainPayment -= this.baseOrder.getDeposit();
		}
		System.out.println("调用第三方接口支付定金: " + remainPayment);
		
		this.baseOrder.setOrderState(6);
		this.baseOrderServiceForBase.updateBaseOrderState(baseOrder);
		return SUCCESS;
	}
	
	/**
	 * 退款
	 * @return
	 */
	public String baseRejectedMag(){
		List<BaseOrderDetail> list = this.baseOrderServiceForBase.listProductDetailByOrderId(this.baseOrder.getBaseOrderId());
		this.request.put("query", list);
		this.baseOrder = this.baseOrderServiceForBase.getBaseOrderById(this.baseOrder.getBaseOrderId());
		this.request.put("baseOrder", baseOrder);
		return SUCCESS;
	}
	
	public String confirmRejected(){
		this.baseOrderServiceForBase.updateBaseOrderDetailReject(this.baseOrder.getBaseOrderId(), rejectList);
		this.baseOrderServiceForBase.updateBaseOrderRefund(this.baseOrder);
		this.baseOrder.setOrderState(7);
		this.baseOrderServiceForBase.updateBaseOrderState(this.baseOrder);
		
		List<BaseOrderDetail> list = this.baseOrderServiceForBase.listProductDetailByOrderId(this.baseOrder.getBaseOrderId());
		this.request.put("query", list);
		this.baseOrder = this.baseOrderServiceForBase.getBaseOrderById(this.baseOrder.getBaseOrderId());
		this.request.put("baseOrder", baseOrder);
		return SUCCESS;
	}
	
	public GoodsAddress getReceiveGoodsAddress() {
		return receiveGoodsAddress;
	}

	public void setReceiveGoodsAddress(GoodsAddress receiveGoodsAddress) {
		this.receiveGoodsAddress = receiveGoodsAddress;
	}

	@JSON(serialize = false)
	public String getUserIdInSession() {
		return userIdInSession;
	}

	public void setUserIdInSession(String userIdInSession) {
		this.userIdInSession = userIdInSession;
	}

	@JSON(serialize = false)
	public String getBaseIdInSession() {
		return baseIdInSession;
	}

	public void setBaseIdInSession(String baseIdInSession) {
		this.baseIdInSession = baseIdInSession;
	}

	public String getBaseOrderProductAddList() {
		return baseOrderProductAddList;
	}

	public void setBaseOrderProductAddList(String baseOrderProductAddList) {
		this.baseOrderProductAddList = baseOrderProductAddList;
	}

	public String getBaseOrderProductOriginalList() {
		return baseOrderProductOriginalList;
	}

	public void setBaseOrderProductOriginalList(String baseOrderProductOriginalList) {
		this.baseOrderProductOriginalList = baseOrderProductOriginalList;
	}

	public String getRejectList() {
		return rejectList;
	}

	public void setRejectList(String rejectList) {
		this.rejectList = rejectList;
	}

	@JSON(serialize = false)
	public BaseOrderService getBaseOrderServiceForBase() {
		return baseOrderServiceForBase;
	}

	public void setBaseOrderServiceForBase(BaseOrderService baseOrderServiceForBase) {
		this.baseOrderServiceForBase = baseOrderServiceForBase;
	}

	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	@JSON(serialize = false)
	public Map<String, Object> getSession() {
		return session;
	}

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
	
	public String baseRejectedInfo() {
		List<BaseOrderDetail> list = this.baseOrderServiceForBase.listProductDetailByOrderId(this.baseOrder.getBaseOrderId());
		this.request.put("query", list);
		this.baseOrder = this.baseOrderServiceForBase.getBaseOrderById(this.baseOrder.getBaseOrderId());
		this.request.put("purchaseOrderId", this.baseOrder.getBaseOrderId());
		this.request.put("actualRefund", this.baseOrder.getActualRefund());
		return SUCCESS;
	}
	
	public String baseOrderLogisticsInfo() {
		this.baseOrder = this.baseOrderServiceForBase.logisticsInformation(this.baseOrder.getBaseOrderId());
		this.request.put("baseOrder", baseOrder);
		return SUCCESS;
	}
}
