package com.basicData.service;

import com.basicData.dao.UploadDao;
import com.model.HotlineAdvertisement;

public class UploadServiceImpl implements UploadService{

	public UploadDao uploadDao;
	public void uploadAdv(HotlineAdvertisement adv) {
		
		this.uploadDao.uploadAdv(adv);
	}
	public UploadDao getUploadDao() {
		return uploadDao;
	}
	public void setUploadDao(UploadDao uploadDao) {
		this.uploadDao = uploadDao;
	}
	public void addHotline(String hotLine) {
		this.uploadDao.addHotline(hotLine);
	}
	public HotlineAdvertisement getHotLineAndAdvert() {
		// TODO Auto-generated method stub
		return this.uploadDao.getHotLineAndAdvert();
	}

}
