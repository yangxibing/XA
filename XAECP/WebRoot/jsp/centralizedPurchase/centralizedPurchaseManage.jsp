<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>集中采购信息管理</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<link href="../../css/menu.css" rel="stylesheet" type="text/css"//>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>

<script type="text/javascript">
//*************************************************************************************************
//组合条件查询模块
//************************************************************************************************* 
		$(document).ready(function(){
			var url = $("#getConditionQueryList").attr("action");
			$.post(url, {async:false}, insertConditionQueryList, 'json');
		});
		
		//回调函数，插入查询条件的下拉列表
		function insertConditionQueryList(data){
			var datas = data.queryList;
			var array = new Array();
			array = datas.split(";");
			var titleList = array[0];
			var productTypeList = array[1];
			insertCentralizedPurchaseTitleList(titleList);
			//insertProductTypeList(productTypeList);
			insertProductTypeListModel();
			
			//recoverQueryCondition();
		}
		
		//插入集中采购信息标题的下拉列表
		function insertCentralizedPurchaseTitleList(titleList){
			var addList = new Array();
			addList = titleList.split(",");       	
        	var count = addList.length;
			
			var titleInfo = "<option value=\"\">--请选择--</option>";
			for(var index = 0; index<count; index++){
				titleInfo += "<option value=\"" + addList[index].split(" ")[0] + "\">" + addList[index].split(" ")[1] + "</option>";
			}
			$("#cpPurchaseInfoTitleQuery option").remove();
			$("#cpPurchaseInfoTitleQuery").append(titleInfo);			
		}
		
		//插入产品类型的下拉列表
		function insertProductTypeList(productTypeList){
			var addList = new Array();
			addList = productTypeList.split(",");
			var count = addList.length;
			
			var typeInfo = "<option value=\"\">--请选择--</option>";
			for(var index = 0; index<count; index++){
				typeInfo += "<option value=\"" + addList[index].split(" ")[0] + "\">" + addList[index].split(" ")[1] + "</option>";
			}
			$("#productTypeIdQuery option").remove();
			$("#productTypeIdQuery").append(typeInfo);			
		}
		
		//恢复保存起来的查询条件
		function recoverQueryCondition(){
			$("#cpPurchaseInfoTitleQuery option").each(function(){
            	if($(this).attr("value")=='<s:property value="#request.centralizedPurchase.cpPurchaseInfoId"/>'){
            		$(this).attr("selected", true);
            	}
            });
            
            var id = $("#productTypeIdStateHidden").attr("value");
            var name = $("#productTypeNameStateHidden").attr("value");
            if(id != null && id != ""){
	            $("#productTypeIdQuery").attr("value", id);
	            $("#productTypeNameQuery").attr("value", name);
				$("#titleMenu").attr("name", id);
				$("#titleMenu").text(name);             	
            }           

            $("#centralizedPurchaseStateQuery option").each(function(){
            	if($(this).attr("value")=='<s:property value="#request.centralizedPurchase.centralizedPurchaseState"/>'){
            		$(this).attr("selected", true);
            	}
            });
		}
		
//*************************************************************************************************
//集中采购列表显示模块
//************************************************************************************************* 		
		//全选
		function allSelected(){
			if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='centralizedPurchaseItem']").attr("checked",true);
        	}
        	else {
        		$("[name='centralizedPurchaseItem']").attr("checked",false);
        	}
		}
		
		//删除
		function deleteCentralizedPurchase(valu){
			var f_str="";
			var url = $("#deleteCentralizedPurchase").attr("action");
        	var count=0;
        	var total=0;
			$("[name='centralizedPurchaseItem']").each(function(){
  				 if($(this).attr("checked")==true){
  				 	total++;
  				 	if($(this).attr("id")==0){
  				 		f_str +=$(this).attr("value")+",";
   					 	count++;	
  				 	}
  				 }
			});
			if(total > 0){
				if(count>0 && total > count){
					if(confirm("只有未发布的集中采购信息可以删除，确实要删除其中未发布的部分吗？")){
						$.post(url,{deleteList:f_str,async: false},function(data){
							$("#queryCentralizedPurchaseList").submit();
						});
					}
				}
				else if(count>0 && total == count){
					if(confirm("确实要删除所选的集中采购信息吗？")){
						$.post(url,{deleteList:f_str,async: false},function(data){
							$("#queryCentralizedPurchaseList").submit();
						});
					}
				}
				else{
					alert("所选集中采购信息中，均已发布，不能删除！");
				}
			} else {
				alert("未选中任何项！");
			}			
		}
		
