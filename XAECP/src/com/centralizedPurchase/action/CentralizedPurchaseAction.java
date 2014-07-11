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
	
	//json异步返回结果
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
	 * 获取集中采购信息标题、产品类型：用于填充集中采购信息管理组合体检查询中相应部分
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
	 * 获取初始时的两级产品类型下拉列表:根及下一级
	 */
	public String queryProductTypeTreeRoot(){
		treeRootAjax = this.centralizedPurchaseService.getProductTypeTreeList();
		return "treeRoot";
	}
	
	/**
	 * 获取某一产品类型的所有直接子类型
	 */
	public String queryProductTypeTreeBranch(){
		this.treeBranchAjax = this.centralizedPurchaseService.getProductTypeTreeBranch(this.parentProductTypeId);
		return "treeBranch";
	}
	
	/**
	 * 获取集中采购信息列表
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
	 * 删除选中的集中采购信息
	 * @return
	 */
	public String deleteCentralizedPurchase(){
		this.centralizedPurchaseService.deleteCentralizedPurchase(deleteList);
		return SUCCESS;
	}
	
	/**
	 * 根据集中采购信息代码获取相应的对象
	 * @return "purchase"
	 */
	public String queryCentralizedPurchaseById(){
		this.purchaseAjax = this.centralizedPurchaseService.getCentralizedPurchaseById(this.centralizedPurchase.getCpPurchaseInfoId());
		return "purchaseAjax";
	}
	
	/**
	 * 增加集中发布信息
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
			
			//给采购商发邮件
			Supplier su = new Supplier();
			su.setPartnerType(1);
			List<Supplier> suppliers = this.purchaserService.listPurchaser(su);
			for(int i=0;i<suppliers.size();i++){
				SendMail sendMail = new SendMail();
				sendMail.setSendToAddress(suppliers.get(i).getEmail());
				sendMail.setMailTitle("尊敬的采购商您好，新的集中采购已发布");
				sendMail.setMailMsg("   标题："+this.centralizedPurchase.getCpPurchaseInfoTitle()
									+"   产品类型： "+this.centralizedPurchase.getProductTypeName()
									+"   价格区间： "+this.centralizedPurchase.getPurchasePriceBegin()+"-"+this.centralizedPurchase.getPurchasePriceEnd()+this.centralizedPurchase.getPurchasePriceUnit()
									+"   度量单位： "+this.centralizedPurchase.getMeasureUnit()
									+"   截止日期： "+this.centralizedPurchase.getDeadline()
									+"   主要内容： "+this.centralizedPurchase.getBriefExplain());
				sendMail.send();
			}
		}
		
		this.centralizedPurchaseService.addCentralizedPurchase(this.centralizedPurchase);
		
		return SUCCESS;
	}
	
	/**
	 * 更新集中采购信息
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
	 * 合并需求确认页面，提取集中采购信息对应的需求信息
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
	 * 需求合并确认后，更新数据库：集中采购状态、需求状态、需求数量合并写入
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
	 * 根据id获取集中采购信息
	 * @return
	 */
	public String queryCentralizedPurchaseInfo(){
		this.centralizedPurchase = this.centralizedPurchaseService.getCentralizedPurchaseById(this.centralizedPurchase.getCpPurchaseInfoId());
		this.request.put("centralizedPurchase", this.centralizedPurchase);
		return SUCCESS;
	}
	
	/**
	 * 查看集中采购需求信息
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
	 * 集中采购申请页面
	 * @return
	 */
	public String centralizedPurchaseApply(){
		this.centralizedPurchase = this.centralizedPurchaseService.getCentralizedPurchaseById(this.centralizedPurchase.getCpPurchaseInfoId());
		this.request.put("centralizedPurchase", this.centralizedPurchase);		
		return SUCCESS;
	}
	
	/**
	 * 获取提交集中采购页面所需信息
	 * @return
	 */
	public String centralizedPurchaseCommit(){
		this.centralizedPurchase = this.centralizedPurchaseService.getCentralizedPurchaseById(this.centralizedPurchase.getCpPurchaseInfoId());
		this.request.put("centralizedPurchase", this.centralizedPurchase);				
		return SUCCESS;
	}
	
	/**
	 * 集中采购订单需求确认之后，更新数据库
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
	 * 发布价格提交数据库，更新状态
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
	 * 查看集中采购订单信息
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
