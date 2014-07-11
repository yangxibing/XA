<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>产品类别管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/menu.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>
<script type="text/javascript"> 

		$().ready(function() {
		/*
			$.post("getProductTypeList.action", function(data) {
					$("#parentProductTypeIdQuery option").remove();
					$("#parentProductTypeIdQuery").append("<option value=\"\">--请选择--</option>");
					$.each(data.productTypeDropDownList, function(i, value) {
							$("#parentProductTypeIdQuery").append("<option value="+value.productTypeId+">"+value.productTypeName+"</option>");
						});
					$("#parentProductTypeIdQuery").attr("value", '<s:property value="#request.productTypeVO.parentProductTypeId"/>');
				
				}, 'json');
			$.post("getProductTypeList.action",{async: false}, function(data) {
					$("#parentProductTypeId option").remove();
					$("#parentProductTypeId").append("<option value=\"\">--请选择--</option>");
					$.each(data.productTypeDropDownList, function(i, value) {
						$("#parentProductTypeId").append("<option value="+value.productTypeId+">"+value.productTypeName+"</option>");
					});
				}, 'json');
		*/
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
			if($(param).parents("form").attr("id") =="listProductType"){
				$("#productTypeQueryModelTD ul li a").eq(0).text($(param).text());
				$("#productTypeQueryModelTD ul li a").eq(0).attr("name", $(param).attr("name"));
				$("#parentProductTypeIdQuery").attr("value", $(param).attr("name"));
				$("#parentProductTypeNameQuery").attr("value", $(param).text());
				$("#listProductType #mainMenu>ul").hide();			
			} else {
				$("#productTypeEditModelTD ul li a").eq(0).text($(param).text());
				$("#productTypeEditModelTD ul li a").eq(0).attr("name", $(param).attr("name"));
				$("#parentProductTypeId").attr("value", $(param).attr("name"));
				$("#parentProductTypeName").attr("value", $(param).text());
				$("#addProductType #mainMenu>ul").hide();				
			}
		}	
		
		//恢复状态
		function recoverSearchState(){
            var id = $("#productTypeIdStateHidden").attr("value");
            var name = $("#productTypeNameStateHidden").attr("value");
            if(id != null && id != ""){
	            $("#parentProductTypeIdQuery").attr("value", id);
	            $("#parentProductTypeNameQuery").attr("value", name);
				$("#titleMenu").attr("name", id);
				$("#titleMenu").text(name);           	
            } else {
	            $("#parentProductTypeIdQuery").attr("value", "");
	            $("#parentProductTypeNameQuery").attr("value", "根类别");
				$("#titleMenu").attr("name", "");
				$("#titleMenu").text("根类别");         
            }		
		}
		
		function displayRegister(valu) {
			prepareForAddUpdate();    
    		if(($(valu).attr("value"))=="新建") {
				$("#addProductType").attr("action","addProductType.action");
   				$("#register :text").each( function(){
   		 			$(this).attr("value","");
   		 		});
	
			} else {//点击编辑
				
				var productTypeIdValue=$(valu).attr("name");
				var url='selectProductTypeForPT.action';
				var params={productTypeId:productTypeIdValue,async: false};
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
        	$("#productTypeEditModelTD").append("<input type=\"hidden\" id=\"parentProductTypeId\" value=\"\"/><input type=\"hidden\" id=\"parentProductTypeName\" value=\"\"/>");
        	var root = $("#productTypeQueryModelTD #mainMenu ul li").eq(0).children('a').eq(0);
        	$("#productTypeEditModelTD ul li a").eq(0).text(root.text());
        	$("#productTypeEditModelTD ul li a").eq(0).attr("name", root.attr("name"));
        	$("#parentProductTypeId").attr("value", root.attr("name"));
        	$("#parentProductTypeName").attr("value", root.text());
        	$('#productTypeEditModelTD #menu li').hover(function(){
				$(this).children('ul').show();
			},function(){
				$(this).children('ul').hide();
			});
        }		
		
		function callBackFunction(data){
			var datas=data.ajaxResultSelectProductType;
			var a=new Array();
			a=datas.split(",");

			$("#productTypeId").attr("value", a[0]);
			$("#productTypeName").attr("value", a[1]);
/*			$("#parentProductTypeId option").each(function(){
	            	if($(this).attr("value") == a[2]) {
	            		$(this).attr("selected", true);
	            	}
			});
*/
		    var root = $(document.getElementsByName(a[2])[0]);
        	$("#productTypeEditModelTD ul li a").eq(0).text(root.text());
        	$("#productTypeEditModelTD ul li a").eq(0).attr("name", root.attr("name"));
        	$("#parentProductTypeId").attr("value", root.attr("name"));
        	$("#parentProductTypeName").attr("value", root.text());	
						
			$("#remark").attr("value", a[3]);
           	$("#addProductType").attr("action","updateProductType.action");
		}
        
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }

        function allSelected(){
        	if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='deleteProductType']").attr("checked",true);
        	}
        	else {
        		$("[name='deleteProductType']").attr("checked",false);
        	}
        }

        function deleteProductType(){
        	var f_str="";
        	var count=0;
			$("[name='deleteProductType']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});
			if(confirm("你真的要删除这项么？")){
					$.post("deleteProductType.action",{deleteProTypeIdList:f_str},function(data){
						$("#listProductType").attr("action","listProductType.action");
						$("#listProductType").submit();
					});
			}
        }

        function saveProductType() {
			var url=$("#addProductType").attr("action");
			var productTypeIdValue=$("#productTypeId").attr("value");
			var productTypeNameValue=$("#productTypeName").attr("value");
			var parentProductTypeIdValue=$("#parentProductTypeId").attr("value");
/*
			$("#parentProductTypeId option").each(function() {
				if($(this).attr("selected")==true) {
					parentProductTypeIdValue = $(this).attr("value");
        		}
			});
*/
						
			var remarkValue=$("#remark").attr("value");
			//验证输入信息
			if(productTypeIdValue==null||productTypeIdValue.length==0){
				alert("产品类型代码不能为空");
				return false;
			}
			if(!checkAllProductType(productTypeIdValue, productTypeNameValue, remarkValue)){
				return false;
			}	
			
			if(url.split(".")[0]=="addProductType"){
				var urlAjax='checkProductIdExistAjax.action';
				var params={productTypeId:productTypeIdValue,async: false};
				$.post(urlAjax,params,function(data){
				
					if(data.checkProductIdExistAjax == "exist"){
						alert("产品类别代码已经存在");
						return false;
					}else{
						var params={productTypeId:productTypeIdValue,
						productTypeName:productTypeNameValue,
						parentProductTypeId:parentProductTypeIdValue,
						remark:remarkValue,
						async: false};
			
						$.post(url,params, function(data){
						$("#listProductType").attr("action","listProductType.action");
						$("#listProductType").submit();
						});
					}
				},'json');	
			}else{
				var params={productTypeId:productTypeIdValue,
						productTypeName:productTypeNameValue,
						parentProductTypeId:parentProductTypeIdValue,
						remark:remarkValue,
						async: false};
			
				$.post(url,params, function(data){
					$("#listProductType").attr("action","listProductType.action");
					$("#listProductType").submit();
				});
			}
			
			
        }
        
        function resetButtonClick(){
        	
        	$("#productTypeIdQuery").attr("value","");
        	$("#productTypeNameQuery").attr("value","");
        }

		//分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#listProductType").attr("action", "listProductType.action?currentPage="+currentPage);
        	$("#listProductType").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#listProductType").attr("action", "listProductType.action?currentPage="+currentPage);
        	$("#listProductType").submit();
		}
            
