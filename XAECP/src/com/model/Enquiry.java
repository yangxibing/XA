package com.model;


/**
 * �����ڱ��۲�ѯ��model�࣬��ΪҪ��ʾѯ�۵�����
 * @author Hu Bo
 */
public class Enquiry {
	
	private String askPriceId;          //ѯ�۵�����
	private String productTypeId;     //��Ʒ���ʹ���
	private String productTypeName;   //��Ʒ������
	private Integer askPriceState;        //ѯ��״̬   (0δ����) (1�ѷ���) (2ѯ�ȼ����)
	private String askPriceStateStr;  //ѯ��״̬�ַ�����ʾ
	private Double number;               //����(���Ҫ��������)
	private String measureUnit;       //������λ
	private String deadline;          //��ֹ����
	private String remark;            //ѯ�۵��У���ע
	
	private String supplierId;        //���۵��й�Ӧ�̴���
	private boolean isAnswer;         //���۵��й�Ӧ���Ƿ�Ը�ѯ�۵�����
	private boolean isSelected;       //���۵��й�Ӧ���Ƿ�ѡ��
	
	public String getAskPriceId() {
		return askPriceId;
	}
	public void setAskPriceId(String askPriceId) {
		this.askPriceId = askPriceId;
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
	public Integer getAskPriceState() {
		return askPriceState;
	}
	public void setAskPriceState(Integer askPriceState) {
		this.askPriceState = askPriceState;
	}
	public String getAskPriceStateStr() {
		return askPriceStateStr;
	}
	public void setAskPriceStateStr(String askPriceStateStr) {
		this.askPriceStateStr = askPriceStateStr;
	}
	public Double getNumber() {
		return number;
	}
	public void setNumber(Double number) {
		this.number = number;
	}
	public String getMeasureUnit() {
		return measureUnit;
	}
	public void setMeasureUnit(String measureUnit) {
		this.measureUnit = measureUnit;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}
	public boolean getIsAnswer() {
		return isAnswer;
	}
	public void setIsAnswer(boolean isAnswer) {
		this.isAnswer = isAnswer;
	}
	public boolean getIsSelected() {
		return isSelected;
	}
	public void setIsSelected(boolean isSelected) {
		this.isSelected = isSelected;
	}
}
