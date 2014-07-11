package com.model;

import java.util.Date;

public class PurchaseOrder {

	private String purchaseOrderId;
	private String purchaserId;
	private Double deposit;
	private Integer orderState;
	private String orderStateName;
	private String deliverDate;
		private Date begin;
		private Date end;
	private String receiveAddress;
	private String receiveZipCode;
	private String receiver;
	private String receiveTelephone;
	private Double fare;
	private Double totalPrice;
	private String CPIId;
	private Integer logisticsSupplierId;
	private String logisticsOrderId;
	private String sendAddressId;
	private String receiveAddressId;
	private String sendAddress;
	private String sendZipCode;
	private String sender;
	private String sendTelephone;
	private Double actualRefund;	
		private String purchaserName;
	private Double orderRate;
	private Double ownOrder;	
	private String logisticsName;
	private String logisticsWebsite;
	private Integer evaluateNumber;
	
	public String getSendAddressId() {
		return sendAddressId;
	}
	public void setSendAddressId(String sendAddressId) {
		this.sendAddressId = sendAddressId;
	}
	public String getLogisticsOrderId() {
		return logisticsOrderId;
	}
	public void setLogisticsOrderId(String logisticsOrderId) {
		this.logisticsOrderId = logisticsOrderId;
	}
	public Double getOwnOrder() {
		return ownOrder;
	}
	public void setOwnOrder(Double ownOrder) {
		this.ownOrder = ownOrder;
	}
	public Double getOrderRate() {
		return orderRate;
	}
	public void setOrderRate(Double orderRate) {
		this.orderRate = orderRate;
	}
	public String getPurchaserName() {
		return purchaserName;
	}
	public void setPurchaserName(String purchaserName) {
		this.purchaserName = purchaserName;
	}
	public String getPurchaseOrderId() {
		return purchaseOrderId;
	}
	public void setPurchaseOrderId(String purchaseOrderId) {
		this.purchaseOrderId = purchaseOrderId;
	}
	public String getPurchaserId() {
		return purchaserId;
	}
	public void setPurchaserId(String purchaserId) {
		this.purchaserId = purchaserId;
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
	public Double getFare() {
		return fare;
	}
	public void setFare(Double fare) {
		this.fare = fare;
	}
	public String getOrderStateName() {
		return orderStateName;
	}
	public void setOrderStateName(String orderStateName) {
		this.orderStateName = orderStateName;
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
	public Integer getLogisticsSupplierId() {
		return logisticsSupplierId;
	}
	public void setLogisticsSupplierId(Integer logisticsSupplierId) {
		this.logisticsSupplierId = logisticsSupplierId;
	}
	public String getLogisticOrderId() {
		return logisticsOrderId;
	}
	public void setLogisticOrderId(String logisticsOrderId) {
		this.logisticsOrderId = logisticsOrderId;
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
	public String getLogisticsName() {
		return logisticsName;
	}
	public void setLogisticsName(String logisticsName) {
		this.logisticsName = logisticsName;
	}
	public String getLogisticsWebsite() {
		return logisticsWebsite;
	}
	public void setLogisticsWebsite(String logisticsWebsite) {
		this.logisticsWebsite = logisticsWebsite;
	}
	public Integer getEvaluateNumber() {
		return evaluateNumber;
	}
	public void setEvaluateNumber(Integer evaluateNumber) {
		this.evaluateNumber = evaluateNumber;
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
