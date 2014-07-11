<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户管理</title>

<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>

<script type="text/javascript"> 
//*************************************************************************************************
//加载页面前获取查询模块的下拉列表，以及恢复页面查询状态
//************************************************************************************************* 	
		$(document).ready(function(){
			var url = $("#querySearchInfo").attr("action");
			$.post(url, {async:false}, processAfterPost, "json");
		});
        
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
        	$("#supplierIdQuery").html(content);
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
        	$("#userIdQuery").attr("value", '<s:property value="#request.userVO.userId"/>');
        	$("#userNameQuery").attr("value", '<s:property value="#request.userVO.userName"/>');
        	$("#supplierIdQuery").attr("value", '<s:property value="#request.userVO.supplierId"/>');
        	$("#actorIdQuery").attr("value", '<s:property value="#request.userVO.actorId"/>');
        	if('<s:property value="#request.userVO.passcheckOrNot"/>' == "true"){
        		$("#passcheckOrNotQuery").attr("checked", true);
        	}	
        }

//*************************************************************************************************
//新建编辑模块
//************************************************************************************************* 	        		
		function displayRegister(valu) {
			clearAddUpdateForm();    
			if(($(valu).attr("value"))=="新建用户"){
				$("#addUpdateXAUser").attr("action","addXAUser.action");
			}else{
				$("#addUpdateXAUser").attr("action","updateXAUser.action");
				var userIdValue=$(valu).attr("name");
				var url=$("#getXAUserById").attr("action");
				var params={userId:userIdValue,async: false};
				$.post(url,params,callBackFunction,'json');
			} 
			    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
        
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
        //清空新建、编辑表单
        function clearAddUpdateForm(){
		   	$("#register :text").each(function(){
		   	 	$(this).attr("value","");
		   	});  
		   	$("#userIdEdit").attr("disabled", false);
		   	$("#supplierIdEdit").html($("#supplierIdQuery").html()); 
		   	$("#actorIdEdit").html($("#actorIdQuery").html()); 
		   	$("#passcheckOrNotEdit").attr("checked", false);
		   	$("#remarkEdit").attr("value", "");    	
        }
        
        //获取到指定用户信息插入表中，用于编辑
        function callBackFunction(data){
        	$("#userIdEdit").attr("value", data.userAjax.userId);
        	$("#userIdEdit").attr("disabled", true);
        	$("#passwordEdit").attr("value", data.userAjax.password);
        	$("#userNameEdit").attr("value", data.userAjax.userName);
        	$("#supplierIdEdit").attr("value", data.userAjax.supplierId);
        	$("#actorIdEdit").attr("value", data.userAjax.actorId);
        	$("#passcheckOrNotEdit").attr("checked", data.userAjax.passcheckOrNot);
        	$("#remarkEdit").attr("value", data.userAjax.remark);
        }

//*************************************************************************************************
//保存用户
//************************************************************************************************* 		        
        function savaXAUser(){
        	var userIdValue = $("#userIdEdit").attr("value");
        	var passwordValue = $("#passwordEdit").attr("value");
        	var userNameValue = $("#userNameEdit").attr("value");
        	var supplierIdValue = $("#supplierIdEdit").attr("value");
        	var actorIdValue = $("#actorIdEdit").attr("value");    
        	var passcheckOrNotValue = $("#passcheckOrNotEdit").attr("checked");
        	var remarkValue = $("#remarkEdit").attr("value");
        	var params = {userId:userIdValue,
        					password:passwordValue,
        					userName:userNameValue,
        					supplierId:supplierIdValue,
        					actorId:actorIdValue,
        					passcheckOrNot:passcheckOrNotValue,
        					remark:remarkValue,
        					async:false};
        	var url = $("#addUpdateXAUser").attr("action");
        	$.post(url, params, function(data){
        		$("#queryXAUserList").submit();
        	});
        }
        
//*************************************************************************************************
//集中采购列表显示模块
//************************************************************************************************* 		
		//全选
		function allSelected(){
			if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='userItem']").attr("checked",true);
        	}
        	else {
        		$("[name='userItem']").attr("checked",false);
        	}
		}
		
		//删除
		function deleteSelectedUser(){
			var f_str="";
        	var count=0;
			$("[name='userItem']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});
			if(count > 0){
				if(confirm("确定要删除所选的用户吗？")){
				 		var url = $("#deleteSelectedUser").attr("action");
						$.post(url,{userList:f_str,async: false},function(data){
							$("#queryXAUserList").submit();
						});
				}
			} else {
				alert("未选中任何项！");
			}		
		}
		
		//审批
		function checkApply(valu){
			var userIdValue = $(valu).attr("name");
			var params = {userId:userIdValue, async:false};
			var url = $("#checkRegisterApply").attr("action");
			$.post(url, params, function(data){
				$("#queryXAUserList").submit();
			});
		}
		
		//分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#queryXAUserList").attr("action", "queryXAUserList.action?currentPage="+currentPage);
        	$("#queryXAUserList").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#queryXAUserList").attr("action", "queryXAUserList.action?currentPage="+currentPage);
        	$("#queryXAUserList").submit();
		}

</script>
<style>
	#supply #register #registCnt .ALLEFT{ width:300px;}
</style>
</head>

