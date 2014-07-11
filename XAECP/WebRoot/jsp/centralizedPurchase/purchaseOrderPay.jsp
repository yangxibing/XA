<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单支付余款</title>

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
        		tbody.rows[index].cells[4].innerText = (tbody.rows[index].cells[2].innerText*tbody.rows[index].cells[3].innerText);
        		sum += tbody.rows[index].cells[4].innerText*1.0;
        	}
        	$("#goodsTotalPriceLabel").text(sum);
        	var remainPayment = $("#totalPriceLabel").text()*1.0-$("#payedDepositLabel").text();
        	$("#bigRedButton").attr("value", "支付余款："+remainPayment+"（元）");
        	$("#bigRedButton").attr("name", remainPayment);
	}
	
	function payForGoodsUpdate(){
		var purchaseOrderIdValue = $("#payForGoodsHidden").attr("value");
		$.post($("#payForGoodsUpdate").attr("action"), {purchaseOrderId:purchaseOrderIdValue, async: false}, function(data){
			$("#bigRedButton").hide();
			alert("支付余款成功！");
			$("#queryPurchaseOrderList").submit();
		});
	}
</script>

<style>
#supply #register{clear:both; display:block; background-color:#FFF; border-width:0;}
.ALRIGHT{ color:#6666CD;}
#supply #top{ text-align:left;background-color:#D5D8FD;}
#supply #top span{ color:#000;}
#supply #top #process{ margin-top:4px; margin-right:4px; color:#000;}
#supply #register{ padding-top:10px; }
#supply #register #registCnt{ text-align:center; background-color:#FFF; margin-top:0;}
#supply #register #spanLeft1{margin-left:27px; margin-top:5px;}
#bigRedButton{font-weight:bold; font-size:16px; width:300px; height:40px; margin-top:10px;}
</style>
</head>

<body>

<form id="payForGoodsUpdate" action="payForGoodsUpdate.action">
	<input type="hidden" name="purchaseOrderId" id="payForGoodsHidden" value="<s:property value="#request.purchaseOrder.purchaseOrderId"/>"/>
</form>
<form id="queryPurchaseOrderList" action="queryPurchaseOrderList.action">
	<input type="hidden" name="orderState" value="6"/>
	<input type="hidden" name="purchaseOrderId" id="payForGoodsHidden" value="<s:property value="#request.purchaseOrder.purchaseOrderId"/>"/>
</form>

<div id="supply" class="CENTER">
    <div id="top">
      <h2><span style="width:250px; margin-left:20px;" class="FLOATLEFT">订单支付余款</span></h2>
     	 <div id="process" class="FLOATRIGHT">
            <div class="ARTLEFTDIV"><span>交易仅需五步</span></div>
            <div class="ARTDIV">
                <span>提交订单</span>
            </div>
            <div class="ARTDIV">
                <span>支付定金</span>
            </div>
            <div class="ARTDIV">
                <span>确认到货</span>
            </div>
            <div class="BLUEDIV">
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
        	<span id="spanLeft1" class="FLOATLEFT">采购订单代码：<s:property value="#request.purchaseOrder.purchaseOrderId"/></span>
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
      	<td align="center">
            <div class="ORDERCONTENT" style="margin-top:10px;"><span>产品货款：<label id="goodsTotalPriceLabel"></label>（元）</span></div>
            <div class="ORDERCONTENT"><span>运费：<label id="fareLabel"><s:property value="#request.purchaseOrder.fare"/></label>（元）</span></div>
            <div class="ORDERCONTENT"><span>总货款：<label id="totalPriceLabel"><s:property value="#request.purchaseOrder.totalPrice"/></label>（元）</span></div>
            <div class="ORDERCONTENT"><span>已支付定金：<label id="payedDepositLabel"><s:property value="#request.purchaseOrder.deposit"/></label>（元）</span></div>
            <input id="bigRedButton" type="button" onclick="payForGoodsUpdate(this)" class="BIGREDBUTTON" value="支付余款：（元）" />
        </td>
      </tr>
  </table>
  <div id="DOWN">
	<input type="button" class="BUTTON" onclick="window.open('home.html','_blank')" value="返回首页"/>
</div>
</div>
</body>
</html>
