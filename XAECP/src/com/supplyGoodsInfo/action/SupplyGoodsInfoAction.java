package com.supplyGoodsInfo.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.model.Page;
import com.model.ProductType;
import com.model.SupplyPurchaseInformation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.supplyGoodsInfo.service.SupplyGoodsInfoService;

public class SupplyGoodsInfoAction extends ActionSupport implements
		ModelDriven<SupplyPurchaseInformation>, RequestAware , SessionAware{

	private SupplyPurchaseInformation supplyGoodsInfo = new SupplyPurchaseInformation(); // �½�һ��������Ϣ

	private Map<String, Object> request;
	private Map<String, Object> session;

	private SupplyGoodsInfoService supplyGoodsInfoService;
	
	private String supplierIdInSession = "";
	private String userName = "";
	
	private String supplyGoodsInfoList;   //for delete ɾ��id�б�
	
	private List<ProductType> productTypes;
	
	private SupplyPurchaseInformation supplyGoodsInfoForEdit;
	
	private List<SupplyPurchaseInformation> supplyGoodsInfoLinkList;
	
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;

	
	public List<SupplyPurchaseInformation> getSupplyGoodsInfoLinkList() {
		return supplyGoodsInfoLinkList;
	}

	public void setSupplyGoodsInfoLinkList(
			List<SupplyPurchaseInformation> supplyGoodsInfoLinkList) {
		this.supplyGoodsInfoLinkList = supplyGoodsInfoLinkList;
	}

	public SupplyPurchaseInformation getSupplyGoodsInfo() {
		return supplyGoodsInfo;
	}

	public void setSupplyGoodsInfo(SupplyPurchaseInformation supplyGoodsInfo) {
		this.supplyGoodsInfo = supplyGoodsInfo;
	}

	@JSON(serialize = false)
	public Map<String, Object> getRequest() {
		return request;
	}

	@JSON(serialize = false)
	public SupplyPurchaseInformation getModel() {
		// TODO Auto-generated method stub
		return supplyGoodsInfo;
	}

	public void setRequest(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		this.request = arg0;
	}

	@JSON(serialize = false)
	public SupplyGoodsInfoService getSupplyGoodsInfoService() {
		return supplyGoodsInfoService;
	}

	public void setSupplyGoodsInfoService(
			SupplyGoodsInfoService supplyGoodsInfoService) {
		this.supplyGoodsInfoService = supplyGoodsInfoService;
	}

	//��ѯ������Ϣ
	public String listSupplyGoodsInfo() {
		if(this.session.get("userName")!=null&&this.session.get("partnerId")!=null){
			userName=(String) this.session.get("userName");
			supplierIdInSession=(String) this.session.get("partnerId");
		}
		supplyGoodsInfo.setSupplierId(supplierIdInSession);
		
		Integer totalCount = this.supplyGoodsInfoService.supplyGoodsInfoTotalCount(supplyGoodsInfo);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<SupplyPurchaseInformation> list =  this.supplyGoodsInfoService.listSupplyGoodsInfo(supplyGoodsInfo, page);
		request.put("totalPage", this.totalPage);     //������ҳ����ҳ��
		request.put("currentPage", this.currentPage); //���浱ǰҳ��ҳ��
		request.put("query", list);
		return SUCCESS;
	}
	
	
	//home��ҳ��������
	public String homeListSupplyInfoMore() {
		
		Integer totalCount = this.supplyGoodsInfoService.supplyGoodsInfoAllTotalCount();
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<SupplyPurchaseInformation> list =  this.supplyGoodsInfoService.listAllSupplyGoodsInfo(page);
		request.put("totalPage", this.totalPage);     //������ҳ����ҳ��
		request.put("currentPage", this.currentPage); //���浱ǰҳ��ҳ��
		request.put("query", list);
		return SUCCESS;
	}
	
	//ɾ��������Ϣ
	public String deleteSupplyGoodsInfo() {
		this.supplyGoodsInfoService.deleteSupplyGoodsInfo(supplyGoodsInfoList);
		return SUCCESS;
	}
	
	//���ӹ�����Ϣ
	public String addSupplyGoodsInfo() {
		if(this.session.get("userName")!=null&&this.session.get("partnerId")!=null){
			userName=(String) this.session.get("userName");
			supplierIdInSession=(String) this.session.get("partnerId");
		}
		supplyGoodsInfo.setPublishType(0);
		supplyGoodsInfo.setSupplierId(supplierIdInSession);
		supplyGoodsInfo.setPublisher(userName);
		this.supplyGoodsInfoService.addSupplyGoodsInfo(supplyGoodsInfo);
		return SUCCESS;
	}
	
	
	public String selectProductType() {
		productTypes = this.supplyGoodsInfoService.selectProductType();
		return "productTypeListReturn";
		
	}
	
	public String selectSupplyGoodsInfo() {
		supplyGoodsInfoForEdit = this.supplyGoodsInfoService.getSupplyGoodsInfoById(supplyGoodsInfo.getId());
		return "supplyGoodsInfoReturn";
	}
	
	public String updateSupplyGoodsInfo() {
		if(this.session.get("userName")!=null&&this.session.get("partnerId")!=null){
			userName=(String) this.session.get("userName");
			supplierIdInSession=(String) this.session.get("partnerId");
		}
		supplyGoodsInfo.setPublisher(userName);
		supplyGoodsInfo.setPublishType(0);
		supplyGoodsInfo.setSupplierId(supplierIdInSession);
		this.supplyGoodsInfoService.updateSupplyGoodsInfo(supplyGoodsInfo);
		return SUCCESS;
	}
	
	public String listSupplyGoodsInfoInHome() {
		supplyGoodsInfoLinkList = this.supplyGoodsInfoService.listAllSupplyGoodsInfo(12, 1);
		return "supplyGoodsInfoLinkList";
	}
	
	//����ҳ�ϵ�����Ź�Ӧ�̹��� ���ӣ��������鲢������+1
	public String querySupplyGoodsInfoById() {
		this.supplyGoodsInfoService.visitNumAddOne(supplyGoodsInfo.getId());
		supplyGoodsInfo = this.supplyGoodsInfoService.getSupplyGoodsInfoById(supplyGoodsInfo.getId());
		request.put("result", supplyGoodsInfo);
		return SUCCESS;
	}
	

	@JSON(serialize = false)
	public String getSupplyGoodsInfoList() {
		return supplyGoodsInfoList;
	}

	public void setSupplyGoodsInfoList(String supplyGoodsInfoList) {
		this.supplyGoodsInfoList = supplyGoodsInfoList;
	}

	public List<ProductType> getProductTypes() {
		return productTypes;
	}

	public void setProductTypes(List<ProductType> productTypes) {
		this.productTypes = productTypes;
	}

	public SupplyPurchaseInformation getSupplyGoodsInfoForEdit() {
		return supplyGoodsInfoForEdit;
	}

	public void setSupplyGoodsInfoForEdit(
			SupplyPurchaseInformation supplyGoodsInfoForEdit) {
		this.supplyGoodsInfoForEdit = supplyGoodsInfoForEdit;
	}

	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
}
