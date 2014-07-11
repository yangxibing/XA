<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>计划采购信息管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/menu.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>

<script type="text/javascript">

		$().ready(function() {
			/*$.post("getProductTypeList.action", function(data) {
					$("#productTypeIdQuery option").remove();
					$("#productTypeIdQuery").append("<option value=\"\">--请选择--</option>");
					$.each(data.productTypeDropDownList, function(i, value) {
							$("#productTypeIdQuery").append("<option value="+value.productTypeId+">"+value.productTypeName+"</option>");
						});
					$("#productTypeIdQuery").attr("value", '<s:property value="#request.planedPurchaseVO.productTypeId"/>');
				}, 'json');

			$("#isEnterOrderProcessQuery").attr("value", '<s:property value="#request.planedPurchaseVO.isEnterOrderProcess"/>');

			$.post("getProductTypeList.action", function(data) {
				$("#productTypeIdEdit option").remove();
				$("#productTypeIdEdit").append("<option value=\"\">--请选择--</option>");
				$.each(data.productTypeDropDownList, function(i, value) {
						$("#productTypeIdEdit").append("<option value="+value.productTypeId+">"+value.productTypeName+"</option>");
					});
			}, 'json');*/
			
				recoverSearchState();
				$.post($("#queryProductTypeListServerSide").attr("action"), {async:false}, insertSearchCondition, 'json');
			
			});
			
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
			if($(param).parents("form").attr("id") =="listPlanedPurchaseInfo"){
				$("#productTypeQueryModelTD ul li a").eq(0).text($(param).text());
				$("#productTypeQueryModelTD ul li a").eq(0).attr("name", $(param).attr("name"));
				$("#productTypeIdQuery").attr("value", $(param).attr("name"));
				$("#productTypeNameQuery").attr("value", $(param).text());
				$("#productTypeQueryModelTD #mainMenu>ul").hide();			
			} else {
				$("#productTypeEditModelTD ul li a").eq(0).text($(param).text());
				$("#productTypeEditModelTD ul li a").eq(0).attr("name", $(param).attr("name"));
				$("#productTypeIdEdit").attr("value", $(param).attr("name"));
				$("#productTypeNameEdit").attr("value", $(param).text());
				$("#productTypeEditModelTD #mainMenu>ul").hide();				
			}
		}	
		
		//恢复状态
		function recoverSearchState(){
			$("#isEnterOrderProcessQuery").attr("value", '<s:property value="#request.planedPurchaseVO.isEnterOrderProcess"/>');
            var id = $("#productTypeIdStateHidden").attr("value");
            var name = $("#productTypeNameStateHidden").attr("value");
            if(id != null && id != ""){
	            $("#productTypeIdQuery").attr("value", id);
	            $("#productTypeNameQuery").attr("value", name);
				$("#titleMenu").attr("name", id);
				$("#titleMenu").text(name);           	
            } else {
	            $("#productTypeIdQuery").attr("value", "");
	            $("#productTypeNameQuery").attr("value", "根类别");
				$("#titleMenu").attr("name", "");
				$("#titleMenu").text("根类别");         
            }		
		}			
		
		function displayRegister(valu) {
			prepareForAddUpdate(); 
			if(($(valu).attr("value")) == "新建") {
				$("#addPlanedPurchaseInfo").attr("action", "addPlanedPurchaseInfo.action");
            	$("#register :text").each( function() {
            		$(this).attr("value","");
            	});
            	$("#cpPurchaseInfoId").attr("value","代码自动生成");
            	$("#cpPurchaseInfoId").attr("readonly", true);
            	        	          	
			} else {
				$("#register :text").each( function() {
            		$(this).attr("value","");
            	});	
				var cpPurchaseInfoIdValue = $(valu).attr("name");
				var url='selectPlanedPurchaseInfo.action';
				var params={cpPurchaseInfoId:cpPurchaseInfoIdValue, async: false};
				$.post(url,params,callBackFunction,'json');
			}
			
			var subMenu=document.getElementById("register");
            subMenu.style.display = "block";						     
        }
        
		//预处理：插入下拉框
       function prepareForAddUpdate(){        	
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
        }        

		function callBackFunction(data) {
			var datas=data.ajaxResult;
			var a=new Array();
			a=datas.split(",");
			$("#cpPurchaseInfoId").attr("value",a[0]);
			$("#cpPurchaseInfoId").attr("readonly", true);
			$("#cpPurchaseInfoTitle").attr("value",a[1]);
			/*$("#productTypeIdEdit option").each( function() {
				if($(this).attr("value") == a[2]) {
            		$(this).attr("selected", true);
            	}
			});*/
		    var root = $(document.getElementsByName(a[2])[0]);
        	$("#productTypeEditModelTD ul li a").eq(0).text(root.text());
        	$("#productTypeEditModelTD ul li a").eq(0).attr("name", root.attr("name"));
        	$("#productTypeId").attr("value", root.attr("name"));
        	$("#productTypeName").attr("value", root.text());				
			
			$("#measureUnit option").each( function() {
				if($(this).val()==a[3]) {
					$(this).attr("selected", true);
				}
			});
			$("#combinePlanedNum").attr("value", a[4]);
           	$("#addPlanedPurchaseInfo").attr("action","updatePlanedPurchaseInfo.action");
		}
        
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
        function allSelected(){
        	if($("[name='allSelectBox']").attr("checked")==true) {
        		$("[name='planedPurchaseInfoItem']").attr("checked",true);
        	}
        	else {
        		$("[name='planedPurchaseInfoItem']").attr("checked",false);
        	}
        }

        function deletePlanedPurchaseInfo() {
            var f_str="";
            var count=0;
            $("[name='planedPurchaseInfoItem']").each(function() {
                if($(this).attr("checked")==true) {
                    f_str +=$(this).attr("value")+","
                    count++;
                }
            });
            if(confirm("你真的要删除这项么？")){
				$.post("deletePlanedPurchaseInfo.action",{planedPurchaseList:f_str},function(data){
					$("#listPlanedPurchaseInfo").attr("action","listPlanedPurchaseInfo.action");
					$("#listPlanedPurchaseInfo").submit();
				});
			}
        }

        function savePurchaseInfo() {
            var url=$("#addPlanedPurchaseInfo").attr("action");
            var cpPurchaseInfoIdValue=$("#cpPurchaseInfoId").attr("value");
            var cpPurchaseInfoTitleValue=$("#cpPurchaseInfoTitle").attr("value");
            var productTypeIdValue=$("#productTypeIdEdit").attr("value");
			/*$("#productTypeIdEdit option").each(function() {
				if($(this).attr("selected")==true) {
					productTypeIdValue=$(this).attr("value");
				}
			});*/
			
			var measureUnitValue="";
			$("#measureUnit option").each(function() {
				if($(this).attr("selected")==true) {
					measureUnitValue=$(this).attr("value");
				}
			});
            var combinePlanedNumValue=$("#combinePlanedNum").attr("value");
			if(checkPlanedPurchase(cpPurchaseInfoTitleValue, combinePlanedNumValue)==false)
				return false;
            var params={cpPurchaseInfoId:cpPurchaseInfoIdValue,
            		cpPurchaseInfoTitle:cpPurchaseInfoTitleValue,
            		productTypeId:productTypeIdValue,
            		measureUnit:measureUnitValue,
            		combinePlanedNum:combinePlanedNumValue,
					async: false};
			
            $.post(url,params, function(data) {
            	$("#listPlanedPurchaseInfo").attr("action","listPlanedPurchaseInfo.action");
				$("#listPlanedPurchaseInfo").submit();
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
        	$("#listPlanedPurchaseInfo").attr("action", "listPlanedPurchaseInfo.action?currentPage="+currentPage);
        	$("#listPlanedPurchaseInfo").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#listPlanedPurchaseInfo").attr("action", "listPlanedPurchaseInfo.action?currentPage="+currentPage);
        	$("#listPlanedPurchaseInfo").submit();
		}
</script>
<style>
#supply #showlist .newsTitle{width:300px; word-wrap:break-word; white-space:normal;}
</style>
</head>

<body>

<input type="hidden" id="productTypeIdStateHidden" value='<s:property value="#request.planedPurchaseVO.productTypeId"/>'/>
<input type="hidden" id="productTypeNameStateHidden" value='<s:property value="#request.planedPurchaseVO.productTypeName"/>'/>
<form id="queryProductTypeListServerSide" action="queryProductTypeListServerSide.action"></form>

<div id="supply" class="CENTER">
<div id="top">
  <span style="color:#FFF;"><h2>计划采购信息管理</h2></span>
</div>
	<form action="listPlanedPurchaseInfo.action" id="listPlanedPurchaseInfo" method="post">
	<table id="search" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE">
        	<td><span class="TITLESPAN1">组合条件查询</span></td>
            <td colspan="4"></td>
        </tr>
        <tr>
        	<td  align="right">是否进入订单</td>
            <td >
            	<select name="isEnterOrderProcess" id="isEnterOrderProcessQuery">
            		<option value="null">--请选择--</option>
            		<option value="false">否</option>
            		<option value="true">是</option>
            	</select>
            </td>
            <td  align="right">产品类型</td>
            <td id="productTypeQueryModelTD">
				<ul id="menu" class="first-menu">
				  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a></li>
				</ul>
				<input type="hidden" name="productTypeId" id="productTypeIdQuery" value=""/>
				<input type="hidden" name="productTypeName" id="productTypeNameQuery" value="根类别"/>				
			</td>
            <!--  
            <td >
            	<select name="productTypeId" id="productTypeIdQuery">
                </select>
            </td>
            -->
            <td  align="right">
            	<input type="submit" class="BUTTON" value="查询" />
                <input type="reset" class="BUTTON" value="清空" />
            </td>
         </tr>
    </table>
    </form>

    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE" style="font-weight:bold;">
        	<td>选择</td>
            <td>计划采购信息代码</td>
            <td>计划采购信息标题</td>
            <td>是否进入订单</td>
            <td>产品类型</td>
            <td>计划数量</td>
            <td>度量单位</td>
            <td>&nbsp;&nbsp;&nbsp;</td>
        </tr>
        
        <s:iterator id="element" value="#request.query">
        <tr class="HOVER">
        	<td><input name="planedPurchaseInfoItem" type="checkbox" class="INPUTTEXT" value="<s:property value="#element.cpPurchaseInfoId"/>" /></td>
            <td><s:property value="#element.cpPurchaseInfoId"/></td>
            <td class="newsTitle"><s:property value="#element.cpPurchaseInfoTitle"/></td>
			<td>
				<s:if test="%{#element.isEnterOrderProcess==1}">
					√
				</s:if>
            	<s:else>
           	    	×
           	    </s:else>
			</td>
			<td ><s:property value="#element.productTypeName"/></td>
            <td><s:property value="#element.combinePlanedNum"/></td>
            <td><s:property value="#element.measureUnit"/></td>
            <td><input type="button" class="BUTTON" name="<s:property value="#element.cpPurchaseInfoId"/>" onclick="displayRegister(this)" value="编辑"/></td>
        </tr>
        </s:iterator>
        
        <tr>
        	<td align="left"><input name="allSelectBox" type="checkbox" onclick="allSelected()"/>全选</td>
            <td><input type="button" class="BUTTON" onclick="deletePlanedPurchaseInfo()" value="删除" />
        		<input type="button" class="BUTTON" onclick="displayRegister(this)" value="新建" /></td>
            <td colspan="6" class="UPBOD" align="right">
	            <input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	            <span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	            <input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
	        </td>
        </tr>
    </table>
    
	<form id="addPlanedPurchaseInfo" method="post">
   <table id="register" class="CENTER" cellpadding="0">
      <tr class="TITLE">
        <td align="left"><span class="TITLESPAN1"><b>计划采购信息</b></span> <span class="TITLESPAN2">注：<font color="#FF0000">*</font>为必填项</span></td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
          <tr>
            <td class="ALRIGHT">计划采购信息代码</td>
            <td class="ALLEFT"><input name="cpPurchaseInfoId" id="cpPurchaseInfoId" type="text" value="1" class="INPUTTEXT"/></td>
            <td class="ALRIGHT">计划采购信息标题</td>
            <td class="ALLEFT"><input name="cpPurchaseInfoTitle" id="cpPurchaseInfoTitle" type="text" class="INPUTTEXT"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">产品类型</td>
            	<td id="productTypeEditModelTD" align="left">
					<ul id="menu" class="first-menu">
					  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a></li>
					</ul>
					<input type="hidden" name="productTypeId" id="productTypeIdEdit" value=""/>
					<input type="hidden" name="productTypeName" id="productTypeNameEdit" value="根类别"/>				
				</td>            
            <!--  
            <td class="ALLEFT">
            	<select name="productTypeId" id="productTypeIdEdit">
                </select>
            </td> 
            -->         
            <td class="ALRIGHT">度量单位</td>
            <td class="ALLEFT">
            	<select name="measureUnit" id="measureUnit">
                	<option value="吨">吨</option>
                	<option value="千克">千克</option>
                	<option value="张">张</option>
                	<option value="箱">箱</option>
                	<option value="kg">kg</option>
                </select>
            </td>
          </tr>
          <tr>
          	<td class="ALRIGHT">计划数量</td>
            <td colspan="3" class="ALLEFT"><input name="combinePlanedNum" id="combinePlanedNum" type="text" class="INPUTTEXT"/></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td align="center">
          <input type="button" class="BUTTON" onclick="savePurchaseInfo()" value="保存" />
          <input type="reset" class="BUTTON" onclick="hideRegister()" value="取消" />
        </td>
      </tr>
  </table>
</form>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>