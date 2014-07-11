package com.model;

public class PageUtils {

	private Integer pageSize;
	private Integer rowCount;
	private  int pageCount=0;
	private int nextPage;
	private int prePage;
	private int firstPage=1;
	private int lastPage;
	private int currentPage;
	private int v_start;
	private int v_end;
	private String searchText;
	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public PageUtils(int rowCount,int current , int pageSize){
		
		this.pageSize=pageSize;
		this.rowCount=rowCount;
		this.currentPage=current;
		
		//判断总行数是不是每页显示的倍数
		if(rowCount%pageSize==0){
			pageCount=rowCount/pageSize;
		}else{
			//如果不是倍数 总页数加一页
			pageCount=rowCount/pageSize+1;
		}
		
		//果当前页小于或等于零 将当前页赋值为1
		if(currentPage<=0){
			currentPage=1;
		//如果当关页大于总页数 将总页数赋值为总页数
		}else if(currentPage>pageCount){
			currentPage=pageCount;
		}
		
		//如果当前页大于1并且小于或等于总页数 则上一页可以减1
		if(currentPage>1 && currentPage<=pageCount){
			prePage=currentPage-1;
			//如果当前页刚好等于第一页数 则将上一页数赋值第一页
		}else{
			prePage=firstPage;
		}
		
		//赋值总页数
		lastPage=pageCount;
		//如果当前页大于0并且小于总页数 则下一页可以加1
		if(currentPage>=0 && currentPage<pageCount){
			nextPage=currentPage+1;
			//如果当前页刚好等于总页数 则将总页数赋于下一次
		}else{
			nextPage=pageCount;
		}
		
		v_start=(currentPage-1)*pageSize;
		v_end=v_start+pageSize;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getRowCount() {
		return rowCount;
	}

	public void setRowCount(Integer rowCount) {
		this.rowCount = rowCount;
	}

	public  int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getPrePage() {
		return prePage;
	}

	public void setPrePage(int prePage) {
		this.prePage = prePage;
	}

	public int getFirstPage() {
		return firstPage;
	}

	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getV_start() {
		return v_start;
	}

	public void setV_start(int vStart) {
		v_start = vStart;
	}

	public int getV_end() {
		return v_end;
	}

	public void setV_end(int vEnd) {
		v_end = vEnd;
	}
	
	
}
