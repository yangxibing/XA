<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻/公告信息</title>

<link href="/XAECP/css/homeMore.css" rel="stylesheet" type="text/css"/>
<link href="/XAECP/css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="/XAECP/javascript/jquery-1.5.2.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		var o = document.getElementById("publishContentEdit");
		o.style.height = o.scrollTop + o.scrollHeight + "px";
	});
	
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
</script>

<style>
#newsTable{width:900px;}
#newsTable thead {font-size:14px; font-weight:bold; color:#333; }
#newsTable thead td{padding-bottom:5px; padding-top:5px;}
#publishContentEdit{ font-size:14px; color:#000;}
#newsTable tfoot{ font-size:12px; color:#333; padding-top:5px;}
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
    	<img src="/XAECP/images/logo.png" align="left" onload="fixPNG(this)"/>
    </div>
    
    <div id="lead" class="DIVTITLE">
    	<span>您当前的位置:&nbsp;&nbsp;<a href="../../home.jsp">首页</a>>新闻/公告</span>
    </div>
    <div class="DIVCNT">	
		<table id="newsTable" class="CENTER" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<td align="center" colspan="4"><s:property value="#request.news.title"/></td>
				</tr>		
			</thead>
			<tbody>
				<tr>
					<td colspan="4"><textarea id="publishContentEdit" style="width:98%;background-color:#FFF;border-width:0;color:#000;" class="LONGINPUT" readonly><s:property value="#request.news.publishContent"/></textarea></td>
				</tr>
			</tbody>
			<tfoot align="center">
				<tr>
		            <td>类型：
						<s:if test="%{#request.news.publishType==0}">新闻</s:if>
						<s:else>公告</s:else>
					</td>
					<td>浏览人次：<s:property value="#request.news.visitNumber"/></td>	
					<td>发布人：<s:property value="#request.news.publisherName"/></td>
					<td>发布时间：<s:property value="#request.news.publishDate"/></td>				
				</tr>
			</tfoot>
		</table>
    </div>
    
    <div id="copyRight" class="CENTER">
        <p align="center">西安印刷包装产业基地版权所有Copyright&copy;2011-2016</p>
        <p align="center">服务热线：029-8966866</p>
    </div>
</div>

</body>
</html>
