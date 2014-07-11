package com.centralizedPurchase.service;

import java.util.List;

import com.centralizedPurchase.dao.EnquiryDao;
import com.model.Enquiry;
import com.model.Page;
import com.model.ProductType;
import com.model.Quote;
import com.model.XAUser;

public class EnquiryServiceImpl implements EnquiryService{
	
	private EnquiryDao enquiryDao;
	
	public List<ProductType> getProductTypeInEnquiry(){
		return this.enquiryDao.getProductTypeInEnquiry();
	}
	
	public ProductType queryProductTypeListServerSide(){
		ProductType root = new ProductType();
		root.setParentProductTypeId("NULL");
		root = this.enquiryDao.getProductListByParantId(root).get(0);
		
		serProductTypeBranchRecursive(root);
		
		return root;
	}
	
	private void serProductTypeBranchRecursive(ProductType type){
		ProductType temp = new ProductType();
		temp.setParentProductTypeId(type.getProductTypeId());
		type.setChildrenList(this.enquiryDao.getProductListByParantId(temp));
		if(type.getChildrenList().size() == 0){
			return;
		}
		for(int index=0; index<type.getChildrenList().size(); index++){
			serProductTypeBranchRecursive(type.getChildrenList().get(index));
		}
	}
	
	public List<Enquiry> queryEnquiry(Enquiry enquiry){
		return this.enquiryDao.queryEnquiry(enquiry);
	}
	
	public List<Enquiry> queryEnquiry(Enquiry enquiry, Page page){
		return this.enquiryDao.queryEnquiry(enquiry, page);
	}
	
	public Integer enquiryTotalCount(Enquiry enquiry){
		return this.enquiryDao.enquiryTotalCount(enquiry);
	}
	
	public Enquiry getEnquiryById(String id){
		return this.enquiryDao.getEnquiryById(id);
	}
	
	public void addEnquiry(Enquiry enquiry){
		this.enquiryDao.addEnquiry(enquiry);
	}
	
	public void updateEnquiry(Enquiry enquiry){
		this.enquiryDao.updateEnquiry(enquiry);
	}
	
	public void deleteEnquiry(String enquiryList){
		String[] idArray = enquiryList.split(",");
		for(int index=0; index<idArray.length; index++){
			this.enquiryDao.deleteEnquiryById(idArray[index]);
		}
	}
	
	public List<Quote> getQuotesInEnquiry(Quote quote){
		return this.enquiryDao.getQuotesInEnquiry(quote);
	}

	public EnquiryDao getEnquiryDao() {
		return enquiryDao;
	}

	public void setEnquiryDao(
			EnquiryDao enquiryDao) {
		this.enquiryDao = enquiryDao;
	}
	
	public void publishPriceCompare(String quoteList, Enquiry enquiry){
		String[] idArray = quoteList.split(",");
		for(int index=0; index<idArray.length; index++){
			this.enquiryDao.selectedQuoteById(idArray[index]);
		}
		enquiry.setAskPriceState(2);
		this.enquiryDao.updateEnquiryState(enquiry);
	}
}
