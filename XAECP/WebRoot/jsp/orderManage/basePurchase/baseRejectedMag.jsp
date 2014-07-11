<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<!-- 
 ==》从一个action跳转到此页面，需要传递三个参数：baseOrder对象、query对象（baseOrderDetail List）
《== 从此页面跳出使用confirmRejected.action，需要到后台处理支付余款的业务：订单状态、更新订单中退款额信息、更新订单明细表中的退货数量
 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>j退货信息</title>

<link href="../../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../../javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
	   function checkNumber(valu){
	   		var index = $(valu).attr("name").split(" ")[0];
     		var tbody = document.getElementById("productListTable");
     		
     		if($(valu).attr("value")!= "" && $(valu).attr("value") <= 0) {
     			alert("退货数量不可以为零或负值！");
     			$(valu).attr("value", "");
     			tbody.rows[index].cells[5].innerText = "";
     		} else if($(valu).attr("value")!= "" && $(valu).attr("value") > $(valu).attr("name").split(" ")[1]*1.0){
     			alert("退货数量必须小于购买数量！");
     			$(valu).attr("value", "");
     			tbody.rows[index].cells[5].innerText = "";
     		} else if($(valu).attr("value")!= "" && $(valu).attr("value") > 0 && $(valu).attr("value") <= $(valu).attr("name").split(" ")[1]*1.0) {
     			var index = $(valu).attr("name").split(" ")[0];
     			var tbody = document.getElementById("productListTable");
     			tbody.rows[index].cells[5].innerText = (tbody.rows[index].cells[2].innerText*$(valu).attr("value"));
     		} else {
     			$("#productTotalEdit").text("");
     		}
     		priceChanged();
     	} 
     	
     	function priceChanged(){
     	    var tbody = document.getElementById("productListTable");
     		var index = 0;
     		var sum = 0.0;
     		var num = tbody.rows.length;
        	for(; index<num; index++){
        		sum += tbody.rows[index].cells[5].innerText*1.0;
        	}
        	$("#productTotalPriceLabel").text(sum);
     	}
     	
     	function checkRefund(valu){
     		if($(valu).attr("value")!= "" && $(valu).attr("value") <= 0) {
     			alert("实际退货款不可以为零或负值！");
     			$(valu).attr("value", "");
     		}
     	}
     	
     	function confirmRejected(valu){

     		var rejectListValue = "";
     		var tbody = document.getElementById("productListTable");
     		var num = tbody.rows.length;
        	for(var index = 0; index<num; index++){
        		rejectListValue += tbody.rows[index].cells[0].childNodes[0].name + " " + tbody.rows[index].cells[4].childNodes[0].value + ",";
        	}
			$("#baseOrderIdTag").attr("value", $("#baseOrderIdLabel").text());
			$("#actualRefundTag").attr("value", $("#actualRefundEdit").attr("value"));
			$("#rejectListTag").attr("value", rejectListValue);
        	$("#confirmRejected").submit();
     	}
</script>

<style>
#supply #register{clear:both; display:block; background-color:#FFF; border-width:0;}
.ALRIGHT{ color:#6666CD;}
#supply #register{ padding-top:10px; }
#supply #register #registCnt{ text-align:center; background-color:#FFF; margin-bottom:20px; margin-top:0;}
#supply #register #spanLeft1{margin-left:27px; margin-bottom:2px;}
#supply #register #spanRight1{margin-right:25px; margin-bottom:2px; background-color:#EBD3C9;}
.ORDERCONTENT{ width:350PX;}
#bigRedButton{font-weight:bold; font-size:16px; width:200px; height:40px; margin-top:10px;}
</style>
</head>

<body>

<form id="confirmRejected" action="confirmRejected.action">
	<input type="hidden" name="baseOrderId" id="baseOrderIdTag" value=""/>
	<input type="hidden" name="actualRefund" id="actualRefundTag" value="" />
	<input type="hidden" name="rejectList" id="rejectListTag" value=""/>
</form>

<div id="supply" class="CENTER">
    <div id="top">
      <h2><span style="color:#FFF;">退货信息</span></h2>
    </div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
	<tr>	
      	<td align="center">
        	<span id="spanLeft1" class="FLOATLEFT">采购订单代码：<label id="baseOrderIdLabel"><s:property value="#request.baseOrderId"/></label></span>
            <span id="spanRight1" class="FLOATRIGHT"><a href="productManage.html" target="_blank">产品目录</a></span>
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
			            <td><input type="text" class="SMALLINPUT" id="returnNumberEdit" onkeyup="checkNumber(this)" name="<s:property value="#status.index"/> <s:property value="#element.number"/>"/></td>
			            <td id="productPriceLabel"></td>
			        </tr>
		  		</s:iterator>
        	</tbody>
        </table></td>
      </tr>
      <tr>
      	<td align="center" style="padding-bottom:15px;">
            <div class="ORDERCONTENT"><span>累计退货：<label id="productTotalPriceLabel"></label>（元）</span></div>
            <div class="ORDERCONTENT"><span>实际退货款：<input type="text" name="actualRefund" id="actualRefundEdit" onkeyup="checkRefund(this)" />（元）</span></div>
            <input type="button" id="bigRedButton" class="BIGREDBUTTON" onclick="confirmRejected()" value="确定退货" />
        </td>
      </tr>
  </table>
  <div id="DOWN">
	<input type="button" class="BUTTON" onclick="window.open('home.html','_blank')" value="返回首页"/>
</div>
</div>
</body>
</html>

