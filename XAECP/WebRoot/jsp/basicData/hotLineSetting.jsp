<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>服务热线管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>

<script language="javascript">
$().ready(function(){
	var flag = '<s:property value="#request.hotLineFlag"/>';
	if(flag!=null&&flag=="yes"){
		alert("服务热线保存成功");
	}
});
</script>
<style>
#hotLineTable{width:400px;}
#supply #search{width:400px;}
</style>
</head>

<body>
<div id="supply" class="CENTER">
<div id="top">
  <span style="color:#FFF;"><h2>服务热线设置</h2></span>
</div>
<form id="hotLine" action="hotLine.action" method="post">
<table id="hotLineTable" class="CENTER">
<tr>
	<td>
    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
       <tr>
        	<td align="right" style="font:黑体; font-size:22px;">服务热线一</td>
            <td align="left"><input name="hotline1" type="text"/></td>
       </tr>
       <tr>
        	<td align="right"  style="font:黑体; font-size:22px;">服务热线二</td>
            <td align="left"><input name="hotline2" type="text"/></td>
       </tr>
       <tr>
        	<td align="right" style="font:黑体; font-size:22px;">服务热线三</td>
            <td align="left"><input name="hotline3" type="text"/></td>
       </tr>
      </table>
      </td>
</tr>
<tr align="center">
	<td><input type="submit" value="保存" class="BUTTON" />&nbsp;<input type="button" value="取消" class="BUTTON" />
    </td>     
</tr>
</table>
</form>    
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