//*************************************************************************************************
//新建、编辑模块
//************************************************************************************************* 	
		
		function displayRegister(valu) {
			clearAddUpdateModule();    
			if(($(valu).attr("value"))=="新建"){
				$("#addUpdateCentralizedPurchase").attr("action","addCentralizedPurchase.action");
			}else{
				$("#addUpdateCentralizedPurchase").attr("action","updateCentralizedPurchase.action");	
				var cpPurchaseInfoIdValue=$(valu).attr("name");
				var url=$("#getCentralizedPurchaseById").attr("action");
				var params={cpPurchaseInfoId:cpPurchaseInfoIdValue,async: false};
				$.post(url,params,insertEditInfo,'json');
			} 
			var subMenu=document.getElementById("register");
		   	subMenu.style.display = "block";
        }
        
        //清空新建编辑模块
        function clearAddUpdateModule(){
        	$("#cpPurchaseInfoIdEdit").text("自动编号生成");
        	
        	var str = $("#productTypeQueryModelTD").html();
        	$("#productTypeEditModelTD").html(str);
        	$("#productTypeEditModelTD input").remove();
        	$("#productTypeEditModelTD").append("<input type=\"hidden\" id=\"productTypeIdEdit\" value=\"\"/><input type=\"hidden\" id=\"productTypeNameEdit\" value=\"\"/>");
        	var root = $("#productTypeQueryModelTD #mainMenu ul li").eq(0).children('a').eq(0);
        	$("#productTypeEditModelTD ul li a").eq(0).text(root.text());
        	$("#productTypeEditModelTD ul li a").eq(0).attr("name", root.attr("name"));
        	$("#productTypeIdEdit").attr("value", root.attr("name"));
        	$("#productTypeNameEdit").attr("value", root.text());
        	$('#productTypeEditModelTD #menu li').hover(function(){
				$(this).children('ul').show();
			},function(){
				$(this).children('ul').hide();
			});
        	
        	$("#cpPurchaseInfoTitleEdit").attr("value", "");
        	$("#measureUnitEdit").attr("value", "");
        	$("#purchasePriceBeginEdit").attr("value", "");
        	$("#purchasePriceEndEdit").attr("value", "");
        	$("#purchasePriceUnitEdit").attr("selectedIndex", 0);
        	$("#deadlineEdit").attr("value", "");
        	$("#telephoneEdit").attr("value", "");
        	$("#briefExplainEdit").attr("value", "");
        }
        
        //插入编辑信息
        function insertEditInfo(data){
        	$("#cpPurchaseInfoIdEdit").text(data.purchaseAjax.cpPurchaseInfoId);
        	
            var root = $(document.getElementsByName(data.purchaseAjax.productTypeId)[0]);
        	$("#productTypeEditModelTD ul li a").eq(0).text(root.text());
        	$("#productTypeEditModelTD ul li a").eq(0).attr("name", root.attr("name"));
        	$("#productTypeIdEdit").attr("value", root.attr("name"));
        	$("#productTypeNameEdit").attr("value", root.text());
            
        	$("#cpPurchaseInfoTitleEdit").attr("value", data.purchaseAjax.cpPurchaseInfoTitle);
        	$("#measureUnitEdit").attr("value", data.purchaseAjax.measureUnit);
        	$("#purchasePriceBeginEdit").attr("value", data.purchaseAjax.purchasePriceBegin);
        	$("#purchasePriceEndEdit").attr("value", data.purchaseAjax.purchasePriceEnd);
        	$("#purchasePriceUnitEdit option").each(function(){
            	if($(this).attr("value") == data.purchaseAjax.purchasePriceUnit){
            		$(this).attr("selected", true);
            	}
            });
        	$("#deadlineEdit").attr("value", data.purchaseAjax.deadline);
        	$("#telephoneEdit").attr("value", data.purchaseAjax.telephone);
        	$("#briefExplainEdit").attr("value", data.purchaseAjax.briefExplain);
        }

