package com.basicData.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.HotlineAdvertisement;

public class UploadDaoImpl extends SqlMapClientDaoSupport implements UploadDao{

	public void uploadAdv(HotlineAdvertisement adv) {
		
		this.getSqlMapClientTemplate().update("upload",adv);
	}

	public void addHotline(String hotline) {
		System.out.println("daoHotline"+hotline);
		Map<String,String> map=new HashMap<String,String>();
		map.put("hotline", hotline);
		this.getSqlMapClientTemplate().update("addHotline",map);
	}

	public HotlineAdvertisement getHotLineAndAdvert() {
		
		return (HotlineAdvertisement) this.getSqlMapClientTemplate().queryForObject("getHotLineAndAdvert");
	}

}
