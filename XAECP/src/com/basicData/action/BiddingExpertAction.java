package com.basicData.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.json.annotations.JSON;

import com.basicData.service.BiddingExpertService;
import com.model.BiddingExpert;
import com.model.Page;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class BiddingExpertAction extends ActionSupport implements ModelDriven<BiddingExpert>,RequestAware{

	private BiddingExpert expert = new BiddingExpert();
	private Map<String,Object> request;
	private BiddingExpertService biddingExpertService;
	private String expertList;
	private String ajaxResult;
	
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	
	//ajax结果
	private List<BiddingExpert> expertListAjax;
	
	//主页评标专家信息显示
	public String homeBiddingExpertList(){
		this.expertListAjax = this.biddingExpertService.queryExpert(expert);	
		return "list";
	}
	
	public String queryExpert(){
		Integer totalCount = this.biddingExpertService.purchaserTotalCount(expert);
		Page page = new Page(currentPage, totalCount, 10);
		this.totalPage = page.getTotalPage();
		this.currentPage = page.getCurrentPage();
		
		List<BiddingExpert> list=this.biddingExpertService.queryExpert(expert, page);
		request.put("query", list);
		request.put("expertVO", expert);
		request.put("totalPage", this.totalPage);
		request.put("currentPage", this.currentPage);
		return SUCCESS;
	}
	
	public String deleteExpert(){
		this.biddingExpertService.deleteExpert(expertList);
		return SUCCESS;
	}
	
	public String addExpert() throws Exception{
		if(expert.getPhotograph() != null){
			uploadFile(expert.getPhotograph(),toAscall(expert.getPhotographFileName().split("\\.")[0])+"."+expert.getPhotographFileName().split("\\.")[1]);
			//expert.setPhotograph(toAscall(expert.getPhotographFileName().split("\\.")[0])+"."+expert.getPhotographFileName().split("\\.")[1]);			
		} else {
			expert.setPhotograph("images/BiddingExpert/default.jpg");
		}
		this.biddingExpertService.addExpert(expert);
		queryExpert();
		return SUCCESS;
	}
	
	public String updateExpert() throws Exception{
		if(expert.getPhotograph() != null){
			uploadFile(expert.getPhotograph(),toAscall(expert.getPhotographFileName().split("\\.")[0])+"."+expert.getPhotographFileName().split("\\.")[1]);
			//expert.setPhotograph(toAscall(expert.getPhotographFileName().split("\\.")[0])+"."+expert.getPhotographFileName().split("\\.")[1]);			
		}
		this.biddingExpertService.updateExpert(expert);
		queryExpert();
		return SUCCESS;		
	}

	public void uploadFile(String advx,String nameX) throws Exception{
		try{
			File f=new File(advx);
			if(f.isFile() && f.canRead()){
				InputStream is=new FileInputStream(f);
				String uploadPath=ServletActionContext.getServletContext().getRealPath(BiddingExpert.updatePath);
				String picStr = this.expert.getExpertId()+"."+expert.getPhotographFileName().split("\\.")[1];
				File toFile=new File(uploadPath, picStr);
				OutputStream os=new FileOutputStream(toFile);
				byte[] buffer=new byte[1024];
				int length=0;
				while((length=is.read(buffer))>0){
					os.write(buffer,0,length);
				}
				is.close();
				os.close();
				this.expert.setPhotograph(BiddingExpert.updatePath+picStr);
				System.out.println(toFile.getAbsolutePath());
			} else {
				this.expert.setPhotograph("");
			}
		} catch(Exception e){
			this.expert.setPhotograph("");
			System.out.println("upload picture error: " + e.toString());
		}
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
	
	public String selectExpert(){
		this.expert = this.biddingExpertService.getExpertById(this.expert.getExpertId());
		this.expert.setPhotograph("../../"+this.expert.getPhotograph());
		request.put("expert", this.expert);
		return SUCCESS;
	}
	
	public String queryExpertById(){
		System.out.println("id: " + this.expert.getExpertId());
		this.expert = this.biddingExpertService.getExpertById(this.expert.getExpertId());
		ajaxResult = expert.getExpertId() + ","
			+ expert.getExpertName() + ","
			+ expert.getBirthday() + ","
			+ expert.getWorkUnit() + ","
			+ expert.getTitle() + ","
			+ expert.getPersonalProfile() + ","
			+ expert.getPhotograph() + ","
			+ expert.getTelephone() + ","
			+ expert.getFax() + ","
			+ expert.getEmail() + ","
			+ expert.getWebsite();
		return "expertInfo";
	}
	
	@JSON(serialize=false)
	public BiddingExpert getModel() {
		return this.expert;
	}

	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}

	@JSON(serialize=false)
	public BiddingExpert getExpert() {
		return expert;
	}

	public void setExpert(BiddingExpert expert) {
		this.expert = expert;
	}

	@JSON(serialize=false)
	public BiddingExpertService getBiddingExpertService() {
		return biddingExpertService;
	}

	public void setBiddingExpertService(BiddingExpertService biddingExpertService) {
		this.biddingExpertService = biddingExpertService;
	}

	@JSON(serialize=false)
	public Map<String, Object> getRequest() {
		return request;
	}

	public String getExpertList() {
		return expertList;
	}

	public void setExpertList(String expertList) {
		this.expertList = expertList;
	}

	public String getAjaxResult() {
		return ajaxResult;
	}

	public void setAjaxResult(String ajaxResult) {
		this.ajaxResult = ajaxResult;
	}

	public List<BiddingExpert> getExpertListAjax() {
		return expertListAjax;
	}

	public void setExpertListAjax(List<BiddingExpert> expertListAjax) {
		this.expertListAjax = expertListAjax;
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
}