//*************************************************************************************************
//保存、保存并发布处理模块
//************************************************************************************************* 	        
        function saveCentralizedPurchase(valu){
        	var url=$("#addUpdateCentralizedPurchase").attr("action");

        	
        	//从页面中获取集中采购信息并封装，用于提交
        	var cpPurchaseInfoIdValue = $("#cpPurchaseInfoIdEdit").text();
        	//var select  = document.getElementById("productTypeIdEdit");
        	//var productTypeIdValue = select.options[select.selectedIndex].value;
        	var productTypeIdValue = $("#productTypeIdEdit").attr("value");
        	var productTypeNameValue = $("#productTypeNameQuery").attr("value");
        	var cpPurchaseInfoTitleValue = $("#cpPurchaseInfoTitleEdit").attr("value");
        	var measureUnitValue = $("#measureUnitEdit").attr("value");
        	var purchasePriceBeginValue = $("#purchasePriceBeginEdit").attr("value");
        	var purchasePriceEndValue = $("#purchasePriceEndEdit").attr("value");
        	select = document.getElementById("purchasePriceUnitEdit");
        	var purchasePriceUnitValue = select.options[select.selectedIndex].value;
        	var deadlineValue = $("#deadlineEdit").attr("value");
        	var telephoneValue = $("#telephoneEdit").attr("value");
        	var briefExplainValue = $("#briefExplainEdit").attr("value");
        	if(checkCPPI(cpPurchaseInfoTitleValue, measureUnitValue, telephoneValue, purchasePriceBeginValue, purchasePriceEndValue,briefExplainValue)==false)
        		return false;
        	var centralizedPurchaseStateValue = "1";
        	if($(valu).attr("value") == "保存"){
        		centralizedPurchaseStateValue = "0";
        	}

			var params={cpPurchaseInfoId:cpPurchaseInfoIdValue,
					productTypeId:productTypeIdValue,
					cpPurchaseInfoTitle:cpPurchaseInfoTitleValue,
					measureUnit:measureUnitValue,
					purchasePriceBegin:purchasePriceBeginValue,
					purchasePriceEnd:purchasePriceEndValue,
					purchasePriceUnit:purchasePriceUnitValue,
					deadline:deadlineValue,
					telephone:telephoneValue,
					briefExplain:briefExplainValue,
					centralizedPurchaseState:centralizedPurchaseStateValue,
					centraOrplaned:false,
					productTypeName:productTypeNameValue,
					async: false};
			$.post(url,params,function(data){
				$("#queryCentralizedPurchaseList").submit();
			});		        	
        }
        
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
//*************************************************************************************************
//倒数第一、二栏：集中采购信息事件处理
//************************************************************************************************* 
		function combineDemandConfirm(valu){
			var cpPurchaseInfoIdValue = $(valu).attr("name");
			$("#cpPurchaseInfoIdCombineDemandHidden").attr("value", cpPurchaseInfoIdValue);
			$("#combineDemandConfirm").submit();
		}
		
		function displayInfo(valu){
			var cpPurchaseInfoIdValue = $(valu).attr("name");
			$("#cpPurchaseInfoIdInfoHidden").attr("value", cpPurchaseInfoIdValue);
			$("#getCentralizedPurchaseInfo").submit();
		}
		
		function browseDemandInfo(valu){
			var cpPurchaseInfoIdValue = $(valu).attr("name");
			$("#cpPurchaseInfoIdDemandInfoHidden").attr("value", cpPurchaseInfoIdValue);
			$("#browseDemandInfo").submit();
		}
		
		function publishPrcie(valu){
			var cpPurchaseInfoIdValue = $(valu).attr("name");
			$("#cpPurchaseInfoIdPublishPriceHidden").attr("value", cpPurchaseInfoIdValue);
			$("#publishPrcie").submit();
		}
		
		//价格详情
		function browsePriceInfo(valu){
			var cpPurchaseInfoIdValue = $(valu).attr("name");
			$("#cpPurchaseInfoIdPriceInfoHidden").attr("value", cpPurchaseInfoIdValue);
			$("#browsePriceInfo").submit();			
		}
		
		//需求订单详情
		function browseDemandOrderInfo(valu){
			var cpPurchaseInfoIdValue = $(valu).attr("name");
			$("#cpPurchaseInfoIdDemandOrderHidden").attr("value", cpPurchaseInfoIdValue);
			$("#browseDemandOrderInfo").submit();
		}
	    
