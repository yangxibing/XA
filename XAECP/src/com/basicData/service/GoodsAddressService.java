package com.basicData.service;

import java.util.List;

import com.model.GoodsAddress;

public interface GoodsAddressService {

	public List<GoodsAddress> queryGoodsAddress(String userId, Boolean bool);
	public void setDefaultAddress(GoodsAddress address);
	public void deleteGoodsAddress(String addressList);
	public GoodsAddress getGoodsAddressById(String id);
	public String addGoodsAddress(GoodsAddress address);
	public void updateGoodsAddress(GoodsAddress address);
}
