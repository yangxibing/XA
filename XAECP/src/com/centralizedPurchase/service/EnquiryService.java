package com.centralizedPurchase.service;

import java.util.List;

import com.model.Enquiry;
import com.model.Page;
import com.model.ProductType;
import com.model.Quote;

public interface EnquiryService {

	public List<ProductType> getProductTypeInEnquiry();
	public ProductType queryProductTypeListServerSide();
	public List<Enquiry> queryEnquiry(Enquiry enquiry);
	public List<Enquiry> queryEnquiry(Enquiry enquiry, Page page);
	public Integer enquiryTotalCount(Enquiry enquiry);
	public Enquiry getEnquiryById(String id);
	public void addEnquiry(Enquiry enquiry);
	public void updateEnquiry(Enquiry enquiry);
	public void deleteEnquiry(String enquiryList);
	public List<Quote> getQuotesInEnquiry(Quote quote);
	public void publishPriceCompare(String quoteList, Enquiry enquiry);
}
