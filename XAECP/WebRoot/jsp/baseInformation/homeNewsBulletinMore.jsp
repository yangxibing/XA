<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>西安印刷包装行业信息发布及集中采购网站</title>

<link href="/XAECP/css/homeMore.css" rel="stylesheet" type="text/css"/>
<link href="/XAECP/css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="/XAECP/javascript/jquery-1.5.2.min.js"></script>

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
	var explorer = window.navigator.userAgent;
	if(explorer.indexOf("Chrome") >= 0){
		var i = 0;
		var length = window.document.getElementById("content").getElementsByTagName("li").length;
		for(i;i<length;i++)
		{
			window.document.getElementById("content").getElementsByTagName("li").item(i).style.display="block";
		}
	}
}

$(document).ready(function(){
	check();	
});

        //分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#homeNewsBulletinMore").attr("action", "homeNewsBulletinMore.action?currentPage="+currentPage);
        	$("#homeNewsBulletinMore").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
        	$("#homeNewsBulletinMore").attr("action", "homeNewsBulletinMore.action?currentPage="+currentPage);
        	$("#homeNewsBulletinMore").submit();
		} 

</script>

</head>
<body>

<form id="homeNewsBulletinMore" action="homeNewsBulletinMore.action" method="post"></form>

<div id="whole" class="CENTER">
<!--[if !IE]>-------------------------------------<![endif]-->
    <div id="login">
    	<span>西安印刷包装行业信息发布及集中采购网站</span>
    </div>
<!--[if !IE]>-------------------------------------<![endif]-->
    <div id="logo" class="CENTER">
    	<img src="/XAECP/images/logo.png" align="left" onload="fixPNG(this)"/>
    </div>
    
    <div id="lead" class="DIVTITLE">
    	<span>您当前的位置:&nbsp;&nbsp;<a href="../../home.jsp">首页</a>>新闻/公告</span>
    </div>
    <div class="DIVCNT">	
    	<ul id="content">
    		<s:iterator id="element" value="#request.query">
    			<li>
    				<a href="jsp/baseInformation/queryNewsBulletinInfo.action?id=<s:property value="#element.id"/>">
    					<s:if test="%{#element.publishType==0}">【新闻】</s:if><s:else>【公告】</s:else>
    					<s:property value="#element.title"/>
    				</a>
    				<em>[<s:property value="#element.publishDate"/>]</em>
    			</li>
    		</s:iterator>
        </ul> 
    </div>
    <div id="next" class="CENTER">
        <span><a href="#" onclick="prePage();">上一页</a><a href="#" onclick="nextPage();">下一页</a>第<span id="currentPageTag"><s:property value="#request.currentPage"/></span>页&nbsp;共<span id="totalPageTag"><s:property value="#request.totalPage"/></span>页</span> 
    </div>
    
    <div id="copyRight" class="CENTER">
        <p align="center">西安印刷包装产业基地版权所有Copyright&copy;2011-2016</p>
        <p align="center">服务热线：029-8966866</p>
    </div>
</div>
</body>
</html>
