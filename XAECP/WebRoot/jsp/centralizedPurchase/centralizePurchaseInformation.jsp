<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>供应商目录管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<style>
#supply #register{ display:block;  background-color:#FFF; border-width:0;}
#supply #register #registCnt{margin-top:10px; background-color:#C0DFFE;}
.ALRIGHT{ color:#A26D00;}
</style>
</head>

<body>
<div id="supply" class="CENTER">
<div id="top">
  <span><h2>集中采购信息</h2></span>
</div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
	<th>
    	<s:property value="centralizedPlanedPurchase.cpPurchaseInfoTitle"/>
    </th>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="2px;" cellspacing="0">
          <tr>
            <td class="ALRIGHT">产品类别&nbsp;</td>
            <td class="ALLEFT"><s:property value="centralizedPlanedPurchase.productTypeName"/></td>
            <td class="ALRIGHT">截止日期&nbsp;</td>
            <td class="ALLEFT"><s:property value="centralizedPlanedPurchase.deadline"/></td>
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">采购价格区间&nbsp;</td>
            <td class="ALLEFT"><s:property value="centralizedPlanedPurchase.purchasePriceInterval"/></td>
            <td class="ALRIGHT">度量单位&nbsp;</td>
            <td class="ALLEFT"><s:property value="centralizedPlanedPurchase.measureUnit"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">发布人&nbsp;</td>
            <td class="ALLEFT"><s:property value="centralizedPlanedPurchase.publisher"/></td>
            <td class="ALRIGHT">联系电话&nbsp;</td>
            <td class="ALLEFT"><s:property value="centralizedPlanedPurchase.telephone"/></td>
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">发布时间&nbsp;</td>
            <td class="ALLEFT"><s:property value="centralizedPlanedPurchase.publishDate"/></td>
            <td class="ALRIGHT">集中采购状态&nbsp;</td>
            <td class="ALLEFT"><s:property value="centralizedPlanedPurchase.centralizedPurchaseStateName"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">简要说明&nbsp;</td>
            <td class="ALLEFT" colspan="3"><s:property value="centralizedPlanedPurchase.briefExplain"/></td>
          </tr>
        </table></td>
      </tr>
  </table>
<div id="DOWN">
	<input type="button" class="BUTTON" onClick="javascript:history.back(-1);" value="返回前一页"/>
</div>
</div>
</body>
</html>
