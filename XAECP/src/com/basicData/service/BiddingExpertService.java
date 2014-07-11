package com.basicData.service;

import java.util.List;

import com.model.BiddingExpert;
import com.model.Page;

public interface BiddingExpertService {
	public List<BiddingExpert> queryExpert(BiddingExpert expert);
	public List<BiddingExpert> queryExpert(BiddingExpert expert, Page page);
	public Integer purchaserTotalCount(BiddingExpert expert);
	public void deleteExpert(String expertList);
	public void addExpert(BiddingExpert expert);
	public BiddingExpert getExpertById(String id);
	public void updateExpert(BiddingExpert expert);
}