<body>
	<form id="querySearchInfo" action="querySearchInfo.action"></form>
	<form id="deleteSelectedUser" action="deleteSelectedUser.action"></form>
	<form id="getXAUserById" action="getXAUserById.action"></form>
	<form id="checkRegisterApply" action="checkRegisterApply.action"></form>

	<div id="supply" class="CENTER">
	<div id="top">
	  <span><h2>用户管理</h2></span>
	</div>
	
	<form id="queryXAUserList" action="queryXAUserList.action" method="post">
	    <table id="search" class="CENTER" cellspacing="0" cellpadding="2px">
	    	<tr class="TITLE">
	        	<td><span class="TITLESPAN1">组合条件查询</span></td>
	            <td colspan="5"></td>
	        </tr>
	        <tr>
	        	<td  align="right">用户账号</td>
	            <td><input name="userId" id="userIdQuery" type="text" class="SMALLINPUT"/></td>
	            <td  align="right">用户姓名</td>
	            <td><input name="userName" id="userNameQuery" type="text" class="SMALLINPUT"/></td>
	            <td  align="right">合作伙伴代码</td>
	            <td>
	            	<select name="supplierId" id="supplierIdQuery">
	            		<!-- 合作伙伴下拉列表 -->
	            	</select>
	            </td>
	         </tr>
	         <tr>
	         	<td  align="right">角色代码</td>
	            <td>
	            	<select name="actorId" id="actorIdQuery">
	            		<!-- 角色下拉列表 -->
	            	</select>
				</td>
	            <td  align="right">是否通过审核</td>
	            <td><input name="passcheckOrNot" id="passcheckOrNotQuery" type="checkbox" value="true"/></td>
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
		        	<td>选择</td>
		            <td>用户账号</td>
		            <td>用户口令</td>
		            <td>用户姓名</td>
		            <td>合作伙伴代码</td>
		            <td>角色代码</td>
		            <td>是否通过审核</td>
		            <td>备注</td>
		            <td colspan="2">&nbsp;&nbsp;</td>
		        </tr>
	    	</thead>
	    	<tbody>
	    		<s:iterator id="element" value="#request.query">
	    			<tr class="HOVER">
		    			<td ><input name="userItem" type="checkbox" class="INPUTTEXT" value="<s:property value="#element.userId"/>" /></td>
		    			<td ><s:property value="#element.userId"/></td>
		    			<td ><s:property value="#element.password"/></td>
		    			<td ><s:property value="#element.userName"/></td>
		    			<td ><s:property value="#element.supplierName"/></td>
		    			<td ><s:property value="#element.actorName"/></td>
		    			<td >
							<s:if test="%{#element.passcheckOrNot == 0}">×</s:if>
							<s:else>√</s:else>
						</td>
						<td ><s:property value="#element.remark" /></td>
						<td ><input type="button" name="<s:property value="#element.userId"/>" onclick="displayRegister(this)" value="编辑" class="ARTBUTTON"/></td>
						<td >
							<s:if test="%{#element.passcheckOrNot == 0}">
								<input type="button" class="BUTTON"  onclick="checkApply(this)" value="审批" name="<s:property value="#element.userId"/>"/>
							</s:if>				
						</td>
					</tr>
	    		</s:iterator>
	    	</tbody>
	    	<tfoot>
		        <tr>
		        	<td><input name="allSelectBox" onclick="allSelected()" type="checkbox" />全选</td>
		            <td><input onclick="deleteSelectedUser()" type="button" class="BUTTON" value="删除用户" /></td>
		            <td><input type="button" class="BUTTON" onclick="displayRegister(this)" value="新建用户" /></td>
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
	
	<form id="addUpdateXAUser" action="">
	  <table id="register" class="CENTER" cellpadding="2PX" cellspacing="0">
	      <tr class="TITLE">
	        <td align="left"><span class="TITLESPAN1">用户信息</span><span class="TITLESPAN2">注：<font color="#FF0000">*</font>为必填项</span></td>
	      </tr>
	      <tr>
	        <td>
	        <table id="registCnt" class="CENTER" cellpadding="2px" cellspacing="0">
	          <tr>
	            <td class="ALRIGHT">用户账号</td>
	            <td class="ALLEFT"><input name="userId" id="userIdEdit" type="text" name="supplyID" class="INPUTTEXT"/>
	              <font color="#FF0000">*</font></td>
	            <td class="ALRIGHT">角色代码</td>
	            <td class="ALLEFT">
	            	<select name="actorId" id="actorIdEdit">
	            		<!-- 角色代码 -->
	            	</select>
	            </td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">用户口令</td>
	            <td class="ALLEFT"><input name="password" id="passwordEdit" type="text" class="INPUTTEXT"/></td>
	            <td class="ALRIGHT">合作伙伴代码</td>
	            <td class="ALLEFT">
	            	<select name="supplierId" id="supplierIdEdit">
	            		<!-- 合作伙伴代码 -->
	            	</select>
	            </td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">用户姓名</td>
	            <td class="ALLEFT"><input name="userName" id="userNameEdit" type="text" name="supplyID" class="INPUTTEXT"/></td>
	            <td class="ALRIGHT">是否通过审核</td>
	            <td class="ALLEFT"><input name="passcheckOrNot" id="passcheckOrNotEdit" type="checkbox" /></td>
	          </tr>
	          <tr>
	          	<td class="ALRIGHT">备注</td>
	            <td class="ALLEFT" colspan="3">
	            	<textarea name="remark" id="remarkEdit" style="width:600px; height:50px;"></textarea>
	            </td>
	          </tr>
	        </table></td>
	      </tr>
	      <tr>
	        <td align="center"><input type="button" onclick="savaXAUser()" class="BUTTON" value="保存"  />
	          <input type="reset" class="BUTTON" onclick="hideRegister()" value="取消" /></td>
	      </tr>
	  </table>
	</form>
	
	  <div class="EMPTYDIV">
	  </div>
	  <div id="DOWN">
	  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
	  </div>
	</div>
</body>
</html>
