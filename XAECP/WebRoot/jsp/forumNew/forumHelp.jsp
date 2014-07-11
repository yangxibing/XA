<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>论坛</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/luntanHome.css" rel="stylesheet" type="text/css"/>

<script language="javascript" type="text/javascript">
function check()
{
	var explorer = window.navigator.userAgent;
	if(explorer.indexOf("Chrome") >= 0){
		var i = 0;
		var length = window.document.getElementById("listMore").getElementsByTagName("li").length;
		for(i;i<length;i++)
		{
			window.document.getElementById("listMore").getElementsByTagName("li").item(i).style.display="block";
		}
	}
	}
window.onload = check;
</script>

<style>
#left{ margin-right:5px;}
#transactionCnt{ float:right; background-color:#FFF; width:798PX; height:250px;margin-bottom:4px; border: solid #A0CFFE; border-width:0 1px 1px 1px; height:510px; padding-top:3px;}

#foot {width:800px; text-align:right;}
#foot ul{ list-style-type:none; clear:both; text-align:right; float:right; width:200px; margin-bottom:10px;}
#foot ul li{ float:left; padding-left:5px; padding-right:5px;}
#foot ul li a{ color:#0060BF;}
#foot ul li a:hover{ color:#F60; text-decoration:underline;}

#listMore{ list-style-image:url(../../images/contentMark.jpg); padding-left:30px; width:760PX;}
#listMore li{ width:760PX; clear:both; line-height:20px; height:20px; vertical-align:top;margin-bottom:4px; border-bottom:1px dotted #ccc;}
#listMore li a { display:block; width:650PX; float:left; height:20px; vertical-align:top;overflow:hidden;text-overflow:ellipsis; white-space:nowrap;}
#listMore em{ width:90px; float:right; line-height:20px; height:20px; vertical-align:top; font-size:12px; font-style:normal;}

#right{width:1003px;}
#transaction{width:1001px;}
#transactionCnt{width:1001px;}
.SPAN12PX{ color:#000;}
.PTITLE{ padding-left:30px; font-size:12px; font-weight:bold; margin-top:30px;}
.PCNT{ padding-left:30px;font-size:12px; font-weight:normal;}
</style>

</head>

<body>
<div id="whole" class="CENTER">
    <div id="logo" class="CENTER">
    	<img src="../../images/luntan.jpg" align="left"/>
    </div>
<!--[if !IE]>-------------------------------------<![endif]-->
    <div id="daoHang" class="CENTER">   
        <ul id="navigation">
            <li>2012年12月12日 星期日</li>     
            <li><a href="#">基地首页</a></li>
            <li><a href="forumHome.html">论坛首页</a></li>
            <li><a href="#">新手须知</a></li>
            <li><a href="forumPublic.html">我要发帖</a></li>
        </ul> 
    </div>
    
    <div id="content" class="CENTER">
        <div id="right">
            <div id="transaction" class="DIVTITLE">
                <span class="TITLELEFTSPAN">&nbsp;当前位置：<a href="../../home.jsp">首页</a>><a href="forumHome.jsp">论坛首页</a>><span class="SPAN12PX">新手须知</span></span>
            </div>
            <div id="transactionCnt">
            	<p class="PTITLE">1、如何注册论坛ID？</p>
                <p class="PCNT">点击<a href="forumHome.jsp">论坛首页</a>右上方的”注册BBS用户“按钮或者点击<a href="forumRegister.jsp">这里</a>进行注册。</p>
                <p class="PTITLE">2、如何登录论坛？</p>
                <p class="PCNT">如果您已经注册成为该论坛的会员，那么您只要在论坛首页右上角的输入框中输入您的用户名和密码，点击”登录“按钮即可完成登录。</p>
                <p class="PTITLE">3、如何发帖？</p>
                <p class="PCNT">已经登录论坛的用户通过点击菜单中的”我要发帖“进入发帖页面，用户填写内容后，单击”发表帖子“按钮即可完成发帖。</p>
                <p class="PTITLE">4、发帖标题长度限制</p>
                <p class="PCNT">发帖标题最大长度不得超过40个字符。</p>
                <p class="PTITLE">5、如何回帖？</p>
                <p class="PCNT">已经登录论坛的用户，进入帖子内容页面后，单击页面顶部的”回复“链接跳转到页面底部的文本编辑框，在编辑框中的输入要回复的内容，然后单击”提交回复“即可完成回帖。</p>
                <p class="PTITLE">6、如何搜索？</p>
                <p class="PCNT">在论坛页面左侧栏的搜索输入框中输入所要搜索的信息，然后单击“搜索”按钮，即可跳转到满足搜索条件的搜索结果页面。</p>
            </div>  
        </div>
    </div>
    
    <div id="copyRight" class="CENTER">
        <p align="center">西安印刷包装产业基地版权所有Copyright&copy;2011-2016</p>
        <p align="center">服务热线：029-8966866</p>
    </div>
</div>
</body>
</html>
