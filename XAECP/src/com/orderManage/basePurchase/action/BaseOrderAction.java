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
	private BaseOrderService baseOrderServiceForBase;               //����service�ķ���
	private String baseOrderIdListForDel;                    //��Ҫ��ɾ���Ķ���id�б�
	private String userIdInSession;
	private String baseIdInSession;

	private BaseOrder baseOrder = new BaseOrder();           //���ڽ����û��ύ�������߳䵱���ض���
	private List<BaseOrderDetail> baseOrderProductDetail;    //�洢���������еĲ�Ʒ�б�
	private GoodsAddress receiveGoodsAddress;                       //�����ڲ鿴��������ʱ�������ջ���ַ��Ϣ
	private BaseOrder baseOrderX;

	private String baseOrderProductAddList;                 //���ڽ���������Ʒ�б�����
	private String baseOrderProductOriginalList;            //���ڽ��յ���༭ԭʼ�Ĳ�Ʒ�б�����
	private String rejectList;    //�˻��б�
	
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
	 * ��ѯ���زɹ������б�
	 * @return
	 */
	public String listBaseOrder() {
		Integer totalCount = this.baseOrderServiceForBase.baseOrderTotalCount(baseOrder);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<BaseOrder> list = this.baseOrderServiceForBase.listBaseOrder(baseOrder, page);
		request.put("totalPage", this.totalPage);     //������ҳ����ҳ��
		request.put("currentPage", this.currentPage); //���浱ǰҳ��ҳ��
		this.request.put("baseOrderVO", baseOrder);
		this.request.put("query", list);
		return SUCCESS;
	}
	
	/**
	 * ɾ��δ�ύ�Ķ���
	 * @return
	 */
	public String deleteBaseOrder() {
		this.baseOrderServiceForBase.deleteBaseOrder(baseOrderIdListForDel);
		return SUCCESS;
	}
	

	/**
	 * ����༭ʱ��Ҫ���õķ���
	 * @return
	 */
	public String getBaseOrderById() {
		baseOrderX = this.baseOrderServiceForBase.getBaseOrderById(baseOrder.getBaseOrderId());
		baseOrderProductDetail = this.baseOrderServiceForBase.listProductDetailByOrderId(baseOrder.getBaseOrderId());
		return "baseOrderDetailForEdit";
	}
	
	/**
	 * �����������ʱ�ṩһ�������ţ����زɹ�����������Ϣ��ֻ����һ���ջ���ַ��Ϣ���Ͷ����в�Ʒ�б�
	 * @return
	 */
	public String getBaseOrderDetail() {
		baseOrderX = this.baseOrderServiceForBase.getBaseOrderById(baseOrder.getBaseOrderId());
		receiveGoodsAddress = this.baseOrderServiceForBase.getReceiveGoodsAddressByOrderId(baseOrder.getBaseOrderId());
		baseOrderProductDetail = this.baseOrderServiceForBase.listProductDetailByOrderId(baseOrder.getBaseOrderId());
		return "baseOrderDetail";
	}	
	
	/**
	 * ����һ������
	 * @return
	 */
	public String addBaseOrder() {
		
		String pk = this.baseOrderServiceForBase.addBaseOrder(baseOrder);
		this.baseOrderServiceForBase.addBaseOrderDetail(baseOrderProductAddList, pk);
		return SUCCESS;
	}
	
	/**
	 * ����һ������
	 * @return
	 */
	public String updateBaseOrder() {
		this.baseOrderServiceForBase.updateBaseOrder(this.baseOrder);
		this.baseOrderServiceForBase.updateBaseOrderDetail(baseOrderProductAddList, baseOrderProductOriginalList, this.baseOrder.getBaseOrderId());
		return SUCCESS;
	}
	
	
	/**
	 * ȡ��һ������,����order��״̬Ϊȡ��״̬
	 */
	public String cancelBaseOrder() {
		baseOrder.setOrderState(3);
		this.baseOrderServiceForBase.cancelBaseOrder(baseOrder);
		return SUCCESS;
	}
	
	/**
	 * ֧������
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
		 * ���õ������ӿ�֧������
		 */
		System.out.println("���õ������ӿ�֧������: " + baseOrder.getDeposit());
		
		this.baseOrder.setOrderState(2);
		this.baseOrder.setDepositState(true);
		this.baseOrderServiceForBase.updateBaseOrderState(baseOrder);
		this.baseOrderServiceForBase.updateBaseOrderDepositState(baseOrder);
		return SUCCESS;
	}
	
	/**
	 * ȷ�ϵ���
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
	 * ֧�����
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
		 * ���õ������ӿ�֧�����
		 */
		Double remainPayment = this.baseOrder.getTotalPrice();
		if(this.baseOrder.getDepositState() != null &&  this.baseOrder.getDepositState() == true){
			remainPayment -= this.baseOrder.getDeposit();
		}
		System.out.println("���õ������ӿ�֧������: " + remainPayment);
		
		this.baseOrder.setOrderState(6);
		this.baseOrderServiceForBase.updateBaseOrderState(baseOrder);
		return SUCCESS;
	}
	
	/**
	 * �˿�
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
