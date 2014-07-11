package com.centralizedPurchase.dao;

import java.util.List;

import com.model.AnswerPrice;
import com.model.Enquiry;
import com.model.Page;
import com.model.SupplierProduct;

public interface QuoteManageDao {
	public List<Enquiry> listEnquirys(Enquiry eq);
	public Enquiry getEnquiryForQuoteById(String id);
	
	/**
	 * ����ĳһ��ѯ�۵���ĳһ����Ӧ�̣������Բ�ѯ�Լ��Ը�ѯ�۵��ѱ��۵Ĳ�Ʒ�б�
	 * @param ap
	 * @return
	 */
	public List<AnswerPrice> listProductQuote(AnswerPrice ap);
	
	/**
	 * ����ĳһ��ѯ�۵���ĳһ����Ӧ�̣�������������Ը�ѯ�۵��ı��۲�Ʒ
	 * @param ap
	 */
	public void addProductQuote(AnswerPrice ap);
	
	/**
	 * ����ĳһ��ѯ�۵���ĳһ����Ӧ�̣�������ɾ����Ը�ѯ�۵��ı��۲�Ʒ
	 * @param ap
	 */
	public void deleteProductQuote(String answerPriceId);
	
	/**
	 * ����ĳһ��ѯ�۵���ĳһ����Ӧ��, �����Ը�����Ը�ѯ�۵���ĳ����Ʒ��������ı��ۼ۸�
	 * @param ap
	 */
	public void updateProductQuote(AnswerPrice ap);
	
	/**
	 * ���ݱ��۵������ȡ���۵�������
	 * @param answerPriceId
	 * @return
	 */
	public AnswerPrice getProductQuoteById(String answerPriceId);
	
	/**
	 * ���ݹ�Ӧ�̴����ѯ��Ʒ���뼰����
	 * @param supplierId
	 * @return
	 */
	public List<SupplierProduct> getProductIdNameListBySupplierId(String supplierId);
	
	/**
	 * ��ʽ����
	 * @param answerPriceId
	 */
	public void formalProductQuote(String answerPriceId);
	
	public List<AnswerPrice> listProductQuoteDetailAfterFromal(AnswerPrice ap);
	
	public Integer enquiryInfoForQuoteTotalCount(Enquiry enquiry);

	public List<Enquiry> listEnquirys(Enquiry enquiry, Page page);
}
