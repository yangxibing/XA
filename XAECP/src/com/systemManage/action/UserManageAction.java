package com.systemManage.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.mail.SendMail;
import com.model.Actor;
import com.model.Page;
import com.model.Supplier;
import com.model.XALog;
import com.model.XAUser;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.systemManage.service.UserManageService;

public class UserManageAction  extends ActionSupport implements ModelDriven<XAUser>,RequestAware, SessionAware{

	private Map<String, Object> request;
	private UserManageService userManageService;
	private XAUser user = new XAUser();
	private String userList;
	private Map session;
	private String checkRegisterExistAjax;
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	//ajax���صı���
	private List<Supplier> partnerListAjax;
	private List<Actor> actorListAjax;
	private XAUser userAjax;
	private String loginAjax;
	private String checkPassOrNotAjax;
	private String logoutAjax;
	private String passwordFindBackAjax;
	private String sessionValue;
	/**
	 * ��ȡע��ɹ���ʱ�������Ϣ���ɹ����б�
	 */
	public String purchaserRegister(){
		Supplier supplier = new Supplier();
		supplier.setPartnerType(1);
		List<Supplier> list = this.userManageService.getSupplierList(supplier);
		this.request.put("query", list);
		return SUCCESS;
	}
	
	/**
	 * ��ȡע�ṩӦ��ʱ�������Ϣ����Ӧ���б�
	 */
	public String supplierRegister(){
		Supplier supplier = new Supplier();
		supplier.setPartnerType(0);
		List<Supplier> list = this.userManageService.getSupplierList(supplier);
		this.request.put("query", list);
		return SUCCESS;
	}
	
	/**
	 * ��ȡע��������Ӧ��ʱ�������Ϣ����Ӧ���б�
	 */
	public String logisticRegister(){
		Supplier supplier = new Supplier();
		supplier.setPartnerType(2);
		List<Supplier> list = this.userManageService.getSupplierList(supplier);
		this.request.put("query", list);
		return SUCCESS;		
	}
	
	/**
	 * ע��ɹ����û�
	 */
	public String purchaserRegisterSubmit(){
		user.setActorId("10000000");
		user.setPasscheckOrNot(false);
		this.userManageService.purchaserRegisterSubmit(user);
		this.request.put("purchaserRegisterSuccess", "SUCCESS");
		return SUCCESS;
	}
	
	/**
	 * ע�ṩӦ���û�
	 */
	public String supplierRegisterSubmit(){
		user.setActorId("20000000");
		user.setPasscheckOrNot(false);
		this.userManageService.purchaserRegisterSubmit(user);
		this.request.put("supplierRegisterSuccess", "SUCCESS");
		return SUCCESS;
	}
	
	/**
	 * ע��������Ӧ���û�
	 * @return
	 */
	public String logisticRegisterSubmit(){
		user.setActorId("20000000");
		user.setPasscheckOrNot(false);
		this.userManageService.purchaserRegisterSubmit(user);
		this.request.put("logisticRegisterSuccess", "SUCCESS");
		return SUCCESS;
	}
	
	/**
	 * ע����ع���Ա
	 * @return
	 */
	public String administratorRegisterSubmit(){
		user.setActorId("30000000");
		user.setPasscheckOrNot(false);
		this.userManageService.purchaserRegisterSubmit(user);
		this.request.put("administratorRegisterSuccess", "SUCCESS");
		return SUCCESS;		
	}
	
	
	/**
	 * ��ȡ���к�������б������û�����ģ��Ĳ�ѯģ��
	 * @return
	 */
	public String querySearchInfo(){
		Supplier supplier = new Supplier();
		partnerListAjax = this.userManageService.getSupplierList(supplier);
		Actor actor = new Actor();
		actorListAjax = this.userManageService.getActorList(actor);
		return "list";		
	}
	
