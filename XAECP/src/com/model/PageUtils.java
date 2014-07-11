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
		
		//�ж��������ǲ���ÿҳ��ʾ�ı���
		if(rowCount%pageSize==0){
			pageCount=rowCount/pageSize;
		}else{
			//������Ǳ��� ��ҳ����һҳ
			pageCount=rowCount/pageSize+1;
		}
		
		//����ǰҳС�ڻ������ ����ǰҳ��ֵΪ1
		if(currentPage<=0){
			currentPage=1;
		//�������ҳ������ҳ�� ����ҳ����ֵΪ��ҳ��
		}else if(currentPage>pageCount){
			currentPage=pageCount;
		}
		
		//�����ǰҳ����1����С�ڻ������ҳ�� ����һҳ���Լ�1
		if(currentPage>1 && currentPage<=pageCount){
			prePage=currentPage-1;
			//�����ǰҳ�պõ��ڵ�һҳ�� ����һҳ����ֵ��һҳ
		}else{
			prePage=firstPage;
		}
		
		//��ֵ��ҳ��
		lastPage=pageCount;
		//�����ǰҳ����0����С����ҳ�� ����һҳ���Լ�1
		if(currentPage>=0 && currentPage<pageCount){
			nextPage=currentPage+1;
			//�����ǰҳ�պõ�����ҳ�� ����ҳ��������һ��
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
