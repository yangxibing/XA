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
	
	//ajax返回的变量
	private List<Supplier> partnerListAjax;
	private List<Actor> actorListAjax;
	private XAUser userAjax;
	private String loginAjax;
	private String checkPassOrNotAjax;
	private String logoutAjax;
	private String passwordFindBackAjax;
	private String sessionValue;
	/**
	 * 获取注册采购商时所需的信息：采购商列表
	 */
	public String purchaserRegister(){
		Supplier supplier = new Supplier();
		supplier.setPartnerType(1);
		List<Supplier> list = this.userManageService.getSupplierList(supplier);
		this.request.put("query", list);
		return SUCCESS;
	}
	
	/**
	 * 获取注册供应商时所需的信息：供应商列表
	 */
	public String supplierRegister(){
		Supplier supplier = new Supplier();
		supplier.setPartnerType(0);
		List<Supplier> list = this.userManageService.getSupplierList(supplier);
		this.request.put("query", list);
		return SUCCESS;
	}
	
	/**
	 * 获取注册物流供应商时所需的信息：供应商列表
	 */
	public String logisticRegister(){
		Supplier supplier = new Supplier();
		supplier.setPartnerType(2);
		List<Supplier> list = this.userManageService.getSupplierList(supplier);
		this.request.put("query", list);
		return SUCCESS;		
	}
	
	/**
	 * 注册采购商用户
	 */
	public String purchaserRegisterSubmit(){
		user.setActorId("10000000");
		user.setPasscheckOrNot(false);
		this.userManageService.purchaserRegisterSubmit(user);
		this.request.put("purchaserRegisterSuccess", "SUCCESS");
		return SUCCESS;
	}
	
	/**
	 * 注册供应商用户
	 */
	public String supplierRegisterSubmit(){
		user.setActorId("20000000");
		user.setPasscheckOrNot(false);
		this.userManageService.purchaserRegisterSubmit(user);
		this.request.put("supplierRegisterSuccess", "SUCCESS");
		return SUCCESS;
	}
	
	/**
	 * 注册物流供应商用户
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
	 * 注册基地管理员
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
	 * 获取所有合作伙伴列表用于用户管理模块的查询模块
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
	 * 根据参数指定的条件，查询用户列表
	 * userVO用于保存查询状态
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
	 * 根据用户代码组成的字符串序列删除指定用户
	 */
	public String deleteSelectedUser(){
		this.userManageService.deleteSelectedUser(userList);
		return SUCCESS;
	}
	
	/**
	 * 根据用户账号获取指定的用户信息
	 */
	public String queryXAUserById(){
		this.userAjax = this.userManageService.getXAUserById(this.user.getUserId());
		return "user";
	}
	
	/**
	 * 增加系统用户
	 */
	public String addXAUser(){
		this.userManageService.addXAUser(this.user);
		return SUCCESS;
	}
	
	/**
	 * 更新用户
	 */
	public String updateXAUser(){
		this.userManageService.updateXAUser(user);
		return SUCCESS;
	}
	
	/**
	 * 审批注册的用户
	 */
	public String checkRegisterApply(){
		user.setPasscheckOrNot(true);
		this.userManageService.checkRegisterApply(user);
		return SUCCESS;
	}
	
	/**
	 * 用户登录
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
			this.passwordFindBackAjax = "用户名或者邮箱不正确，请重新输入";
		}else{
			XAUser xauser = this.userManageService.passwordFindBack(user);
			this.passwordFindBackAjax = "已经发送到您的邮箱，请注意查收";
			SendMail sendMail =new SendMail();
			sendMail.setMailTitle("西安印刷包装物资集中采购网找回密码邮件");
			sendMail.setSendToAddress(xauser.getEmail());
			sendMail.setMailMsg("尊敬的 "+xauser.getUserName()+" 您好，感谢您使用西安印刷包装物资集中采购网找回密码邮件功能，您的密码是"+xauser.getPassword());
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
	 * 用户退出系统
	 */
	public String XAUserLogout(){
		this.session.clear();
		sessionValue = "default";
		this.logoutAjax = "SUCCESS";
		return "logout";
	}
	
	/**
	 * 修改密码
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
