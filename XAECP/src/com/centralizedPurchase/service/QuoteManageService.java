package com.centralizedPurchase.service;

import java.util.List;

import com.model.AnswerPrice;
import com.model.Enquiry;
import com.model.Page;
import com.model.SupplierProduct;


public interface QuoteManageService {
	
	/**
	 * ������ϲ�ѯ������ѯѯ�۵��б�
	 * @param su
	 * @return
	 */
	public List<Enquiry> listEnquirys(Enquiry eq);
	
	/**
	 * ����ѯ�۵�id��ѯѯ�۵�����
	 * @param id
	 * @return
	 */
	public Enquiry getEnquiryForQuoteById(String id);
	
	/**
	 * ����ĳһ��ѯ�۵���ĳһ����Ӧ�̣������Բ�ѯ�Լ��Ը�ѯ�۵�(δ��ʽ����)�Ĳ�Ʒ�б�
	 * @param ap
	 * @return
	 */
	public List<AnswerPrice> listProductQuote(AnswerPrice ap);
	
	/**
	 * ��Ӧ����ʽ���ۺ���ʾ�������飬(�ѱ��۵Ĳ�Ʒ�б�)
	 * @param ap
	 * @return
	 */
	public List<AnswerPrice> listProductQuoteDetailAfterFromal(AnswerPrice ap);
	
	
	/**
	 * ����ĳһ��ѯ�۵���ĳһ����Ӧ�̣�������������Ը�ѯ�۵��ı��۲�Ʒ
	 * @param ap
	 */
	public void addProductQuote(AnswerPrice ap);
	
	/**
	 * ����ĳһ��ѯ�۵���ĳһ����Ӧ�̣�������ɾ����Ը�ѯ�۵��ı��۲�Ʒ
	 * @param ap
	 */
	public void deleteProductQuote(String answerPriceIdList);
	
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
	 * ��ȡ��Ʒ����������б�
	 * @param supplierId
	 * @return
	 */
	public List<SupplierProduct> getProductIdNameListBySupplierId(String supplierId);
	
	/**
	 * ��ʽ����
	 * @param answerPriceIdList
	 */
	public void formalProductQuote(String answerPriceIdList);

	public Integer enquiryInfoForQuoteTotalCount(Enquiry enquiry);

	public List<Enquiry> listEnquirys(Enquiry enquiry, Page page);
}
