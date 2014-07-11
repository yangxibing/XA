<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>报价详情</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script type="text/javascript">
        //************************************************************
        //从前一个页面跳转至action，然后取到报价列表，只需要在Action里把名为query的报价列表
        //压到request中，在跳转到该页面即可
        //************************************************************
</script>
</head>
<body >
	<div id="supply" class="CENTER">
	<div id="top">
	  <span style="color:#FFF;"><h2>报价详情</h2></span>
	</div>
	
	<table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
	    	<tr class="TITLE" style="font-weight:bold;">
	            <td>产品代码及名称</td>
	            <td>价格（元）</td>
	            <td>备注</td>
	        </tr>
		  	    <s:iterator id="element" value="#request.query">
		        	<tr class="HOVER">
		          	    <td ><s:property value="#element.productId"/>&nbsp;&nbsp;<s:property value="#element.productName"/></td>
		           	    <td ><s:property value="#element.price"/></td>
		           	    <td ><s:property value="#element.remark"/></td>
		        	</tr>
		        </s:iterator>
	  </table>
	  
	  <div id="DOWN">
	  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
	  </div>
	</div>
</body>
</html>