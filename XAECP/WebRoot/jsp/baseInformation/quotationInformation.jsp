<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>价格行情</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript"> 
		function displayRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
        //分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#quotationInformation").attr("action", "quotationInformation.action?currentPage="+currentPage);
        	$("#quotationInformation").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
        	$("#quotationInformation").attr("action", "quotationInformation.action?currentPage="+currentPage);
        	$("#quotationInformation").submit();
		}        
</script>
</head>

<body>

<form id="quotationInformation" action="quotationInformation.action" method="post"></form>

	<div id="supply" class="CENTER">
		<div id="top">
		  <span><h2>价格行情</h2></span>
		</div>
		<form action="loadQuotationInformation.action" id="loadQuotationInformation"></form>
		    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
		    	<tr class="TITLE" style="font-weight:bold;">
		            <td>产品代码</td>
		            <td>产品名称</td>
		            <td>供应商名称</td>
		            <td>产品类别</td>
		            <td>度量单位</td>
		            <td>规格</td>
		            <td>价格（元）</td>
		            <td>库存数量</td>
		        </tr>
				<s:iterator id="element" value="#request.query">
		        	<tr class="HOVER">
		          	    <td ><s:property value="#element.productId"/></td>
		           	    <td ><s:property value="#element.productName"/></td>
		           	    <td ><s:property value="#element.supplierName"/></td>
		           	    <td ><s:property value="#element.productTypeName"/></td>
						<td ><s:property value="#element.measureUnit"/></td>
						<td ><s:property value="#element.format"/></td>
		            	<td><s:property value="#element.price"/></td>
		            	<td><s:property value="#element.number"/></td>
		        	</tr>
		        </s:iterator>		        
		        <tr>
		            <td colspan="8" class="UPBOD" align="right">
		            	<input type="button" onclick="prePage()" class="BUTTON" value="上一页" />
						<span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
						<input type="button" onclick="nextPage()" class="BUTTON" value="下一页" />
		            </td>
		        </tr>
		    </table>
		    
		  <div id="DOWN">
		  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
		  </div>
	</div>
</body>
</html>
