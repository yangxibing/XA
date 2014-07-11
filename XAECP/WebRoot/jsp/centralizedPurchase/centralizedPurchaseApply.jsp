<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>集中采购信息</title>

<link href="/XAECP/css/supply.css" rel="stylesheet" type="text/css"/>
<link href="/XAECP/css/global.css" rel="stylesheet" type="text/css"/>
<link href="/XAECP/css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="/XAECP/javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="/XAECP/javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		if('<s:property value="#request.centralizedPurchase.applyAvailable"/>' == 0){
			$("#centralizedPurchaseApplyBtn").attr("value", "申请需求");
			$("#centralizedPurchaseApplyBtn").attr("disabled", false);
		} else if('<s:property value="#request.centralizedPurchase.applyAvailable"/>' == 1){
			$("#centralizedPurchaseApplyBtn").attr("value", "集中采购信息已过期");
			$("#centralizedPurchaseApplyBtn").attr("disabled", true);
		} else {
			$("#centralizedPurchaseApplyBtn").attr("value", "集中采购信息当前状态不是“信息已发布”状态，无法申请");
			$("#centralizedPurchaseApplyBtn").attr("disabled", true);			
		}
	});
	
	function centralizedPurchaseCommit(valu){
		if('<s:property value="#session.userId"/>' != null && '<s:property value="#session.userId"/>' != ""){
			$("#centralizedPurchaseCommit").submit();		
		} else {
			alert("您尚未登录，请先登录系统！");
		}
	}
</script>

<style>
#supply #register{ display:block;  background-color:#FFF; border-width:0;}
#supply #register #registCnt{margin-top:10px; background-color:#C0DFFE;}
.ALRIGHT{ color:#A26D00;}
</style>
</head>

<body>
	<form id="centralizedPurchaseCommit" action="centralizedPurchaseCommit.action">
		<input type="hidden" name="cpPurchaseInfoId" id="cpPurchaseInfoIdHidden" value="<s:property value="#request.centralizedPurchase.cpPurchaseInfoId"/>" />
	</form>

	<div id="supply" class="CENTER">
	<div id="top">
	  <h2><span>集中采购信息</span></h2>
	</div>
	<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
		<thead><tr><td><s:property value="#request.centralizedPurchase.cpPurchaseInfoTitle"/></td></tr></thead>
	    <tbody>
	      <tr>
	        <td>
	        <table id="registCnt" class="CENTER" cellpadding="2px;" cellspacing="0">
	          <tr>
	            <td class="ALRIGHT">产品类别&nbsp;</td>
	            <td class="ALLEFT" id="productTypeInfo"><s:property value="#request.centralizedPurchase.productTypeName"/></td>
	            <td class="ALRIGHT">截止日期&nbsp;</td>
	            <td class="ALLEFT" id="deadlineInfo"><s:property value="#request.centralizedPurchase.deadline"/></td>
	          </tr>
	          <tr class="EEE">
	            <td class="ALRIGHT">采购价格区间&nbsp;</td>
	            <td class="ALLEFT" id="purchasePriceIntervalInfo"><s:property value="#request.centralizedPurchase.purchasePriceInterval"/></td>
	            <td class="ALRIGHT">度量单位&nbsp;</td>
	            <td class="ALLEFT" id="measureUnitInfo"><s:property value="#request.centralizedPurchase.measureUnit"/></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">发布人&nbsp;</td>
	            <td class="ALLEFT" id="publisherInfo"><s:property value="#request.centralizedPurchase.publisher"/></td>
	            <td class="ALRIGHT">联系电话&nbsp;</td>
	            <td class="ALLEFT" id="telephoneInfo"><s:property value="#request.centralizedPurchase.telephone"/></td>
	          </tr>
	          <tr class="EEE">
	            <td class="ALRIGHT">发布时间&nbsp;</td>
	            <td class="ALLEFT" id="publishDateInfo"><s:property value="#request.centralizedPurchase.publishDate"/></td>
	            <td class="ALRIGHT">集中采购状态&nbsp;</td>
	            <td class="ALLEFT" id="centralizedPurchaseStateInfo">
					<s:if test="%{#request.centralizedPurchase.centralizedPurchaseState==0}">未发布</s:if>
					<s:elseif test="%{#request.centralizedPurchase.centralizedPurchaseState==1}">信息已发布</s:elseif>
					<s:elseif test="%{#request.centralizedPurchase.centralizedPurchaseState==2}">需求已合并</s:elseif>
					<s:elseif test="%{#request.centralizedPurchase.centralizedPurchaseState==3}">价格已发布</s:elseif>
					<s:elseif test="%{#request.centralizedPurchase.centralizedPurchaseState==4}">需求已确认</s:elseif>
					<s:elseif test="%{#request.centralizedPurchase.centralizedPurchaseState==5}">购买中</s:elseif>
					<s:elseif test="%{#request.centralizedPurchase.centralizedPurchaseState==6}">完成</s:elseif>
					<s:else>未发布</s:else>
				</td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">简要说明&nbsp;</td>
	            <td class="ALLEFT" id="briefExplainInfo" colspan="3" rowspan="2"><s:property value="#request.centralizedPurchase.briefExplain"/></td>
	          </tr>        
	        </table></td>
	      </tr>
	      <tr>
	      	<td> <input type="button" id="centralizedPurchaseApplyBtn" onclick="centralizedPurchaseCommit(this)" value="申报需求"  class="BUTTON"/></td> 
	      </tr>
	    </tbody>
	  </table>
	<div id="DOWN">
		<input type="button" class="BUTTON" onclick="javascript:window.location='../../home.jsp';" value="返回首页"/>
	</div>
	</div>
</body>
</html>
