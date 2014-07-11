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

<script type="text/javascript">
	function check()
	{
		var explorer = window.navigator.userAgent;
		if(explorer.indexOf("Chrome") >= 0){
			var i = 0;
			var length = window.document.getElementById("listContent1").getElementsByTagName("li").length;
			for(i;i<length;i++)
			{
				window.document.getElementById("listContent1").getElementsByTagName("li").item(i).style.display="block";
			}
			i = 0;
			length = window.document.getElementById("listContent2").getElementsByTagName("li").length;
			for(i;i<length;i++)
			{
				window.document.getElementById("listContent2").getElementsByTagName("li").item(i).style.display="block";
			}
		}
	}

	$(document).ready(function(){
		loginStateProcess();
		//获取最新帖的异步处理
		var url = $("#bbsHomeNewSubjectList").attr("action");
		$.post(url, {async:false}, bbsHomeNewSubjectListCallBack, "json");

		//获取最热帖的异步处理
		var url = $("#bbsHomeHotSubjectList").attr("action");
		$.post(url, {async:false}, bbsHomeHotSubjectListCallBack, "json");

		//版主推荐
		var url = $("#bbsHomeRecommendSubjectList").attr("action");
		$.post(url, {async:false}, bbsHomeRecommendSubjectListCallBack, "json");		
	});

	//插入最新帖列表
	function bbsHomeNewSubjectListCallBack(data){
		var str = "";
		$.each(data.ajaxNewSubjectList, function(i, value){
            str += "<li><a href=\"#\" name=\""+value.subjectId+"\" onclick=\"bbsHomeSubjectClick(this)\">"+value.subjectTitle+"</a><em>["+value.subjectCreatTime.split(" ")[0]+"]</em></li>";
		});
		$("#transactionNewCnt ul").eq(0).append(str);
		check();
	}

	//获取最热帖的异步处理
	function bbsHomeHotSubjectListCallBack(data){
		var str = "";
		$.each(data.ajaxHotSubjectList, function(i, value){
            str	+= "<li><a href=\"#\" name=\""+value.subjectId+"\" onclick=\"bbsHomeSubjectClick(this)\">"+value.subjectTitle+"</a><em>人气："+value.responseNumber+"</em></li>";
		});
		$("#transactionHotCnt ul").eq(0).append(str);
		check();
	}

	//插入近期推荐帖
	function bbsHomeRecommendSubjectListCallBack(data){
		var str = "";
		$.each(data.ajaxRecommendSubjectList, function(i, value){
			str += "<li><span><a href=\"#\" name=\""+value.subjectId+"\" onclick=\"bbsHomeSubjectClick(this)\">"+value.subjectTitle+"</a></span></li>";
		});
		$("#leftHot ul").eq(0).append(str);
	}

	//论坛首页主题点击事件
	function bbsHomeSubjectClick(param){
		var id = $(param).attr("name");
		var url = $("#bbsHomeReplyProcess").attr("action");
		window.open(url+"?subjectId="+id);		
	}



	//跳转到注册BBS页面
	function registerBBSMember() {
		window.open("forumRegister.jsp");
	}

	function BBSUserLogin() {
		var bbsuserIdValue = $("#bbsuserIdLogin").attr("value");
		var bbspasswordValue = $("#bbspasswordLogin").attr("value");
		var params = {loginAccount:bbsuserIdValue, password:bbspasswordValue, async:false};
		var url = $("#BBSUserLogin").attr("action");
		$.post(url, params, loginCallBack, "json");
	}

	function loginCallBack(data){
		if(data.loginAjaxResult == "success") {
			//成功登录
			$("#BBSUserIdLabel").text(data.bbsUserAjax.loginAccount);
			$("#BBSUserLoginModel").hide();
			$("#BBSUserLogoutModel").show();
			$("#loginStateTag").attr("value", "login");
			window.location.reload();
		} else {
			//登录不成功
			$("#BBSUserLoginModel").show();
			$("#BBSUserLogoutModel").hide();
			$("#loginStateTag").attr("value", "logout");
			alert("请检查登录信息后重新登录！");
		}
	}

	//用户退出
	function BBSUserLogout() {
		var url = $("#BBSUserLogout").attr("action");
		$.post(url, {async:false}, function(data) {
			if(data.logoutAjaxResult == "SUCCESS") {
				$("#userIdLogin").attr("value", "");
				$("#passwordLogin").attr("value", "");
				$("#BBSUserLoginModel").show();
				$("#BBSUserLogoutModel").hide();
				$("#loginStateTag").attr("value", "logout");
				window.location.reload();
			}		
		}, 'json');
	}

	//处理登录状态
	function loginStateProcess(){
		if('<s:property value="#session.bbsUserId"/>' != null && '<s:property value="#session.bbsUserId"/>' != ""){
			//用户已经登录
			$("#BBSUserLoginModel").hide();
			$("#BBSUserLogoutModel").show();
			$("#loginStateTag").attr("value", "login");				
		} else {
			//用户未登录
			$("#BBSUserLoginModel").show();
			$("#BBSUserLogoutModel").hide();
			$("#loginStateTag").attr("value", "logout");
		}
	}

	function bbsSubjectSearch(){
		var str = $("#searchInput").attr("value");
		$("#bbsSubjectSearchInput").attr("value", str);
		$("#bbsSubjectSearch").submit();
	}

