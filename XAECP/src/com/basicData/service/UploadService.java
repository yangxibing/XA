package com.basicData.service;

import com.model.HotlineAdvertisement;

public interface UploadService {

	public void uploadAdv(HotlineAdvertisement adv);
	public void addHotline(String hotLine);
	public HotlineAdvertisement getHotLineAndAdvert();

}
