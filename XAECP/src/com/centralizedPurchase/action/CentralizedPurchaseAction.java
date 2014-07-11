package com.centralizedPurchase.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.basicData.service.PurchaserService;
import com.centralizedPurchase.service.CentralizedPurchaseService;
import com.mail.SendMail;
import com.model.CentralizedPlanedPurchase;
import com.model.CentralizedPurchaseDemand;
import com.model.CentralizedPurchaseSupplyPrice;
import com.model.Page;
import com.model.ProductType;
import com.model.PurchaseOrder;
import com.model.Supplier;
import com.model.SupplierProduct;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class CentralizedPurchaseAction extends ActionSupport implements ModelDriven<CentralizedPlanedPurchase>,RequestAware,SessionAware{

	private Map<String,Object> request;
	private Map<String,Object> session;
	private CentralizedPurchaseService centralizedPurchaseService;
	private CentralizedPlanedPurchase centralizedPurchase = new CentralizedPlanedPurchase();
	private String deleteList;
	private String priceList;
	private PurchaserService purchaserService;
	private String parentProductTypeId;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	//json�첽���ؽ��
	private String queryList;
	private CentralizedPlanedPurchase purchaseAjax;
	private List<CentralizedPlanedPurchase> purchaseListAjax;
	private ProductType treeRootAjax;
	private List<ProductType> treeBranchAjax;
	private String CPDemandApplyState;
	
	//in session
	private String userIdInSession;
	private String partnerIdInSession;

	public String homeCentralizedPurchaseList(){
		this.centralizedPurchase.setCentralizedPurchaseState(new Short("1"));
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		String time = format.format(now);
		try {
			this.centralizedPurchase.setDeadlineDate(format.parse(time));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		purchaseListAjax = this.centralizedPurchaseService.getCentralizedPurchaseList(this.centralizedPurchase);
		return "list";
	}
	
	/**
	 * ��ȡ���вɹ���Ϣ���⡢��Ʒ���ͣ�������伯�вɹ���Ϣ�����������ѯ����Ӧ����
	 * 
	 * @return
	 */
	public String queryConditionQueryList(){
		queryList = "";
		queryList += this.centralizedPurchaseService.getCentralizedPurchaseTitleList() + ";";
		queryList += this.centralizedPurchaseService.getProductTypeList();
		return "queryList";
	}
	
	/**
	 * ��ȡ��ʼʱ��������Ʒ���������б�:������һ��
	 */
	public String queryProductTypeTreeRoot(){
		treeRootAjax = this.centralizedPurchaseService.getProductTypeTreeList();
		return "treeRoot";
	}
	
	/**
	 * ��ȡĳһ��Ʒ���͵�����ֱ��������
	 */
	public String queryProductTypeTreeBranch(){
		this.treeBranchAjax = this.centralizedPurchaseService.getProductTypeTreeBranch(this.parentProductTypeId);
		return "treeBranch";
	}
	
	/**
	 * ��ȡ���вɹ���Ϣ�б�
	 */
	public String queryCentralizedPurchaseList(){
		Integer totalCount = this.centralizedPurchaseService.centralizedPurchaseTotalCount(centralizedPurchase);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<CentralizedPlanedPurchase> list = this.centralizedPurchaseService.getCentralizedPurchaseList(this.centralizedPurchase, page);
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);
		this.request.put("query", list);
		this.request.put("centralizedPurchase", centralizedPurchase);
		return SUCCESS;
	}
	
	public String homeCentralizedPurchaseMore(){
		this.centralizedPurchase.setCentralizedPurchaseState(new Short("1"));
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		String time = format.format(now);
		try {
			this.centralizedPurchase.setDeadlineDate(format.parse(time));
		} catch (ParseException e) {
			e.printStackTrace();
		}		
		
		Integer totalCount = this.centralizedPurchaseService.centralizedPurchaseTotalCount(centralizedPurchase);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<CentralizedPlanedPurchase> list = this.centralizedPurchaseService.getCentralizedPurchaseList(this.centralizedPurchase, page);
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);
		this.request.put("query", list);
		this.request.put("centralizedPurchase", centralizedPurchase);
		return SUCCESS;		
	}	
	
	/**
	 * ɾ��ѡ�еļ��вɹ���Ϣ
	 * @return
	 */
	public String deleteCentralizedPurchase(){
		this.centralizedPurchaseService.deleteCentralizedPurchase(deleteList);
		return SUCCESS;
	}
	
	/**
	 * ���ݼ��вɹ���Ϣ�����ȡ��Ӧ�Ķ���
	 * @return "purchase"
	 */
	public String queryCentralizedPurchaseById(){
		this.purchaseAjax = this.centralizedPurchaseService.getCentralizedPurchaseById(this.centralizedPurchase.getCpPurchaseInfoId());
		return "purchaseAjax";
	}
	
	/**
	 * ���Ӽ��з�����Ϣ
	 * @return SUCCESS
	 */
	public String addCentralizedPurchase(){
		if(this.centralizedPurchase.getCentralizedPurchaseState() == 1){
			this.userIdInSession = (String) this.session.get("userId");
			this.centralizedPurchase.setPublisher(this.userIdInSession);
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			String time = format.format(now); 
			this.centralizedPurchase.setPublishDate(time);	
			
			//���ɹ��̷��ʼ�
			Supplier su = new Supplier();
			su.setPartnerType(1);
			List<Supplier> suppliers = this.purchaserService.listPurchaser(su);
			for(int i=0;i<suppliers.size();i++){
				SendMail sendMail = new SendMail();
				sendMail.setSendToAddress(suppliers.get(i).getEmail());
				sendMail.setMailTitle("�𾴵Ĳɹ������ã��µļ��вɹ��ѷ���");
				sendMail.setMailMsg("   ���⣺"+this.centralizedPurchase.getCpPurchaseInfoTitle()
									+"   ��Ʒ���ͣ� "+this.centralizedPurchase.getProductTypeName()
									+"   �۸����䣺 "+this.centralizedPurchase.getPurchasePriceBegin()+"-"+this.centralizedPurchase.getPurchasePriceEnd()+this.centralizedPurchase.getPurchasePriceUnit()
									+"   ������λ�� "+this.centralizedPurchase.getMeasureUnit()
									+"   ��ֹ���ڣ� "+this.centralizedPurchase.getDeadline()
									+"   ��Ҫ���ݣ� "+this.centralizedPurchase.getBriefExplain());
				sendMail.send();
			}
		}
		
		this.centralizedPurchaseService.addCentralizedPurchase(this.centralizedPurchase);
		
		return SUCCESS;
	}
	
	/**
	 * ���¼��вɹ���Ϣ
	 * @return SUCCESS
	 */
	public String updateCentralizedPurchase(){
		if(this.centralizedPurchase.getCentralizedPurchaseState() == 1){
			this.userIdInSession = (String) this.session.get("userId");
			this.centralizedPurchase.setPublisher(this.userIdInSession);
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			String time = format.format(now); 
			this.centralizedPurchase.setPublishDate(time);			
		}
		
		this.centralizedPurchaseService.updateCentralizedPurchase(this.centralizedPurchase);
		return SUCCESS;		
	}
	
	/**
	 * �ϲ�����ȷ��ҳ�棬��ȡ���вɹ���Ϣ��Ӧ��������Ϣ
	 * @return SUCCESS
	 */
	public String combineDemandConfirm(){
		CentralizedPurchaseDemand demand = new CentralizedPurchaseDemand();
		demand.setCPIId(this.centralizedPurchase.getCpPurchaseInfoId());
		List<CentralizedPurchaseDemand> list = this.centralizedPurchaseService.getCentralizedPurchaseDemandList(demand); 
		this.request.put("query", list);
		return SUCCESS;
	}
	
	/**
	 * ����ϲ�ȷ�Ϻ󣬸������ݿ⣺���вɹ�״̬������״̬�����������ϲ�д��
	 * @return SUCCESS
	 */
	public String combineDemandUpdate(){
		CentralizedPurchaseDemand demand = new CentralizedPurchaseDemand();
		demand.setDemandState(new Short("1"));
		demand.setOriginalState(new Short("0"));
		demand.setCPIId(this.centralizedPurchase.getCpPurchaseInfoId());
		this.centralizedPurchaseService.updateCentralizedPurchaseDemandState(demand);
		this.centralizedPurchase.setCentralizedPurchaseState(new Short("2"));
		this.centralizedPurchaseService.updateCentralizedPurchaseCombineNumber(this.centralizedPurchase);
		this.centralizedPurchaseService.updateCentralizedPurchaseState(this.centralizedPurchase);
		return SUCCESS;
	}
	
	/**
	 * ����id��ȡ���вɹ���Ϣ
	 * @return
	 */
	public String queryCentralizedPurchaseInfo(){
		this.centralizedPurchase = this.centralizedPurchaseService.getCentralizedPurchaseById(this.centralizedPurchase.getCpPurchaseInfoId());
		this.request.put("centralizedPurchase", this.centralizedPurchase);
		return SUCCESS;
	}
	
	/**
	 * �鿴���вɹ�������Ϣ
	 * @return
	 */
	public String browseDemandInfo(){
		CentralizedPurchaseDemand demand = new CentralizedPurchaseDemand();
		demand.setCPIId(this.centralizedPurchase.getCpPurchaseInfoId());
		List<CentralizedPurchaseDemand> list = this.centralizedPurchaseService.getCentralizedPurchaseDemandList(demand);
		this.request.put("query", list);
		return SUCCESS;
	}
	
	/**
	 * ���вɹ�����ҳ��
	 * @return
	 */
	public String centralizedPurchaseApply(){
		this.centralizedPurchase = this.centralizedPurchaseService.getCentralizedPurchaseById(this.centralizedPurchase.getCpPurchaseInfoId());
		this.request.put("centralizedPurchase", this.centralizedPurchase);		
		return SUCCESS;
	}
	
	/**
	 * ��ȡ�ύ���вɹ�ҳ��������Ϣ
	 * @return
	 */
	public String centralizedPurchaseCommit(){
		this.centralizedPurchase = this.centralizedPurchaseService.getCentralizedPurchaseById(this.centralizedPurchase.getCpPurchaseInfoId());
		this.request.put("centralizedPurchase", this.centralizedPurchase);				
		return SUCCESS;
	}
	
	/**
	 * ���вɹ���������ȷ��֮�󣬸������ݿ�
	 * @return
	 */
	public String centralizedPurchaseCommitUpdate(){
		CentralizedPurchaseDemand demand = new CentralizedPurchaseDemand();
		demand.setCPIId(this.centralizedPurchase.getCpPurchaseInfoId());
		this.partnerIdInSession = (String) this.session.get("partnerId");
		demand.setPurchaserId(this.partnerIdInSession);		
		
		if(this.centralizedPurchaseService.countCentralizedPurchaseDemand(demand) >= 1){
			this.CPDemandApplyState = "CONFLICT";
		} else {
			demand.setDemandNumber(this.centralizedPurchase.getDemandNumber());
			demand.setDemandState(new Short("0"));
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			String time = format.format(now);
			demand.setReportDemandTime(time);
			this.centralizedPurchaseService.addCentralizedPurchaseDemand(demand);
			this.CPDemandApplyState = "SUCCESS";			
		}
		return "message";
	}
	
	public String publishPrcie(){
		this.centralizedPurchase = this.centralizedPurchaseService.getCentralizedPurchaseById(this.centralizedPurchase.getCpPurchaseInfoId());
		List<SupplierProduct> list = this.centralizedPurchaseService.getProductListByType(this.centralizedPurchase.getProductTypeId());
		this.request.put("query", list);
		this.request.put("centralizedPurchase", centralizedPurchase);
		
		return SUCCESS;
	}
	
	/**
	 * �����۸��ύ���ݿ⣬����״̬
	 * @return
	 */
	public String publishPriceCommit(){
		this.centralizedPurchaseService.publishPriceCommit(this.centralizedPurchase.getCpPurchaseInfoId(), priceList);
		CentralizedPurchaseDemand demand = new CentralizedPurchaseDemand();
		demand.setCPIId(this.centralizedPurchase.getCpPurchaseInfoId());
		this.partnerIdInSession = (String) this.session.get("partnerId");
		demand.setPurchaserId(this.partnerIdInSession);
		demand.setDemandState(new Short("2"));
		demand.setOriginalState(new Short("1"));
		this.centralizedPurchaseService.updateCentralizedPurchaseDemandState(demand);
		centralizedPurchase.setCentralizedPurchaseState(new Short("3"));
		this.centralizedPurchaseService.updateCentralizedPurchaseState(centralizedPurchase);
		return SUCCESS;
	}
	
	public String browsePriceInfo(){
		List<CentralizedPurchaseSupplyPrice> list = this.centralizedPurchaseService.getCentralizedPurchaseSupplyPriceList(this.centralizedPurchase.getCpPurchaseInfoId());
		this.request.put("query", list);
		return SUCCESS;
	}
	
	/**
	 * �鿴���вɹ�������Ϣ
	 */
	public String browseDemandOrderInfo(){
		PurchaseOrder order = new PurchaseOrder();
		order.setCPIId(this.centralizedPurchase.getCpPurchaseInfoId());
		List<PurchaseOrder> list = this.centralizedPurchaseService.queryPurchaseOrderList(order);
		this.request.put("query", list);
		
		return SUCCESS;
	}
	
	@JSON(serialize=false)
	public CentralizedPlanedPurchase getModel() {
		return this.centralizedPurchase;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}

	@JSON(serialize=false)
	public CentralizedPurchaseService getCentralizedPurchaseService() {
		return centralizedPurchaseService;
	}

	public void setCentralizedPurchaseService(
			CentralizedPurchaseService centralizedPurchaseService) {
		this.centralizedPurchaseService = centralizedPurchaseService;
	}

	@JSON(serialize=false)
	public CentralizedPlanedPurchase getCentralizedPurchase() {
		return centralizedPurchase;
	}

	public void setCentralizedPurchase(
			CentralizedPlanedPurchase centralizedPurchase) {
		this.centralizedPurchase = centralizedPurchase;
	}

	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}

	public String getQueryList() {
		return queryList;
	}

	public void setQueryList(String queryList) {
		this.queryList = queryList;
	}

	@JSON(serialize=false)
	public String getDeleteList() {
		return deleteList;
	}

	public void setDeleteList(String deleteList) {
		this.deleteList = deleteList;
	}

	public CentralizedPlanedPurchase getPurchaseAjax() {
		return purchaseAjax;
	}

	public void setPurchaseAjax(CentralizedPlanedPurchase purchaseAjax) {
		this.purchaseAjax = purchaseAjax;
	}

	public String getUserIdInSession() {
		return userIdInSession;
	}

	public void setUserIdInSession(String userIdInSession) {
		this.userIdInSession = userIdInSession;
	}

	public List<CentralizedPlanedPurchase> getPurchaseListAjax() {
		return purchaseListAjax;
	}

	public void setPurchaseListAjax(List<CentralizedPlanedPurchase> purchaseListAjax) {
		this.purchaseListAjax = purchaseListAjax;
	}

	public String getPartnerIdInSession() {
		return partnerIdInSession;
	}

	public void setPartnerIdInSession(String partnerIdInSession) {
		this.partnerIdInSession = partnerIdInSession;
	}

	public String getPriceList() {
		return priceList;
	}

	public void setPriceList(String priceList) {
		this.priceList = priceList;
	}

	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	@JSON(serialize=false)
	public Map<String, Object> getSession() {
		return session;
	}
	@JSON(serialize=false)
	public PurchaserService getPurchaserService() {
		return purchaserService;
	}

	public void setPurchaserService(PurchaserService purchaserService) {
		this.purchaserService = purchaserService;
	}

	public ProductType getTreeRootAjax() {
		return treeRootAjax;
	}

	public void setTreeRootAjax(ProductType treeRootAjax) {
		this.treeRootAjax = treeRootAjax;
	}

	public List<ProductType> getTreeBranchAjax() {
		return treeBranchAjax;
	}

	public void setTreeBranchAjax(List<ProductType> treeBranchAjax) {
		this.treeBranchAjax = treeBranchAjax;
	}

	public String getParentProductTypeId() {
		return parentProductTypeId;
	}

	public void setParentProductTypeId(String parentProductTypeId) {
		this.parentProductTypeId = parentProductTypeId;
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

	public String getCPDemandApplyState() {
		return CPDemandApplyState;
	}

	public void setCPDemandApplyState(String cPDemandApplyState) {
		CPDemandApplyState = cPDemandApplyState;
	}
	
}
