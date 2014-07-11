<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>评标委员会专家信息查看</title>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>

<style>
	#supply #register{ clear:both; display:block; background-color:#FFF; border-width:0;}
	#supply #register .ALRIGHT{width:120px;}
	#supply #register #registCnt .ALRIGHT{width:18%;}
	#supply #register #registCnt .ALLEFT{ width:30%;}
	#supply #register #registCnt{margin-top:10px; background-color:#C0DFFE;}
	.ALRIGHT{ color:#A26D00;}
</style>
</head>

<body>
<!-- 
<form id="selectExpert" action="selectExpert">
	<input type="text" name="expertId" id="expertId" value="2008303393"/>
	<input type="submit" name="submit" value="submit" /> 
</form>
 -->

	<div id="supply" class="CENTER">
	<div id="top">
  		<span><h2>评标委员会专家信息</h2></span>
	</div>
	<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
	      <tr>
	        <td>
		        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
		          <tr>
		            <td class="ALRIGHT">专家代码&nbsp;</td>
		            <td class="ALLEFT" id="expertId"><s:property value="#request.expert.expertId" /></td>
		            <td class="ALRIGHT">出生年月&nbsp;</td>
		            <td class="ALLEFT" id="birthday"><s:property value="#request.expert.birthday" /></td>
		            <td rowspan="5" align="right" style="width:114px; height:140px;">
		            	<img src="<s:property value="#request.expert.photograph" />" style="width:114px; height:140px;" />
		            </td>
		          </tr>
		          <tr class="EEE">
		            <td class="ALRIGHT">专家姓名&nbsp;</td>
		            <td class="ALLEFT" id="expertName"><s:property value="#request.expert.expertName" /></td>
		            <td class="ALRIGHT">工作单位&nbsp;</td>
		            <td class="ALLEFT" id="workUnit"><s:property value="#request.expert.workUnit" /></td>
		          </tr>
		          <tr>
		            <td class="ALRIGHT">职称&nbsp;</td>
		            <td class="ALLEFT" id="title"><s:property value="#request.expert.title" /></td>
		            <td class="ALRIGHT">Email&nbsp;</td>
		            <td class="ALLEFT" id="email"><s:property value="#request.expert.email" /></td>
		          </tr>
		          <tr class="EEE">
		            <td class="ALRIGHT">电话&nbsp;</td>
		            <td class="ALLEFT" id="telephone"><s:property value="#request.expert.telephone" /></td>
		            <td class="ALRIGHT">传真&nbsp;</td>
		            <td class="ALLEFT" id="fax"><s:property value="#request.expert.fax" /></td>
		          </tr>
		          <tr>
		            <td class="ALRIGHT">网址&nbsp;</td>
		            <td class="ALLEFT" id="website" colspan="3"><s:property value="#request.expert.website" /></td>
		          </tr>
		          <tr style="height:40px; " class="EEE">
		            <td class="ALRIGHT">个人简况&nbsp;</td>
		            <td class="ALLEFT" id="personalProfile" colspan="4"><s:property value="#request.expert.personalProfile" />&nbsp;</td>
		          </tr>
		        </table>
		     </td>
	      </tr>
	  </table>
	  
	<div id="DOWN">
		<input type="button" class="BUTTON" onclick="window.open('../../home.jsp','_blank')" value="返回主页"/>
	</div>
	
	</div>
</body>
</html>
