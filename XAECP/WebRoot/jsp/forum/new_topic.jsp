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
<title>无标题文档</title>
<%
	com.common.WebEditor.createFCKEditor(request, "600", "450");
%>
<link type="text/css" rel="stylesheet" href="../../css/post.css"/>
<link type="text/css" rel="stylesheet" href="../../css/main.css"/>
</head>
<body>
<jsp:include page="top.html"></jsp:include>
<div class="LunTan">
<div class="LunTan">
	<table id="test" cellspacing="0" cellpadding="0">
		<tr>
			<td id="left" rowspan="3" class="background">
				<div id="leftInfo">
					<img src="../../images/lufei.jpg" />
					<p align="left"><a href="upload.jsp">更换头像</a></p>
				</div>
			</td>
		</tr>
		<tr>
			<td id="center">
				<div id="cnt">
					<p>
						<form name="postReview" action="post_topic.action" method="post">
						
						标题：<input type="text" name="title" id="title" style="width: 600px" />
						</p>
						内容：
  						${requestScope.editor}
  						<input type="submit" value="发表帖子"/>
  					</form>
					</p>
				</div>
			</td>
		</tr>
			
	</table>
</div>
<jsp:include page="footter.html"></jsp:include>
</div>
</body>
</html>
