package com.basicData.service;

import java.util.List;

import com.basicData.dao.GoodsAddressDao;
import com.model.GoodsAddress;

public class GoodsAddressServiceImpl implements GoodsAddressService{

	private GoodsAddressDao goodsAddressDao;
	
	/**
	 * PurchaserOrderAction.goodsAddressManage()->this.queryGoodsAddress()
	 * 
	 * @return List<GoodsAddress> : the goods address list of the current user.
	 */
	public List<GoodsAddress> queryGoodsAddress(String userId, Boolean bool){
		GoodsAddress address = new GoodsAddress();
		address.setUserId(userId);
		address.setSendOrReceive(bool);
		return this.goodsAddressDao.queryGoodsAddressList(address);
	}
	
	public void setDefaultAddress(GoodsAddress address){
		this.goodsAddressDao.resetDefaultAddress(address);
		this.goodsAddressDao.setDefaultAddress(address);
	}
	
	/**
	 * GoodsAddressAction.deleteGoodsAddress()->this.deleteGoodsAddress(String)
	 * Delete the selected goods address in addressList
	 * 
	 */
	public void deleteGoodsAddress(String addressList){
		String[] list = addressList.split(",");
		for(int index=0; index<list.length; index++){
			this.goodsAddressDao.deleteGoodsAddressById(list[index]);
		}
	}
	
	/**
	 * GoodsAddressAction.getGoodsAddressById()->this.getGoodsAddressById(String)
	 * Get goodsAddress specified by the id.
	 * 
	 * @return GoodsAddress
	 */
	public GoodsAddress getGoodsAddressById(String id){
		return this.goodsAddressDao.getGoodsAddressById(id);
	}
	
	/**
	 * GoodsAddressAction.addGoodsAddress()->this.addGoodsAddress(GoodsAddress)
	 * Add new goods address into the database.
	 * 
	 */
	public String addGoodsAddress(GoodsAddress address){
		if(address.getDefaultOrNot() == "true"){
			this.goodsAddressDao.resetDefaultAddress(address);
		}
		return this.goodsAddressDao.addGoodsAddress(address);
	}
	
	public void updateGoodsAddress(GoodsAddress address){
		if(address.getDefaultOrNot() == "true"){
			this.goodsAddressDao.resetDefaultAddress(address);
		}
		this.goodsAddressDao.updateGoodsAddress(address);
	}

	public GoodsAddressDao getGoodsAddressDao() {
		return goodsAddressDao;
	}

	public void setGoodsAddressDao(GoodsAddressDao goodsAddressDao) {
		this.goodsAddressDao = goodsAddressDao;
	}
}
