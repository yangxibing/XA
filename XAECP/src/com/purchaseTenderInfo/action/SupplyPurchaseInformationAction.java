package com.purchaseTenderInfo.action;

import java.util.ArrayList;
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
import com.purchaseTenderInfo.service.SupplyPurchaseInformationService;

public class SupplyPurchaseInformationAction extends ActionSupport implements ModelDriven<SupplyPurchaseInformation>,RequestAware, SessionAware{

	private SupplyPurchaseInformation supplyPurchaseInformation = new SupplyPurchaseInformation();
	private Map<String, Object> request;
	private SupplyPurchaseInformationService supplyPurchaseInformationService;
	private List<ProductType> productTypes=new ArrayList<ProductType>();
	private Map<String, Object> session;
	private String  purchaserId="";
	private String userId="";
	private String userName="";
	private String idList;//ǰ̨��������purchaseTenderId��list
	private List<SupplyPurchaseInformation> ptName;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;

	
	public String listSupplyPurchaseInformation(){
		if(this.session.get("userName")!=null&&this.session.get("partnerId")!=null){
			userName=(String) this.session.get("userName");
			purchaserId=(String) this.session.get("partnerId");
		}
		supplyPurchaseInformation.setSupplierId(purchaserId);
		
		Integer totalCount = this.supplyPurchaseInformationService.purchaseTenderInfoTotalCount(supplyPurchaseInformation);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<SupplyPurchaseInformation> list = this.supplyPurchaseInformationService.listSupplyPurchaseInformation(supplyPurchaseInformation, page);
		request.put("totalPage", this.totalPage);     //������ҳ����ҳ��
		request.put("currentPage", this.currentPage); //���浱ǰҳ��ҳ��
		request.put("supplyPurchaseInformations", list);
		return SUCCESS;
	}
	
	
	public String homeListAllCaigouInfo() {
		Integer totalCount = this.supplyPurchaseInformationService.homeAllCaigouInfoTotalCount();
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<SupplyPurchaseInformation> list = this.supplyPurchaseInformationService.homeListAllCaigouInfo(page);
		request.put("totalPage", this.totalPage);     //������ҳ����ҳ��
		request.put("currentPage", this.currentPage); //���浱ǰҳ��ҳ��
		
		request.put("query", list);
		return SUCCESS;
	} 
	
	//ѡ�����еĲ�Ʒ����
	public String selectProductType(){
		
		productTypes=this.supplyPurchaseInformationService.selectProductType();
		return "productTypesReturn";
	}
	//����һ���½��Ĳɹ����б���Ϣ
	public String savePurchaseTender(){
		if(this.session.get("userName")!=null&&this.session.get("partnerId")!=null){
			userName=(String) this.session.get("userName");
			purchaserId=(String) this.session.get("partnerId");
		}
		supplyPurchaseInformation.setPublisher(userName);
		supplyPurchaseInformation.setSupplierId(purchaserId);
		if(supplyPurchaseInformation.getProductTypeId()==null||supplyPurchaseInformation.getProductTypeId().length()==0){
			supplyPurchaseInformation.setProductTypeId("000000");//��ֵΪ�����
		}
		this.supplyPurchaseInformationService.savePurchaseTender(supplyPurchaseInformation);
		return SUCCESS;
	}
	//�༭��ť�����±�
	public String updatePurchaseTender(){
		this.supplyPurchaseInformationService.updatePurchaseTender(supplyPurchaseInformation);
		return SUCCESS;
	}

	//ɾ��purchaseTenderInfoͨ��id
	public String deletePurchaseTenderInfo(){
		this.supplyPurchaseInformationService.deletePurchaseTenderInfo(idList);
		return SUCCESS;
	}
	
	//�г������еĲɹ�/�б���Ϣ
	public String listAllSupplyPurchaseInformation(){
		
		ptName=this.supplyPurchaseInformationService.listAllSupplyPurchaseInformation(12, 1);
		return "ptName";
	}
	
	//չʾ�ɹ�/�б���Ϣ������Ϣ�����ҷ�������+1
	public String queryPTbyid(){
		
		this.supplyPurchaseInformationService.visitNumAddOne(supplyPurchaseInformation.getId());
		if(this.supplyPurchaseInformationService.listSupplyPurchaseInformation(supplyPurchaseInformation)!=null){
			supplyPurchaseInformation =this.supplyPurchaseInformationService.listSupplyPurchaseInformation(supplyPurchaseInformation).get(0);
		}
		return SUCCESS;
	}
	
	@JSON(serialize = false)
	public SupplyPurchaseInformation getModel() {

		return this.supplyPurchaseInformation;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}
	@JSON(serialize = false)
	public SupplyPurchaseInformation getSupplyPurchaseInformation() {
		return supplyPurchaseInformation;
	}

	public void setSupplyPurchaseInformation(
			SupplyPurchaseInformation supplyPurchaseInformation) {
		this.supplyPurchaseInformation = supplyPurchaseInformation;
	}
	@JSON(serialize = false)
	public SupplyPurchaseInformationService getSupplyPurchaseInformationService() {
		return supplyPurchaseInformationService;
	}

	public void setSupplyPurchaseInformationService(
			SupplyPurchaseInformationService supplyPurchaseInformationService) {
		this.supplyPurchaseInformationService = supplyPurchaseInformationService;
	}
	public List<ProductType> getProductTypes() {
		return productTypes;
	}
	public void setProductTypes(List<ProductType> productTypes) {
		this.productTypes = productTypes;
	}
	public String getIdList() {
		return idList;
	}
	public void setIdList(String idList) {
		this.idList = idList;
	}
	public List<SupplyPurchaseInformation> getPtName() {
		return ptName;
	}
	public void setPtName(List<SupplyPurchaseInformation> ptName) {
		this.ptName = ptName;
	}
	
	@JSON(serialize = false)

	public Map<String, Object> getRequest() {
		return request;
	}
	public void setSession(Map<String, Object> session) {
		
		this.session = session;
	}
	@JSON(serialize = false)
	public Map<String, Object> getSession() {
		return session;
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
