package com.forum.action;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.forum.service.UserService;
import com.model.User;
import com.opensymphony.xwork2.ActionSupport;

public class UploadAction  extends ActionSupport{
	
	public User user=new User();
	private String username;
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	private List<File> myFile;
	private List<String> myFileContentType;
	private List<String> myFileFileName;
	private UserService userService;
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	private String savePath;
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public List<File> getMyFile() {
		return myFile;
	}

	public void setMyFile(List<File> myFile) {
		this.myFile = myFile;
	}

	public List<String> getMyFileContentType() {
		return myFileContentType;
	}

	public void setMyFileContentType(List<String> myFileContentType) {
		this.myFileContentType = myFileContentType;
	}

	public List<String> getMyFileFileName() {
		return myFileFileName;
	}

	public void setMyFileFileName(List<String> myFileFileName) {
		this.myFileFileName = myFileFileName;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public String execute() throws Exception{
		 username=new String(username.getBytes("iso-8859-1"),"gb2312");
		List<File> files=this.getMyFile();
		for(int i=0;i<files.size();i++)
		{
			InputStream is=new FileInputStream(files.get(i));
			String uploadPath=ServletActionContext.getServletContext().getRealPath("/content")+"/"+"wang";
			File toFile=new File(uploadPath,getMyFileFileName().get(i));
			user.setName("wang");
			user.setImagePath("/"+user.getName()+"/"+getMyFileFileName().get(i));
			this.userService.insertImagePath(user);
			System.out.println(user.getImagePath());
			OutputStream os=new FileOutputStream(toFile);
			byte[] buffer=new byte[1024];
			int length=0;
			while((length=is.read(buffer))>0){
				os.write(buffer,0,length);
			}
			is.close();
			os.close();
		}
		return SUCCESS;
	}

}
