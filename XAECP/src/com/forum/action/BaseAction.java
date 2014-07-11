package com.forum.action;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.common.UserInfo;
import com.forum.service.ServiceManager;
import com.opensymphony.xwork2.ActionSupport;


@SuppressWarnings("serial")
public class BaseAction extends ActionSupport implements
		org.apache.struts2.interceptor.ServletRequestAware,
		org.apache.struts2.interceptor.ServletResponseAware,org.apache.struts2.util.ServletContextAware
{

	protected ServiceManager serviceManager;
	public UserInfo userInfo=new UserInfo();
	protected String result;	
	protected Map<String, String> cookies;
	protected javax.servlet.http.HttpServletResponse response;
	protected javax.servlet.http.HttpServletRequest request;
	protected ServletContext servletContext;
	

	public void setServletResponse(HttpServletResponse response)
	{
		this.response = response;

	}
	public void setServletContext(ServletContext servletContext)
	{
		this.servletContext = servletContext;
	}

	protected String getCookieValue(String name)
	{
		javax.servlet.http.Cookie cookies[] = request.getCookies();
		if (cookies != null)
		{
			for (Cookie cookie : cookies)
			{

				if (!cookie.getName().equals(name))
					continue;
				return cookie.getValue();
			}

		}
		return null;
	}

	public void setServletRequest(HttpServletRequest request)
	{
		this.request = request;

		/*userInfo.setCookieUser(getCookieValue("user"));*/
	}

	/**
	 * result属性的getter方法
	 */
	public String getResult()
	{
		return result;
	}

	/**
	 * result属性的setter方法
	 */
	public void setResult(String result)
	{
		this.result = result;

	}

	public void setServiceManager(ServiceManager serviceManager)
	{
		this.serviceManager = serviceManager;
	}

	/**
	 * userInfo属性的setter方法
	 */
	public void setUserInfo(UserInfo userInfo)
	{
		this.userInfo = userInfo;

	}

	protected void saveCookie(String name, String value, int maxAge)
	{
		javax.servlet.http.Cookie cookie = new javax.servlet.http.Cookie(name,
				value);
		cookie.setMaxAge(maxAge);
		response.addCookie(cookie);
	}

}