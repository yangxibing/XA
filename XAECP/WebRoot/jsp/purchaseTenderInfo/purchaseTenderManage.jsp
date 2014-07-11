<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>采购/招标信息管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<link href="../../css/menu.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>

<script type="text/javascript"> 
		function displayRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
        //新建准备
		function prepareForAddUpdate(){
			$.post($("#queryProductTypeListServerSide").attr("action"), {async:false}, insertSearchCondition, 'json');
		}

		//回调函数
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
        
        function clearNewUpdate(){
        	$("#title").attr("value", "");
        	$("#effectiveDate").attr("value", "");
        	$("#publishType").attr("value", 0);
			$("#content").attr("value", "");        
        }
        
        function newPurchaseTender(){
        	
        	/*var url = "selectProductType.action";
        	$.post(url,function(data){
        		$.each(data.productTypes,function(i,value){
        		
        			var str = "<option value='"+value.productTypeId+"'>"+value.productTypeName+"</option>";
        			$("#productType").append(str);
        		});
        		$("#saveButton").attr("name","新建保存");
        		displayRegister();
        	});*/
        	clearNewUpdate();
			
			$("#productType").attr("value", "");
	        $("#productTypeName").attr("value", "根类别");
			$("#titleMenu").attr("name", "");
			$("#titleMenu").text("根类别");
			
			$("#effectiveDate").attr("value", "");
			$("#publishContent").attr("value", "");
			$("#saveButton").attr("name","新建保存");
			displayRegister();
			prepareForAddUpdate();        	
        }
        
        function edit(valu){
       	    var supplierId=$(valu).attr("name").split("?*")[0];
        	var id=$(valu).attr("name").split("?*")[1];
        	var title=$(valu).attr("name").split("?*")[2];
        	var productTypeId=$(valu).attr("name").split("?*")[3];
        	var effectiveDate=$(valu).attr("name").split("?*")[4];
        	var publishType=$(valu).attr("name").split("?*")[5];
        	var publishContent=$(valu).attr("name").split("?*")[6];
        	var productTypeName = $(valu).attr("name").split("?*")[7];
        	/*var url = "selectProductType.action";
        	$.post(url,function(data){
        		$.each(data.productTypes,function(i,value){
        			var str="";
        			if(value.productTypeId==productTypeId){
        				str = "<option value='"+value.productTypeId+"' selected>"+value.productTypeName+"</option>";
        			}else{
        				str = "<option value='"+value.productTypeId+"'>"+value.productTypeName+"</option>";
        			}
        			$("#productType").append(str);
        		});        	});*/
        		$("#productType").attr("value", productTypeId);
	            $("#productTypeName").attr("value", productTypeName);
				$("#titleMenu").attr("name", productTypeId);
				$("#titleMenu").text(productTypeName);   
				
        		$("#title").attr("value",title);
        		$("#effectiveDate").attr("value",effectiveDate);
        		$("#content").attr("value",publishContent);
        		$("#publishType>option").each(function(){
        			if($(this).attr("value")==publishType){
        				$(this).attr("selected",true);
        			}
        		});
        		$("#saveButton").attr("name",id);
        	
        	displayRegister();
			prepareForAddUpdate();     
        }
        function save(valu){
        	
        	var titleV=$("#title").attr("value");
        	var productTypeV=$("#productType").attr("value");
        	var effectiveDateV=$("#effectiveDate").attr("value");
        	var publishTypeV=$("#publishType").attr("value");
        	var publishContentV=$("#content").text();
        	if(checkAllSupplyProduct(titleV, publishContentV)==false)
        		return false;
        	var url="savePurchaseTender.action";
        	var params={
        					title:titleV,
        					productTypeId:productTypeV,
        					effectiveDate:effectiveDateV,
        					publishType:publishTypeV,
        					publishContent:publishContentV
        					
        				};
        	if($(valu).attr("name")!="新建保存"){
        		url="updatePurchaseTender.action";
        		var supplierIdV=$("#edit").attr("name").split("?*")[0];
        		params={
        					id:$(valu).attr("name"),
        					title:titleV,
        					productTypeId:productTypeV,
        					effectiveDate:effectiveDateV,
        					publishType:publishTypeV,
        					publishContent:publishContentV,
        					supplierId:supplierIdV
        				};
        	}
        	
        	
        	$.post(url,params,function(data){
        		$("#hhh").submit();
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
        	$("#list>tr").each(function(){
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
        			var url = "deletePurchaseTenderInfo.action";
        			var params={idList:idListV};
        			$.post(url,params,function(data){
        				$("#hhh").submit();
        			});
        		}
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
        	$("#hhh").attr("action", "listSupplyPurchaseInformation.action?currentPage="+currentPage);
        	$("#hhh").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#hhh").attr("action", "listSupplyPurchaseInformation.action?currentPage="+currentPage);
        	$("#hhh").submit();
		}
        
        
</script>
</head>

<body>
<form id="hhh" action="listSupplyPurchaseInformation.action" method="post"></form>
<form id="queryProductTypeListServerSide" action="queryProductTypeListServerSide.action"></form>
<div id="supply" class="CENTER">
<div id="top">
  <span><h2>采购/招标信息管理</h2></span>
</div>
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<thead>
    	<tr class="TITLE">
        	<td>选择</td>
            <td>序号</td>
            <td>标题</td>
            <td>发布类型</td>
            <td>产品类别</td>
            <td>有效日期</td>
            <td>采购商名称</td>
            <td>浏览人次</td>
            <td>发布人</td>
            <td>发布时间</td>
            <td>&nbsp;</td>
        </tr>
        </thead >
        <tbody id="list">
        <s:iterator id="element" value="#request.supplyPurchaseInformations">
        <tr class="HOVER">
        	<td ><input name="checkbox" type="checkbox" class="INPUTTEXT"/></td>
            <td ><s:property value="#element.id"/></td>
            <td ><s:property value="#element.title"/></td>
            <td ><s:property value="#element.publishTypeName"/></td>
            <td ><s:property value="#element.productTypeName"/></td>
            <td ><s:property value="#element.effectiveDate"/></td>
            <td ><s:property value="#element.partnerName"/></td>
            <td ><s:property value="#element.visitNumber"/></td>
            <td ><s:property value="#element.publisher"/></td>
            <td ><s:property value="#element.publishDate"/></td>
            <td><input type="button" onClick="edit(this);" id="edit" name="<s:property value='#element.supplierId'/>?*<s:property value='#element.id'/>?*<s:property value='#element.title'/>?*<s:property value='#element.productTypeId'/>?*<s:property value='#element.effectiveDate'/>?*<s:property value='#element.publishType'/>?*<s:property value='#element.publishContent'/>?*<s:property value='#element.productTypeName'/>" class="BUTTON"   value="编辑"/></td>
        </tr>
        </s:iterator>
        </tbody>
        <tr>
        	<td colspan="2" align="left"><input onclick="allSelect(this);" type="checkbox" />全部选中</td>
            <td><input type="button" onclick="deleteById();" class="BUTTON" value="删除" /></td>
            <td><input type="button" class="BUTTON" onclick="newPurchaseTender()" value="新建" /></td>
            <td colspan="6" class="UPBOD" align="right">
            	<input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	            <span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	           	<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
            </td>
            <td></td>
        </tr>
    </table>
<form>
  <table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr class="TITLE">
        <td align="left"><span class="TITLESPAN1">采购/招标信息</span><span class="TITLESPAN2">注：<font color="#FF0000">*</font>为必填项</span></td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
          <tr>
            <td class="ALRIGHT">标题</td>
            <td class="ALLEFT" colspan="3"><input id="title" type="text" class="LONGINPUT"/>
              <font color="#FF0000">*</font></td>
          </tr>
          <tr>
            <td class="ALRIGHT">产品类别</td>
            <td id="productTypeQueryModelTD">
				<ul id="menu" class="first-menu">
				  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a></li>
				</ul>
				<input type="hidden" name="productTypeId" id="productType" value="000000"/>
				<input type="hidden" name="productTypeName" id="productTypeName" value="根类别"/>				
			</td>            
            <!--  
            <td class="ALLEFT">
            	<select id="productType"></select>
            </td>
            -->
            <td class="ALRIGHT">有效日期</td>
            <td class="ALLEFT"><input type="text" id="effectiveDate" class="INPUTTEXT" onclick="WdatePicker();"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">发布类型</td>
            <td class="ALLEFT" colspan="3">
            	<select id="publishType">
            		<option value="0">供货</option>
            		<option value="1">采购</option>
            		<option value="2">招标</option>
            	</select>
            </td>
          </tr>
          <tr>
            <td class="ALRIGHT">内容</td>
            <td class="ALLEFT" colspan="3"> <textarea id="content" style="height:200px;" class="LONGINPUT"></textarea></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td align="center"><input id="saveButton" type="button" onclick="save(this);" class="BUTTON" value="保存" />
          <input type="reset" class="BUTTON" onclick="hideRegister()" value="取消" /></td>
      </tr>
  </table>
</form>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
