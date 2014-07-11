<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改密码</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>

<script type="text/javascript">
	//修改密码
function modifyPassword(){
	if('<s:property value="#session.userId"/>' != null && '<s:property value="#session.userId"/>' != ""){
		var passwordValue = $("#passwordEdit").attr("value");
		var newPasswordValue = $("#newPasswordEdit").attr("value");
		var params = {password:passwordValue, newPassword:newPasswordValue, async:false};
		var url = $("#modifyPassword").attr("action");
		$.post(url, params, function(data){
			if(data.passwordModify == "ORIGNALERROR"){
				alert("旧密码错误！");
			} else if(data.passwordModify == "SUCCESS"){
				alert("修改密码成功！");
				$("input:password").attr("value", "");
			}
		}, 'json');
	}
} else {
	alert("您尚未登录，请登录后再修改密码！");
}
</script>

<style>
#supply{ width:500px;}
#supply #top{ width:500px;}
#supply #DOWN{ width:500px;}
#supply #changePwd{clear:both; width:400px; height:140px; border:2px groove #8DC6FE;}
#supply #changePwd img{ float:left; margin-left:10px; margin-top:10px;}
#supply #changePwd table{ margin-top:40px;}
#supply #button{ width:500px; text-align:center; margin-top:5px;}
</style>
</head>

<body>
<form id="modifyPassword" action="modifyPassword.action"></form>

<div id="supply" class="CENTER">
    <div id="top">
    	<span><h2>修改密码</h2></span>
    </div>
    
	<div id="changePwd" class="CENTER">
    	<img src="../../images/changePwd.png" />
        <table cellspacing="2px" cellpadding="2px">
        	<tr>
            	<td align="right">当前密码:</td>
                <td align="left"><input name="" id="passwordEdit" type="password" class="SMALLINPUT" /></td>
            </tr>
            <tr>
            	<td align="right">新密码：</td>
                <td align="left"><input name="" id="newPasswordEdit" type="password" class="SMALLINPUT" /></td>
            </tr>
            <tr>
            	<td align="right">确认密码：</td>
                <td align="left"><input name="" id="confirmPasswordEdit" type="password" class="SMALLINPUT" /></td>
            </tr>
        </table>
    </div>
	
    <div id="button">
    	<input onclick="modifyPassword()" type="button" class="BUTTON" value="修改" />
        <input type="button" class="BUTTON" value="取消" />
    </div>
	
	<div id="DOWN">
		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../home.html';" />
	</div>
</div>
</body>
</html>
