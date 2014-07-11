package com.centralizedPurchase.dao;

import java.util.List;

import com.model.Enquiry;
import com.model.Page;
import com.model.ProductType;
import com.model.Quote;

public interface EnquiryDao {
	
	public List<ProductType> getProductTypeInEnquiry();
	public List<ProductType> getProductListByParantId(ProductType type);
	public List<Enquiry> queryEnquiry(Enquiry enquiry);
	public List<Enquiry> queryEnquiry(Enquiry enquiry, Page page);
	public Integer enquiryTotalCount(Enquiry enquiry);
	public Enquiry getEnquiryById(String id);
	public void addEnquiry(Enquiry enquiry);
	public void updateEnquiry(Enquiry enquiry);
	public void deleteEnquiryById(String id);
	public List<Quote> getQuotesInEnquiry(Quote quote);
	public void selectedQuoteById(String id);
	public void updateEnquiryState(Enquiry enquiry);
}
