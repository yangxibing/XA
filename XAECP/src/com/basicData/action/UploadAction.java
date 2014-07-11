package com.basicData.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.basicData.service.UploadService;
import com.model.HotlineAdvertisement;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class UploadAction extends ActionSupport implements ModelDriven<HotlineAdvertisement>,RequestAware{
	
	private HotlineAdvertisement adv=new HotlineAdvertisement();
	private UploadService uploadService;
	private HotlineAdvertisement hotlineAdvertisementAjax;
	private Map<String, Object> request;
	private String hotline1;
	private String hotline2;
	private String hotline3;
	public String getHotline1() {
		return hotline1;
	}


	public void setHotline1(String hotline1) {
		this.hotline1 = hotline1;
	}


	public String getHotline2() {
		return hotline2;
	}


	public void setHotline2(String hotline2) {
		this.hotline2 = hotline2;
	}


	public String getHotline3() {
		return hotline3;
	}


	public void setHotline3(String hotline3) {
		this.hotline3 = hotline3;
	}


	@JSON(serialize = false)
	public UploadService getUploadService() {
		return uploadService;
	}


	public void setUploadService(UploadService uploadService) {
		this.uploadService = uploadService;
	}

	@JSON(serialize = false)
	public HotlineAdvertisement getAdv() {
		return adv;
	}


	public void setAdv(HotlineAdvertisement adv) {
		this.adv = adv;
	}


	public String hotLine(){
		
		String content="";
		if(hotline1!=null&&hotline1.length()!=0){
			content = content+hotline1+",";
		}
		if(hotline2!=null&&hotline2.length()!=0){
			content = content+hotline2+",";
		}
		if(hotline3!=null&&hotline3.length()!=0){
			content = content+hotline3+",";
		}
		this.uploadService.addHotline(content);
		this.request.put("hotLineFlag", "yes");
		return SUCCESS;
	}
	
	public String getHotLineAndAdvert(){
		
		hotlineAdvertisementAjax = this.uploadService.getHotLineAndAdvert();
		return "advertHotLine";
	}
	public String uploadFile()throws Exception{
		if(adv.getAdvertising1()!=null){
			uploadFile(adv.getAdvertising1(),toAscall(adv.getAdvertising1FileName().split("\\.")[0])+"."+adv.getAdvertising1FileName().split("\\.")[1]);
			adv.setAdvertising1(toAscall(adv.getAdvertising1FileName().split("\\.")[0])+"."+adv.getAdvertising1FileName().split("\\.")[1]);
		}
		if(adv.getAdvertising2()!=null){
			uploadFile(adv.getAdvertising2(),toAscall(adv.getAdvertising2FileName().split("\\.")[0])+"."+adv.getAdvertising2FileName().split("\\.")[1]);
			adv.setAdvertising2(toAscall(adv.getAdvertising2FileName().split("\\.")[0])+"."+adv.getAdvertising2FileName().split("\\.")[1]);
		}
		if(adv.getAdvertising3()!=null){
			uploadFile(adv.getAdvertising3(),toAscall(adv.getAdvertising3FileName().split("\\.")[0])+"."+adv.getAdvertising3FileName().split("\\.")[1]);
			adv.setAdvertising3(toAscall(adv.getAdvertising3FileName().split("\\.")[0])+"."+adv.getAdvertising3FileName().split("\\.")[1]);
		}
		if(adv.getAdvertising4()!=null){
			uploadFile(adv.getAdvertising4(),toAscall(adv.getAdvertising4FileName().split("\\.")[0])+"."+adv.getAdvertising4FileName().split("\\.")[1]);
			adv.setAdvertising4(toAscall(adv.getAdvertising4FileName().split("\\.")[0])+"."+adv.getAdvertising4FileName().split("\\.")[1]);
		}
		if(adv.getAdvertising5()!=null){
			uploadFile(adv.getAdvertising5(),toAscall(adv.getAdvertising5FileName().split("\\.")[0])+"."+adv.getAdvertising5FileName().split("\\.")[1]);
			adv.setAdvertising5(toAscall(adv.getAdvertising5FileName().split("\\.")[0])+"."+adv.getAdvertising5FileName().split("\\.")[1]);
		}
		if(adv.getAdvertising6()!=null){
			uploadFile(adv.getAdvertising6(),toAscall(adv.getAdvertising6FileName().split("\\.")[0])+"."+adv.getAdvertising6FileName().split("\\.")[1]);
			adv.setAdvertising6(toAscall(adv.getAdvertising6FileName().split("\\.")[0])+"."+adv.getAdvertising6FileName().split("\\.")[1]);
		}
		
		this.uploadService.uploadAdv(adv);
		this.request.put("upload", "success");
		return SUCCESS;
	}
	
	public void uploadFile(String advx,String nameX) throws Exception{
		File f=new File(advx);
		InputStream is=new FileInputStream(f);
		String uploadPath=ServletActionContext.getServletContext().getRealPath(adv.advPath);
		File toFile=new File(uploadPath,nameX);
		OutputStream os=new FileOutputStream(toFile);
		byte[] buffer=new byte[1024];
		int length=0;
		while((length=is.read(buffer))>0){
			os.write(buffer,0,length);
		}
		is.close();
		os.close();
	}
	
	//将字符包括汉字转化为ascall码
	public String toAscall(String s){
		char [] chars=s.toCharArray();
		String returnStr="";
		for(int i=0;i<chars.length;i++){
			returnStr+=(int)chars[i];
		}
		return returnStr;
	}
	@JSON(serialize = false)
	public HotlineAdvertisement getModel() {
		// TODO Auto-generated method stub
		return adv;
	}


	public HotlineAdvertisement getHotlineAdvertisementAjax() {
		return hotlineAdvertisementAjax;
	}


	public void setHotlineAdvertisementAjax(
			HotlineAdvertisement hotlineAdvertisementAjax) {
		this.hotlineAdvertisementAjax = hotlineAdvertisementAjax;
	}


	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}

	
	
}
