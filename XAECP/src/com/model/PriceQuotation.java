package com.model;

public class PriceQuotation {
	private String productId;         //��Ʒ���룭����(��Ʒ��͹�Ӧ�̲�Ʒ�������)
	private String productName;       //��Ʒ����
	private String supplierId;        //��Ӧ�̴���
	private String supplierName;      //���õ���Ӧ�̱�����Ӧ������
	private String productTypeId;     //��Ʒ������
	private String productTypeName;   //���õ���Ʒ���ͱ� ������Ʒ�����
	private Double basePrice;         //��׼�۸�
	private String measureUnit;       //������λ
	private String format;            //���
	private String remark;            //��ע
	private Double price;             //��Ʒ�����۸�
	private Double number;              //��Ʒ�� �������زֿ�����
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
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
	public String getProductTypeId() {
		return productTypeId;
	}
	public void setProductTypeId(String productTypeId) {
		this.productTypeId = productTypeId;
	}
	public String getProductTypeName() {
		return productTypeName;
	}
	public void setProductTypeName(String productTypeName) {
		this.productTypeName = productTypeName;
	}
	public Double getBasePrice() {
		return basePrice;
	}
	public void setBasePrice(Double basePrice) {
		this.basePrice = basePrice;
	}
	public String getMeasureUnit() {
		return measureUnit;
	}
	public void setMeasureUnit(String measureUnit) {
		this.measureUnit = measureUnit;
	}
	public String getFormat() {
		return format;
	}
	public void setFormat(String format) {
		this.format = format;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Double getNumber() {
		return number;
	}
	public void setNumber(Double number) {
		this.number = number;
	}

	
}
