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
	 * �������������ѯ���ض����б�
	 * @param bo
	 * @return
	 */
	public List<BaseOrder> listBaseOrder(BaseOrder bo);
	
	/**
	 * ɾ�����ض����б�
	 * @param baseOrderIdListForDel
	 */
	public void deleteBaseOrder(String baseOrderIdListForDel);
	
	/**
	 * ��ȡ��Ӧ���б�
	 * @return
	 */
	public List<Supplier> querySupplierList();
	
	/**
	 * ��ȡ���вɹ��б�
	 */
	public List<CentralizedPlanedPurchase> queryCentralizedPurchaseList();
	
	/**
	 * ��ȡ�ƻ��ɹ��б�
	 * @return
	 */
	public List<CentralizedPlanedPurchase> queryPlanedPurchaseList();
	
	/**
	 * ���ݻ��ص�¼���û�����ȡ��Ӧ�����ջ���ַ�б�
	 */
	public List<GoodsAddress> queryGoodsAddressList(GoodsAddress address);
	
	/**
	 * ���ݻ��زɹ������Ż�ö�����ϸ��Ϣ���Ƿ��м��вɹ����ƻ��ɹ���
	 */
	public BaseOrder getBaseOrderById(String baseOrderId);
	
	/**
	 * ���ݻ��زɹ������Ż�ȡ�����ڵĲ�Ʒ�����б� 
	 */
	public List<BaseOrderDetail> listProductDetailByOrderId(String baseOrderId);
	
	/**
	 * ��ȡ��Ӧ�̲�Ʒ�б�
	 * @return
	 */
	public List<SupplierProduct> querySupplierProductList();
	
	
	/**
	 * �������ύ������id���ҵ���ѯ�ջ���ַ��ϸ��Ϣ
	 * @param baseOrderId
	 * @return
	 */
	public GoodsAddress getReceiveGoodsAddressByOrderId(String baseOrderId);
	
	
	/**
	 * ����һ�����ض������������½�������id
	 */
	public String addBaseOrder(BaseOrder bo);
	
	
	/**
	 * ���ݶ���id���Ӳ�Ʒdetail�б�
	 * @param baseOrderProductAddList
	 * @param pk
	 */
	public void addBaseOrderDetail(String baseOrderProductAddList, String pk);
	
	
	/**
	 * ����һ������
	 */
	public void updateBaseOrder(BaseOrder baseOrder);
	
	/**
	 * ����һ������(���¶�������)���ϲ�ԭʼ�Ĳ�Ʒ�б���½��Ĳ�Ʒ�б�
	 */
	
	public void updateBaseOrderDetail(String add, String original, String pk);
	
	/**
	 * ���¶���״̬
	 */
	public void updateBaseOrderState(BaseOrder baseOrder);
	
	/**
	 * ���¶���״̬
	 */
	public void updateBaseOrderDepositState(BaseOrder baseOrder);
	
	/**
	 * ���²�Ʒ��
	 */
	public void updateBaseProduct(List<BaseOrderDetail> list);
	
	/**
	 * ���¶����˿���Ϣ
	 */
	public void updateBaseOrderRefund(BaseOrder order);
	
	/**
	 * �����˻�ʱ���¶�����ϸ���˻�����
	 */
	public void updateBaseOrderDetailReject(String id, String list);
	
	
	/**
	 * ȡ��һ�������������ǰ����״̬Ϊ�������ύδ֧�����𡱻򡰶����ύ��֧�����𡱣��Ҳࡰ�༭����ť���Ϊ���������顱�͡�ȡ�����������ȡ�������Խ�����״̬���Ϊ��ȡ����
	 */
	public void cancelBaseOrder(BaseOrder order);

	public Integer baseOrderTotalCount(BaseOrder baseOrder);

	public List<BaseOrder> listBaseOrder(BaseOrder baseOrder, Page page);

	public List<SupplierProduct> querySupplierProductList(String supplierId);

	public BaseOrder logisticsInformation(String baseOrderId);
}
