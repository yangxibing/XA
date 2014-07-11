package com.baseInformation.dao;

import java.util.List;

import com.model.Page;
import com.model.PriceQuotation;

public interface PriceQuotationDao {
	public List<PriceQuotation> queryPriceQuotation(PriceQuotation quotation);
	public List<PriceQuotation> queryPriceQuotation(PriceQuotation quotation, Page page);
	public Integer quotationTotalCount(PriceQuotation quotation);
	public List<PriceQuotation> getQuotationAddList(PriceQuotation quotation);
	public PriceQuotation getPriceQuotationById(String id);
	public void addPriceQuotation(PriceQuotation quotation);
	public void updatePriceQuotation(PriceQuotation quotation);
	public void deletePriceQuotationById(String id);
}
