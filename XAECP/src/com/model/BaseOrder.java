package com.model;

import java.util.Date;

/**
 * ���زɹ�������
 * @author hubo
 *
 */
public class BaseOrder {
	private String baseOrderId;   //���زɹ���������
	private String supplierId;    //��Ӧ�̴���
	private String supplierName;  //��Ӧ������
	private Double deposit;       //����
	private Boolean depositState;//����״̬��0��δ֧����1����֧��
	private Integer orderState;   //����״̬
	private String orderStateName;
	private String deliverDate;     //��������
		private Date begin;
		private Date end;
	private Double fare;             //�˷�
	private Double totalPrice;       //�ܻ���
	private String CPIId;            //���вɹ���Ϣ����
	private String PPIId;            //�ƻ��ɹ���Ϣ����
	private String logisticsSupplierId; //������Ӧ�̴���
	private String logisticsName;
	private String logisticsOrderId; //��������
	private Double actualRefund;     //ʵ���˻���
	private String receiveAddressId;  //���ܵ�ַ���
	private String receiveAddress;
	private String receiveZipCode;
	private String receiver;
	private String receiveTelephone;
	private String sendAddressId;    //���͵�ַ���
	private String sendAddress;
	private String sendZipCode;
	private String sender;
	private String sendTelephone;
	private String logisticsWebsite;
	public String getBaseOrderId() {
		return baseOrderId;
	}
	public void setBaseOrderId(String baseOrderId) {
		this.baseOrderId = baseOrderId;
	}
	public String getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}
	public String getSupplierName() {
		return supplierName;
	}
	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
	public Double getDeposit() {
		return deposit;
	}
	public void setDeposit(Double deposit) {
		this.deposit = deposit;
	}
	public Integer getOrderState() {
		return orderState;
	}
	public void setOrderState(Integer orderState) {
		this.orderState = orderState;
	}
	
	public String getDeliverDate() {
		return deliverDate;
	}
	public void setDeliverDate(String deliverDate) {
		this.deliverDate = deliverDate;
	}
	public Double getFare() {
		return fare;
	}
	public void setFare(Double fare) {
		this.fare = fare;
	}
	public Double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getCPIId() {
		return CPIId;
	}
	public void setCPIId(String cPIId) {
		CPIId = cPIId;
	}
	public String getPPIId() {
		return PPIId;
	}
	public void setPPIId(String pPIId) {
		PPIId = pPIId;
	}
	public String getLogisticsSupplierId() {
		return logisticsSupplierId;
	}
	public void setLogisticsSupplierId(String logisticsSupplierId) {
		this.logisticsSupplierId = logisticsSupplierId;
	}
	public String getLogisticsOrderId() {
		return logisticsOrderId;
	}
	public void setLogisticsOrderId(String logisticsOrderId) {
		this.logisticsOrderId = logisticsOrderId;
	}
	public Double getActualRefund() {
		return actualRefund;
	}
	public void setActualRefund(Double actualRefund) {
		this.actualRefund = actualRefund;
	}
	public String getReceiveAddressId() {
		return receiveAddressId;
	}
	public void setReceiveAddressId(String receiveAddressId) {
		this.receiveAddressId = receiveAddressId;
	}
	public String getSendAddressId() {
		return sendAddressId;
	}
	public void setSendAddressId(String sendAddressId) {
		this.sendAddressId = sendAddressId;
	}
	public Boolean getDepositState() {
		return depositState;
	}
	public void setDepositState(Boolean depositState) {
		this.depositState = depositState;
	}
	public String getOrderStateName() {
		return orderStateName;
	}
	public void setOrderStateName(String orderStateName) {
		this.orderStateName = orderStateName;
	}
	public String getLogisticsName() {
		return logisticsName;
	}
	public void setLogisticsName(String logisticsName) {
		this.logisticsName = logisticsName;
	}
	public String getReceiveAddress() {
		return receiveAddress;
	}
	public void setReceiveAddress(String receiveAddress) {
		this.receiveAddress = receiveAddress;
	}
	public String getReceiveZipCode() {
		return receiveZipCode;
	}
	public void setReceiveZipCode(String receiveZipCode) {
		this.receiveZipCode = receiveZipCode;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getReceiveTelephone() {
		return receiveTelephone;
	}
	public void setReceiveTelephone(String receiveTelephone) {
		this.receiveTelephone = receiveTelephone;
	}
	public String getSendAddress() {
		return sendAddress;
	}
	public void setSendAddress(String sendAddress) {
		this.sendAddress = sendAddress;
	}
	public String getSendZipCode() {
		return sendZipCode;
	}
	public void setSendZipCode(String sendZipCode) {
		this.sendZipCode = sendZipCode;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getSendTelephone() {
		return sendTelephone;
	}
	public void setSendTelephone(String sendTelephone) {
		this.sendTelephone = sendTelephone;
	}
	public String getLogisticsWebsite() {
		return logisticsWebsite;
	}
	public void setLogisticsWebsite(String logisticsWebsite) {
		this.logisticsWebsite = logisticsWebsite;
	}
	public Date getBegin() {
		return begin;
	}
	public void setBegin(Date begin) {
		this.begin = begin;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}	
}
