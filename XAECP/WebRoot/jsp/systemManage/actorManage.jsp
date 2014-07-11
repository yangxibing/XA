<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>角色管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>

<script type="text/javascript"> 
		function displayRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        function newActor(){
        	$("#actorId").attr("value","");
        	$("#actorName").attr("value","");
        	$("#saveButton").attr("name","新建角色");
        	displayRegister();
        }
        function saveActor(valu){
        	var actorNameV = $("#actorName").attr("value");
        	var actorIdV = $("#actorId").attr("value");
        	var url="";
        	
        	if($(valu).attr("name")=="新建角色"){
        		//验证actorId是否存在
        		var checkUrl = "checkActorIdExist.action";
        		var params = {actorId:actorIdV};
        		$.post(checkUrl, params, function(data){
        			if(data.idExitOrNot=="exit"){
        				alert("角色代码已经存在");
        				return false;
        			}
        		});
        	
        		url = "newActor.action";
        	}else{
        		url = "updateActor.action";
        	}
        	var params = { actorId : actorIdV, actorName : actorNameV };
        	$.post(url, params, function(data){
        		$("#listActorsForm").submit();
        	});
        }
        
		function allSelect(valu){
        	if($(valu).attr("checked")==true){
        		$("input[name='checkbox']").each(function(){
        			$(this).attr("checked",true);
        		});
        	}else{
        		$("input[name='checkbox']").each(function(){
        			$(this).attr("checked",false);
        		});
        	}
        }
        
        function deleteById(){
        	var idListV="";
        	var all=0;
        	var flag=0;
        	$("#actors>tr").each(function(){
        		all++;
        		var td=$(this).children("td");
        		if(td.eq(0).children("input").eq(0).attr("checked")==true){
        			idListV=idListV+td.eq(1).text()+",";
        		}else{
        			flag++;
        		}
        	});
        	if(all==flag){
        		alert("没有选中任何一个");
        	}else{
        		if(confirm("确定要删除么？")){
        			var url = "deleteActor.action";
        			var params={actorIdString:idListV};
        			$.post(url,params,function(data){
        				$("#listActorsForm").submit();
        			});
        		}
        	}
        }
        
        function edit(valu){
        	$("#actorId").attr("value",$(valu).attr("name").split("?*")[0]);
        	$("#actorName").attr("value",$(valu).attr("name").split("?*")[1]);
        	$("#actorId").attr("disabled",true);
        	displayRegister();
        }
        
        function perssion(valu){
        	var actorId = $(valu).attr("name");
        	location.href = "perssionDistribute.jsp?actorId='"+actorId+"'";
        }
        
        //分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#listActorsForm").attr("action", "listActors.action?currentPage="+currentPage);
        	$("#listActorsForm").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#listActorsForm").attr("action", "listActors.action?currentPage="+currentPage);
        	$("#listActorsForm").submit();
		}
</script>

</head>

<body>
<form id="listActorsForm" method="post" action="listActors.action"></form>
<div id="supply" class="CENTER">
<div id="top">
  <span><h2>角色管理</h2></span>
</div>
<form method="post" action="listActors.action">
    <table id="search" class="CENTER" cellspacing="0" cellpadding="2px">
    	<tr class="TITLE">
        	<td><span class="TITLESPAN1">组合条件查询</span></td>
            <td colspan="4"></td>
        </tr>
        <tr>
        	<td class="BORDER"  align="right">角色代码</td>
            <td class="BORDER"><input name="actorId" type="text" class="INPUTTEXT"/></td>
            <td class="BORDER" align="right">角色名称</td>
            <td class="BORDER"><input name="actorName" type="text" class="INPUTTEXT"/></td>
            <td align="right">
            	<input type="submit"  class="BUTTON" value="查询" />
                <input type="reset" class="BUTTON" value="清空" />
            </td>
    	</tr>
    </table>
</form>
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="1px">
    	<thead>
    	<tr class="TITLE" style="font-weight:bold;">
        	<td>选择</td>
            <td>角色代码</td>
            <td>角色名称</td>
            <td colspan="2">&nbsp;</td>
        </tr>
        </thead>
        <tbody id="actors">
        <s:iterator id="element" value="#request.actors">
        <tr class="HOVER">
        	<td ><input type="checkbox" name="checkbox" class="INPUTTEXT"/></td>
            <td ><s:property value="#element.actorId"/></td>
            <td ><s:property value="#element.actorName"/></td>
            <td><input type="button" class="BUTTON"  name="<s:property value="#element.actorId"/>?*<s:property value="#element.actorName"/>" onclick="edit(this)" value="编辑"/></td>
            <td><input type="button" class="BUTTON"  onClick="perssion(this);" name="<s:property value="#element.actorId"/>" value="权限分配"/></td>
        </tr>
        </s:iterator>
        </tbody>
        <tfoot>
        <tr>
        	<td><input type="checkbox" onclick="allSelect(this)"/>全选</td>
            <td><input type="button" onclick="deleteById()" class="BUTTON" value="删除角色" />
           		<input type="button" class="BUTTON" onclick="newActor()" value="新建角色" />
           	</td>
            <td colspan="3" align="right">
	            	<input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	            	<span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	           		<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
	        </td>
        </tr>
        </tfoot>
    </table>
<div class="EMPTYDIV">
</div>
  <table id="register" class="CENTER" cellpadding="2PX" cellspacing="0">
      <tr class="TITLE">
        <td align="left"><span class="TITLESPAN1">角色信息</span><span class="TITLESPAN2">注：<font color="#FF0000">*</font>为必填项</span></td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="2px" cellspacing="0">
          <tr>
            <td class="ALRIGHT">角色代码</td>
            <td class="ALLEFT"><input type="text" id="actorId" name="supplyID" />
              <font color="#FF0000">*</font></td>
            <td class="ALRIGHT">角色名称</td>
            <td class="ALLEFT"><input type="text" id="actorName"/></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td align="center"><input type="button" id="saveButton" onclick="saveActor(this);" class="BUTTON" value="保存"  />
          <input type="reset" class="BUTTON" onclick="hideRegister()" value="取消" /></td>
      </tr>
  </table>
  <div class="EMPTYDIV">
  </div>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
