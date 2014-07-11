<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>西安印刷包装行业信息发布及集中采购网站供应商注册</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script type="text/javascript">
	function passwordFindBack(){
		
		var url = "passwordFindBack.action";
		var params = {userId:$("#userId").attr("value"), email:$("#email").attr("value")};
		$.post(url, params, function(data){
			alert(data.passwordFindBackAjax);
		});
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
table { margin:0; padding:0;margin-top:20px;}
h1{ margin:0; padding:0;}
#table{ width:1003px; margin-top:20px; margin-bottom:10px;}
#sky #input{ margin-left:auto; margin-right:auto; padding-top:2px;}
#title{
	margin-top:5px; text-align:center;
	background-image:url(../images/registBg.png);
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
	background-image:url(../images/cpyBg.png); 
	background-repeat:repeat-x;}
#copyRight p{ margin:0; padding:0;}
.TITLESPAN1{ float:left;}
.TITLESPAN2{ float:left; margin-top:15px; margin-left:5px;}
#input{ background-color:#E8F3FF; border:solid #ACD6FF; border-width:2px 2px 0 0; margin-bottom:5px; width:400px;}
#input td{border:solid #ACD6FF; border-width: 0 0 2px 2px; }
#button{ width:1001px; text-align:center; margin-bottom:15px;}
</style>
</head>

<body>
<div class="CENTER" id="sky">
<div class="CENTER" id="title">
	<div class="CENTER" id="titleCnt">
	<span class="TITLESPAN1"><h1>密码找回</h1></span><span class="TITLESPAN2">注：<font color="#FF0000">*</font>为必填项</span>
    </div>
</div>
<div id="table">
<table align="center"  cellpadding="2px" cellspacing="0" id="input">
	<tr>
    	<td class="RIGHT">登录账号：</td>
        <td class="LEFT"><input id="userId" type="text" /><font color="#FF0000">*</font></td>
    </tr>
    <tr>
    	<td class="RIGHT">注册邮箱：</td>
        <td class="LEFT"><input id="email" type="text" /><font color="#FF0000">*</font></td>
    </tr>
</table>
</div>

	<div id="button" class="CENTER">
    	<input type="button" onclick="passwordFindBack()"  class="BUTTON" value="提交" />
        <input type="reset"  class="BUTTON" value="重置" />
        <input type="button" class="BUTTON" value="取消" onclick="javascript:window.location='../../home.jsp';"/>
    </div>

<div id="copyRight" class="List">
<p align="center">西安印刷包装产业基地版权所有&copy;
2011-2016 </p>
<p align="center">客户服务热线：029-8666866</p>
</div>

</div>
</body>
</html>