</script>  
</head>

<body>

<input type="hidden" id="productTypeIdStateHidden" value='<s:property value="#request.productTypeVO.parentProductTypeId"/>'/>
<input type="hidden" id="productTypeNameStateHidden" value='<s:property value="#request.productTypeVO.parentProductTypeName"/>'/>
<form action="selectProductType" id="selectProductType" ></form>
<form id="queryProductTypeListServerSide" action="queryProductTypeListServerSide.action"></form>

<div id="supply" class="CENTER">
<div id="top">
  <span><h2>产品类别管理</h2></span>
</div>
	<form action="listProductType.action" method="post" id="listProductType">
    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE">
        	<td colspan="6"><b>&nbsp;组合条件查询</b></td>
        </tr>
        <tr>
        	<td class="BORDER" align="right">所属父类别名称</td>
            <td id="productTypeQueryModelTD">
				<ul id="menu" class="first-menu">
				  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a></li>
				</ul>
				<input type="hidden" name="parentProductTypeId" id="parentProductTypeIdQuery" value=""/>
				<input type="hidden" name="parentProductTypeName" id="parentProductTypeNameQuery" value="根类别"/>				
			</td>			
        
        	<td class="BORDER" align="right">产品类别代码</td>
            <td class="BORDER">
            	<input type="text" name="productTypeId" id="productTypeIdQuery" class="SMALLINPUT" value="<s:property value="#request.productTypeVO.productTypeId"/>"/>
            </td>
            <td class="BORDER" align="right">产品类别名称</td>
            <td class="BORDER">
            	<input type="text" name="productTypeName" id="productTypeNameQuery" class="SMALLINPUT" value="<s:property value="#request.productTypeVO.productTypeName"/>"/>
            </td>
            
