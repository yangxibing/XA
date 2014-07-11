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
</head>

<body>
<jsp:include page="top.html"></jsp:include>
<div id="souSuoFather" class="SY">
<div id="souSuo" class="left">
&nbsp;帖子列表:
</div>
<div id="souSuo" class="right">
条件：
<select>
<option>帖子标题</option>
<option>帖子内容</option>
<option>发帖人</option>
</select>
关键字：
<form action="main.action" method="post">
	<input id="inputText" name="searchText" type="text"/>
	<input type="hidden" name="searchBoolean" value="OK"/>
	<input type="radio" name="JingQue"  checked="checked"/>模糊
	<input id="inputBt" type="submit" value="搜索" />
</form>
</div>
</div>

<div class="SY">
<div id="head" class="SY">
<table id="tie" cellpadding="0" cellspacing="0">
<tr>
<td id="t1">状态</td>
<td id="t2">帖子标题</td>
<td id="t3">发帖人</td>
<td id="t4">浏览数</td>
<td id="t5">回复数</td>
<td id="t6">发帖时间</td>
</tr>
</table>
</div>
			
<div id="tieCnt" class="SY">
<table id="tie" cellpadding="0" cellspacing="0">
<s:iterator id="elements" value="topics">
<tr>
<td id="t1"><img src="../../images/staus.jpg"/></td>
<td id="t2"><a href="view_topic.action?userName=<s:property value='#elements.user.name'/>&path=<s:property value="#elements.topicPath"/>">
						<s:property value='#elements.name'/></a></td>
<td id="t3"><s:property value="#elements.user.name"/></td>
<td id="t4"><s:property value="#elements.viewCount"/></td>
<td id="t5"><s:property value="#elements.replyCount"/></td>
<td id="t6"><s:property value="#elements.lastReplyTime"/></td>
</tr>
</s:iterator>
</table>
</div>
<div id="nextPage" class="SY">
<div id="nextCnt">
<ul>
<li><a href="main.action?currentPage=${pu.firstPage}&searchText=${sessionScope.searchT}">首页</a></li>
<li><a href="main.action?currentPage=${pu.prePage}&searchText=${sessionScope.searchT}">上一页</a></li>
<li><a href="main.action?currentPage=${pu.nextPage}&searchText=${sessionScope.searchT}">下一页</a></li>
<li><a href="main.action?currentPage=${pu.lastPage}&searchText=${sessionScope.searchT}">最后一页</a></li>
<li>当前第${pu.currentPage}/${pu.pageCount}页</li>
</ul>
</div>
</div>
<form action="new_topic.jsp" method="post">
		<input type="submit" value="我要发帖"></input>
</form>
<jsp:include page="footter.html"></jsp:include>

</div>

</body>
</html>
