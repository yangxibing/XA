package com.purchaseTenderInfo.service;

import java.util.List;
import java.util.Map;

import com.model.Page;
import com.model.ProductType;
import com.model.SupplyPurchaseInformation;

public interface SupplyPurchaseInformationService {

	public List<SupplyPurchaseInformation> listSupplyPurchaseInformation(SupplyPurchaseInformation s);
	public List<ProductType> selectProductType();
	public void savePurchaseTender(SupplyPurchaseInformation s);
	public String getUserNameByUserId(String userId);
	public void updatePurchaseTender(SupplyPurchaseInformation s);
	public void deletePurchaseTenderInfo(String idList);
	public List<SupplyPurchaseInformation> listAllSupplyPurchaseInformation(Integer number,Integer start);
	public void visitNumAddOne(Integer id);
	public Integer purchaseTenderInfoTotalCount(
			SupplyPurchaseInformation supplyPurchaseInformation);
	public List<SupplyPurchaseInformation> listSupplyPurchaseInformation(
			SupplyPurchaseInformation supplyPurchaseInformation, Page page);
	public Integer homeAllCaigouInfoTotalCount();
	public List<SupplyPurchaseInformation> homeListAllCaigouInfo(Page page);

}
