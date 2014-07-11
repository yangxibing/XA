<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>供货信息管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/menu.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">

		$(document).ready(function(){		
			//全选与取消全选
			$("#allSelectedCheckBox").click(function() {
				var chk = $(this).attr("checked");
				$('input[type=checkbox][name=supplyInfoItem]').each(function(){
					$(this).attr("checked", chk);
				});
			});
		});
		
		function prepareForAddUpdate(){
			$.post($("#queryProductTypeListServerSide").attr("action"), {async:false}, insertSearchCondition, 'json');
		}

		function insertSearchCondition(data){
			//insertProductTypeList(data);
			insertProductTypeListClientSide(data);		
		}
		
		//插入全部产品列表
		function insertProductTypeListClientSide(data){
			var root = data.ajaxRoot;
			
			var list = "<ul id=\"FirstLevelSubMenu\" name=\"Level1SubMenu\" class=\"second-menu\">";
			list += "<li ><a name=\""+root.productTypeId+"\" href=\"#\" onmouseup=\"selectChanged(this)\">"+root.productTypeName+"</a></li>";
			$.each(root.childrenList, function(i, value){
				list += "<li ><a name=\""+value.productTypeId+"\" href=\"#\" onmouseup=\"selectChanged(this)\">"+value.productTypeName+"</a></li>";				
			});
			list += "</ul>";
			$("#productTypeQueryModelTD ul li").eq(0).append(list);
			
			$('#productTypeQueryModelTD ul li').hover(function(){
				$(this).children('ul').show();
			},function(){
				$(this).children('ul').hide();
			});	
			
			$.each(root.childrenList, function(i, value){
				insertProductTypeBranchRecursive(value);
			});
			
			//$("#mainMenu")
			$('#productTypeQueryModelTD ul li').hover(function(){
				$(this).children('ul').show();
			},function(){
				$(this).children('ul').hide();
			});		
		}
		
		//递归插入产品类型子菜单
		function insertProductTypeBranchRecursive(param){
			if(param.childrenList == null || param.childrenList.length == 0){
				return false;
			}
			
			var list = "<ul class=\"third-menu\">";
			$.each(param.childrenList, function(i, value){
				list += "<li ><a name=\""+value.productTypeId+"\" href=\"#\" onmouseup=\"selectChanged(this)\">"+value.productTypeName+"</a></li>";				
			});
			list += "</ul>";
			
			var element = $('#productTypeQueryModelTD a[name="' + param.productTypeId +'"]').last();

				element.parent().append(list);
				
				$.each(param.childrenList, function(i, value){
					insertProductTypeBranchRecursive(value);
				});
		}
		
		//用户从下拉列表里选择了产品类型，响应事件
		function selectChanged(param){
				$("#productTypeQueryModelTD ul li a").eq(0).text($(param).text());
				$("#productTypeQueryModelTD ul li a").eq(0).attr("name", $(param).attr("name"));
				$("#productType").attr("value", $(param).attr("name"));
				$("#productTypeName").attr("value", $(param).text());
				$("#productTypeQueryModelTD #mainMenu>ul").hide();		
		}	
		 
		function clickNew() {
			$("#title").attr("value", "");
			
			$("#productType").attr("value", "");
	        $("#productTypeName").attr("value", "根类别");
			$("#titleMenu").attr("name", "");
			$("#titleMenu").text("根类别");
			
			$("#effectiveDate").attr("value", "");
			$("#publishContent").attr("value", "");
			
			displayRegister();
			prepareForAddUpdate();
			
			/*var url = "selectProductTypeForSupplyGoodsInfo.action";
			$.post(url, function(data){
        		$.each(data.productTypes,function(i,value) {
        			var str = "<option value='"+value.productTypeId+"'>"+value.productTypeName+"</option>";
        			$("#productType").append(str);
        		});
        		displayRegister();
        	});*/ 
        }
        
        function clickEdit(valu) {
        	/*var url1 = "selectProductTypeForSupplyGoodsInfo.action";
			$.post(url1 ,function(data){
        		$.each(data.productTypes, function(i,value) {
        			
        			var str = "<option value='"+value.productTypeId+"'>"+value.productTypeName+"</option>";
        			$("#productType").append(str);
        		});
        		
        	}, 'json');*/
        	
        	$("#addSupplyGoodsInfo").attr("action", "updateSupplyGoodsInfo.action");
        
        	var idValue = $(valu).attr("name");
        	var url = "selectSupplyGoodsInfo.action";
        	$.post(url, {id:idValue}, function(data) {
        		
        		var supplyGoodsInfo = data.supplyGoodsInfoForEdit;
        		$("#idForUpdate").attr("value", supplyGoodsInfo.id);
        		$("#title").attr("value", supplyGoodsInfo.title);
        		/*$("#productType option").each(function() {
        			if($(this).attr("value") == supplyGoodsInfo.productTypeId) {
							$(this).attr("selected", true);
					}
        		});*/
        		
	            $("#productType").attr("value", supplyGoodsInfo.productTypeId);
	            $("#productTypeName").attr("value", supplyGoodsInfo.productTypeName);
				$("#titleMenu").attr("name", supplyGoodsInfo.productTypeId);
				$("#titleMenu").text(supplyGoodsInfo.productTypeName);        		
        		
        		$("#effectiveDate").attr("value", supplyGoodsInfo.effectiveDate);
        		$("#publishContent").attr("value", supplyGoodsInfo.publishContent);             
        		
        	}, 'json');
        	
        	displayRegister();
        	prepareForAddUpdate();
        }
        
        function displayRegister() {
        	var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
        
        
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
        function deleteSupplyInfo() {
        	var f_str = "";
        	var count = 0;
        	$('input[type=checkbox][name=supplyInfoItem]').each(function(){
        		if($(this).attr("checked")== true) {
        			f_str += $(this).attr("value")+",";
        			count++;
        		}
        	});
        	
        	if(confirm("你真的要删除这项么?")) {
        		$.post("deleteSupplyGoodsInfo.action", {supplyGoodsInfoList:f_str}, function(data){
        			$("#querySupplyInfoForm").attr("action", "listSupplyGoodsInfo.action");
        			$("#querySupplyInfoForm").submit();
        		});
        	}
        }
        
        function saveSupplyGoodsInfo() {
        	if(checkAllSupplyProduct($("#title").attr("value"), $("#publishContent").attr("value"))==false)
        		return false;
        	var url=$("#addSupplyGoodsInfo").attr("action");
        	param = $("#addSupplyGoodsInfo").serializeArray();
        	$.post(url, param, function(data){
        		$("#querySupplyInfoForm").attr("action", "listSupplyGoodsInfo.action");
        		$("#querySupplyInfoForm").submit();
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
        	$("#querySupplyInfoForm").attr("action", "listSupplyGoodsInfo.action?currentPage="+currentPage);
        	$("#querySupplyInfoForm").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#querySupplyInfoForm").attr("action", "listSupplyGoodsInfo.action?currentPage="+currentPage);
        	$("#querySupplyInfoForm").submit();
		}
        
        
</script>
</head>

<body>

<form id="querySupplyInfoForm" action="listSupplyGoodsInfo.action" method="post"></form>
<form id="queryProductTypeListServerSide" action="queryProductTypeListServerSide.action"></form>

<div id="supply" class="CENTER">
<div id="top">
  <span><h2>供货信息管理</h2></span>
</div>
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE">
        	<td>选择</td>
            <td>序号</td>
            <td>标题</td>
            <td>产品类别</td>
            <td>有效日期</td>
            <td>供应商名称</td>
            <td>浏览人次</td>
            <td>发布人</td>
            <td>发布时间</td>
            <td>&nbsp;</td>
        </tr>
        
        <s:iterator id="element" value="#request.query">
	        	<tr class="HOVER">
	        		<td ><input name="supplyInfoItem" type="checkbox" class="INPUTTEXT" value="<s:property value="#element.id"/>"/></td>
	          	    <td ><s:property value="#element.id"/></td>
	           	    <td ><s:property value="#element.title"/></td>
	           	    <td ><s:property value="#element.productTypeName"/></td>
	           	    <td ><s:property value="#element.effectiveDate"/></td>
					<td ><s:property value="#element.partnerName"/></td>
	            	<td><s:property value="#element.visitNumber"/></td>
	            	<td><s:property value="#element.publisher"/></td>
	            	<td><s:property value="#element.publishDate"/></td>
	            	<td><input type="button" class="BUTTON" name="<s:property value="#element.id"/>" onclick="clickEdit(this);" value="编辑"/></td>
	        	</tr>
	    </s:iterator>
	    
        <tr>
        	<td colspan="2" align="left"><input type="checkbox" id="allSelectedCheckBox"/>全部选中</td>
            <td><input type="button" class="BUTTON" value="删除" onclick="deleteSupplyInfo()"/></td>
            <td><input type="button" class="BUTTON" onclick="clickNew()" value="新建" /></td>
            
            <td colspan="6" class="UPBOD"  align="right">
	            <input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	            <span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	           	<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
	        </td>
        </tr>
    </table>
    
<form id="addSupplyGoodsInfo" action="addSupplyGoodsInfo.action" method="post">
  <table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr class="TITLE">
        <td align="left"><span class="TITLESPAN1">供货信息</span><span class="TITLESPAN2">注：<font color="#FF0000">*</font>为必填项</span></td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
          <tr>
            <td class="ALRIGHT">标题<input id="idForUpdate" name="id" type="hidden" value=""/></td>
            <td class="ALLEFT" colspan="3"><input id="title" name="title" type="text" class="LONGINPUT"/>
              <font color="#FF0000">*</font></td>
          </tr>
          <tr>
            <td class="ALRIGHT">产品类别</td>
            <td id="productTypeQueryModelTD" align="left">
				<ul id="menu" class="first-menu">
				  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a></li>
				</ul>
				<input type="hidden" name="productTypeId" id="productType" value=""/>
				<input type="hidden" name="productTypeName" id="productTypeName" value="根类别"/>				
			</td>            
            <!--  
            <td class="ALLEFT">
            	<select id="productType" name="productTypeId"></select>
            </td>
            -->
            <td class="ALRIGHT">有效日期</td>
            <td class="ALLEFT"><input id="effectiveDate" name="effectiveDate" type="text" class="INPUTTEXT" onclick="WdatePicker()"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">内容</td>
            <td class="ALLEFT" colspan="3"> <textarea id="publishContent" name="publishContent" style="height:200px;" class="LONGINPUT"></textarea></td>
          </tr>
          
        </table></td>
      </tr>
      <tr>
        <td align="center"><input type="button" onclick="saveSupplyGoodsInfo()" class="BUTTON" value="保存" />
          <input type="reset" class="BUTTON" onclick="hideRegister()" value="取消" /></td>
      </tr>
  </table>
</form>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
