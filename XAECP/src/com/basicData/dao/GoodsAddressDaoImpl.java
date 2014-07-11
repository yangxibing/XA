package com.basicData.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.GoodsAddress;

public class GoodsAddressDaoImpl extends SqlMapClientDaoSupport implements GoodsAddressDao{
	
	public List<GoodsAddress> queryGoodsAddressList(GoodsAddress address){
		List list = this.getSqlMapClientTemplate().queryForList("goodsAddress.queryGoodsAddressList", address);
		return list;
	}
	
	public int resetDefaultAddress(GoodsAddress address){
		return this.getSqlMapClientTemplate().update("goodsAddress.resetDefaultAddress", address);
	}
	
	public int setDefaultAddress(GoodsAddress address){
		return this.getSqlMapClientTemplate().update("goodsAddress.setDefaultAddress", address);
	}
	
	public int deleteGoodsAddressById(String id){
		return this.getSqlMapClientTemplate().delete("goodsAddress.deleteGoodsAddressById", id);
	}
	
	public GoodsAddress getGoodsAddressById(String id){
		return (GoodsAddress) this.getSqlMapClientTemplate().queryForObject("goodsAddress.getGoodsAddressById", id);
	}
	
	public String addGoodsAddress(GoodsAddress address){
		return (String) this.getSqlMapClientTemplate().insert("goodsAddress.addGoodsAddress", address);
	}
	
	public int updateGoodsAddress(GoodsAddress address){
		return this.getSqlMapClientTemplate().update("goodsAddress.updateGoodsAddress", address);
	}
}
