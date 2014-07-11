package com.basicData.dao;

import com.model.HotlineAdvertisement;

public interface UploadDao {

	public void uploadAdv(HotlineAdvertisement adv);
	public void addHotline(String hotline);
	public HotlineAdvertisement getHotLineAndAdvert();
}
