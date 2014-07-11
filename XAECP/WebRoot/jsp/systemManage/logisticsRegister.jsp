<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>西安印刷包装行业信息发布及集中采购网站物流供应商注册</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		testJump();
	});
	function testJump(){
		if('<s:property value="#request.logisticRegisterSuccess"/>' == "SUCCESS"){
			$("#timeCountDiv").show();
			$("#button").hide();
			 function jump(count) {  
	                window.setTimeout(function(){  
	                    count--;  
	                    if(count > 0) {  
	                        $('#timeCount').attr('innerHTML', count);  
	                        jump(count);  
	                    } else {  
	                        location.href="/XAECP/home.jsp";  
	                    }  
	                }, 1000);  
	         }  
	         jump(3);  
		}
		else {
			$("#timeCountDiv").hide();
			$("#button").show();
		}
	}
</script>

<style>
body{
	margin:0;
	padding:0;
	background-color:#FFF;
	}
#sky{
	width:1003px;}
table { margin:0; padding:0;}
h1{ margin:0; padding:0;}
#table{ width:1003px; margin-top:20px;}
#sky #input{ margin-left:auto; margin-right:auto; padding-top:2px;}
#title{
	margin-top:5px; text-align:center;
	background-image:url(../../images/registBg.png);
	background-repeat:repeat-x;
	padding-top:3px; height:40px;}
#titleCnt{ width:280px; text-align:center; margin-top:20px;}
.LEFT{ text-align:left;}
.RIGHT{ text-align:right;}
#copyRight{ 
	height:25px;
	padding-top:5px;
	margin-top:8px; 
	text-align:center; 
	background-image:url(../../images/cpyBg.png); 
	background-repeat:repeat-x;}
#copyRight p{ margin:0; padding:0;}
.TITLESPAN1{ float:left;}
.TITLESPAN2{ float:left; margin-top:15px; margin-left:5px;}
#input{ background-color:#E8F3FF; border:solid #ACD6FF; border-width:2px 2px 0 0; margin-bottom:5px;}
#input td{border:solid #ACD6FF; border-width: 0 0 2px 2px; }
#button{ width:1001px; text-align:center; margin-bottom:15px;}
#timeCountDiv{ width:1000px; text-align:center;}
</style>
</head>

<body>
	<form id="logisticRegisterSubmit" action="logisticRegisterSubmit.action" method="post">
	<div class="CENTER" id="sky">
	<div class="CENTER" id="title">
		<div class="CENTER" id="titleCnt">
			<span class="TITLESPAN1"><h1>物流供应商注册</h1></span><span class="TITLESPAN2">注：<font color="#FF0000">*</font>为必填项</span>
	    </div>
	</div>
	<br /><br />
	<div id="table">
		<table align="center"  cellpadding="2px" cellspacing="0" id="input">
			<tr>
		    	<td class="RIGHT">用户账号：</td>
		        <td class="LEFT"><input name="userId" id="userIdEdit" type="text" /><font color="#FF0000">*</font></td>
		    </tr>
		    <tr>
		    	<td class="RIGHT">登录密码：</td>
		        <td class="LEFT"><input name="password" id="passwordEdit" type="text" /><font color="#FF0000">*</font></td>
		    </tr>
		    <tr>
		    	<td class="RIGHT">确认密码：</td>
		        <td class="LEFT"><input name="passwordComfirm" id="passwordComfirmEdit" type="text" /><font color="#FF0000">*</font></td>
		    </tr>
		    <tr>
		    	<td class="RIGHT">用户昵称：</td>
		        <td class="LEFT"><input name="userName" id="userNameEdit" type="text" /><font color="#FF0000">*</font></td>
		    </tr>
		    <tr>
		    	<td class="RIGHT">邮箱：</td>
		        <td class="LEFT"><input name="email" id="passwordComfirmEdit" type="text" /><font color="#FF0000">*</font></td>
		    </tr>
		    <tr>
		    	<td class="RIGHT">所属合作伙伴：</td>
		        <td class="LEFT">
		        	<select name="supplierId" id="supplierIdEdit">
		        		<option value="">--请选择--</option>
		        		<s:iterator id="element" value="#request.query">
		        			<option value="<s:property value="#element.partnerId"/>"><s:property value="#element.partnerId"/> <s:property value="#element.partnerName"/></option>
		        		</s:iterator>
		        	</select>
		        	<font color="#FF0000">*</font>
		        </td>
		    </tr>
		    <tr>
		    	<td class="RIGHT">备注：</td>
		        <td class="LEFT"><textarea name="remark" id="remarkEdit" cols ="50" rows = "3"></textarea><font color="#FF0000">*</font></td>
		    </tr>
		</table>
	</div>
	
		<div id="button" class="CENTER">
	    	<input type="submit" class="BUTTON" value="提交" />
	        <input type="reset"  class="BUTTON" value="重置" />
	        <input type="button" class="BUTTON" value="取消" onclick="javascript:window.location='../home.html';"/>
	    </div>
	    <div id="timeCountDiv" class="CENTER">您已注册成功，页面跳转中....当前还剩<span id="timeCount">3</span>秒 </div>
	
	<div id="copyRight" class="List">
	<p align="center">西安印刷包装产业基地版权所有&copy;
	2011-2016 </p>
	<p align="center">客户服务热线：029-8666866</p>
	</div>
	</div>
	</form>
</body>
</html>
