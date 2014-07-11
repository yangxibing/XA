<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>物流信息</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<style>
#supply #register{clear:both; display:block;background-color:#FFF; border-width:0;}
.ALRIGHT{ color:#6666CD;}
</style>
</head>

<body>
<div id="supply" class="CENTER">
<div id="top">
  <span style="color:#FFF;"><h2>物流信息</h2></span>
</div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
          <tr>
            <td class="ALRIGHT">物流供应商&nbsp;</td>
            <td class="ALLEFT"><s:property value="purchaseOrder.logisticsName"/></td>
            
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">物流单号&nbsp;</td>
            <td class="ALLEFT"><s:property value="purchaseOrder.logisticsOrderId"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">物流查询网址&nbsp;</td>
            <td class="ALLEFT"><a href="http://<s:property value="purchaseOrder.logisticsWebsite"/>"><s:property value="purchaseOrder.logisticsWebsite"/></a></td>
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">收货信息&nbsp;</td>
            <td class="ALLEFT"><s:property value="purchaseOrder.receiveAddress"/>，&nbsp;<s:property value="purchaseOrder.receiveZipCode"/>，&nbsp;<s:property value="purchaseOrder.receiver"/>，&nbsp;<s:property value="purchaseOrder.receiveTelephone"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">发货信息&nbsp;</td>
            <td class="ALLEFT"><s:property value="purchaseOrder.sendAddress"/>&nbsp;<s:property value="purchaseOrder.sendZipCode"/>&nbsp;<s:property value="purchaseOrder.sender"/>&nbsp;<s:property value="purchaseOrder.sendTelephone"/></td>
          </tr>
        </table></td>
      </tr>
  </table>
<div id="DOWN">
	<input type="button" class="BUTTON" onclick="window.open('../../home.jsp','_blank')" value="返回首页"/>
</div>
</div>
</body>
</html>
