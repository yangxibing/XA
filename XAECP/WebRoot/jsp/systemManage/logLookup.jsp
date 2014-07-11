<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>日志查看</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript"> 
		$(document).ready(function(){
			var url = $("#querySearchInfo").attr("action");
			$.post(url, {async:false}, processAfterPost, "json");			
		});
		
		//后处理程序
        function processAfterPost(data){
        	insertPartnerList(data);
        	insertActorList(data);
        	recoverQueryCondition();
        }
        
        //插入合作伙伴列表
        function insertPartnerList(data){
        	var content = "<option value=\"\">--请选择--</option>";        	
        	$.each(data.partnerListAjax, function(i,value){
        		content += "<option value='" + value.partnerId + "'>" + value.partnerName + "</option>";
        	});
        	$("#partnerIdQuery").html(content);
        }
        
        //插入角色列表
        function insertActorList(data){
        	var content = "<option value=\"\">--请选择--</option>";        	
        	$.each(data.actorListAjax, function(i,value){
        		content += "<option value='" + value.actorId + "'>" + value.actorName + "</option>";
        	});
        	$("#actorIdQuery").html(content);        	
        }	
        
        //恢复查询状态
        function recoverQueryCondition(){
        	$("#userIdQuery").attr("value", '<s:property value="#request.logVO.userId"/>');
        	$("#partnerIdQuery").attr("value", '<s:property value="#request.logVO.partnerId"/>');
        	$("#actorIdQuery").attr("value", '<s:property value="#request.logVO.actorId"/>');
        	$("#beginTimeQuery").attr("value", '<s:property value="#request.logVO.beginTime"/>');
        	$("#endTimeQuery").attr("value", '<s:property value="#request.logVO.endTime"/>');
        }	

		function displayRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
        //分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#queryXAUserLogInfo").attr("action", "queryXAUserLogInfo.action?currentPage="+currentPage);
        	$("#queryXAUserLogInfo").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
        	$("#queryXAUserLogInfo").attr("action", "queryXAUserLogInfo.action?currentPage="+currentPage);
        	$("#queryXAUserLogInfo").submit();
		}
</script>

<style>
	#supply #register #registCnt .ALLEFT{ width:300px;}
	#partnerIdQuery{width:250px;}
</style>
</head>

<body>

	<form id="querySearchInfo" action="querySearchInfo.action"></form>

	<div id="supply" class="CENTER">
		<div id="top">
		  <span><h2>日志查看</h2></span>
		</div>
		
		<form id="queryXAUserLogInfo" action="queryXAUserLogInfo.action" method="post">		
		    <table id="search" class="CENTER" cellspacing="0" cellpadding="2px">
		    	<tr class="TITLE">
		        	<td><span class="TITLESPAN1">组合条件查询</span></td>
		            <td colspan="5"></td>
		        </tr>
		        <tr>
		        	<td  align="right">角色代码</td>
		            <td><select name="actorId" id="actorIdQuery"></select></td>
		            <td  align="right">合作伙伴代码</td>
		            <td><select name="partnerId" id="partnerIdQuery"></select></td>
		            <td  align="right">用户账号</td>
		            <td><input name="userId" id="userIdQuery" type="text" class="SMALLINPUT"/></td>
		         </tr>
		         <tr>
		         	<td  align="right">开始时间</td>
		            <td><input name="beginTime" id="beginTimeQuery" type="text" class="SMALLINPUT" onclick="WdatePicker()"/></td>
		            <td  align="right">结束时间</td>
		            <td><input name="endTime" id="endTimeQuery" type="text" class="SMALLINPUT" onclick="WdatePicker()"/></td>
		            <td align="right" colspan="2">
		            	<input type="submit" class="BUTTON" value="查询" />
		                <input type="reset" class="BUTTON" value="清空" />
		            </td>
		    	</tr>
		    </table>
		</form>
		
		    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="1px">
		    	<thead>
			    	<tr class="TITLE" style="font-weight:bold;">
			        	<td>序号</td>
			            <td>用户账号</td>
			            <td>用户姓名</td>
			            <td>合作伙伴代码</td>
			            <td>角色代码</td>
			            <td>登录时间</td>
			            <td>备注</td>
			        </tr>		    	
		    	</thead>
				<tbody>
					<s:iterator id="element" value="#request.query">
						<tr>
							<td><s:property value="#element.id" /></td>
							<td><s:property value="#element.userId" /></td>
							<td><s:property value="#element.userName" /></td>
							<td><s:property value="#element.partnerName" /></td>
							<td><s:property value="#element.actorName" /></td>
							<td>
								<s:if test="%{#element.loginTime != null}">
									<s:property value="#element.loginTime.substring(0,19)"/>
								</s:if>					
							</td>
							<td><s:property value="#element.remark" /></td>
						</tr>
					</s:iterator>
				</tbody>
				<tfoot>
			        <tr>
			        	<td colspan="7" align="right">
			                <input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
			                <span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
			                <input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />
			            </td>
			        </tr>				
				</tfoot>
		    </table>
		<div class="EMPTYDIV">
		</div>
		  <div id="DOWN">
		  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
		  </div>
	</div>
</body>
</html>
