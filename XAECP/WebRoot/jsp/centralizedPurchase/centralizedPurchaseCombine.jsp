<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>j需求列表</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
	window.onload = function(){
		var tbody = document.getElementById("demandDetailTable");
		var count = tbody.rows.length;
		var sum = 0.0;
		for(var index=0; index<count; index++){
			if(tbody.rows[index].cells[0].childNodes[1].name == "0"){
				sum += tbody.rows[index].cells[1].innerText*1.0;
			}
		}
		$("#combineDemandBtn").attr("name", sum);
		$("#combineDemandBtn").attr("value", "合并需求："+sum+"（"+tbody.rows[0].cells[2].innerText+"）");
	}
	
	function combineDemandUpdate(valu){
		var combinePlanedNumValue = valu.name;
		var cpPurchaseInfoIdValue = $("#cpPurchaseInfoIdHidden").attr("value");
		var url = $("#combineDemandUpdate").attr("action");
		var params = {cpPurchaseInfoId:cpPurchaseInfoIdValue, combinePlanedNum:combinePlanedNumValue, async:false};
		$.post(url, params, function(data){
			$("#queryCentralizedPurchaseList").submit();
		});
	}
</script>

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

	<form id="combineDemandUpdate" action="combineDemandUpdate.action"></form>
	<form id="queryCentralizedPurchaseList" action="queryCentralizedPurchaseList.action">
		<input type="hidden" name="cpPurchaseInfoId" id="cpPurchaseInfoIdHidden" value="<s:property value="#request.query[0].CPIId"/>" />
		<input type="hidden" name="centralizedPurchaseState" value="2" />
	</form>
	
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
	        	<tbody id="demandDetailTable">
	        		<s:iterator id="element" value="#request.query">
				        <tr id="demandItem" class="HOVER">
				            <td ><input type="button" class="ARTBUTTON" onclick="" name="<s:property value="#element.purchaserId"/>" value="<s:property value="#element.purchaserName"/>"/><input type="hidden" name="<s:property value="#element.demandState"/>" /></td>
				            <td ><s:property value="#element.demandNumber"/></td>
				            <td ><s:property value="#element.measureUnit"/></td>
				            <td >
				            	<s:if test="%{#element.demandState==0}">需求已提交</s:if>
				            	<s:if test="%{#element.demandState==1}">需求已合并</s:if>
				            	<s:if test="%{#element.demandState==2}">价格已发布</s:if>
				            	<s:if test="%{#element.demandState==3}">取消</s:if>
				            	<s:if test="%{#element.demandState==4}">需求已确认</s:if>
				            </td>
				            <td ><s:property value="#element.reportDemandTime"/></td>
				        </tr>
			  		</s:iterator>
	        	</tbody>
	        </table></td>
	      </tr>
	      <tr>
	      	<td align="center" style="padding-bottom:15px;">
	            <input type="button" class="REDBUTTON" name="" id="combineDemandBtn" onclick="combineDemandUpdate(this)" value="合并需求：（度量单位）" />
	        </td>
	      </tr>
	  </table>
	  <div id="DOWN">
		<input type="button" class="BUTTON" onclick="window.open('home.html','_blank')" value="返回首页"/>
	</div>
	</div>
</body>
</html>
