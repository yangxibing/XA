package com.bbs.action;

import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.annotations.JSON;

import com.bbs.service.UserMangeServiceBBS;
import com.model.BBSUser;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class UserManageActionBBS extends ActionSupport implements ModelDriven<BBSUser>,RequestAware,SessionAware {
	
	private BBSUser user = new BBSUser();
	private Map<String,Object> request;
	private UserMangeServiceBBS userMangeServiceBBS;
	private Map<String, Object> session;
	
	private String verifyAccountInfo;
	private int flag ; //-1表示帐号已存在
	
	private String loginAjaxResult; //记录是否登录成功success failure
	private BBSUser bbsUserAjax;
	private String logoutAjaxResult;
	
	private String ajaxRegisterResult;
	
	public String getAjaxRegisterResult() {
		return ajaxRegisterResult;
	}

	public void setAjaxRegisterResult(String ajaxRegisterResult) {
		this.ajaxRegisterResult = ajaxRegisterResult;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	@JSON(serialize=false)
	public UserMangeServiceBBS getUserMangeServiceBBS() {
		return userMangeServiceBBS;
	}

	public void setUserMangeServiceBBS(UserMangeServiceBBS userMangeServiceBBS) {
		this.userMangeServiceBBS = userMangeServiceBBS;
	}

	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}

	@JSON(serialize=false)
	public BBSUser getUser() {
		return user;
	}

	public void setUser(BBSUser user) {
		this.user = user;
	}

	@JSON(serialize=false)
	public BBSUser getModel() {
		// TODO Auto-generated method stub
		return user;
	}

	public void setRequest(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		this.request = arg0; 
	}
	
	public String getVerifyAccountInfo() {
		return verifyAccountInfo;
	}

	public void setVerifyAccountInfo(String verifyAccountInfo) {
		this.verifyAccountInfo = verifyAccountInfo;
	}

	public String registerUser() {
		this.userMangeServiceBBS.registerUser(user);
		ajaxRegisterResult = "success";
		return "success";
	}
	
	public String checkUserAccount() {
		if (this.userMangeServiceBBS.checkUserAccount(user.getLoginAccount()) ) {
			verifyAccountInfo = "用户帐号已存在";
			flag = -1;
		} else {
			verifyAccountInfo = "恭喜您可以使用此帐号";
			flag = 0;
		}
		return "checkResult";
	}
	
	
	public String bbsUserLogin() {
		if (this.userMangeServiceBBS.bbsUserLogin(user)) {
			BBSUser loginUser = this.userMangeServiceBBS.queryUserByAccount(user.getLoginAccount());
			this.session.put("bbsUserId", loginUser.getLoginAccount());
			this.session.put("bbsUserType", loginUser.getUserType());
			loginAjaxResult = "success";
			this.bbsUserAjax = user;
		} else {
			loginAjaxResult = "failure";
		}
		return "login";
	}

	
	public String bbsUserLogout() {
		this.session.clear();
		this.logoutAjaxResult = "SUCCESS";
		return "logout";
	}
	
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}
	
	@JSON(serialize=false)
	public Map<String, Object> getSession() {
		return session;
	}

	public String getLoginAjaxResult() {
		return loginAjaxResult;
	}

	public void setLoginAjaxResult(String loginAjaxResult) {
		this.loginAjaxResult = loginAjaxResult;
	}

	public BBSUser getBbsUserAjax() {
		return bbsUserAjax;
	}

	public void setBbsUserAjax(BBSUser bbsUserAjax) {
		this.bbsUserAjax = bbsUserAjax;
	}

	public String getLogoutAjaxResult() {
		return logoutAjaxResult;
	}

	public void setLogoutAjaxResult(String logoutAjaxResult) {
		this.logoutAjaxResult = logoutAjaxResult;
	}
}
