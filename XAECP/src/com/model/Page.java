package com.model;
/**
 * 
 * @author wyk
 * 功能：用于分页的信息
 */
public class Page {

	private Integer start =0;
	private Integer rowCount =2;
	private Integer currentPage = 1;
	private Integer totalPage = 1;
	private Integer prePage;
	private Integer nextPage;
	public static final Integer pageSize = 10;//每页包含的行数
	
	public Page(String currentPage, Integer totalCount){
		if(currentPage==null){
			currentPage ="0";
		}
		if(totalCount==null){
			totalCount = 0;
		}
		if(Integer.valueOf(currentPage)>=(totalCount/this.rowCount)){
			this.currentPage = totalCount/this.rowCount;
		}else{
			this.currentPage = Integer.valueOf(currentPage);
		}
		this.start = this.currentPage*this.rowCount;
	}
	
	public Page(Integer currentPage, Integer totalCount, Integer rowCount){
		if(rowCount != null){
			this.rowCount = rowCount;
		}
		if(totalCount == null){
			totalCount = 0;
		}
		this.totalPage = (int) Math.ceil((double)totalCount/(double)this.rowCount);
		
		if(currentPage==null){
			currentPage =1;
		}		
		this.currentPage = currentPage;
		if(this.currentPage>this.totalPage){
			this.currentPage = this.totalPage;
		}
		this.start = (this.currentPage-1)*this.rowCount;
		if(this.start < 0){
			this.start = 0;
		}
	}
	
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getRowCount() {
		return rowCount;
	}
	public void setRowCount(Integer rowCount) {
		this.rowCount = rowCount;
	}
	public Integer getPrePage() {
		return prePage;
	}
	public void setPrePage(Integer prePage) {
		this.prePage = prePage;
	}
	public Integer getNextPage() {
		return nextPage;
	}
	public void setNextPage(Integer nextPage) {
		this.nextPage = nextPage;
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
