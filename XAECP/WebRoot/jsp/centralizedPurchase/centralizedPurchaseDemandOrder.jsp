<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>需求订单</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<style>
	#supply #showlist{ font-size:12px;}
</style>
</head>

<body>
<div id="supply" class="CENTER">
<div id="top">
  <h2><span style="color:#FFF;">需求订单</span></h2>
</div>

   <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
   		<thead>
	    	<tr class="TITLE" style="font-weight:bold;">
	        	<td>订单代码</td>
	            <td>采购商名称</td>
	            <td>订单状态</td>
	            <td>是否支付定金</td>
	            <td>定金（元）</td>
	            <td>运费（元）</td>
	            <td>总货款（元）</td>
	            <td>收货地址</td>
	        </tr>   		
   		</thead>
        <tbody>
		    <s:iterator id="element" value="#request.query">
	        	<tr class="HOVER">
	        		<td ><s:property value="#element.purchaseOrderId"/></td>
	          	    <td><s:property value="#element.purchaserName"/></td>  
	          	    <td>
	          	    	<s:if test="%{#element.orderState==0}">未提交</s:if>
	          	    	<s:elseif test="%{#element.orderState==1}">订单提交未支付定金</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==2}">订单提交已支付定金</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==3}">取消</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==4}">已经确认发货</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==5}">已经确认到货未支付货款</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==6}">交易完成</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==7}">申请退货</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==8}">退货收货</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==9}">退货成功</s:elseif>
	          	    	<s:else>未提交</s:else>
	          	    </td>	    
	          	    <td >
	          	    	<s:if test="%{#element.deposit < #element.totalPrice*#element.orderRate}">×</s:if>
	          	    	<s:else>√</s:else>
	          	    </td>
	          	    <td><s:property value="#element.totalPrice*#element.orderRate"/></td>
	           	    <td ><s:property value="#element.fare"/></td>
	           	    <td ><s:property value="#element.totalPrice"/></td>
					<td ><s:property value="#element.receiveAddress"/></td>
				</tr>
	        </s:iterator>                
        </tbody>
        <tr>
            <td colspan="8" align="right">
                <input type="button" class="BUTTON" value="上一页" />
                <input type="button" class="BUTTON" value="下一页" />
            </td>
        </tr>
    </table>
    
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='home.html';" />
  </div>
</div>
</body>
</html>
