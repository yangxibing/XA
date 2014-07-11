package com.centralizedPurchase.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.AnswerPrice;
import com.model.Enquiry;
import com.model.Page;
import com.model.SupplierProduct;

public class QuoteManageDaoImpl extends SqlMapClientDaoSupport implements QuoteManageDao {

	public List<Enquiry> listEnquirys(Enquiry eq) {
		System.out.println("���۹�����ѯѯ�۵���ʼ  ѯ�۵�����="+eq.getAskPriceId()+" ��Ʒ����id="+eq.getProductTypeId());
		List<Enquiry> list = this.getSqlMapClientTemplate().queryForList("productQuoteManage.listEnquiryForQuote", eq);
		System.out.println("���۹�����ѯѯ�۵����� list.size="+list.size());
		return list;
	}

	public Enquiry getEnquiryForQuoteById(String id) {
		System.out.println("���۹�����ȡѯ�۵����� ѯ�۵�����=" + id);
		return (Enquiry)this.getSqlMapClientTemplate().queryForObject("productQuoteManage.getEnquiryForQuoteById", id);
	}

	public void addProductQuote(AnswerPrice ap) {
		System.out.println("���ۣ��������ĳһѯ�۵��Ĳ�Ʒ����=" + ap.getAnswerPriceId());
		this.getSqlMapClientTemplate().insert("productQuoteManage.addProductQuote", ap);
		
	}

	public void deleteProductQuote(String  answerPriceId) {
		System.out.println("���ۣ�ɾ�����ĳһѯ�۵��Ĳ�Ʒ����=" + answerPriceId);
		this.getSqlMapClientTemplate().delete("productQuoteManage.deleteProductQuote", answerPriceId);
	}

	public AnswerPrice getProductQuoteById(String answerPriceId) {
		System.out.println("���ۣ����ݱ��۵������ȡ��Ʒ������Ϣ id=" + answerPriceId);
		return (AnswerPrice)this.getSqlMapClientTemplate().queryForObject("productQuoteManage.getProductQuoteById", answerPriceId);
	}

	public List<AnswerPrice> listProductQuote(AnswerPrice ap) {
		System.out.println("���ۣ���ȡ���ĳһѯ�۵��ù�Ӧ�̵Ĳ�Ʒ�����б�  ѯ�۵�����="+ap.getAskPriceId() + "��Ӧ�̴���="+ap.getSupplierId());
		List<AnswerPrice> list = (List<AnswerPrice>) this.getSqlMapClientTemplate().queryForList("productQuoteManage.listProductQuote", ap);
		return list;
	}
	
	public List<AnswerPrice> listProductQuoteDetailAfterFromal(AnswerPrice ap) {
		System.out.println("���ۣ���ȡ���ĳһѯ�۵��ù�Ӧ�̵Ĳ�Ʒ�����б�  ѯ�۵�����="+ap.getAskPriceId() + "��Ӧ�̴���="+ap.getSupplierId());
		List<AnswerPrice> list = (List<AnswerPrice>) this.getSqlMapClientTemplate().queryForList("productQuoteManage.listProductQuoteDetailAfterFromal", ap);
		return list;
	}

	public void updateProductQuote(AnswerPrice ap) {
		System.out.println("���ۣ��������ĳһѯ�۵��Ĳ�Ʒ����id=" + ap.getAnswerPriceId());
		this.getSqlMapClientTemplate().update("productQuoteManage.updateProductQuote", ap);
		
	}

	public List<SupplierProduct> getProductIdNameListBySupplierId(
			String supplierId) {
		System.out.println("���ۣ���ȡ��Ʒ�����б����ƣ����ݹ�Ӧ�̴����ѯ��Ʒ���뼰����supplierId="+supplierId);
		List<SupplierProduct> list = (List<SupplierProduct>)this.getSqlMapClientTemplate().queryForList("productQuoteManage.getProductIdNameListBySupplierId", supplierId);
		return list;
	}

	public void formalProductQuote(String answerPriceId) {
		System.out.println("���ۡ�����ʽ���۱��۵�id="+answerPriceId);
		this.getSqlMapClientTemplate().update("productQuoteManage.formalProductQuote", answerPriceId);
	}

	public Integer enquiryInfoForQuoteTotalCount(Enquiry enquiry) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("productQuoteManage.enquiryInfoForQuoteTotalCount", enquiry);
	}

	public List<Enquiry> listEnquirys(Enquiry enquiry, Page page) {
		List<Enquiry> list = this.getSqlMapClientTemplate().queryForList("productQuoteManage.listEnquiryForQuote", enquiry, page.getStart(), page.getRowCount());
		System.out.println("���۹�����ѯѯ�۵����� list.size="+list.size());
		return list;
	}
	
	
}
