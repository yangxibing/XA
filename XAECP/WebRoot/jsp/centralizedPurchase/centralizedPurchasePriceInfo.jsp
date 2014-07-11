<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>价格发布</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<style>
	#supply #register{clear:both; display:block; background-color:#FFF; border-width:0;}
	#supply #register #registCnt{margin-top:0;}
	#supply #register #registCnt .ALRIGHT{ color:#A26D00;}
	#rightSpace{ margin-right:25px;}
</style>
</head>

<body>
<div id="supply" class="CENTER">
<div id="top">
  <h2><span style="color:#FFF;">价格发布</span></h2>
</div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="2px;" cellspacing="0">
        	<s:iterator id="element" value="#request.query">
        		<tr>
	        		<td class="ALRIGHT">产品代码及名称</td>
		            <td class="ALLEFT"><s:property value="#element.productId" /> <s:property value="#element.productName" /></td>
		            <td class="ALRIGHT">价格（元）</td>
		            <td class="ALLEFT"><s:property value="#element.price" /></td>        		
        		</tr>
        	</s:iterator>
        </table></td>
      </tr>
  </table>
  <div id="DOWN">
	<input type="button" class="BUTTON" onclick="window.open('home.html','_blank')" value="返回首页"/>
</div>
</div>
</body>
</html>
