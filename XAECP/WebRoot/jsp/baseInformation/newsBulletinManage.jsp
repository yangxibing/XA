<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻/公告信息管理</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>

<script type="text/javascript"> 
		//新建、编辑时的响应事件
		function displayRegister(valu) {
			clearAddUpdateForm();   
            if(($(valu).attr("value"))=="新建"){
				$("#addUpdateNewsBulletin").attr("action","addNewsBulletin.action");
			}else{
				$("#addUpdateNewsBulletin").attr("action","updateNewsBulletin.action");
				var idValue=$(valu).attr("name");
				var url=$("#queryNewsBulletinById").attr("action");
				var params={Id:idValue, async: false};
				$.post(url, params, callBackFunction, 'json');
			} 		
		 
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
        
        //清空新建、编辑表单
        function clearAddUpdateForm(){
        	$("#titleEdit").attr("value", "");
        	$("#publishContentEdit").attr("value", "");
		   	$("#publishTypeSelectEdit option").eq(0).attr("selected", true);
        }
        
        //编辑时的回调函数
        function callBackFunction(data){
        	$("#newsIdEdit").attr("name", data.newsAjax.id);
        	$("#titleEdit").attr("value", data.newsAjax.title);
        	$("#publishContentEdit").attr("value", data.newsAjax.publishContent);
		   	$("#publishTypeSelectEdit option").each(function(){
		   		if($(this).attr("value") == data.newsAjax.publishType){
		   			$(this).attr("selected", true);
		   		}
		   	});
        }
        
        //保存新建、编辑的新闻公告信息
        function saveNewsBulletin(valu){
        	var url=$("#addUpdateNewsBulletin").attr("action");
        	
        	var idValue = $(valu).attr("name");
        	var titleValue = $("#titleEdit").attr("value");
        	var publishTypeValue = 0;
			$("#publishTypeSelectEdit option").each(function(){
            	if($(this).attr("selected")==true){
            		publishTypeValue = $(this).attr("value");
            	}
            });
            var publishContentValue = $("#publishContentEdit").attr("value");
            if(checkNews(titleValue, publishContentValue)==false)
            	return false;
			var params={id:idValue,
					title:titleValue,
					publishType:publishTypeValue,
					publishContent:publishContentValue,
					async: false};
			$.post(url,params,function(data){
				$("#queryNewsBulletin").submit();
			});
        }
        
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
        //全选响应事件
        function allSelected(valu){
        	if($(valu).attr("checked")==true){
        		$("[name='newBulletinItem']").attr("checked",true);
        	}
        	else {
        		$("[name='newBulletinItem']").attr("checked",false);
        	}
        }
        
        //删除响应事件
        function deleteNewsBulletin(){
			var f_str="";
        	var count=0;
			$("[name='newBulletinItem']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});
			if(count > 0){
				if(confirm("你真的要删除这些项么？")){
						var url = $("#deleteNewsBulletin").attr("action");
						$.post(url, {newsList:f_str}, function(data){
							$("#queryNewsBulletin").submit();
						});
				}
			} else {
				alert("未选中任何项！");
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
        	$("#queryNewsBulletin").attr("action", "queryNewsBulletin.action?currentPage="+currentPage);
        	$("#queryNewsBulletin").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
        	$("#queryNewsBulletin").attr("action", "queryNewsBulletin.action?currentPage="+currentPage);
        	$("#queryNewsBulletin").submit();
		}       
</script>
<style>
	#supply #register #registCnt .ALLEFT{width:85%;}
	#supply #register #registCnt .ALRIGHT{width:15%;}
</style>
</head>

<body>
	<!-- 用于脚本的、辅助性的控件，公用控件 -->
	<form id="deleteNewsBulletin" action="deleteNewsBulletin.action"></form>
	<form id="queryNewsBulletin" action="queryNewsBulletin.action" method="post"></form>
	<form id="queryNewsBulletinById" action="queryNewsBulletinById.action"></form>

	<div id="supply" class="CENTER">
	<div id="top">
	  <span><h2>新闻/公告信息管理</h2></span>
	</div>
	    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
	    	<thead>
		    	<tr class="TITLE">
		        	<td>选择</td>
		            <td>序号</td>
		            <td>标题</td>
		            <td>发布类型</td>
		            <td>浏览人次</td>
		            <td>发布人</td>
		            <td>发布时间</td>
		            <td>&nbsp;</td>
		        </tr>
	    	</thead>
	    	<tbody>
		        <s:iterator id="element" value="#request.query">
			        <tr class="HOVER">
			        	<td ><input name="newBulletinItem" type="checkbox" class="INPUTTEXT" value="<s:property value="#element.id"/>" /></td>
			            <td ><s:property value="#element.id"/></td>
			            <td ><s:property value="#element.title"/></td>
			            <td>
			            	<s:if test="%{#element.publishType==0}">新闻</s:if>
			            	<s:else>公告</s:else>
			            </td>
			            <td ><s:property value="#element.visitNumber"/></td>
			            <td><s:property value="#element.publisherName"/></td>
			            <td ><s:property value="#element.publishDate"/></td>
			            <td><input type="button" class="BUTTON" name="<s:property value="#element.id"/>" onclick="displayRegister(this)" value="编辑"/></td>
			        </tr>
		        </s:iterator>    		
	    	</tbody>
	    	<tfoot>
		        <tr>
		        	<td align="left"><input name="allSelectBox" onclick="allSelected(this)" type="checkbox" />全选</td>
		            <td><input type="button" class="BUTTON" onclick="deleteNewsBulletin(this)" value="删除" /></td>
		            <td align="left"><input type="button" class="BUTTON" onclick="displayRegister(this)" value="新建" /></td>
		            <td colspan="5" class="UPBOD" align="right">
		            	<input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
		            	<span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
						<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />
		            </td>
		        </tr>    	
	    	</tfoot>
	    </table>
	    
	<form id="addUpdateNewsBulletin" action="">
	  <table id="register" class="CENTER" cellpadding="0" cellspacing="0">
	      <tr class="TITLE">
	        <td align="left"><span class="TITLESPAN1">新闻/公告信息</span><span class="TITLESPAN2">注：<font color="#FF0000">*</font>为必填项</span></td>
	      </tr>
	      <tr>
	        <td>
	        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
	          <tr>
	            <td class="ALRIGHT">标题</td>
	            <td class="ALLEFT"><input type="text" id="titleEdit" class="LONGINPUT"/>
	              <font color="#FF0000">*</font></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">发布类型</td>
	            <td class="ALLEFT">
	            	<select id="publishTypeSelectEdit">
	                	<option value="0">新闻</option>
	                    <option value="1">公告</option>
	                </select>
	            </td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">内容</td>
	            <td class="ALLEFT"> <textarea id="publishContentEdit" style="height:200px;" class="LONGINPUT"></textarea></td>
	          </tr>
	        </table></td>
	      </tr>
	      <tr>
	        <td align="center"><input type="button" id="newsIdEdit" name="" onclick="saveNewsBulletin(this)" class="BUTTON" value="保  存" />
	          <input type="reset" class="BUTTON" onclick="hideRegister()" value="取  消" /></td>
	      </tr>
	  </table>
	</form>
	  <div id="DOWN">
	  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='/XAECP/home.jsp';" />
	  </div>
	</div>
</body>
</html>
