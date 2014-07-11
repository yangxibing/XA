<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>供应商产品目录管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/menu.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>
<script type="text/javascript">
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
				$("#productTypeId").attr("value", $(param).attr("name"));
				$("#productTypeName").attr("value", $(param).text());
				$("#productTypeQueryModelTD #mainMenu>ul").hide();		
		}

	function displayRegister(valu) { 
		if(($(valu).attr("value"))=="新建"){
				$("#productId").attr("disabled",false);
				$("#addSupplierProduct").attr("action","addSupplierProduct.action");
           		 $("#register :text").each(function(){
           		 	$(this).attr("value","");
           		 });
           		 $("#productId").attr("disable",false);
           		$("#productTypeId").attr("value", "");
		        $("#productTypeName").attr("value", "根类别");
				$("#titleMenu").attr("name", "");
				$("#titleMenu").text("根类别");
			}else{
				var productIdValue=$(valu).attr("name");
				var url='selectSupplierProduct.action';
				var params={productId:productIdValue,async: false};
				$.post(url,params,callBackFunction,'json');
			} 
			var subMenu=document.getElementById("register");
           	subMenu.style.display = "block";
           	
           	prepareForAddUpdate();
    }
	
	function callBackFunction(data){
			var datas=data.ajaxResult;
			var a=new Array();
			a=datas.split(",");
			var subMenu=document.getElementById("register");
           	subMenu.style.display = "block";
            $("#productId").attr("value",a[0]);
            $("#productName").attr("value",a[1]);
            $("#measureUnit").attr("value",a[2]);
            $("#remark").attr("value",a[3]);
            //$("#productTypeId").attr("value",a[4]);
            
	        $("#productTypeId").attr("value", a[4]);
	        $("#productTypeName").attr("value", a[7]);
			$("#titleMenu").attr("name", a[4]);
			$("#titleMenu").text(a[7]);            
            
            $("#basePrice").attr("value",a[5]);
            $("#format").attr("value",a[6]);
           	$("#addSupplierProduct").attr("action","updateSupplierProduct.action");
			$("#productId").attr("disabled",true);
		}
	
	function hideRegister(valu) {
        var url=$("#addSupplierProduct").attr("action");
        
        if($(valu).attr("value")=="保存"){
			var supplierId = '<s:property value="#request.supplierId"/>';
			if($("#productId").attr("value")==null||$("#productId").attr("value").length==0){
				alert("请输入产品代码");
				return false;
			}
        	var  params={ productId:$("#productId").attr("value"),
        				  productName:$("#productName").attr("value"),
        				  measureUnit:$("#measureUnit").attr("value"),
        				  remark:$("#remark").attr("value"),
        				  productTypeId:$("#productTypeId").attr("value"),
        				  basePrice:$("#basePrice").attr("value"),
        				  format:$("#format").attr("value"),
        				  supplierId:supplierId
        				 };
        	if(!productAllCheck($("#productId"), $("#productName"), $("#basePrice"), $("#measureUnit"), $("#format"), $("#remark"))){
        		return false;
        	}
        	
        	if(url.split(".")[0]=="addSupplierProduct"){
        		$.post("chekProductIdExsitAjax.action", {productId:$("#productId").attr("value")}, function(data){
        		if(data.chekProductIdExsitAjax=="exist"){
        			alert("产品代码已经存在，请使用其他产品代码");
        			return false;
        		}else{
        			$.post(url,params,function(data){
        				listSupplierProduct();
        				var subMenu=document.getElementById("register");
           				subMenu.style.display = "none"; 
        			});		
        		}
        		});
        	}else{
        		$.post(url,params,function(data){
        				listSupplierProduct();
        				var subMenu=document.getElementById("register");
           				subMenu.style.display = "none"; 
        		});
        	}
        	

        }if($(valu).attr("value")=="取消"){
        	var subMenu=document.getElementById("register");
           	subMenu.style.display = "none"; 
        }
    } 
   
    	function allSelected(valu){
        	if($(valu).attr("checked")==true){
        		$("input[name='deletePro']").each(function(){
        			$(this).attr("checked",true);
        		});
        	}else{
        		$("input[name='deletePro']").each(function(){
        			$(this).attr("checked",false);
        		});
        	}
        }
    
    function deleteSupplierProduct(){
        	var f_str="";
        	var count=0;
        	var supplierId = '<s:property value="#request.supplierId"/>';
			$("[name='deletePro']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});
			if(confirm("你真的要删除这"+count+"项么？")){
					
					$.post("deleteSupplierProduct.action",{supplierProductList:f_str},function(data){
						$("#selectProduct").attr("action","listSupplierProduct.action?supplierId="+supplierId);
						$("#selectProduct").submit();
					});
			}
        }
        function listSupplierProduct(){
			var supplierIdV= $("#supplierId2").attr("value");
        	$("#selectProduct").attr("action","listSupplierProduct.action?supplierId="+supplierIdV);
        	$("#selectProduct").submit();
        }
        
        function priceRelation(valu){
      
        	var value=$(valu).attr("name");
    
        	$("#productPriceId").attr("value",value);
        	$("#priceRelation").submit();
        }

      	//分页处理
        function prePage(){
        	var supplierId = '<s:property value="#request.supplierId"/>';
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#selectProduct").attr("action", "listSupplierProduct.action?currentPage="+currentPage+"&&supplierId="+supplierId);
        	$("#selectProduct").submit();
        }

		function nextPage(){
			var supplierId = '<s:property value="#request.supplierId"/>';
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#selectProduct").attr("action", "listSupplierProduct.action?currentPage="+currentPage+"&&supplierId="+supplierId);
        	$("#selectProduct").submit();
		}
</script> 

</head>

<body>
<form id="priceRelation" action="productPrice.action" method="post"><input type="hidden" id="productPriceId" name="productId"/></form>
<form id="queryProductTypeListServerSide" action="queryProductTypeListServerSide.action"></form>
<div id="supply" class="CENTER">
<input type="hidden" name="supplierId" id="supplierId2" value="<s:property value="#request.supplierId"/>"/>
<div id="top">
    	<span style="color:#FFF;"><h2>供应商产品目录管理</h2></span>
</div>
	<form id="selectProduct" method="post">
    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE">
        	<td >组合条件查询</td>
            <td colspan="6"></td> 
        </tr>
        <tr>
        	<td class="BORDER" align="right">产品代码</td>
            <td class="BORDER"><input type="text" name="productId" value="<s:property value="supplierProduct.productId"/>" class="INPUTTEXT" /></td>
            <td class="BORDER" align="right">产品名称</td>
            <td class="BORDER"><input type="text" name="productName" value="<s:property value="supplierProduct.productName"/>" class="INPUTTEXT" /></td>
            <td class="BORDER"><input type="button" onClick="listSupplierProduct()" class="BUTTON"  value="查询" /></td>
            <td class="BORDER"><input type="button" class="BUTTON"  value="清空" /></td>
        </tr>
    </table>
    </form>
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr style=" font-weight:bold;" class="TITLE">
        	<td>选择</td>
            <td>产品代码</td>
            <td>产品名称</td>
            <td>产品类别</td>
            <td>规格</td>
            <td>基准价格（元）</td>
            <td>度量单位</td>
            <td colspan="2">&nbsp;</td>
        </tr>
        <s:iterator id="element" value="#request.productList">
        <tr class="HOVER">
        	<td ><input type="checkbox" name="deletePro" value="<s:property value="#element.productId"/>"/></td>
            <td ><s:property value="#element.productId"/></td>
            <td ><s:property value="#element.productName"/></td>
            <td ><s:property value="#element.productTypeName"/></td>
            <td><s:property value="#element.format"/></td>
            <td><s:property value="#element.basePrice"/></td>
            <td><s:property value="#element.measureUnit"/></td>
            <td><input type="button" class="BUTTON" name="<s:property value="#element.productId"/>" onclick="displayRegister(this)" value="编辑"></td>
            <td><input type="button" name="<s:property value="#element.productId"/>" class="BUTTON" onClick="priceRelation(this)" value="量价关系"></td>
        </tr>
       </s:iterator>
        <tr>
        	<td><input type="checkbox" id="allSelected" onClick="allSelected(this)"/>全部选中</td>
            <td><input type="button" class="BUTTON" onclick="deleteSupplierProduct()" value="删除" /></td>
            <td><input type="button" class="BUTTON" name="xinjian" onclick="displayRegister(this)" value="新建" /></td>
 			<td colspan="6" align="right">
            	<input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	        	<span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	        	<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
	        </td>
        </tr>
    </table>
    <form id="addSupplierProduct" method="post">
    <table id="register" class="CENTER">
    	<tr class="TITLE">
        	<td align="left"><b>供应商所提供产品信息 </b>       注：<font color="#FF0000">*</font>为必填项</td>
        </tr>
        <tr>
        	<td>
            	<table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
                	<tr>
                    	<td class="ALRIGHT">产品代码</td>
                        <td class="ALLEFT">
                        	<input type="text" name="productId" id="productId" class="INPUTTEXT"/>
                            <font color="#FF0000">*</font>
                        </td>
                    	<td class="ALRIGHT">产品名称</td>
                        <td class="ALLEFT"><input type="text" name="productName" id="productName" class="INPUTTEXT" />
                        </td>                                              
                        
                        <!--  
                        <td class="ALLEFT">
                        	<input type="text" name="productTypeId" id="productTypeId" class="INPUTTEXT" />
                            <font color="#FF0000">*</font>
                        </td>
                        -->
                    </tr>
                    <tr>
                        <td class="ALRIGHT">产品类别</td>
			            <td id="productTypeQueryModelTD">
							<ul id="menu" class="first-menu">
							  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a></li>
							</ul>
							<input type="hidden" name="productTypeId" id="productTypeId" value=""/>
							<input type="hidden" name="productTypeName" id="productTypeName" value="根类别"/>				
						</td>                    
                        <td class="ALRIGHT">基准价格（元）</td>
                        <td class="ALLEFT">
                        	<input type="text" name="basePrice" id="basePrice" class="INPUTTEXT" />
                        </td>
                    </tr>
                    <tr>
                    	<td class="ALRIGHT">度量单位
                        </td>
                        <td class="ALLEFT"><input type="text" name="measureUnit" id="measureUnit" class="INPUTTEXT" />
                        	<font color="#FF0000">*</font>
                        </td>
                        <td class="ALRIGHT">规格</td>
                        <td class="ALLEFT"><input type="text" name="format" id="format" class="INPUTTEXT" /></td>
                    </tr>
                    <tr>
                    	<td class="ALRIGHT">备注</td>
                        <td class="ALLEFT" colspan="3"><input style="width:400px;" id="remark" name="remark" type="text" class="INPUTTEXT" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
        	<td align="center">
            	<input type="button" class="BUTTON" onclick="hideRegister(this)" value="保存" />
                <input type="button" class="BUTTON" onclick="hideRegister(this)" value="取消" />
            </td>
        </tr>
    </table>
    </form>
<div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
</div>
</div>
</body>
</html>
