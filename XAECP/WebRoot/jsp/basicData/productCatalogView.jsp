<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>产品目录查看</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<link href="../../css/menu.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script type="text/javascript">
	$().ready(function(){
		/*$.post("getProductTypeList.action", function(data) {
			$("#productTypeIdQuery option").remove();
			$("#productTypeIdQuery").append("<option value=\"\">--请选择--</option>");
			$.each(data.productTypeDropDownList, function(i, value) {
					$("#productTypeIdQuery").append("<option value="+value.productTypeId+">"+value.productTypeName+"</option>");
				});
			$("#productTypeIdQuery").attr("value", '<s:property value="#request.supplierProductVO.productTypeId"/>');
		
		}, 'json');*/
		
		recoverSearchState();
		$.post($("#queryProductTypeListServerSide").attr("action"), {async:false}, insertSearchCondition, 'json');
	});
	
		function insertSearchCondition(data){
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
				$("#productTypeIdQuery").attr("value", $(param).attr("name"));
				$("#productTypeNameQuery").attr("value", $(param).text());
				$("#productTypeQueryModelTD #mainMenu>ul").hide();			
		}	
		
		//恢复状态
		function recoverSearchState(){
            var id = $("#productTypeIdStateHidden").attr("value");
            var name = $("#productTypeNameStateHidden").attr("value");
            if(id != null && id != ""){
	            $("#productTypeIdQuery").attr("value", id);
	            $("#productTypeNameQuery").attr("value", name);
				$("#titleMenu").attr("name", id);
				$("#titleMenu").text(name);           	
            } else {
	            $("#parentProductTypeIdQuery").attr("value", "");
	            $("#parentProductTypeIdNameQuery").attr("value", "根类别");
				$("#titleMenu").attr("name", "");
				$("#titleMenu").text("根类别");         
            }		
		}
		
		function priceRelation(object){
			var productId = $(object).attr("name");
			$("#priceRelationForm").attr("action","productPriceWatch.action?productId="+productId);
			$("#priceRelationForm").submit();
		}
	
	//分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#listProductCatalog").attr("action", "listProductCatalog.action?currentPage="+currentPage);
        	$("#listProductCatalog").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#listProductCatalog").attr("action", "listProductCatalog.action?currentPage="+currentPage);
        	$("#listProductCatalog").submit();
		}
</script>
</head>

<body>

<input type="hidden" id="productTypeIdStateHidden" value='<s:property value="#request.supplierProductVO.productTypeId"/>'/>
<input type="hidden" id="productTypeNameStateHidden" value='<s:property value="#request.supplierProductVO.productTypeName"/>'/>
<form id="queryProductTypeListServerSide" action="queryProductTypeListServerSide.action"></form>
<form id="priceRelationForm" method="post"></form>
<div id="supply" class="CENTER">
<div id="top">
  <span><h2>产品目录查看</h2></span>
</div>

<form action="listProductCatalog.action" id="listProductCatalog" method="post">
    <table id="search" class="CENTER" cellspacing="0" cellpadding="2px">
    	<tr class="TITLE">
        	<td><span class="TITLESPAN1">组合条件查询</span></td>
            <td colspan="5"></td>
        </tr>
        <tr>
            <td class="BORDER" align="right">产品类别</td>
            <td id="productTypeQueryModelTD">
				<ul id="menu" class="first-menu">
				  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a></li>
				</ul>
				<input type="hidden" name="productTypeId" id="productTypeIdQuery" value=""/>
				<input type="hidden" name="productTypeName" id="productTypeNameQuery" value="根类别"/>				
			</td>            
            <!--  
            <td class="BORDER">
            	<select name="productTypeId" id="productTypeIdQuery">
                </select>
            </td> 
            -->       
        	<td class="BORDER" align="right">供应商名称</td>
            <td class="BORDER">
            	<input type="text" name="supplierName" class="INPUTTEXT" value="<s:property value="#request.supplierProductVO.supplierName"/>"/>
            </td>
            <td class="BORDER" align="right">产品名称</td>
            <td class="BORDER">
            	<input type="text" name="productName" class="INPUTTEXT" value="<s:property value="#request.supplierProductVO.productName"/>"/>
            </td>
        </tr>
        <tr>
            <td colspan="6" align="right" class="BORDER">
            	<input type="submit" class="BUTTON" value="查询" />
                <input type="reset" class="BUTTON" value="清空" />
            </td>
    	</tr>
    </table>
</form>
    
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE" style="font-weight:bold;">
        	<td>产品代码</td>
            <td>产品名称</td>
            <td>供应商名称</td>
            <td>产品类别</td>
            <td>规格</td>
            <td>基准价格（元）</td>
            <td>度量单位</td>
            <td>基地库存数量</td>
            <td>&nbsp;</td>
        </tr>
        
        <s:iterator id="element" value="#request.query">
        <tr class="HOVER">
            <td ><s:property value="#element.productId"/></td>
            <td ><s:property value="#element.productName"/></td>
            <td><a href="supplierInformation.jsp?supplierId='<s:property value="#element.supplierId"/>'"><s:property value="#element.supplierName"/>(链接)</a></td>
            <td ><s:property value="#element.productTypeName"/></td>
            <td><s:property value="#element.format"/></td>
            <td><s:property value="#element.basePrice"/></td>
            <td><s:property value="#element.measureUnit"/></td>
            <td><s:property value="#element.baseNumber"/></td>
            <td><input type="button" name="<s:property value="#element.productId"/>" class="BUTTON" onclick="priceRelation(this)" value="量价关系"/></td>
        </tr>
       </s:iterator>
        <tr>
            <td colspan="9" align="right">
	            <input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	            <span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	            <input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
	        </td>
        </tr>
    </table>
  <div class="EMPTYDIV"></div>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