//*************************************************************************************************
//产品类型下拉列表处理
//************************************************************************************************* 	 
		//插入产品类型列表模块
		function insertProductTypeListModel(){
			var url = $("#getProductTypeTreeRoot").attr("action");
			$.post(url, {async:false}, insertProductTypeTreeCallBack, 'json');
			
			$('#menu>li').hover(function(){
				$(this).children('ul').show();
			},function(){
				$(this).children('ul').hide();
			});
		}
		
		//异步方法的回调函数：插入一级子类型、恢复状态
		function insertProductTypeTreeCallBack(data){
			insertProductTypeTreeRoot(data);
			syncTriggerMouseOver(document.getElementById("FirstLevelSubMenu"));
			recoverQueryCondition();
		}
		
		//插入一级子目录：根目录+一级子目录
		function insertProductTypeTreeRoot(data){
			var root = data.treeRootAjax;
			
			$("#titleMenu").attr("name", root.productTypeId);
			$("#titleMenu").text(root.productTypeName);
			$("#productTypeIdQuery").attr("value", root.productTypeId);
			$("#productTypeNameQuery").attr("value", root.productTypeName);			
			
			var list = "<ul id=\"FirstLevelSubMenu\" name=\"Level1SubMenu\" class=\"second-menu\">";
			list += "<li ><a name=\""+root.productTypeId+"\" href=\"#\" onmouseup=\"selectChanged(this)\">"+root.productTypeName+"</a></li>";
			$.each(root.childrenList, function(i, value){
				list += "<li onmouseover=\"processHover(this)\" onmouseout=\"processLeave(this)\"><a name=\""+value.productTypeId+"\" href=\"#\" onmouseup=\"selectChanged(this)\">"+value.productTypeName+"</a></li>";				
			});
			list += "</ul>";
			$("#mainMenu").append(list);
		}
		
		//自动触发子目录
		function syncTriggerMouseOver(param){
				$(param).children('li').each(function(){
					$(this).trigger("mouseover");
					$(this).trigger("mouseout");
				});				
		}
	
		//用户鼠标离开响应事件：隐藏子目录
		function processLeave(param){
			$(param).children('ul').hide();
		}

		//用户鼠标悬浮响应事件：加载子目录
		function processHover(param){
			if($(param).children('ul').size() > 0){$(param).children('ul').show();return false;}
			
			var url = $("#getProductTypeTreeBranch").attr("action");
			var param = {parentProductTypeId:$(param).children('a').eq(0).attr("name"), async:false};
			$.post(url, param, insertProductTypeTreeBranch, 'json');
		}
		
		//回调函数：插入子目录
		function insertProductTypeTreeBranch(data){
			var branch = data.treeBranchAjax;
			if(branch.length <= 0){return false;}
			
			var list = "<ul class=\"third-menu\">";
			$.each(branch, function(i, value){
				list += "<li onmouseover=\"processHover(this)\" onmouseout=\"processLeave(this)\"><a name=\""+value.productTypeId+"\" href=\"#\" onmouseup=\"selectChanged(this)\">"+value.productTypeName+"</a></li>";				
			});
			list += "</ul>";
			
			var id = branch[0].parentProductTypeId;
			var length = document.getElementsByName(id).length;
			if(length >= 1){
				var param = $("li[name="+id+"]:last");
				var param = $(document.getElementsByName(id)[length-1]);
				$(param).parent().append(list);
				$("#triggerStopTagHidden").attr("value", "false");
				syncTriggerMouseOver($(param).parent().children('ul')[0]);				
			}
		}
		
		//用户从下拉列表里选择了产品类型，响应事件
		function selectChanged(param){
			if($(param).parents("form").attr("id") =="queryCentralizedPurchaseList"){
				$("#queryCentralizedPurchaseList ul li a").eq(0).text($(param).text());
				$("#queryCentralizedPurchaseList ul li a").eq(0).attr("name", $(param).attr("name"));
				$("#productTypeIdQuery").attr("value", $(param).attr("name"));
				$("#productTypeNameQuery").attr("value", $(param).text());
				$("#queryCentralizedPurchaseList #mainMenu>ul").hide();			
			} else {
				$("#addUpdateCentralizedPurchase ul li a").eq(0).text($(param).text());
				$("#addUpdateCentralizedPurchase ul li a").eq(0).attr("name", $(param).attr("name"));
				$("#productTypeIdEdit").attr("value", $(param).attr("name"));
				$("#productTypeNameEdit").attr("value", $(param).text());
				$("#addUpdateCentralizedPurchase #mainMenu>ul").hide();					
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
        	$("#queryCentralizedPurchaseList").attr("action", "queryCentralizedPurchaseList.action?currentPage="+currentPage);
        	$("#queryCentralizedPurchaseList").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
        	$("#queryCentralizedPurchaseList").attr("action", "queryCentralizedPurchaseList.action?currentPage="+currentPage);
        	$("#queryCentralizedPurchaseList").submit();
		}			        
</script>
<style>
	#supply #showlist{ font-size:12px;}
</style>
</head>

<body>

	<!-- 辅助的表单及控件 -->
	<input type="hidden" id="treeBranchDataHidden" value=""/>
	<input type="hidden" id="triggerStopTagHidden" value="true" />
	<input type="hidden" id="productTypeIdStateHidden" value='<s:property value="#request.centralizedPurchase.productTypeId"/>'/>
	<input type="hidden" id="productTypeNameStateHidden" value='<s:property value="#request.centralizedPurchase.productTypeName"/>'/>
	<form id="getConditionQueryList" action="getConditionQueryList.action"></form>
	<form id="getProductTypeTreeRoot" action="getProductTypeTreeRoot.action"></form>
	<form id="getProductTypeTreeBranch" action="getProductTypeTreeBranch.action"></form>
	<form id="deleteCentralizedPurchase" action="deleteCentralizedPurchase.action"></form>
	<form id="getCentralizedPurchaseById" action="getCentralizedPurchaseById.action"></form>
	<form id="getCentralizedPurchaseInfo" action="getCentralizedPurchaseInfo.action">
		<input type="hidden" name="cpPurchaseInfoId" id="cpPurchaseInfoIdInfoHidden" value=""/>
	</form>
	<form id="combineDemandConfirm" action="combineDemandConfirm.action">
		<input type="hidden" name="cpPurchaseInfoId" id="cpPurchaseInfoIdCombineDemandHidden" />
	</form>
	<form id="browseDemandInfo" action="browseDemandInfo.action">
		<input type="hidden" name="cpPurchaseInfoId" id="cpPurchaseInfoIdDemandInfoHidden" />	
	</form>
	<form id="publishPrcie" action="publishPrcie.action">
		<input type="hidden" name="cpPurchaseInfoId" id="cpPurchaseInfoIdPublishPriceHidden" />
	</form>
	<form id="browseDemandOrderInfo" action="browseDemandOrderInfo.action">
		<input type="hidden" name="cpPurchaseInfoId" id="cpPurchaseInfoIdDemandOrderHidden" />
	</form>
	<form id="browsePriceInfo" action="browsePriceInfo.action">
		<input type="hidden" name="cpPurchaseInfoId" id="cpPurchaseInfoIdPriceInfoHidden" />
	</form>
	
	<div id="supply" class="CENTER">
	<div id="top">
	  <span><h2>集中采购</h2></span>
	</div>
	
	<form id="queryCentralizedPurchaseList" action="queryCentralizedPurchaseList.action" method="post">
	    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
	    	<tr class="TITLE">
	        	<td colspan="7"><span class="TITLESPAN1">组合条件查询</span></td>
	        </tr>
	        <tr>
	        	<td  align="right">标题</td>
	            <td >
	            	<select name="cpPurchaseInfoId" id="cpPurchaseInfoTitleQuery" style="width:150px;">
	                	<option>全部标题</option>
	                </select>
	            </td>
	            
	            <td  align="right">产品类别</td>
				<td id="productTypeQueryModelTD">
					<ul id="menu" class="first-menu">
					  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a></li>
					</ul>
					<input type="hidden" name="productTypeId" id="productTypeIdQuery" value=""/>
					<input type="hidden" name="productTypeName" id="productTypeNameQuery" value="根类别"/>				
				</td>	            
	            <!--
	            <td>
	            	<select name="productTypeId" id="productTypeIdQuery">
	                	<option>根类别</option>
	                </select>	            
	            </td>
	            -->
	            <td  align="right">集中采购状态</td>
	            <td >
	            	<select name="centralizedPurchaseState" id="centralizedPurchaseStateQuery" >
	                	<option value="-1">--请选择--</option>
	                	<option value="0">未发布</option>
	                	<option value="1">信息已发布</option>
	                	<option value="2">需求已合并</option>
	                	<option value="3">价格已发布</option>
	                	<option value="4">需求已确认</option>
	                	<option value="5">购买中</option>
						<option value="6">完成</option>	                	
	                </select>
	            </td>
	            <td  align="right">
	            	<input type="submit" class="BUTTON" value="查询" />
	                <input type="reset" class="BUTTON" value="清空" />
	                &nbsp;&nbsp;
	            </td>
	        </tr>
	    </table>
	</form>
	
	    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
	    	<thead>
		    	<tr class="TITLE" style="font-weight:bold;">
		        	<td>选择</td>
		            <td>信息代码</td>
		            <td>信息标题</td>
		            <td>产品类型</td>
		            <td>截止日期</td>
		            <td>价格区间</td>
		            <td>联系电话</td>
		            <td>度量单位</td>
		            <td>采购状态</td>
		            <td>发布时间</td>
		            <td>发布人</td>
		            <td colspan="2">&nbsp;</td>
		        </tr>	    	
	    	</thead>
			<tbody>
				<s:iterator id="element" value="#request.query">
		        	<tr class="HOVER">
		        		<td ><input name="centralizedPurchaseItem" type="checkbox" value="<s:property value="#element.cpPurchaseInfoId"/>" id="<s:property value="#element.centralizedPurchaseState"/>"/></td>
		          	    <td><s:property value="#element.cpPurchaseInfoId"/></td> 
		          	    <td><s:property value="#element.cpPurchaseInfoTitle"/></td> 
		          	    <td><s:property value="#element.productTypeName"/></td>
		          	    <td><s:property value="#element.deadline"/></td>
		          	    <td><s:property value="#element.purchasePriceInterval"/></td>
		          	    <td><s:property value="#element.telephone"/></td>
		          	    <td><s:property value="#element.measureUnit"/></td>
		          	    <td>
		          	    	<s:if test="%{#element.centralizedPurchaseState==0}">未发布</s:if>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==1}">信息已发布</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==2}">需求已合并</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==3}">价格已发布</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==4}">需求已确认</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==5}">购买中</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==6}">完成</s:elseif>
		          	    	<s:else>未发布</s:else>
		          	    </td>	    
		          	    <td ><s:property value="#element.publishDate"/></td>
		           	    <td ><s:property value="#element.publisherName"/></td>
						<!-- 倒数第二列：信息详情栏 -->
		            	<td>
		          	    	<s:if test="%{#element.centralizedPurchaseState==0}"><!-- 未发布 -->
								<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="displayRegister(this)" value="编辑" class="ARTBUTTON"/>
							</s:if>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==1}"><!-- 信息已发布 -->
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="displayInfo(this)" value="集中采购详情" class="ARTBUTTON"/><br />
		          	    	</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==2}"><!-- 需求已合并 -->
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="displayInfo(this)" value="集中采购详情" class="ARTBUTTON"/><br />
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="browseDemandInfo(this)" value="需求详情" class="ARTBUTTON"/>		
		          	    	</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==3}"><!-- 价格已发布 -->
    							<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="displayInfo(this)" value="集中采购详情" class="ARTBUTTON"/><br />
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="browseDemandInfo(this)" value="需求详情" class="ARTBUTTON"/><br />
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="browsePriceInfo(this)" value="价格详情" class="ARTBUTTON"/>
		          	    	</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==4}"><!-- 需求已确认 -->
    							<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="displayInfo(this)" value="集中采购详情" class="ARTBUTTON"/><br />
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="browseDemandInfo(this)" value="需求详情" class="ARTBUTTON"/><br />
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="browsePriceInfo(this)" value="价格详情" class="ARTBUTTON"/><br />         	    	
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="browseDemandOrderInfo(this)" value="需求订单详情" class="ARTBUTTON"/>         	    			          	    		
		          	    	</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==5}"><!-- 购买中 -->
    							<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="displayInfo(this)" value="集中采购详情" class="ARTBUTTON"/><br />
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="browseDemandInfo(this)" value="需求详情" class="ARTBUTTON"/><br />
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="browsePriceInfo(this)" value="价格详情" class="ARTBUTTON"/><br />         	    	    	    		          	    	
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="browseDemandOrderInfo(this)" value="需求订单详情" class="ARTBUTTON"/>         	    			          	    				          	    	
		          	    	</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==6}"><!-- 完成 -->
    							<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="displayInfo(this)" value="集中采购详情" class="ARTBUTTON"/><br />
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="browseDemandInfo(this)" value="需求详情" class="ARTBUTTON"/><br />
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="browsePriceInfo(this)" value="价格详情" class="ARTBUTTON"/><br />         	    	
		          	    		<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="browseDemandOrderInfo(this)" value="需求订单详情" class="ARTBUTTON"/>         	    			          	    				          	    	
		          	    	</s:elseif>
		          	    	<s:else><!-- 其他默认未提交 -->
								<input type="button" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="displayRegister(this)" value="编辑" class="ARTBUTTON"/>
		          	    	</s:else>
		            	</td>
		            	
		            	<!-- 最后一列：集中采购状态、操作栏 -->
		            	<td>
		            		<s:if test="%{#element.centralizedPurchaseState==0}"></s:if>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==1}">
								等待需求申报<br />
		          	    		<input type="button" class="BUTTON" onclick="combineDemandConfirm(this)" name="<s:property value="#element.cpPurchaseInfoId"/>" value="合并需求" />
							</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==2}">
		          	    		<input type="button" class="BUTTON" onclick="publishPrcie(this)" name="<s:property value="#element.cpPurchaseInfoId"/>" value="发布价格" />
							</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==3}">
		          	    		等待需求确认
		          	    	</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==4}">
								已经生成订单
		          	    	</s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==5}"></s:elseif>
		          	    	<s:elseif test="%{#element.centralizedPurchaseState==6}"></s:elseif>
		          	    	<s:else></s:else>
		            	</td>
		        	</tr>
		        </s:iterator>        
			</tbody>
			<tfoot>
				<tr>
					<td><input type="checkbox" name="allSelectBox" onclick="allSelected(this)" />全选</td>
		            <td><input type="button" class="BUTTON" onclick="deleteCentralizedPurchase(this)" value="删除" /></td>
		            <td><input type="button" class="BUTTON" onclick="displayRegister(this)" value="新建" /></td>
		            <td colspan="10" class="UPBOD" align="right">
		                <input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
		                <span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
		                <input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />
		            </td>
		        </tr>
			</tfoot>
	    </table>
	    
	<form id="addUpdateCentralizedPurchase" action="addCentralizedPurchase.action">
	  <br /><table id="register" class="CENTER" cellpadding="0">
	      <tr class="TITLE">
	        <td align="left"><b>&nbsp;集中采购信息</b> 注：<font color="#FF0000">*</font>为必填项</td>
	      </tr>
	      <tr>
	        <td>
	        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
	          <tr>
	            <td class="ALRIGHT">集中采购供应商代码</td>
	            <td class="ALLEFT"><label id="cpPurchaseInfoIdEdit"></label></td>
	            <td class="ALRIGHT">产品类型</td>
	            <td id="productTypeEditModelTD" class="ALLEFT">
					<ul id="menu" class="first-menu">
					  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a>
					  	
					  </li>
					</ul>
