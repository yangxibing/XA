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
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>

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
</style>

<script type="text/javascript">
	$(document).ready(function(){		
		//版主推荐
		var url = $("#bbsHomeRecommendSubjectList").attr("action");
		$.post(url, {async:false}, bbsHomeRecommendSubjectListCallBack, "json");	
		check();	
	});

	//插入近期推荐帖
	function bbsHomeRecommendSubjectListCallBack(data){
		var str = "";
		$.each(data.ajaxRecommendSubjectList, function(i, value){
			str += "<li><span><a href=\"#\" name=\""+value.subjectId+"\" onclick=\"bbsHomeSubjectClick(this)\">"+value.subjectTitle+"</a></span></li>";
		});
		$("#leftHot ul").eq(0).append(str);
	}

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

	//论坛首页主题点击事件
	function bbsHomeSubjectClick(param){
		var id = $(param).attr("name");
		var url = $("#bbsHomeReplyProcess").attr("action");
		window.open(url+"?subjectId="+id);		
	}

    //分页处理
    function prePage(){
    	var currentPageValue = Number($("#currentPageTag").text());
    	var totalPage = Number($("#totalPageTag").text());
    	if(currentPageValue<=1){
    		return false;
    	}
    	currentPageValue = currentPageValue - 1;
    	$("#bbsSubjectSearch").attr("action", "bbsSubjectSearch.action?currentPage="+currentPageValue);
    	$("#bbsSubjectSearch").submit();
    }

	function nextPage(){
    	var currentPageValue = Number($("#currentPageTag").text());
    	var totalPage = Number($("#totalPageTag").text());
    	if(currentPageValue >= totalPage){
    		return false;
    	}
    	currentPageValue = currentPageValue + 1;
    	$("#bbsSubjectSearch").attr("action", "bbsSubjectSearch.action?currentPage="+currentPageValue);
    	$("#bbsSubjectSearch").submit();
	}

	function bbsSubjectSearch(){
		var str = $("#searchInput").attr("value");
		$("#bbsSubjectSearchInput").attr("value", str);
		$("#bbsSubjectSearch").submit();
	}			
</script>

</head>

<body>

<form action="bbsMore"></form>
<form id="bbsHomeRecommendSubjectList" action="bbsHomeRecommendSubjectList.action"></form>
<form id="bbsMoreNewSubjectList" action="bbsMoreNewSubjectList.action" method="post"></form>
<form id="bbsMoreHotSubjectList" action="bbsMoreHotSubjectList.action" method="post"></form>
<form id="bbsHomeReplyProcess" action="bbsHomeReplyProcess.action"></form>
<form id="bbsSubjectSearch" action="bbsSubjectSearch.action" method="post">
	<input type="hidden" name="subjectTitle" id="bbsSubjectSearchInput" value="<s:property value="#request.title"/>"/>
</form>

<div id="whole" class="CENTER">
<!--[if !IE]>-------------------------------------<![endif]-->

<!--[if !IE]>-------------------------------------<![endif]-->
    <div id="logo" class="CENTER">
    	<img src="../../images/luntan.jpg" align="left"/>
    </div>
<!--[if !IE]>-------------------------------------<![endif]-->
    <jsp:include page="forumHeader.jsp"></jsp:include>
    
    <div id="content" class="CENTER">
    	<div id="left">
            <div id="left1" class="DIVTITLE">
                <span class="TITLELEFTSPAN">全站搜索</span>
            </div>
            <div id="left1Cnt" class="DIVCNT">
               <input id="searchInput" type="text" />
               <input id="searchButton" onclick="bbsSubjectSearch(this);" type="button" value="搜索" class="BUTTON"/>
            </div>
            
            <img id="adv1" src="../../images/adv4.jpg" />
         <!--[if !IE]>-------------------------------------<![endif]-->  
           
            <div id="left1" class="DIVTITLE">
                <span class="TITLELEFTSPAN">版主推荐</span>
            </div>
            <div id="leftHot" class="DIVCNT">
            	<ul id="tieList">
            	<!-- 
                	<li><span><a href="#">XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</a></span></li>
                    <li><span><a href="#">XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</a></span></li>
                    <li><span><a href="#">XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</a></span></li>
                -->    
                </ul>
            </div>
        </div>
        <div id="right">
            <div id="transaction" class="DIVTITLE">
                <span class="TITLELEFTSPAN">&nbsp;当前位置：<a href="../../home.jsp">首页</a>><a href="forumHome.jsp">论坛首页</a>><span id="moreTypeTag" class="TITLELEFTSPAN">搜索结果</span></span>
            </div>
            
            <div id="transactionCnt">
            	<ul id="listMore">
            		<s:iterator id="element" value="#request.query">
            			<li><a href="#" name="<s:property value="#element.subjectId"/>" onclick="bbsHomeSubjectClick(this);"><s:property value="#element.subjectTitle"/></a><em>[<s:property value="#element.subjectCreatTime.substring(0, 10)"/>]</em></li>
            		</s:iterator>
				<!-- 
                    <li><a href="#">XXXXXXXXXXXXXXXXXXXXX</a><em>[2011-11-11]</em></li>
                    <li><a href="#">XXXXXXXXXXXXXXXXXXXXX</a><em>[2011-11-11]</em></li>
                    <li><a href="#">XXXXXXXXXXXXXXXXXXXXX</a><em>[2011-11-11]</em></li>
        		-->
        		</ul> 
            </div> 
            <div id="foot">
            	<ul>
                	<li><a href="#" onclick="prePage();" >上一页</a></li>
                    <li><a href="#" onclick="nextPage();" >下一页</a></li>
                    <li>第<span id="currentPageTag"><s:property value="#request.currentPage"/></span>页</li>
                    <li>共<span id="totalPageTag"><s:property value="#request.totalPage"/></span>页</li>
                </ul>
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
