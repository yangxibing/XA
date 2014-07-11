package com.model;


/**
 * 服务于报价查询的model类，因为要显示询价单详情
 * @author Hu Bo
 */
public class Enquiry {
	
	private String askPriceId;          //询价单代码
	private String productTypeId;     //产品类型代码
	private String productTypeName;   //产品类型名
	private Integer askPriceState;        //询价状态   (0未发布) (1已发布) (2询比价完成)
	private String askPriceStateStr;  //询价状态字符串显示
	private Double number;               //数量(这次要订购多少)
	private String measureUnit;       //度量单位
	private String deadline;          //截止日期
	private String remark;            //询价单中－备注
	
	private String supplierId;        //报价单中供应商代码
	private boolean isAnswer;         //报价单中供应商是否对该询价单报价
	private boolean isSelected;       //报价单中供应商是否被选中
	
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