<!-- 					
	            	<input type="hidden" id="productTypeIdEdit" value=""/>
	            	<input type="hidden" id="productTypeNameEdit" value=""/>
 -->	            	
	            	
	            </td>
<!--
		            <td class="ALLEFT"> 
		            	<select id="productTypeIdEdit">
		                	
		                </select>
		            </td>
-->
	          </tr>
	          <tr>
	            <td class="ALRIGHT">集中采购信息标题</td>
	            <td class="ALLEFT"><input type="text" class="INPUTTEXT" id="cpPurchaseInfoTitleEdit"/><font color="#FF0000">*</font></td>
	            <td class="ALRIGHT">度量单位</td>
	            <td class="ALLEFT"><input type="text" class="INPUTTEXT" id="measureUnitEdit"/></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">采购价格区间</td>
	            <td class="ALLEFT" style="vertical-align:top;">
	            	<input type="text" class="SMALLINPUT" id="purchasePriceBeginEdit"/>&#8211;<input type="text" class="SMALLINPUT" id="purchasePriceEndEdit"/>
	 				<select id="purchasePriceUnitEdit">
	                	<option value="元">元</option>
	                    <option value="万元">万元</option>
	                </select>         	
	            </td>
	            <td class="ALRIGHT">截止日期</td>
	            <td class="ALLEFT"><input type="text" onclick="WdatePicker();" id="deadlineEdit"/></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">联系电话</td>
	            <td class="ALLEFT" colspan="3"><input type="text" class="INPUTTEXT" id="telephoneEdit"/></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">简要说明</td>
	            <td class="ALLEFT" colspan="3"><textarea name="textarea" style="height:40px;" class="LONGINPUT" id="briefExplainEdit"></textarea></td>
	          </tr>
	        </table></td>
	      </tr>
	      <tr>
	        <td align="center">
	        	<input type="button" class="BUTTON" onclick="saveCentralizedPurchase(this)" value="保存" />
	        	<input type="reset" class="BUTTON" onclick="hideRegister()" value="取消" />
	        	<input type="button" class="REDBUTTON" onclick="saveCentralizedPurchase(this)" value="保存并发布" />
	        </td>
	      </tr>
	  </table>
	</form>
	<div class="EMPTYDIV"></div>
	  <div id="DOWN">
	  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
	  </div>
	</div>
</body>
</html>
