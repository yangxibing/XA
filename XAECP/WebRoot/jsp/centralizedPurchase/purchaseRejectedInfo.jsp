<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>退货详情</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
	window.onload = function(){
	     	var tbody = document.getElementById("productListTable");
     		var index = 0;
     		var sum = 0.0;
     		var num = tbody.rows.length;
        	for(; index<num; index++){
        		tbody.rows[index].cells[5].innerText = (tbody.rows[index].cells[2].innerText*tbody.rows[index].cells[4].innerText);
        		sum += tbody.rows[index].cells[5].innerText*1.0;
        	}
        	$("#productTotalPriceLabel").text(sum);
	}
</script>

<style>
#supply #register{clear:both; display:block; background-color:#FFF; border-width:0;}
.ALRIGHT{ color:#6666CD;}
#supply #register{ padding-top:10px; }
#supply #register #registCnt{ text-align:center; background-color:#FFF; margin-bottom:20px; margin-top:0;}
*+html #supply #register #registCnt{margin-top:-10px;}
#supply #register #spanLeft1{margin-left:27px; margin-bottom:2px;}
#supply #register #spanRight1{margin-right:25px; margin-bottom:2px;}
.ORDERCONTENT{ width:350PX;}
#bigRedButton{font-weight:bold; font-size:16px; width:200px; height:40px; margin-top:10px;}
</style>
</head>

<body>
<div id="supply" class="CENTER">
    <div id="top">
      <span style="color:#FFF;"><h2>退货信息</h2></span>
    </div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
	<tr>	
      	<td align="center">
        	<span id="spanLeft1" class="FLOATLEFT">采购订单代码：<label id="purchaseOrderIdLabel"><s:property value="#request.purchaseOrderId"/></label></span>
            <span id="spanRight1" class="FLOATRIGHT"><a class="ARTA" href="quotationInformation.action">价格行情</a></span>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="2px;" cellspacing="0">
        	<thead>
	           <tr class="TITLE">
	            <td>产品代码及名称</td>
	            <td>度量单位</td>
	            <td>价格（元）</td>
	            <td>购买数量</td>
	            <td>退货数量</td>
	            <td>合计（元）</td>
	          </tr>       	
        	</thead>
        	<tbody id="productListTable">
        		<s:iterator id="element" value="#request.query" status="status">
			        <tr id="productItem" class="HOVER">
			            <td ><input type="button" class="ARTBUTTON" onclick="" name="<s:property value="#element.productId"/>" value="<s:property value="#element.productId"/> <s:property value="#element.productName"/>"/></td>
			            <td ><s:property value="#element.measureUnit"/></td>
			            <td ><s:property value="#element.price"/></td>
			            <td><s:property value="#element.number"/></td>
			            <td><s:property value="#element.returnNumber"/></td>
			            <td id="productPriceLabel"></td>
			        </tr>
		  		</s:iterator>
        	</tbody>
        </table></td>
      </tr>
      <tr>
      	<td align="center" style="padding-bottom:15px;">
            <div class="ORDERCONTENT"><span>累计退货：<label id="productTotalPriceLabel"></label>（元）</span></div>
            <div class="ORDERCONTENT"><span>实际退货款：<s:property value="#request.actualRefund"/>（元）</span></div>
        </td>
      </tr>
  </table>
  <div id="DOWN">
	<input type="button" class="BUTTON" onclick="window.open('../../home.jsp','_blank')" value="返回首页"/>
</div>
</div>
</body>
</html>
