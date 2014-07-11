package com.centralizedPurchase.service;

import java.util.List;

import com.model.AnswerPrice;
import com.model.Enquiry;
import com.model.Page;
import com.model.SupplierProduct;


public interface QuoteManageService {
	
	/**
	 * 根据组合查询条件查询询价单列表
	 * @param su
	 * @return
	 */
	public List<Enquiry> listEnquirys(Enquiry eq);
	
	/**
	 * 根据询价单id查询询价单详情
	 * @param id
	 * @return
	 */
	public Enquiry getEnquiryForQuoteById(String id);
	
	/**
	 * 对于某一个询价单的某一个供应商，他可以查询自己对该询价单(未正式报价)的产品列表
	 * @param ap
	 * @return
	 */
	public List<AnswerPrice> listProductQuote(AnswerPrice ap);
	
	/**
	 * 供应商正式报价后，显示报价详情，(已报价的产品列表)
	 * @param ap
	 * @return
	 */
	public List<AnswerPrice> listProductQuoteDetailAfterFromal(AnswerPrice ap);
	
	
	/**
	 * 对于某一个询价单的某一个供应商，他可以增加针对该询价单的报价产品
	 * @param ap
	 */
	public void addProductQuote(AnswerPrice ap);
	
	/**
	 * 对于某一个询价单的某一个供应商，他可以删除针对该询价单的报价产品
	 * @param ap
	 */
	public void deleteProductQuote(String answerPriceIdList);
	
	/**
	 * 对于某一个询价单的某一个供应商, 他可以更新针对该询价单的某个产品，例如更改报价价格
	 * @param ap
	 */
	public void updateProductQuote(AnswerPrice ap);
	
	/**
	 * 根据报价单代码获取报价单的详情
	 * @param answerPriceId
	 * @return
	 */
	public AnswerPrice getProductQuoteById(String answerPriceId);
	
	/**
	 * 获取产品代码和名字列表
	 * @param supplierId
	 * @return
	 */
	public List<SupplierProduct> getProductIdNameListBySupplierId(String supplierId);
	
	/**
	 * 正式报价
	 * @param answerPriceIdList
	 */
	public void formalProductQuote(String answerPriceIdList);

	public Integer enquiryInfoForQuoteTotalCount(Enquiry enquiry);

	public List<Enquiry> listEnquirys(Enquiry enquiry, Page page);
}
