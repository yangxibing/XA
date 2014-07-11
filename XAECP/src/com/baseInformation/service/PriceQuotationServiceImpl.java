package com.baseInformation.service;

import java.util.List;

import com.baseInformation.dao.PriceQuotationDao;
import com.model.Page;
import com.model.PriceQuotation;

public class PriceQuotationServiceImpl implements PriceQuotationService {
	
	private PriceQuotationDao priceQuotationDao;

	public List<PriceQuotation> queryPriceQuotation(PriceQuotation quotation) {
		return this.priceQuotationDao.queryPriceQuotation(quotation);
	}
	
	public List<PriceQuotation> queryPriceQuotation(PriceQuotation quotation, Page page){
		return this.priceQuotationDao.queryPriceQuotation(quotation, page);
	}
	
	public Integer quotationTotalCount(PriceQuotation quotation){
		return this.priceQuotationDao.quotationTotalCount(quotation);
	}

	public List<PriceQuotation> getQuotationAddList(PriceQuotation quotation) {
		return this.priceQuotationDao.getQuotationAddList(quotation);
	}
	
	public void addPriceQuotation(PriceQuotation quotation){
		this.priceQuotationDao.addPriceQuotation(quotation);
	}
	
	public void updatePriceQuotation(PriceQuotation quotation){
		this.priceQuotationDao.updatePriceQuotation(quotation);
	}
	
	public void deletePriceQuotationById(String quotationList){
		String[] idArray = quotationList.split(",");
		for(int index=0; index<idArray.length; index++){
			this.priceQuotationDao.deletePriceQuotationById(idArray[index]);
		}
	}

	public PriceQuotationDao getPriceQuotationDao() {
		return priceQuotationDao;
	}

	public void setPriceQuotationDao(PriceQuotationDao priceQuotationDao) {
		this.priceQuotationDao = priceQuotationDao;
	}
	
	public PriceQuotation getPriceQuotationById(String id){
		return this.priceQuotationDao.getPriceQuotationById(id);
	}
}
