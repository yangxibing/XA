package com.model;

import java.util.Date;

/**
 * 基地采购订单表
 * @author hubo
 *
 */
public class BaseOrder {
	private String baseOrderId;   //基地采购订单代码
	private String supplierId;    //供应商代码
	private String supplierName;  //供应商名字
	private Double deposit;       //定金
	private Boolean depositState;//定金状态，0＝未支付，1＝已支付
	private Integer orderState;   //订单状态
	private String orderStateName;
	private String deliverDate;     //交货日期
		private Date begin;
		private Date end;
	private Double fare;             //运费
	private Double totalPrice;       //总货款
	private String CPIId;            //集中采购信息代码
	private String PPIId;            //计划采购信息代码
	private String logisticsSupplierId; //物流供应商代码
	private String logisticsName;
	private String logisticsOrderId; //物流单号
	private Double actualRefund;     //实际退货款
	private String receiveAddressId;  //接受地址编号
	private String receiveAddress;
	private String receiveZipCode;
	private String receiver;
	private String receiveTelephone;
	private String sendAddressId;    //发送地址编号
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