<!--             
            <td class="BORDER">
            	<select name="parentProductTypeId" id="parentProductTypeIdQuery">
                </select>
            </td>
-->
        </tr>
        <tr>
            <td colspan="6" align="right" class="BORDER">
            	<input type="submit" class="BUTTON" value="查询" />
                <input type="button" onclick="resetButtonClick()" class="BUTTON" value="清空" />
            </td>
    	</tr>
    </table>
    </form>
    
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE" style="font-weight:bold;">
        	<td>选择</td>
            <td>产品类别代码</td>
            <td>产品类别名称</td>
            <td>所属父类别名称</td>
            <td>&nbsp;</td>
        </tr>
        <s:iterator id="element" value="#request.query">
        	<tr class="HOVER">
        		<td ><input type="checkbox" class="INPUTTEXT" name="deleteProductType" value="<s:property value='#element.productTypeId'/>"/></td>
            	<td ><s:property value="#element.productTypeId"/></td>
           	    <td ><s:property value="#element.productTypeName"/></td>
           	    <td ><s:property value="#element.parentProductTypeName"/></td>
            	<td><input type="button" class="BUTTON" name="<s:property value='#element.productTypeId'/>" onclick="displayRegister(this)" value="编辑"/></td>
        	</tr>
        </s:iterator>
        <tr>
        	<td><input type="checkbox" name="allSelectBox" onclick="allSelected()" />全选</td>
        	<td><input type="button" class="BUTTON" name="删除"  onclick="deleteProductType()" value="删除"/>
            	<input type="button" class="BUTTON" name="新建"  onclick="displayRegister(this)" value="新建" /></td>
            <td colspan="6" align="right">
	            <input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	            <span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	            <input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
	        </td>
        </tr>
    </table>
    
    
    <form id="addProductType" method="post" action="addProductType">
    <table id="register" class="CENTER" cellpadding="0">
        <tr class="TITLE">
            <td align="left"><span class="TITLESPAN1"><b>&nbsp;产品类别信息</b></span><span class="TITLESPAN2"> 注：<font color="#FF0000">*</font>为必填项</span></td>
        </tr>
        <tr>
            <td>
            <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
            <tr>
            <td class="ALRIGHT">产品类别代码</td>
            <td class="ALLEFT"><input name="productTypeId" id="productTypeId" type="text" class="INPUTTEXT"/>
              <font color="#FF0000">*</font></td>
            <td class="ALRIGHT">产品类别名称</td>
            <td class="ALLEFT"><input name="productTypeName" id="productTypeName" type="text" class="INPUTTEXT"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">所属父类别名称</td>
            <!-- 
            <td class="ALLEFT">
            	<select name="parentProductTypeId" id="parentProductTypeId">
                </select>
            </td>
            -->
            	<td id="productTypeEditModelTD" class="ALLEFT">
					<ul id="menu" class="first-menu">
					  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a></li>
					</ul>
					<input type="hidden" name="parentProductTypeId" id="parentProductTypeId" value=""/>
					<input type="hidden" name="parentProductTypeName" id="parentProductTypeName" value="根类别"/>				
				</td>
            
            <td class="ALRIGHT">备注</td>
            <td class="ALLEFT"><input name="remark" id="remark" type="text" class="INPUTTEXT"/></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td align="center">
          <input type="button" class="BUTTON" onclick="saveProductType()" value="保存" />
          <input type="button" class="BUTTON" onclick="hideRegister()" value="取消" /></td>
      </tr>
    </table>
    </form>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>


