<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>西安印刷包装行业信息发布及集中采购网站</title>
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
	$("#queryAllSupplierForm").attr("action", "homeShowSupplierMore.action?currentPage="+currentPage);
	$("#queryAllSupplierForm").submit();
}

function nextPage(){
	var currentPage = Number($("#currentPageTag").text()); 	
	var totalPage = Number($("#totalPageTag").text());
	if(currentPage>=totalPage){
		return false;
	}
	currentPage = currentPage + 1;
	$("#queryAllSupplierForm").attr("action", "homeShowSupplierMore.action?currentPage="+currentPage);
	$("#queryAllSupplierForm").submit();
}
</script>

<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/homeMore.css" rel="stylesheet" type="text/css"/>
<link href="../../css/homeMoreTab.css" rel="stylesheet" type="text/css"/>
<style>
#contentTab .CNT1{width:450px;white-space:pre;overflow:hidden; text-overflow:ellipsis;}
#contentTab .CNT2{width:200px;}
#contentTab .CNT3{ width:450px;white-space:pre;overflow:hidden; text-overflow:ellipsis;}

</style>

</head>
<body>
<form action="homeShowSupplierMore.action" id="queryAllSupplierForm" method="post"></form>
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
    	<span>您当前的位置:&nbsp;&nbsp;<a href="../home.jsp">首页</a>>企业链接</span>
    </div>
    
    <div class="DIVCNT">	
    	<table id="contentTab" cellpadding="2px" cellspacing="0" class="CENTER">
           <tr class="TITLE">
            	<td>公司名称</td>
                <td>诚信级别</td>
                <td>公司网址</td>
            </tr>
            <s:iterator id="element" value="#request.query">
	        	<tr>
	        	<td class="CNT1"><a href="#"><s:property value="#element.partnerName"/></a></td>
                <td class="CNT2">
                	<s:if test="#element.integrityLevel == 5">
                		<img src="../../images/starLevel.jpg" />
                    	<img src="../../images/starLevel.jpg" />
                    	<img src="../../images/starLevel.jpg" />
                    	<img src="../../images/starLevel.jpg" />
                    	<img src="../../images/starLevel.jpg" />
                	</s:if>
                	<s:elseif test="#element.integrityLevel == 4">
                		<img src="../../images/starLevel.jpg" />
                    	<img src="../../images/starLevel.jpg" />
                    	<img src="../../images/starLevel.jpg" />
                    	<img src="../../images/starLevel.jpg" />
                	</s:elseif>
                	<s:elseif test="#element.integrityLevel == 3">
                		<img src="../../images/starLevel.jpg" />
                    	<img src="../../images/starLevel.jpg" />
                    	<img src="../../images/starLevel.jpg" />
                	</s:elseif>
                	<s:elseif test="#element.integrityLevel == 2">
                		<img src="../../images/starLevel.jpg" />
                    	<img src="../../images/starLevel.jpg" />
                	</s:elseif>
                	<s:elseif test="#element.integrityLevel == 1">
                		<img src="../../images/starLevel.jpg" />
                	</s:elseif>
                	<s:else>
                	</s:else>
                </td>        	
                <td class="CNT3"><s:property value="#element.website"/></td>
	        	</tr>
	        </s:iterator>
        </table>
    </div>
    <div id="next" class="CENTER">
       <span><a href="#" onclick="prePage();">上一页</a>&nbsp;&nbsp;<a href="#" onclick="nextPage();">下一页</a>&nbsp;&nbsp;第<span id="currentPageTag"><s:property value="#request.currentPage"/></span>页&nbsp;共<span id="totalPageTag"><s:property value="#request.totalPage"/></span>页</span> 
    </div>
    
    <div id="copyRight" class="CENTER">
        <p align="center">西安印刷包装产业基地版权所有Copyright&copy;2011-2016</p>
        <p align="center">服务热线：029-8966866</p>
    </div>
</div>
</body>
</html>
