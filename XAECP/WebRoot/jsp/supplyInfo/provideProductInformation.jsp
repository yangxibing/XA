<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>供货信息</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>

<style>
#supply #register{ display:block;background-color:#FFF; border-width:0;}
#supply #register #registCnt{margin-top:10px;background-color:#C0DFFE;}
.ALRIGHT{ color:#A26D00;}
</style>
</head>

<body>
<div id="supply" class="CENTER">
<div id="top">
  <span style="color:#FFF;"><h2>供货信息</h2></span>
</div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="2px;" cellspacing="0">
          <tr>
            <td class="ALRIGHT">标题&nbsp;</td>
            <td class="ALLEFT" colspan="3"><s:property value="#request.result.title"/></td>
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">产品类别&nbsp;</td>
            <td class="ALLEFT"><s:property value="#request.result.productTypeName"/></td>
            <td class="ALRIGHT">有效日期&nbsp;</td>
            <td class="ALLEFT"><s:property value="#request.result.effectiveDate"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">供货商&nbsp;</td>
            <td class="ALLEFT"><a href="supplyInformation.html"><s:property value="#request.result.partnerName"/></a></td>
            <td class="ALRIGHT">浏览人次&nbsp;</td>
            <td class="ALLEFT"><s:property value="#request.result.visitNumber"/></td>
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">发布人&nbsp;</td>
            <td class="ALLEFT"><s:property value="#request.result.publisher"/></td>
            <td class="ALRIGHT">发布时间&nbsp;</td>
            <td class="ALLEFT"><s:property value="#request.result.publishDate"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT" >内容&nbsp;</td>
            <td class="ALLEFT" colspan="3" ><s:property value="#request.result.publishContent"/></td>
          </tr>
        </table></td>
      </tr>
  </table>
<div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
</div>
</body>
</html>
