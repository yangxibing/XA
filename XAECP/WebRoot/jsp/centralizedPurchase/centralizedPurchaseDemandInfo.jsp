<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>需求列表</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<style>
	#supply #register{clear:both; display:block; background-color:#FFF; border-width:0;}
	.ALRIGHT{ color:#6666CD;}
	#supply #register #registCnt{ text-align:center; background-color:#FFF;margin-bottom:20px; margin-top:0;}
	#supply #register #spanLeft1{margin-left:27px; margin-bottom:2px;}
	#supply #register #spanRight1{margin-right:25px; margin-bottom:2px;}
	.ORDERCONTENT{ width:350PX;}
</style>
</head>

<body>
<div id="supply" class="CENTER">
    <div id="top">
      <h2><span style="color:#FFF;">需求列表</span></h2>
    </div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="2px;" cellspacing="0">
        	<thead>
		          <tr class="TITLE">
		            <td>采购商名称</td>
		            <td>需求数量</td>
		            <td>度量单位</td>
		            <td>需求状态</td>
		            <td>申报时间</td>
		          </tr>        	
        	</thead>
        	<tbody>
        		<s:iterator id="element" value="#request.query">
			        <tr id="demandItem" class="HOVER">
			            <td ><input type="button" class="ARTBUTTON" onclick="" name="<s:property value="#element.purchaserId"/>" value="<s:property value="#element.purchaserName"/>"/></td>
			            <td ><s:property value="#element.demandNumber"/></td>
			            <td ><s:property value="#element.measureUnit"/></td>
			            <td ><s:property value="#element.demandState"/></td>
			            <td ><s:property value="#element.reportDemandTime" /></td>
			        </tr>
		  		</s:iterator>
        	</tbody>
        </table></td>
      </tr>
  </table>
  <div id="DOWN">
	<input type="button" class="BUTTON" onclick="window.open('home.html','_blank')" value="返回首页"/>
</div>
</div>
</body>
</html>
