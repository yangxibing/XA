package com.mail;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

public class SendMail {
	private String mailTitle;
	private String mailMsg;
	private String sendToAddress = "jgq2008303393@163.com";
	private String sendAddress = "1028463799@qq.com";
	private String password = "mm03091221";
	
	public SendMail(){}
	
	public String send(){
		
		SimpleEmail email = new SimpleEmail();
		email.setTLS(true);
		email.setHostName("smtp.qq.com");
		email.setAuthentication(this.sendAddress, this.password);
		
		try{
			email.addTo(this.sendToAddress);
			email.setFrom(this.sendAddress);
			email.setSubject(this.mailTitle);
			email.setCharset("GB2312");
			email.setMsg(this.mailMsg);
			email.send();
			return "send success";
		}catch(EmailException e){
			e.printStackTrace();
			return "send fail";
		}
		
	}

	public String getMailTitle() {
		return mailTitle;
	}

	public void setMailTitle(String mailTitle) {
		this.mailTitle = mailTitle;
	}

	public String getMailMsg() {
		return mailMsg;
	}

	public void setMailMsg(String mailMsg) {
		this.mailMsg = mailMsg;
	}

	public String getSendToAddress() {
		return sendToAddress;
	}

	public void setSendToAddress(String sendToAddress) {
		this.sendToAddress = sendToAddress;
	}

	public String getSendAddress() {
		return sendAddress;
	}

	public void setSendAddress(String sendAddress) {
		this.sendAddress = sendAddress;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