</script>
</head>

<body>

<input type="hidden" id="loginStateTag" value="logout" />
<form id="bbsHomeNewSubjectList" action="bbsHomeNewSubjectList.action"></form>
<form id="bbsHomeHotSubjectList" action="bbsHomeHotSubjectList.action"></form>
<form id="bbsHomeRecommendSubjectList" action="bbsHomeRecommendSubjectList.action"></form>
<form id="bbsHomeReplyProcess" action="bbsHomeReplyProcess.action"></form>
<form id="BBSUserLogin" action="BBSUserLogin.action"></form>
<form id="BBSUserLogout" action="BBSUserLogout.action"></form>
<form id="bbsSubjectSearch" action="bbsSubjectSearch.action" method="post">
	<input type="hidden" name="subjectTitle" id="bbsSubjectSearchInput" value=""/>
</form>

<div id="whole" class="CENTER">
<!--[if !IE]>-------------------------------------<![endif]-->
    <table id="login" cellpadding="0" cellspacing="0" class="CENTER">
        <tr>
            <td align="left" id="loginLeft">西安印刷包装行业信息发布及集中采购网站</td>
            
            <td align="right">
            	<div id="BBSUserLoginModel">
	            	用户名：<input id="bbsuserIdLogin" type="text" class="HOMETEXT"/>
	           	 	密码：     <input id="bbspasswordLogin" type="password" class="HOMETEXT" />
			            <input onclick="BBSUserLogin()" type="button" class="HOMEBUTTON" value="登录" />
			            <input type="button" class="HOMEBUTTON" onclick="registerBBSMember()" value="注册BBS用户" />
			            <input type="button" class="HOMEBUTTON" value="忘记密码？" />
	            </div>
	            <div id="BBSUserLogoutModel">
	            	您好账号：<label id="BBSUserIdLabel"><s:property value="#session.bbsUserId"/></label>&nbsp;&nbsp;&nbsp;&nbsp;
	            	<input onclick="BBSUserLogout()" type="button" class="HOMEBUTTON" value="退出" />
	            </div>
            </td>
        </tr>
    </table>
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
               <input id="searchButton" type="button" onclick="bbsSubjectSearch();" value="搜索" class="BUTTON"/>
            </div>
            
            <img id="adv1" src="../../images/adv4.jpg" />
         <!--[if !IE]>-------------------------------------<![endif]-->  
           
            <div id="left1" class="DIVTITLE">
                <span class="TITLELEFTSPAN">版主推荐</span>
            </div>
            <div id="leftHot" class="DIVCNT">
            	<ul id="tieList">
            	<!-- 
                	<li><span><a href="forumContent.html">XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</a></span></li>
                    <li><span><a href="forumContent.html">XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</a></span></li>
                    <li><span><a href="forumContent.html">XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</a></span></li>
                -->
                </ul>
            </div>
        </div>
        <div id="right">
            <div id="transaction" class="DIVTITLE">
                <span class="TITLELEFTSPAN">&nbsp;论坛讨论区</span>
            </div>
            <div id="transactionNew" class="SMALLTITLE">
                <span class="FLOATLEFT">&nbsp;最新贴</span>
                <span class="FLOATRIGHT"><a href="forumList.jsp?type=0">更多</a>&nbsp;</span>
            </div>
            <div id="transactionHot" class="SMALLTITLE">
                <span class="FLOATLEFT">&nbsp;最热帖</span>
                <span class="FLOATRIGHT"><a href="forumList.jsp?type=1">更多</a>&nbsp;</span>
            </div>
            <div id="transactionNewCnt" class="SMALLCNT">
            	<ul id="listContent1" class="listContent">
            	<!-- 
                    <li><a href="#">XXXXXXXXXXXXXXXXXXXXX</a><em>[2011-11-11]</em></li>
                    <li><a href="#">XXXXXXXXXXXXXXXXXXXXX</a><em>[2011-11-11]</em></li>
                    <li><a href="#">XXXXXXXXXXXXXXXXXXXXX</a><em>[2011-11-11]</em></li>
                    <li><a href="#">XXXXXXXXXXXXXXXXXXXXX</a><em>[2011-11-11]</em></li>
                -->
        		</ul> 
            </div>
            <div id="transactionHotCnt" class="SMALLCNT">
            	<ul id="listContent2" class="listContent">
            	<!-- 
                    <li><a href="#">XXXXXXXXXXXXXXXXXXXXX</a><em>[2011-11-11]</em></li>
                    <li><a href="#">XXXXXXXXXXXXXXXXXXXXX</a><em>[2011-11-11]</em></li>
                    <li><a href="#">XXXXXXXXXXXXXXXXXXXXX</a><em>[2011-11-11]</em></li>
                    <li><a href="#">XXXXXXXXXXXXXXXXXXXXX</a><em>[2011-11-11]</em></li>
                -->    
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
