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
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

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
  <span style="color:#FFF;"><h2>采购/招标信息</h2></span>
</div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="2px;" cellspacing="0">
          <tr>
            <td class="ALRIGHT">标题&nbsp;</td>
            <td class="ALLEFT" colspan="3"><s:property value="supplyPurchaseInformation.title"/></td>
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">发布类型&nbsp;</td>
            <td class="ALLEFT" colspan="3"><s:property value="supplyPurchaseInformation.publishTypeName"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">产品类别&nbsp;</td>
            <td class="ALLEFT"><s:property value="supplyPurchaseInformation.productTypeName"/></td>
            <td class="ALRIGHT">有效日期&nbsp;</td>
            <td class="ALLEFT"><s:property value="supplyPurchaseInformation.effectiveDate"/></td>
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">采购商&nbsp;</td>
            <td class="ALLEFT"><a href="purchaseInformation.html"><s:property value="supplyPurchaseInformation.partnerName"/></a></td>
            <td class="ALRIGHT">浏览人次&nbsp;</td>
            <td class="ALLEFT"><s:property value="supplyPurchaseInformation.visitNumber"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">发布人&nbsp;</td>
            <td class="ALLEFT"><s:property value="supplyPurchaseInformation.publisher"/></td>
            <td class="ALRIGHT">发布时间&nbsp;</td>
            <td class="ALLEFT"><s:property value="supplyPurchaseInformation.publishDate"/></td>
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">内容&nbsp;</td>
            <td class="ALLEFT" colspan="3"><s:property value="supplyPurchaseInformation.publishContent"/></td>
          </tr>
        </table></td>
      </tr>
  </table>
<div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
</div>
</div>
</body>
</html>
