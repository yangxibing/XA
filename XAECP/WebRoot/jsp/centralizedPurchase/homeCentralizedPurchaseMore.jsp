<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>西安印刷包装行业信息发布及集中采购网站</title>

<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/homeMore.css" rel="stylesheet" type="text/css"/>
<link href="../../css/homeMoreTab.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>

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

        //分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#homeCentralizedPurchaseMore").attr("action", "homeCentralizedPurchaseMore.action?currentPage="+currentPage);
        	$("#homeCentralizedPurchaseMore").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
        	$("#homeCentralizedPurchaseMore").attr("action", "homeCentralizedPurchaseMore.action?currentPage="+currentPage);
        	$("#homeCentralizedPurchaseMore").submit();
		} 
</script>

</head>
<body>

<form id="homeCentralizedPurchaseMore" action="homeCentralizedPurchaseMore.action" method="post"></form>

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
    	<span>您当前的位置:&nbsp;&nbsp;<a href="../../home.jsp">首页</a>>集中采购信息</span>
    </div>
    <div class="DIVCNT">	
    	<table id="contentTab" cellpadding="2px" cellspacing="0" class="CENTER">
        	<tr class="TITLE">
            	<td>标题</td>
                <td>截止日期</td>
                <td>发布时间</td>                
                <td>发布人</td>
            </tr>
            <s:iterator id="element" value="#request.query">
            	<tr>
            		<td class="CNT1"><a href="jsp/centralizedPurchase/centralizedPurchaseApply.action?cpPurchaseInfoId=<s:property value="#element.cpPurchaseInfoId"/>">【<s:property value="#element.cpPurchaseInfoId"/>期集中采购】 <s:property value="#element.cpPurchaseInfoTitle"/></a></td>            		
            		<td class="CNT2">[<s:property value="#element.deadline"/>]</td>
					<td class="CNT3">[<s:property value="#element.publishDate"/>]</td>
                	<td class="CNT4"><s:property value="#element.publisherName"/></td>            		
            	</tr>
            </s:iterator>
        </table>
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
