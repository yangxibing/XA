package com.basicData.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.basicData.dao.BiddingExpertDao;
import com.model.BiddingExpert;
import com.model.Page;

public class BiddingExpertServiceImpl implements BiddingExpertService{

	private BiddingExpertDao biddingExpertDao;
	
	public List<BiddingExpert> queryExpert(BiddingExpert expert) {
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		if(expert.getMinAge()!= null && expert.getMinAge() != 0){
			calendar.add(Calendar.YEAR, expert.getMinAge()*(-1));
			String dateStr = calendar.get(Calendar.YEAR) + "-"
				+ (calendar.get(Calendar.MONTH)+1) + "-"
				+ calendar.get(Calendar.DAY_OF_MONTH);
			
			try {
				expert.setEndDate(dateFormat.parse(dateStr));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if(expert.getMaxAge() != null && expert.getMaxAge() != 0){
			int value = expert.getMaxAge()*(-1);
			if(expert.getMinAge() != 0) value += expert.getMinAge();
			calendar.add(Calendar.YEAR, value);
			String dateStr = (calendar.get(Calendar.YEAR)-1) + "-"
			+ (calendar.get(Calendar.MONTH)+1) + "-"
			+ calendar.get(Calendar.DAY_OF_MONTH);
			try {
				expert.setBeginDate(dateFormat.parse(dateStr));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		return this.biddingExpertDao.queryExpert(expert);
	}
	
	public List<BiddingExpert> queryExpert(BiddingExpert expert, Page page){
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		if(expert.getMinAge()!= null && expert.getMinAge() != 0){
			calendar.add(Calendar.YEAR, expert.getMinAge()*(-1));
			String dateStr = calendar.get(Calendar.YEAR) + "-"
				+ (calendar.get(Calendar.MONTH)+1) + "-"
				+ calendar.get(Calendar.DAY_OF_MONTH);
			
			try {
				expert.setEndDate(dateFormat.parse(dateStr));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if(expert.getMaxAge() != null && expert.getMaxAge() != 0){
			int value = expert.getMaxAge()*(-1);
			if(expert.getMinAge() != 0) value += expert.getMinAge();
			calendar.add(Calendar.YEAR, value);
			String dateStr = (calendar.get(Calendar.YEAR)-1) + "-"
			+ (calendar.get(Calendar.MONTH)+1) + "-"
			+ calendar.get(Calendar.DAY_OF_MONTH);
			try {
				expert.setBeginDate(dateFormat.parse(dateStr));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		return this.biddingExpertDao.queryExpert(expert, page);		
	}
	
	public Integer purchaserTotalCount(BiddingExpert expert){
		return this.biddingExpertDao.purchaserTotalCount(expert);
	}

	public void deleteExpert(String expertList) {
		String[] idArray = expertList.split(",");
		for(int index=0; index<idArray.length; index++){
			this.biddingExpertDao.deleteExpert(idArray[index]);
		}
	}
	
	public void addExpert(BiddingExpert expert) {
		this.biddingExpertDao.addExpert(expert);
	}
	
	public void updateExpert(BiddingExpert expert){
		this.biddingExpertDao.updateExpert(expert);
	}
	
	public BiddingExpert getExpertById(String id){
		return this.biddingExpertDao.getExpertById(id);
	}
	
	public BiddingExpertDao getBiddingExpertDao() {
		return biddingExpertDao;
	}

	public void setBiddingExpertDao(BiddingExpertDao biddingExpertDao) {
		this.biddingExpertDao = biddingExpertDao;
	}

}