	/**
	 * ���ݲ���ָ������������ѯ�û��б�
	 * userVO���ڱ����ѯ״̬
	 * @return
	 */
	public String queryXAUserList(){
		Integer totalCount = this.userManageService.userTotalCount(user);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<XAUser> list = this.userManageService.getXAUserList(user, page);
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);
		this.request.put("query", list);
		this.request.put("userVO", user);
		return SUCCESS;
	}
	
	/**
	 * �����û�������ɵ��ַ�������ɾ��ָ���û�
	 */
	public String deleteSelectedUser(){
		this.userManageService.deleteSelectedUser(userList);
		return SUCCESS;
	}
	
	/**
	 * �����û��˺Ż�ȡָ�����û���Ϣ
	 */
	public String queryXAUserById(){
		this.userAjax = this.userManageService.getXAUserById(this.user.getUserId());
		return "user";
	}
	
	/**
	 * ����ϵͳ�û�
	 */
	public String addXAUser(){
		this.userManageService.addXAUser(this.user);
		return SUCCESS;
	}
	
	/**
	 * �����û�
	 */
	public String updateXAUser(){
		this.userManageService.updateXAUser(user);
		return SUCCESS;
	}
	
	/**
	 * ����ע����û�
	 */
	public String checkRegisterApply(){
		user.setPasscheckOrNot(true);
		this.userManageService.checkRegisterApply(user);
		return SUCCESS;
	}
	
	/**
	 * �û���¼
	 */
	public String XAUserLogin(){
		List<XAUser> list = this.userManageService.getXAUserListLogin(user);
		if(list.size() == 1){
			
			
			if(list.get(0).getPasscheckOrNot()==true){
				this.checkPassOrNotAjax = "pass";
				this.session.put("userId", user.getUserId());
				this.session.put("userName", list.get(0).getUserName());
				this.session.put("partnerId", list.get(0).getSupplierId());
				this.session.put("actorId", "'"+list.get(0).getActorId()+"'");
				sessionValue = "'"+list.get(0).getActorId()+"'";
				this.loginAjax = "SUCCESS";
				this.userAjax = list.get(0);
				
				XALog xalog = new XALog();
				xalog.setUserId((String) this.session.get("userId"));
				xalog.setPartnerId((String) this.session.get("partnerId"));
				xalog.setActorId(list.get(0).getActorId());
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date now = new Date();
				String time = format.format(now);
				xalog.setLoginTime(time);
				xalog.setRemark("");
				this.userManageService.addXALog(xalog);
			}
				
			else
				this.checkPassOrNotAjax = "notPass";
			
			
		} else {
			this.loginAjax = "FALSE";
		}
		return "login";
	}
	
	public String passwordFindBack(){
		
		if(this.userManageService.passwordFindBack(user)==null){
			this.passwordFindBackAjax = "�û����������䲻��ȷ������������";
		}else{
			XAUser xauser = this.userManageService.passwordFindBack(user);
			this.passwordFindBackAjax = "�Ѿ����͵��������䣬��ע�����";
			SendMail sendMail =new SendMail();
			sendMail.setMailTitle("����ӡˢ��װ���ʼ��вɹ����һ������ʼ�");
			sendMail.setSendToAddress(xauser.getEmail());
			sendMail.setMailMsg("�𾴵� "+xauser.getUserName()+" ���ã���л��ʹ������ӡˢ��װ���ʼ��вɹ����һ������ʼ����ܣ�����������"+xauser.getPassword());
			sendMail.send();
		}
		
		return "passwordFindBackAjax";
	}
	
	public String checkRegisterExistAjax(){
		
		if(this.userManageService.getXAUserListLogin(user)==null){
			checkRegisterExistAjax = "notExist";
		}else
			checkRegisterExistAjax = "exist";
		return "checkRegisterExistAjax";
		
	}
	/**
	 * �û��˳�ϵͳ
	 */
	public String XAUserLogout(){
		this.session.clear();
		sessionValue = "default";
		this.logoutAjax = "SUCCESS";
		return "logout";
	}
	
	/**
	 * �޸�����
	 */
	public String modifyPassword(){
		this.user.setUserId((String) this.session.get("userId"));
		this.userManageService.modifyPassword(user);
		return SUCCESS;
	}
	
	/**
	 * Getter and Setter for members
	 */
	@JSON(serialize=false)
	public XAUser getModel() {
		return user;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;		
	}

	@JSON(serialize=false)
	public UserManageService getUserManageService() {
		return userManageService;
	}

	public void setUserManageService(UserManageService userManageService) {
		this.userManageService = userManageService;
	}

	@JSON(serialize=false)
	public XAUser getUser() {
		return user;
	}

	public void setUser(XAUser user) {
		this.user = user;
	}

	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}

	public List<Supplier> getPartnerListAjax() {
		return partnerListAjax;
	}

	public void setPartnerListAjax(List<Supplier> partnerListAjax) {
		this.partnerListAjax = partnerListAjax;
	}

	public String getUserList() {
		return userList;
	}

	public void setUserList(String userList) {
		this.userList = userList;
	}

	public List<Actor> getActorListAjax() {
		return actorListAjax;
	}

	public void setActorListAjax(List<Actor> actorListAjax) {
		this.actorListAjax = actorListAjax;
	}

	public XAUser getUserAjax() {
		return userAjax;
	}

	public void setUserAjax(XAUser userAjax) {
		this.userAjax = userAjax;
	}

	public String getLoginAjax() {
		return loginAjax;
	}

	public void setLoginAjax(String loginAjax) {
		this.loginAjax = loginAjax;
	}

	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	@JSON(serialize=false)
	public Map getSession() {
		return session;
	}

	public String getLogoutAjax() {
		return logoutAjax;
	}

	public void setLogoutAjax(String logoutAjax) {
		this.logoutAjax = logoutAjax;
	}

	public String getSessionValue() {
		return sessionValue;
	}

	public void setSessionValue(String sessionValue) {
		this.sessionValue = sessionValue;
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

	public String getCheckRegisterExistAjax() {
		return checkRegisterExistAjax;
	}

	public void setCheckRegisterExistAjax(String checkRegisterExistAjax) {
		this.checkRegisterExistAjax = checkRegisterExistAjax;
	}

	public String getCheckPassOrNotAjax() {
		return checkPassOrNotAjax;
	}

	public void setCheckPassOrNotAjax(String checkPassOrNotAjax) {
		this.checkPassOrNotAjax = checkPassOrNotAjax;
	}

	public String getPasswordFindBackAjax() {
		return passwordFindBackAjax;
	}

	public void setPasswordFindBackAjax(String passwordFindBackAjax) {
		this.passwordFindBackAjax = passwordFindBackAjax;
	}

	
	
}
