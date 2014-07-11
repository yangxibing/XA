<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>西安印刷包装行业信息发布及集中采购网站用户注册</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<style>
	#registerHome{
		border:4px double #025FBB;
		width:1001px;
		height:255px;
		margin-top:60px;}
	#registerHome #top{
		width:1001px;
		height:37px;
		background-color:#025FBB; text-align:center; padding-top:5px;}
	#registerHome #top span{ color:#FFF; font-size:24px; font-weight:bold; vertical-align:top;}
	#registerHome .MIDDIV{
		width:333px;
		height:94px;
		margin-top:30px;
		margin-bottom:10px;
		float:left;
		border-right: 3PX double #025FBB;}
	#registerHome .MIDDIV img{float:left; margin-left:20px;}
	#registerHome .MIDDIV p{float:left;}
	#registerHome #last{ border-right-style:none;}
	#registerHome table .BORDER{ border-bottom:1px dotted #025FBB;}
	#registerHome #lastTr{ padding-top:10px;}
	
	.regTitle{ display:block; margin-bottom:5px; width:110px; text-align:center; float:left; margin-bottom:15px;}
	.regA{display:block; text-decoration:underline; width:115px; text-align:center; color:#016CD8; float:left;}
	.regA:hover{ text-decoration:underline;}

</style>
</head>

<body>
<div class="CENTER">
<div id="registerHome" class="CENTER">
<table cellpadding="0" cellspacing="0" align="center">
	<tr>
    	<td colspan="4">
        	<div id="top"> 
            	<span>用户注册</span>
			</div>
        </td>
    </tr>
    <tr>
    	<td class="BORDER">
            <div class="MIDDIV">
            <img src="../../images/purchaser.png" />
            <span class="regTitle"><br />采购商注册</span><br />
            <a class="regA" href="purchaserRegister.action">点击进入</a>
            </div>
        </td>
        <td class="BORDER">
            <div class="MIDDIV">
            <img src="../../images/supplier.png" />
           <span class="regTitle"><br />供应商注册</span><br />
            <a class="regA" href="supplierRegister.action">点击进入</a>
            </div>     	
        </td>
        <!--  
        <td class="BORDER">
            <div class="MIDDIV">
            <img src="../../images/logistics.png" />
            <span class="regTitle"><br />物流供应商注册</span><br />
            <a class="regA" href="logisticRegister.action">点击进入</a>
            </div>
        </td>
        -->
        <td class="BORDER">
            <div class="MIDDIV" id="last">
            <img src="../../images/administrator.png" />
            <span class="regTitle"><br />基地管理员注册</span><br />
            <a class="regA" href="administratorRegister.jsp">点击进入</a>
            </div>
        </td>
    </tr>
    <tr>
    	<td colspan="4" align="center" id="lastTr">
        	
                <p id="top5px">
                提示：已经注册但是没有完成注册手续的采购用户或供应商，请在首页输入<br />
                注册时的用户名和密码，登陆继续完成注册手续，不必再另外注册，如果您<br />属于上述用户，请<a href="../../home.jsp">【返回】</a>
                </p>
           
        </td>
    </tr>
</table>

</div>
</div>
</body>
</html>
