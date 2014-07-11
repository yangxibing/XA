<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>确认到货</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
	window.onload = function(){
		    var tbody = document.getElementById("productListTable");
     		var index = 0;
     		var num = tbody.rows.length;
        	for(; index<num; index++){
        		tbody.rows[index].cells[4].innerText = (tbody.rows[index].cells[2].innerText*tbody.rows[index].cells[3].innerText);
        	}
	}
	
	function comfirmReceiveGoodsUpdate(){
		var purchaseOrderIdValue = $("#confirmUpdateHidden").attr("value");
		$.post($("#comfirmReceiveGoodsUpdate").attr("action"), {purchaseOrderId:purchaseOrderIdValue, async: false}, function(data){
			$("#comfirmReceiveButton").hide();
			alert("确认到货成功！");
			$("#queryPurchaseOrderList").submit();
		});
	}
</script>

<style>
#supply #register{clear:both; display:block; background-color:#FFF; border-width:0;}
.ALRIGHT{ color:#6666CD;}
#supply #top{ text-align:left;background-color:#D5D8FD;}
#supply #top span{ color:#000;}
#supply #top #process{ margin-top:4px; margin-right:4px;}
#supply #register{ padding-top:10px; }
#supply #register #registCnt{ text-align:center; background-color:#FFF;margin-bottom:20px; margin-top:4px;}
#supply #register #spanLeft1{margin-left:27px; margin-top:5px;}
#supply #register #spanRight1{margin-right:25px; margin-top:15px; background-color:#EBD3C9;}
#supply #register #borderTD{border-width:0 0 2px 0; border-style:dotted; border-color:#727BF8; margin-bottom:10px;}
#rightDown{ margin-right:23px; margin-bottom:10px;}
.BIGREDBUTTON{ width:250px; height:40px; font-size:16px; font-weight:bold;}
</style>
</head>

<body>

<form id="comfirmReceiveGoodsUpdate" action="comfirmReceiveGoodsUpdate.action">
	<input type="hidden" name="purchaseOrderId" id="confirmUpdateHidden" value="<s:property value="#request.purchaseOrderId"/>"/>
</form>
<form id="queryPurchaseOrderList" action="queryPurchaseOrderList.action">
	<input type="hidden" name="orderState" value="5"/>
	<input type="hidden" name="purchaseOrderId" id="confirmUpdateHidden" value="<s:property value="#request.purchaseOrderId"/>"/>
</form>

<div id="supply" class="CENTER">
    <div id="top">
      <span style="width:250px; margin-left:20px;" class="FLOATLEFT"><h2>订单确认到货</h2></span>
     	 <div id="process" class="FLOATRIGHT">
            <div class="ARTLEFTDIV"><span>交易仅需五步</span></div>
            <div class="ARTDIV">
                <span>提交订单</span>
            </div>
            <div class="ARTDIV">
                <span>支付定金</span>
            </div>
            <div class="BLUEDIV">
                <span>确认到货</span>
            </div>
            <div class="ARTDIV">
                <span>支付货款</span>
            </div>
            <div class="ARTDIV">
                <span>用后评价</span>
            </div>
        </div>
    </div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
	<tr>	
      	<td>
        	<span id="spanLeft1" class="FLOATLEFT">采购订单代码：<s:property value="#request.purchaseOrderId"/></span>
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
		            <td>采购数量</td>
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
				            <td id="productPriceLabel"></td>
				        </tr>
			  		</s:iterator>
	        </tbody>
        </table></td>
      </tr>
      <tr>
      	<td style=" height:40px; vertical-align:bottom; text-align:center;"> 
        	<input type="button" id="comfirmReceiveButton" value="确认到货" onclick="comfirmReceiveGoodsUpdate(this)" class="BIGREDBUTTON"/>
        </td> 
      </tr>
  </table>
  <div id="DOWN">
	<input type="button" class="BUTTON" onclick="window.open('../../home.jsp','_blank')" value="返回首页"/>
</div>
</div>
</body>
</html>
