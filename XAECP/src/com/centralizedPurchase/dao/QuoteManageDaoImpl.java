package com.centralizedPurchase.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.model.AnswerPrice;
import com.model.Enquiry;
import com.model.Page;
import com.model.SupplierProduct;

public class QuoteManageDaoImpl extends SqlMapClientDaoSupport implements QuoteManageDao {

	public List<Enquiry> listEnquirys(Enquiry eq) {
		System.out.println("报价管理－查询询价单开始  询价单代码="+eq.getAskPriceId()+" 产品类型id="+eq.getProductTypeId());
		List<Enquiry> list = this.getSqlMapClientTemplate().queryForList("productQuoteManage.listEnquiryForQuote", eq);
		System.out.println("报价管理－查询询价单结束 list.size="+list.size());
		return list;
	}

	public Enquiry getEnquiryForQuoteById(String id) {
		System.out.println("报价管理－获取询价单详情 询价单代码=" + id);
		return (Enquiry)this.getSqlMapClientTemplate().queryForObject("productQuoteManage.getEnquiryForQuoteById", id);
	}

	public void addProductQuote(AnswerPrice ap) {
		System.out.println("报价－增加针对某一询价单的产品报价=" + ap.getAnswerPriceId());
		this.getSqlMapClientTemplate().insert("productQuoteManage.addProductQuote", ap);
		
	}

	public void deleteProductQuote(String  answerPriceId) {
		System.out.println("报价－删除针对某一询价单的产品报价=" + answerPriceId);
		this.getSqlMapClientTemplate().delete("productQuoteManage.deleteProductQuote", answerPriceId);
	}

	public AnswerPrice getProductQuoteById(String answerPriceId) {
		System.out.println("报价－根据报价单代码获取产品报价信息 id=" + answerPriceId);
		return (AnswerPrice)this.getSqlMapClientTemplate().queryForObject("productQuoteManage.getProductQuoteById", answerPriceId);
	}

	public List<AnswerPrice> listProductQuote(AnswerPrice ap) {
		System.out.println("报价－获取针对某一询价单该供应商的产品报价列表  询价单代码="+ap.getAskPriceId() + "供应商代码="+ap.getSupplierId());
		List<AnswerPrice> list = (List<AnswerPrice>) this.getSqlMapClientTemplate().queryForList("productQuoteManage.listProductQuote", ap);
		return list;
	}
	
	public List<AnswerPrice> listProductQuoteDetailAfterFromal(AnswerPrice ap) {
		System.out.println("报价－获取针对某一询价单该供应商的产品报价列表  询价单代码="+ap.getAskPriceId() + "供应商代码="+ap.getSupplierId());
		List<AnswerPrice> list = (List<AnswerPrice>) this.getSqlMapClientTemplate().queryForList("productQuoteManage.listProductQuoteDetailAfterFromal", ap);
		return list;
	}

	public void updateProductQuote(AnswerPrice ap) {
		System.out.println("报价－更新针对某一询价单的产品报价id=" + ap.getAnswerPriceId());
		this.getSqlMapClientTemplate().update("productQuoteManage.updateProductQuote", ap);
		
	}

	public List<SupplierProduct> getProductIdNameListBySupplierId(
			String supplierId) {
		System.out.println("报价－获取产品下拉列表及名称－根据供应商代码查询产品代码及名称supplierId="+supplierId);
		List<SupplierProduct> list = (List<SupplierProduct>)this.getSqlMapClientTemplate().queryForList("productQuoteManage.getProductIdNameListBySupplierId", supplierId);
		return list;
	}

	public void formalProductQuote(String answerPriceId) {
		System.out.println("报价——正式报价报价单id="+answerPriceId);
		this.getSqlMapClientTemplate().update("productQuoteManage.formalProductQuote", answerPriceId);
	}

	public Integer enquiryInfoForQuoteTotalCount(Enquiry enquiry) {
		return (Integer)this.getSqlMapClientTemplate().queryForObject("productQuoteManage.enquiryInfoForQuoteTotalCount", enquiry);
	}

	public List<Enquiry> listEnquirys(Enquiry enquiry, Page page) {
		List<Enquiry> list = this.getSqlMapClientTemplate().queryForList("productQuoteManage.listEnquiryForQuote", enquiry, page.getStart(), page.getRowCount());
		System.out.println("报价管理－查询询价单结束 list.size="+list.size());
		return list;
	}
	
	
}
