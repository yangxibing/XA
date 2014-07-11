package com.common;

import java.io.File;
import java.util.List;

public class UploadFile
{

	// 封装上传文件域的属性
	private File newFile;
	// 封装上传文件类型的属性
	private List<String> uploadContentType;
	// 封装上传文件名的属性
	private List<String> uploadFileName;
	  
	// 封装上传文件保存在服务器的路径，通过参数设置
	private String uploadPath;
	
	private UserInfo userInfo;
	
	public UserInfo getUserInfo()
	{
		return userInfo;
	}
	public void setUserInfo(UserInfo userInfo)
	{
		this.userInfo = userInfo;
	}
	public String getUploadPath()
	{
		return uploadPath;
	}
	public void setUploadPath(String uploadPath)
	{
		this.uploadPath = uploadPath;
	}

	public List<String> getUploadContentType()
	{
		return uploadContentType;
	}
	public void setUploadContentType(List<String> uploadContentType)
	{
		this.uploadContentType = uploadContentType;
	}
	public List<String> getUploadFileName()
	{
		return uploadFileName;
	}
	public void setUploadFileName(List<String> uploadFileName)
	{
		this.uploadFileName = uploadFileName;
	}
	/**
	 * newFile属性的getter方法
	 */
	public File getNewFile()
	{
		return newFile;
	}
	/**
	 * newFile属性的setter方法
	 */
	public void setNewFile(File newFile)
	{
		this.newFile = newFile;
	}
}
