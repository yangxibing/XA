package com.supplyGoodsInfo.service;

import java.util.List;

import com.model.Page;
import com.model.ProductType;
import com.model.SupplyPurchaseInformation;

public interface SupplyGoodsInfoService {
	
	
	public List<SupplyPurchaseInformation> listSupplyGoodsInfo(SupplyPurchaseInformation supplyGoodsInfo);
	
	public void deleteSupplyGoodsInfo(String supplyGoodsInfoList);
	
	public List<ProductType> selectProductType();


	public String getUserNameById(String userIdInSession);


	public void addSupplyGoodsInfo(SupplyPurchaseInformation supplyGoodsInfo);


	public SupplyPurchaseInformation getSupplyGoodsInfoById(Integer id);
	
	public void updateSupplyGoodsInfo(SupplyPurchaseInformation s);


	public List<SupplyPurchaseInformation> listAllSupplyGoodsInfo(Integer number,Integer start);
	
	public void visitNumAddOne(Integer id);


	public Integer supplyGoodsInfoTotalCount(
			SupplyPurchaseInformation supplyGoodsInfo);


	public List<SupplyPurchaseInformation> listSupplyGoodsInfo(
			SupplyPurchaseInformation supplyGoodsInfo, Page page);

	public Integer supplyGoodsInfoAllTotalCount();

	public List<SupplyPurchaseInformation> listAllSupplyGoodsInfo(Page page);
}
