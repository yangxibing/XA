package com.model;

import java.util.List;

public class ProductType {
	
	private String productTypeId;
	private String productTypeName;
	private String parentProductTypeId;
	private String parentProductTypeName;
	private String remark;
	
	private String typeLevel;
	private List<ProductType> childrenList;
	
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
	public String getParentProductTypeId() {
		return parentProductTypeId;
	}
	public void setParentProductTypeId(String parentProductTypeId) {
		this.parentProductTypeId = parentProductTypeId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getTypeLevel() {
		return typeLevel;
	}
	public void setTypeLevel(String typeLevel) {
		this.typeLevel = typeLevel;
	}
	public String getParentProductTypeName() {
		return parentProductTypeName;
	}
	public void setParentProductTypeName(String parentProductTypeName) {
		this.parentProductTypeName = parentProductTypeName;
	}
	public List<ProductType> getChildrenList() {
		return childrenList;
	}
	public void setChildrenList(List<ProductType> childrenList) {
		this.childrenList = childrenList;
	}

}
