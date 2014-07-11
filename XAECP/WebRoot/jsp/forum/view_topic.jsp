<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="css/post.css"/>
<link type="text/css" rel="stylesheet" href="css/main.css"/>
<title>无标题文档</title>
</head>

<body>

<jsp:include page="top.html"></jsp:include>
  	<div >
  		
 <div class="LunTan">
	<table id="test" cellspacing="0" cellpadding="0">
		<tr>
			<td id="left" rowspan="3" class="background">
				<div id="leftInfo">
					<img src="<%=application.getRealPath("/content/") %>${topic.user.imagePath}" width="100px" height="100px"/>
					<p id="userName" align="left">作者:<b><s:property value="topic.user.name"/></p>
					<p align="left">等级：12</p>
				</div>
			</td>
			<td id="rightTop">
				<div class="left">
					<span >浏览: <s:property value="topic.viewCount"/></span>
					<span>&nbsp;&nbsp;&nbsp; 发表时间:<s:property value="topic.postTopicTime"/></span>
				</div>
				<div class="right">
					<span>楼主&nbsp;</span>
				</div>
			</td>
		</tr>
		<tr>
			<td id="center">
				<div id="cnt"><jsp:include page="${topicURL}"></jsp:include></div>
			</td>
		</tr>
		<tr>
			<td id="rightBottom" class="background">
				<div id="touPiao" class="right">
					<ul>
						<li><a href="#">对我有用</a></li>
						<li><a href="#">丢个板砖</a></li>
						<li class="border"><a href="#">引用</a></li>
						<li class="border"><a href="#">举报</a></li>
						<li class="border"><a href="#">管理</a></li>
						<li><a href="#">TOP</a></li>
					</ul>
				</div>
			</td>
		</tr>
	</table>
</div>
  		
  		
<s:iterator id="review" value="reviews" status="status">
<div class="LunTan">
	<table id="test" cellspacing="0" cellpadding="0">
		<tr>
			<td id="left" rowspan="3" class="background">
				<div id="leftInfo">
					<img src="images/lufei.jpg" />
					
					<p align="left">等级：12</p>
				</div>
			</td>
			<td id="rightTop">
				<div class="left">
					<span>&nbsp;回复于：</span>
				</div>
				<div class="right">
					<span>#楼，得分0&nbsp;</span>
				</div>
			</td>
		</tr>
		<tr>
			<td id="center">
				<div id="cnt">
					<p><jsp:include page="${topicPath}${review.id}.txt" /></p>
				</div>
			</td>
		</tr>
		<tr>
			<td id="rightBottom" class="background">
				<div id="touPiao" class="right">
					<ul>
						<li><a href="#">对我有用</a></li>
						<li><a href="#">丢个板砖</a></li>
						<li class="border"><a href="#">引用</a></li>
						<li class="border"><a href="#">举报</a></li>
						<li class="border"><a href="#">管理</a></li>
						<li><a href="#">TOP</a></li>
					</ul>
				</div>
			</td>
		</tr>
	</table>
</div>
</s:iterator>

</div>

<div class="LunTan">
	<table id="test" cellspacing="0" cellpadding="0">
		<tr>
			<td id="left" rowspan="3" class="background">
				<div id="leftInfo">
					<img src="images/lufei.jpg" />
					
					<p align="left">等级：12</p>
				</div>
			</td>
		</tr>
		<tr>
			<td id="center">
				<div id="cnt">
					<p>
						<form name="postReview" action="post_review" method="post">
  						<input type="hidden" name="user" value="${param.userName}"/>
  						<input type="hidden" name="path" value="${param.path}"/>
  						${requestScope.editor}
  						<input type="submit" value="发表评论"/>
  					</form>
					</p>
				</div>
			</td>
		</tr>
	</table>
</div>
<jsp:include page="footter.html"></jsp:include>
  </body>
</html>
