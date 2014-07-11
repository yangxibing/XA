package com.centralizedPurchase.service;

import java.util.List;

import com.centralizedPurchase.dao.QuoteManageDao;
import com.model.AnswerPrice;
import com.model.Enquiry;
import com.model.Page;
import com.model.SupplierProduct;

public class QuoteManageServiceImpl implements QuoteManageService {
	private QuoteManageDao quoteManageDao;
	public List<Enquiry> listEnquirys(Enquiry eq) {
		List<Enquiry> list = quoteManageDao.listEnquirys(eq);
		for(Enquiry item: list) {	
			item.setDeadline(item.getDeadline().split(" ")[0]);
			switch(item.getAskPriceState()) {
			case 0:
				item.setAskPriceStateStr("未发布");
				break;
			case 1:
				item.setAskPriceStateStr("已发布");
				break;
			case 2:
				item.setAskPriceStateStr("询比价完成");
				break;
			default:
				item.setAskPriceStateStr("未发布");
			}
		}
		return list;
	}
	
	public Enquiry getEnquiryForQuoteById(String id) {
		Enquiry en = quoteManageDao.getEnquiryForQuoteById(id);
		switch(en.getAskPriceState()) {
		case 0:
			en.setAskPriceStateStr("未发布");
			break;
		case 1:
			en.setAskPriceStateStr("已发布");
			break;
		case 2:
			en.setAskPriceStateStr("询比价完成");
			break;
		default:
			en.setAskPriceStateStr("未发布");
		}
		return en;
	}	
	
	public QuoteManageDao getQuoteManageDao() {
		return quoteManageDao;
	}
	public void setQuoteManageDao(QuoteManageDao quoteManageDao) {
		this.quoteManageDao = quoteManageDao;
	}

	public void addProductQuote(AnswerPrice ap) {
		this.quoteManageDao.addProductQuote(ap);	
	}

	public void deleteProductQuote(String answerPriceIdList) {
		String[] idArray = answerPriceIdList.split(",");
		for(int i = 0; i < idArray.length; i++) {
			this.quoteManageDao.deleteProductQuote(idArray[i]);
		}
	}

	public AnswerPrice getProductQuoteById(String answerPriceId) {
		return this.quoteManageDao.getProductQuoteById(answerPriceId);
	}

	public List<AnswerPrice> listProductQuote(AnswerPrice ap) {
		return this.quoteManageDao.listProductQuote(ap);
	}

	public void updateProductQuote(AnswerPrice ap) {
		this.quoteManageDao.updateProductQuote(ap);
	}

	public List<SupplierProduct> getProductIdNameListBySupplierId(
			String supplierId) {
		return this.quoteManageDao.getProductIdNameListBySupplierId(supplierId);
	}

	public void formalProductQuote(String answerPriceIdList) {
		String[] idArray = answerPriceIdList.split(",");
		for(int i = 0; i < idArray.length; i++) {
			this.quoteManageDao.formalProductQuote(idArray[i]);
		}
	}

	public List<AnswerPrice> listProductQuoteDetailAfterFromal(AnswerPrice ap) {
		return this.quoteManageDao.listProductQuoteDetailAfterFromal(ap);
	}

	public Integer enquiryInfoForQuoteTotalCount(Enquiry enquiry) {
		return this.quoteManageDao.enquiryInfoForQuoteTotalCount(enquiry);
	}

	public List<Enquiry> listEnquirys(Enquiry enquiry, Page page) {
		List<Enquiry> list = quoteManageDao.listEnquirys(enquiry, page);
		for(Enquiry item: list) {	
			item.setDeadline(item.getDeadline().split(" ")[0]);
			switch(item.getAskPriceState()) {
			case 0:
				item.setAskPriceStateStr("未发布");
				break;
			case 1:
				item.setAskPriceStateStr("已发布");
				break;
			case 2:
				item.setAskPriceStateStr("询比价完成");
				break;
			default:
				item.setAskPriceStateStr("未发布");
			}
		}
		return list;
	}
	
}
