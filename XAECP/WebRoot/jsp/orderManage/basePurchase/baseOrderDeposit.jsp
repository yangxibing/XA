<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单支付余款</title>

<link href="../../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../../javascript/My97DatePicker/WdatePicker.js"></script>

<!-- 
 ==》从一个action跳转到此页面，需要传递三个参数：baseOrder对象、query对象（baseOrderDetail List）、goodsAddress对象
《== 从此页面跳出使用payForDepositUpdateaction，需要到后台处理支付定金的业务：第三方支付接口调用（现阶段取出定金即可）、订单状态、定金支付状态
 -->

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
	}
	
	function payForDepositBaseUpdate(){
		var baseOrderIdValue = $("#payForDepositHidden").attr("value");
		$.post($("#payForDepositBaseUpdate").attr("action"), {baseOrderId:baseOrderIdValue, async: false}, function(data){
			$("#rightDownBt").hide();
			alert("支付定金成功！");
			$("#listBaseOrder").submit();
		});
	}
</script>

<style>
	#supply #register{clear:both; display:block; background-color:#FFF; border-width:0;}
	#supply #register #registCnt{ border-width:1px;}
	.ALRIGHT{ color:#6666CD;}
	#supply #top{ text-align:left;background-color:#D5D8FD;}
	#supply #top span{ color:#000;}
	#supply #top #process{ margin-top:4px; margin-right:4px;}
	#supply #register{ padding-top:10px; }
	#supply #register #registCnt{ text-align:center; background-color:#FFF; border-right-width:0; border-bottom-width:0; margin-bottom:20px; margin-top:4px;}
	#supply #register #registCnt td{ border-width:0 1px 1px 0;}
	#supply #register #spanLeft1{margin-left:27px; margin-top:5px;}
	#supply #register #spanRight1{margin-right:25px; margin-top:15px; background-color:#EBD3C9;}
	#supply #register #borderTD{border-width:0 0 2px 0; border-style:dotted; border-color:#727BF8; margin-bottom:10px;}
	#rightDown{ margin-right:23px; margin-bottom:10px;}
	#rightDownBt{margin-right:23px; margin-bottom:10px; width:304px; height:40px; font-weight:bold;}
</style>
</head>

<body>

<form id="listBaseOrder" action="listBaseOrder.action">
	<input type="hidden" name="orderState" value="2"/>
	<input type="hidden" name="CPIId" value="<s:property value="#request.baseOrder.CPIId"/>"/>
	<input type="hidden" name="supplierId" value="<s:property value="#request.baseOrder.supplierId"/>" /> 
</form>
<form id="payForDepositBaseUpdate" action="payForDepositBaseUpdate.action">
	<input type="hidden" name="baseOrderId" id="payForDepositHidden" value="<s:property value="#request.baseOrder.baseOrderId"/>"/>
</form>

<div id="supply" class="CENTER">
    <div id="top">
      <h2><span style="width:250px; margin-left:20px;" class="FLOATLEFT">
      支付定金</span></h2>
     	 <div id="process" class="FLOATRIGHT">
            <div class="ARTLEFTDIV"><span>交易仅需四步</span></div>
            <div class="ARTDIV">
                <span>提交订单</span>
            </div>
            <div class="BLUEDIV">
                <span>支付定金</span>
            </div>
            <div class="ARTDIV">
                <span>确认到货</span>
            </div>
            <div class="ARTDIV">
                <span>支付货款</span>
            </div>
        </div>
    </div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="2px;" cellspacing="0">
          <tr class="FFF">
            <td class="ALRIGHT">采购订单代码</td>
            <td class="ALLEFT" id="baseOrderIdTd"><s:property value="#request.baseOrder.baseOrderId"/></td>
            <td class="ALRIGHT">供应商名称</td>
            <td class="ALLEFT"><s:property value="#request.baseOrder.supplierName"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">集中采购信息代码</td>
            <td class="ALLEFT"><s:property value="#request.baseOrder.CPIId"/></td>
            <td class="ALRIGHT">计划采购信息代码</td>
            <td class="ALLEFT"><s:property value="#request.baseOrder.PPIId"/></td>
          </tr>
          <tr class="FFF">
            <td class="ALRIGHT">交货日期</td>
            <td class="ALLEFT"><s:property value="#request.baseOrder.deliverDate"/></td>
            <td class="ALRIGHT">运费</td>
            <td class="ALLEFT"><s:property value="#request.baseOrder.fare"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">收货地址</td>
            <td class="ALLEFT"><s:property value="#request.goodsAddress.shippingAddress"/>&nbsp;<s:property value="#request.goodsAddress.zipCode"/>&nbsp;<s:property value="#request.goodsAddress.contacter"/>&nbsp;<s:property value="#request.goodsAddress.telephone"/></td>
            <td class="ALRIGHT">总货款</td>
            <td class="ALLEFT"><s:property value="#request.baseOrder.totalPrice"/></td>
          </tr>
        </table></td>
      </tr>
      <tr>
      	<td id="borderTD"></td>
      </tr>
      <tr>	
      	<td>
        	<span id="spanRight1" class="FLOATRIGHT"><a href="#">产品目录</a></span>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0" align="center">
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
      	<td align="right" style="padding-bottom:15px;">
            <div class="ORDERCONTENT" id="rightDown"><span>产品货款：<label id="goodsTotalPriceLabel"></label>（元）</span></div>
            <input type="button" id="rightDownBt" onclick="payForDepositBaseUpdate(this)" class="BIGREDBUTTON" value="应支付定金：<s:property value="#request.baseOrder.deposit"/>（元）" />
        </td>
      </tr>
  </table>
  <div id="DOWN">
	<input type="button" class="BUTTON" onclick="window.open('home.html','_blank')" value="返回首页"/>
</div>
</div>
</body>
</html>
