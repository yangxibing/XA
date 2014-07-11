<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>物流供应商目录查看</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/control/scripts/eye-base.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/control/scripts/eye-all.js"></script>
<script type="text/javascript"> 

$().ready(function(){
	$("#year option").each(function(){
		if($(this).attr("value") == $("#yearConvertHidden").attr("value")){
			$(this).attr("selected", true);
		}
	});
	$("#orderType option").each(function(){
		if($(this).attr("value") == $("#orderTypeConvertHidden").attr("value")){
			$(this).attr("selected", true);
		}		
	});
	$("#partnerName").attr("value", $("#partnerNameConvertHidden").attr("value"));
});
		
		function displayRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
</script>
</head>

<body>

<input type="hidden" id="yearConvertHidden" value="<s:property value="#request.year"/>"/>
<input type="hidden" id="orderTypeConvertHidden" value="<s:property value="#request.orderType"/>"/>
<input type="hidden" id="partnerNameConvertHidden" value="<s:property value="#request.partnerName"/>"/>

<div id="supply" class="CENTER">
<div id="top">
  <span style="color:#FFF;"><h2>报表统计</h2></span>
</div>
    <form action="reportAnalysis.action" id="reportAnalysis" method="post">
	    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
	    	<tr class="TITLE">
	            <td><span class="TITLESPAN1">组合条件查询</span></td>
	            <td colspan="6"></td>       
	        </tr>
	        <tr>
	        	<td class="BORDER" align="right">选择年份</td>
	            <td class="BORDER">
	            	<select name="year" id="year">
	            		<option value="">--请选择--</option>
	            		<option value="2011">2011年</option>
	            		<option value="2012">2012年</option>
	            		<option value="2013">2013年</option>
	            		<option value="2014">2014年</option>
	            		<option value="2015">2015年</option>
	            		<option value="2016">2016年</option>
	            		<option value="2017">2017年</option>
	            		<option value="2018">2018年</option>
	            		<option value="2019">2019年</option>
	            		<option value="2020">2020年</option>
	            		<option value="2021">2021年</option>
	            	</select>
	            </td>
	            <td class="BORDER" align="right">选择订单类型</td>
	            <td class="BORDER">
	            	<select name="orderType" id="orderType">
	            		<option value="0">对供应商订单</option>
	            		<option value="1">对采购商订单</option>
	            	</select>
	            </td>
	            <td class="BORDER" align="right">合作伙伴名称</td>
	            <td class="BORDER">
	                <input type="text" name="partnerName" id="partnerName"  class="INPUTTEXT"/>
	            </td>
	            <td colspan="2" align="right" class="BORDER">
	            	<input type="submit" class="BUTTON" value="查询" />
	                <input type="button" onclick="resetButtonClick()"  class="BUTTON" value="清空" />
	            </td>
	        </tr>
	    </table>
    </form>
    
    
    <form action="editLogistics.action" method="post" id="editLogistics">
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE" style="font-weight:bold;">
            <td>月份</td>
            <td>订单总量</td>
            <td>订单总金额</td>
        </tr>
        
        <s:iterator id="element" value="#request.query">
	        <tr class="HOVER">
	            <td><s:property value="#element.monthNo"/></td>
	            <td><s:property value="#element.orderCount"/></td>
	            <td><s:property value="#element.totalAmount"/>元</td>
	        </tr>
        </s:iterator>
    </table>    
    </form>
  
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
