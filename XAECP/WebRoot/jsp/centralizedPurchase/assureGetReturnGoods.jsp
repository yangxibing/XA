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
<script language="javascript">
	$().ready(function (){
		var p=0;
		$("#registCnt tr:gt(0)").each(function(){
			
			p=Number(p)+Number($(this).children("td").eq(5).text());
			
		});
		$("#allReturnPrice").text("累计退货款  "+p+" （元）");
	});
	
	function assureGetReturnGoodes(){
		var baseOrderIdv=$("#spanLeft1").text().replace(/\D/g,"");
		var params={baseOrderId:baseOrderIdv};
		$.post("assureGetReturnGoods.action",params,function(data){
			$("#toFrontpageForm").submit();
		});
	}
</script>
<style>
#supply #register{clear:both; display:block; background-color:#FFF; border-width:0;}
#supply #register #registCnt{ border-width:1px;
border-color:#CCC;}
.ALRIGHT{ color:#6666CD;}
#supply #register{ padding-top:10px; }
#supply #register #registCnt{ text-align:center; background-color:#FFF; border-right-width:0; border-bottom-width:0; margin-bottom:20px;}
#supply #register #registCnt td{ border-width:0 1px 1px 0; border-color:#CCC;}
#supply #register #spanLeft1{margin-left:27px; margin-bottom:2px;}
#supply #register #spanRight1{margin-right:25px; margin-bottom:2px; background-color:#EBD3C9;}
.ORDERCONTENT{ width:350PX;}
#bigRedButton{font-weight:bold; font-size:16px; width:200px; height:40px; margin-top:10px;"}
</style>
</head>

<body>
<form id="toFrontpageForm" action="listSupplierOrders.action"></form>
<div id="supply" class="CENTER">
    <div id="top">
      <span style="color:#FFF;"><h2>退货信息</h2></span>
    </div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
	<tr>	
      	<td align="center">
        	<span id="spanLeft1"  class="FLOATLEFT">采购订单代码：<s:property value="baseOrder.baseOrderId"/></span>
            <span id="spanRight1" class="FLOATRIGHT"><a href="#">价格行情</a></span>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="2px;" cellspacing="0">
          <tr class="TITLE">
            <td>产品代码及名称</td>
            <td>度量单位</td>
            <td>价格（元）</td>
            <td>购买数量</td>
            <td>退货数量</td>
            <td>合计（元）</td>
          </tr>
          <s:iterator id="element" value="#request.list">
          <tr>
            <td><a href="#"><s:property value="#element.idName"/></a></td>
            <td><s:property value="#element.measureUnit"/></td>
            <td><s:property value="#element.price"/></td>
            <td><s:property value="#element.number"/></td>
            <td><s:property value="#element.returnNumber"/></td>
            <td><s:property value="#element.allPrice"/></td>
          </tr>
          </s:iterator>
        </table></td>
      </tr>
      <tr>
      	<td align="center" style="padding-bottom:15px;">
            <div class="ORDERCONTENT"><span id="allReturnPrice"></span></div>
            <div class="ORDERCONTENT"><span>实际退货款：<s:property value="baseOrder.actualRefund"/>（元）</span></div>
            <input type="button" id="bigRedButton" onclick = "assureGetReturnGoodes()" class="BIGREDBUTTON" value="确定收到退货" />
        </td>
      </tr>
  </table>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
</div>
</div>
</body>
</html>
