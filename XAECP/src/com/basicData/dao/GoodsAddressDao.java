package com.basicData.dao;

import java.util.List;

import com.model.GoodsAddress;

public interface GoodsAddressDao {
	
	public List<GoodsAddress> queryGoodsAddressList(GoodsAddress address);
	public int resetDefaultAddress(GoodsAddress address);
	public int setDefaultAddress(GoodsAddress address);
	public int deleteGoodsAddressById(String id);
	public GoodsAddress getGoodsAddressById(String id);
	public String addGoodsAddress(GoodsAddress address);
	public int updateGoodsAddress(GoodsAddress address);
}
