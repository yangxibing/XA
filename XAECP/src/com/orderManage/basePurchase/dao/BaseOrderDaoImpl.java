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
		System.out.println("�ɹ���������-�����أ��Թ�Ӧ�� -�������������ѯ");
		List<BaseOrder> list = (List<BaseOrder>)this.getSqlMapClientTemplate().queryForList("baseOrderForBase.listBaseOrder", bo);
		return list;
	}

	public void deleteBaseOrder(String baseOrderIdForDel) {
		System.out.println("�ɹ���������-�����أ��Թ�Ӧ�� -ɾ��δ�ύ����id="+baseOrderIdForDel);
		this.getSqlMapClientTemplate().delete("baseOrderForBase.deleteBaseOrder", baseOrderIdForDel);
	}

	public List<Supplier> querySupplierList() {
		System.out.println("��ȡ��Ӧ�������б���ѯ��Ӧ���б�");
		List<Supplier> list = this.getSqlMapClientTemplate().queryForList("baseOrderForBase.querySupplierList");
		return list;
	}

	public List<CentralizedPlanedPurchase> queryCentralizedPurchaseList() {
		System.out.println("��ȡ���вɹ����������б�");
		List<CentralizedPlanedPurchase> list = this.getSqlMapClientTemplate().queryForList("baseOrderForBase.queryCentralizedPurchaseList");
		return list;
	}

	public List<CentralizedPlanedPurchase> queryPlanedPurchaseList() {
		System.out.println("��ȡ�ƻ��ɹ����������б�");
		List<CentralizedPlanedPurchase> list = this.getSqlMapClientTemplate().queryForList("baseOrderForBase.queryPlanedPurchaseList");
		return list;
	}
	
	public List<GoodsAddress> queryGoodsAddressList(GoodsAddress address){
		System.out.println("��ȡ�����ջ���ַ�б�");
		List<GoodsAddress> list = this.getSqlMapClientTemplate().queryForList("goodsAddress.queryGoodsAddressList", address);
		System.out.println("�����ջ���ַ�б�size �� " +list.size());
		return list;
	}

	public BaseOrder getBaseOrderById(String baseOrderId) {
		System.out.println("���ݻ��ض���id��ȡ�������� id = "+ baseOrderId);
		return (BaseOrder) this.getSqlMapClientTemplate().queryForObject("baseOrderForBase.getBaseOrderById", baseOrderId);
	}

	public List<BaseOrderDetail> listProductDetailByOrderId(String baseOrderId) {
		System.out.println("���ݻ��ض���id��ȡ���������Ʒ�б� id = " + baseOrderId);
		List<BaseOrderDetail> list = this.getSqlMapClientTemplate().queryForList("baseOrderDetail.listBaseOrderDetail", baseOrderId);
		System.out.println("������Ʒ��ϸ�б�size �� " +list.size());
		return list;
	}

	public List<SupplierProduct> querySupplierProductList() {
		System.out.println("��ȡ��Ӧ�̲�Ʒ�б�");
		List<SupplierProduct> list = this.getSqlMapClientTemplate().queryForList("supplierProduct.querySupplierProductList");
		System.out.println("��Ӧ�̲�Ʒ�б�size �� " +list.size());
		return list;
	}

	public GoodsAddress getReceiveGoodsAddressByOrderId(String baseOrderId) {
		System.out.println("�������ύ������id���ҵ���ѯ�ջ���ַ��ϸ��Ϣid="+baseOrderId);
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

	//ȡ��һ�����ض�����������ض���״̬���ڶ����ύδ֧������򶩵��ύ��֧�����𣬿���ȡ�����������𲻷���
	public void cancelBaseOrder(BaseOrder order) {
		System.out.println("ȡ������ ֻ�Ǹı䶩����״̬ BaseorderId=" + order.getBaseOrderId());
		this.getSqlMapClientTemplate().update("baseOrderForBase.updateBaseOrderState", order);
	}

	//����һ������
	public String addBaseOrder(BaseOrder bo) {
		String str = (String) this.getSqlMapClientTemplate().insert("baseOrderForBase.addBaseOrder", bo);
		return str;
	}

	//����һ����������
	public void addBaseOrderDetail(BaseOrderDetail orderdetail) {
		this.getSqlMapClientTemplate().insert("baseOrderDetail.addBaseOrderDetail", orderdetail);
	}

	//����һ������
	public void updateBaseOrder(BaseOrder baseOrder) {
		System.out.println("����һ������  ����baseOrderId="+baseOrder.getBaseOrderId());
		this.getSqlMapClientTemplate().update("baseOrderForBase.updateBaseOrder",baseOrder);
		
	}

	//���¶�������
	public void updateBaseOrderDetail(BaseOrderDetail baseOrderDetail) {
		// TODO Auto-generated method stub
		System.out.println("���»��ض������� ");
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

