<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>西安印刷包装行业信息发布及集中采购网站</title>
<script language="javascript">
// 修复 IE 下 PNG 图片不能透明显示的问题
function fixPNG(myImage) {
var arVersion = navigator.appVersion.split("MSIE");
var version = parseFloat(arVersion[1]);
if ((version >= 5.5) && (version < 7) && (document.body.filters))
{
     var imgID = (myImage.id) ? "id='" + myImage.id + "' " : "";
     var imgClass = (myImage.className) ? "class='" + myImage.className + "' " : "";
     var imgTitle = (myImage.title) ? "title='" + myImage.title   + "' " : "title='" + myImage.alt + "' ";
     var imgStyle = "display:inline-block;" + myImage.style.cssText;
     var strNewHTML = "<span " + imgID + imgClass + imgTitle

   + " style=\"" + "width:" + myImage.width

   + "px; height:" + myImage.height

   + "px;" + imgStyle + ";"

   + "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"

   + "(src=\'" + myImage.src + "\', sizingMethod='scale');\"></span>";
     myImage.outerHTML = strNewHTML;
}       
}
function check()
{

}
window.onload = check;

</script>

<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/homeMore.css" rel="stylesheet" type="text/css"/>
<style>
.TITLEP{padding-left:15px; font-size:14px; font-weight:bold; margin-top:10px; color:#006CBD;}
.PTITLE{ padding-left:30px; font-size:12px; font-weight:bold; margin-top:15px;}
.PCNT{ padding-left:30px;font-size:12px; font-weight:normal;margin-bottom:15px;}
</style>
</head>
<body>
<div id="whole" class="CENTER">
<!--[if !IE]>-------------------------------------<![endif]-->
    <div id="login">
    	<span>西安印刷包装行业信息发布及集中采购网站</span>
    </div>
<!--[if !IE]>-------------------------------------<![endif]-->
    <div id="logo" class="CENTER">
    	<img src="../../images/logo.png" align="left" onload="fixPNG(this)"/>
    </div>
    
    <div id="lead" class="DIVTITLE">
    	<span>您当前的位置:&nbsp;&nbsp;<a href="../../home.jsp">首页</a>>系统帮助</span>
    </div>
    <div class="DIVCNT">
    	<p class="TITLEP">疑难解答：</p>	
    		<p class="PTITLE">1、如何注册系统用户？</p>
            <p class="PCNT">点击<a href="../../home.jsp">首页</a>右上方的”注册会员“按钮或者点击<a href="register.jsp">这里</a>进行注册。</p>
            <p class="PTITLE">2、如何登录系统？</p>
            <p class="PCNT">如果您已经注册成为该系统的会员，那么您只要在论坛首页右上角的输入框中输入您的用户名和密码，点击”登录“按钮即可完成登录。</p>
            <p class="PTITLE">3、忘记密码怎么办？</p>
            <p class="PCNT">点击<a href="../../home.jsp">首页</a>右上方的”忘记密码“按钮或者点击<a href="getBackPassword.jsp">这里</a>找回密码。</p>
            <p class="PTITLE">4、如何修改密码？</p>
            <p class="PCNT">已登录用户可以点击<a href="../../home.jsp">首页</a>右上方的”修改密码“按钮或者点击<a href="passwordModify.jsp">这里</a>修改密码；注意，只有已登录的用户才可以修改密码!</p>
            <p class="PTITLE">5、如何获得更多功能？</p>
            <p class="PCNT">注册用户会根据用户类型的不同拥有不同的功能，用户登录后，用户可以使用的功能会列在导航菜单中。</p>
            <p class="PTITLE">6、还有其他疑问？</p>
            <p class="PCNT">如果用户还有其他疑问或建议，可以拔打<a href="../../home.jsp">首页</a>上的服务热线进行咨询。</p>
    	<p class="TITLEP">常用模块介绍:</p>
    		<p class="PTITLE">1、登录模块</p>
    		<p class="PCNT">登录模块在首页的顶部，用户可直接在其中输入用户名、密码，然后点击【登陆】按钮，登陆后的效果如下图：</p>
    		<img style="width:800px; position:relative; left:40px; margin-bottom:20px;" src="../../images/systemHelp/login.jpg" />
    
    		<p class="PTITLE">2、导航菜单模块</p>
    		<p class="PCNT">导航菜单模块出现在企业LOGO下方，是用户其他功能的入口，不同用户角色类型的用户具有不同的导航菜单，管理员拥有全部功能，如下图:</p>
    		<img style="width:800px; position:relative; left:40px; margin-bottom:20px;" src="../../images/systemHelp/menu.jpg" />
    		<p class="PCNT">注意：未登录的用户，具有较少的功能，部分功能会提示用户登陆后才能拥有。登陆的用户会根据其用户类型不同，导航菜单出现不同的功能。</p>
    
    		<p class="PTITLE">3、服务热线模块</p>
    		<p class="PCNT">通过热线模块，用户可以看到西安印刷包装产业基地发展有限公司为用户提供的咨询电话，用户可以通过服务热线来了解更多情况或解决一些线下问题。</p>
    
     		<p class="PTITLE">4、价格行情模块</p>
    		<p class="PCNT">价格行情模块主要用于向用户展示印刷、包装相关产品的近期价格，以滚动的方式显示。</p>
    		
    		<p class="PTITLE">5、新闻公告模块</p>
    		<p class="PCNT">新闻公告模块用于显示行业内近期的新闻事件以及西安印刷包装产业基地发展有限公司所发表的一些公告信息，用户可以点击链接查看更详细的信息。</p>	
    		
    		<p class="PTITLE">6、集中采购模块</p>
    		<p class="PCNT">此模块用于显示近期的集中采购信息，供采购商查看；如果感兴趣，可以点击【更多】超链接查看。</p>	
    </div>
    
    <div id="copyRight" class="CENTER">
        <p align="center">西安印刷包装产业基地版权所有Copyright&copy;2011-2016</p>
        <p align="center">服务热线：029-8966866</p>
    </div>
</div>
</body>
</html>
