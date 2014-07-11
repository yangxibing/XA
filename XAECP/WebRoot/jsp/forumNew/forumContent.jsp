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
<link href="../../css/luntanContent.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>

<script type="text/javascript" language="javascript">    
        function displaySubMenu(li) {    
            var subMenu = li.getElementsByTagName("ul")[0];    
            subMenu.style.display = "block";
        }    
        function hideSubMenu(li) {    
            var subMenu = li.getElementsByTagName("ul")[0];    
            subMenu.style.display = "none";    
        }
		
		function setValue(){
			document.getElementById("content1").innerHTML = 
			CKEDITOR.instances.editor1.getData();
			CKEDITOR.instances.editor1.setData("");
		}

		//提交回复
		function submitBBSReply(){
			if('<s:property value="#session.bbsUserId"/>' != null && '<s:property value="#session.bbsUserId"/>' != ""){
				//用户已经登录
				var content = CKEDITOR.instances.editor1.getData();
				//$("#responseContentHidden").attr("value", content);
				//$("#addBBSSubjectReply").submit();
				var subjectIdValue = $("#bbsSubjectIdHiddenAddReply").attr("value");
				var url = $("#addBBSSubjectReply").attr("action");
				var param = {subjectId:subjectIdValue, responseContent:content, async:false};
				$.post(url, param, function(){
					var url = $("#bbsHomeReplyProcess").attr("action");
					window.location.href = url+"?subjectId="+subjectIdValue;					
				})				
			} else {
				alert("请先登录！");
				CKEDITOR.instances.editor1.setData("");
			} 			
		}

		//推荐处理
		function recommendSubject(){
			if('<s:property value="#session.bbsUserId"/>' != null && '<s:property value="#session.bbsUserId"/>' != "" && '<s:property value="#session.bbsUserType"/>' == 1){
			var subjectIdValue = $("#bbsSubjectIdHidden").attr("value");
			var url = $("#recommendSubject").attr("action");
			$.post(url, {subjectId:subjectIdValue, async:false});
			} else {
				alert("没有足够的权限！");
			}
		}
		//取消推荐处理
		function cancelRecommendSubject(){
			if('<s:property value="#session.bbsUserId"/>' != null && '<s:property value="#session.bbsUserId"/>' != "" && '<s:property value="#session.bbsUserType"/>' == 1){
				var subjectIdValue = $("#bbsSubjectIdHidden").attr("value");
				var url = $("#cancelRecommendSubject").attr("action");
				$.post(url, {subjectId:subjectIdValue, async:false});	
			} else {
				alert("没有足够的权限！");
			}			
		}

		//删除主题
		function removeSubject(param){
			if('<s:property value="#session.bbsUserId"/>' != null && '<s:property value="#session.bbsUserId"/>' != "" && '<s:property value="#session.bbsUserType"/>' == 1){
				$("#removeBBSSubject").submit();		
			} else {
				alert("没有足够的权限！");
			}
		}

		//删除主题回复
		function removeSubjectReply(param){
			if('<s:property value="#session.bbsUserId"/>' != null && '<s:property value="#session.bbsUserId"/>' != "" && '<s:property value="#session.bbsUserType"/>' == 1){
				var replyIdValue = $(param).attr("name");
				//$("#subjectResponseIdHidden").attr("value", replyId);
				//$("#removeBBSSubjectReply").submit();	
				var url = $("#removeBBSSubjectReply").attr("action");
				$.post(url, {subjectResponseId:replyIdValue, async:false}, function(){
					var url = $("#bbsHomeReplyProcess").attr("action");
					var subjectIdValue = $("#bbsSubjectIdHidden").attr("value");
					window.location.href = url+"?subjectId="+subjectIdValue;
				});					
			} else {
				alert("没有足够的权限！");
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
        	var subjectIdValue = $("#bbsSubjectIdHidden").attr("value");
			$("#bbsHomeReplyProcess").attr("action", "bbsHomeReplyProcess.action?currentPage="+currentPage+"&subjectId="+subjectIdValue);
        	$("#bbsHomeReplyProcess").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			var subjectIdValue = $("#bbsSubjectIdHidden").attr("value");
			$("#bbsHomeReplyProcess").attr("action", "bbsHomeReplyProcess.action?currentPage="+currentPage+"&subjectId="+subjectIdValue);
        	$("#bbsHomeReplyProcess").submit();
		}			
</script>
<script type="text/javascript" language="javascript" src="../../javascript/ckeditor/ckeditor.js">
</script>
</head>

<body>

<form id="submitBBSReply" action="submitBBSReply.action"></form>
<form id="recommendSubject" action="recommendSubject.action"></form>
<form id="cancelRecommendSubject" action="cancelRecommendSubject.action"></form>
<form id="bbsHomeReplyProcess" action="bbsHomeReplyProcess.action" method="post"></form>
<form id="removeBBSSubject" action="removeBBSSubject.action">
	<input type="hidden" name="subjectId" id="bbsSubjectIdHidden" value="<s:property value="#request.bbsSubject.subjectId"/>"/>
</form>
<form id="removeBBSSubjectReply" action="removeBBSSubjectReply.action">
	<input type="hidden" name="subjectId" id="bbsSubjectIdHiddenRemoveReply" value="<s:property value="#request.bbsSubject.subjectId"/>"/>
	<input type="hidden" name="subjectResponseId" id="subjectResponseIdHidden" value=""/>	
</form>
<form id="addBBSSubjectReply" action="addBBSSubjectReply.action" method="post">
	<input type="hidden" name="subjectId" id="bbsSubjectIdHiddenAddReply" value="<s:property value="#request.bbsSubject.subjectId"/>"/>
	<input type="hidden" name="responseContent" id="responseContentHidden" value=""/>	
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
        <div id="lead">
        	<span class="FLOATLEFT">
            	当前位置：<a href="../../home.jsp">首页</a>><a href="forumHome.jsp">论坛首页</a>><span><s:property value="#request.bbsSubject.subjectTitle"/></span> &nbsp;&nbsp; <a href="#replyHref">回复</a>
            </span>
            <span class="FLOATRIGHT">
            	<ul class="fatherList">
                	<li onmouseover="displaySubMenu(this)" onmouseout="hideSubMenu(this)"><a href="#">管理菜单</a>
                    	<ul class="subList">
                            <li><a onclick="recommendSubject()" href="#">推荐</a></li>
                            <li><a onclick="cancelRecommendSubject()" href="#">取消推荐</a></li>
                            <li><a href="#" onclick="removeSubject(this)">删除</a></li>
                        </ul>
                    </li>
                </ul>
            </span>
        </div>
        
    	<div id="bbsSubjectInfoTable">
	        <table class="FORUM">
	        	<tr>
	            	<td rowspan="3" class="forumInfo">
	                	<div id="userInfo">
	                    	<img src="../../images/head.gif" />
	                    	<p><s:property value="#request.bbsSubject.subjectCreator"/></p>
	                    </div>
	                </td>
	                <td class="forumTitle">
	                	<span class="FLOATLEFT">
	                    	发表于：<s:property value="#request.bbsSubject.subjectCreatTime.substring(0,19)"/>
	                    </span>
	                    <span class="LOUZHU">
	                    	楼主
	                    </span>
	                </td>
	            </tr>
	            <tr>
	            	<td class="forumContent">
	                	<s:property escape="false" value="#request.bbsSubject.subjectContent"/>
	                </td>
	            </tr>
	            <tr>
	            	<td class="forumFoot">
	                	<span class="FLOATLEFT">
	                    	回复次数:<label id="replyNumberCountLabel"><s:property value="#request.bbsSubject.responseNumber"/></label>
	                    </span>
	                    <span class="FLOATRIGHT">
	                    	<ul>
	                            <li><a href="#" onclick="removeSubject(this)">删除</a></li>
	                            <li class="LASTLI"><a href="#">TOP</a></li>
	                        </ul>
	                    </span>
	                </td>
	            </tr>
	        </table>
        </div>

		<div id="bbsSubjectReplyTable">
			<s:iterator id="element" value="#request.list" status="status">
		        <table class="FORUM">
		        	<tr>
		            	<td rowspan="3" class="forumInfo">
		                	<div id="userInfo">
		                    	<img src="../../images/head.gif" />
		                        <p><s:property value="#element.responser"/></p>
		                    </div>
		                </td>
		                <td class="forumTitle">
		                	<span class="FLOATLEFT">
		                    	回复于：<s:property value="#element.responseTime.substring(0,19)"/>
		                    </span>
		                    <span class="FLOATRIGHT">
		                    	#<s:property value="#status.count+(#request.currentPage-1)*20"/>楼
		                    </span>
		                </td>
		            </tr>
		            <tr>
		            	<td class="forumContent">
		                	<s:property escape="false" value="#element.responseContent"/>
		                </td>
		            </tr>
		            <tr>
		            	<td class="forumFoot">
		                    <span class="FLOATRIGHT">
		                    	<ul>
		                            <li><a href="#" name="<s:property escape="false" value="#element.subjectResponseId"/>" onclick="removeSubjectReply(this)">删除</a></li>
		                            <li class="LASTLI"><a href="#">TOP</a></li>
		                        </ul>
		                    </span>
		                </td>
		            </tr>
		        </table>		
			</s:iterator>
		</div>
		<div id="nextPage" class="CENTER">
        	<span><a href="#" onclick="prePage();">上一页</a>&nbsp;&nbsp;<a href="#" onclick="nextPage();">下一页</a>&nbsp;&nbsp;第<span id="currentPageTag"><s:property value="#request.currentPage"/></span>页&nbsp;&nbsp;共<span id="totalPageTag"><s:property value="#request.totalPage"/></span>页</span>
        </div>
    </div>
    <table class="CENTER" id="response">
    	<tr>
    		<td><span class="FLOATLEFT">回帖内容</span></td>
        </tr>
    
    	<tr>
        	<td><a name="replyHref"></a>
                <textarea  rows="5" cols="10" name="editor1"></textarea>
                <script type="text/javascript" language="javascript">
                    CKEDITOR.replace("editor1",
                    {
                        toobar:'Basic',
                        uiColor:'#DEF'
                    });
                </script>
             </td>
         </tr>
         <tr>
         	<td><input type="button" class="BUTTON" onclick="submitBBSReply();"  value="提交回复"/></td>
         </tr>
    </table>
    
    <div id="copyRight" class="CENTER">
        <p align="center">西安印刷包装产业基地版权所有Copyright&copy;2011-2016</p>
        <p align="center">服务热线：029-8966866</p>
    </div>
</div>
</body>
</html>

