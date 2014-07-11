<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>供应商目录管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
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
        
        function newPrice(){
        	$("#startNumber").attr("disabled",false);
        	$("#endNumber").attr("disabled",false);
        	$("#newPriceForm").attr("action","addPrice.action");
				var subMenu=document.getElementById("register");
           		subMenu.style.display = "block";
           		$("#register :text").each(function(){
           		 	$(this).attr("value","");
           		 });
        }
        function save(){
        	//验证输入	
        	if(priceRelationCheck($("#startNumber"), $("#endNumber"), $("#price"), $("#remark"))==false){
        		return false;
        	}
        	var url=$("#newPriceForm").attr("action");
			var productId = '<s:property value="#request.productId"/>';
        	var  params={ startNumber:$("#startNumber").attr("value"),
        				  endNumber:$("#endNumber").attr("value"),
        				  price:$("#price").attr("value"),
        				  remark:$("#remark").attr("value"),
        				  productId:productId,
        				  measureUnit:$("#measureUnit").attr("value")
        				 };
        	//验证数量区间是否存在
        	$.post("checkNumberIntervalExistAjax.action", {productId:productId, startNumber:$("#startNumber").attr("value"), endNumber:$("#endNumber").attr("value")}, function(data){
        		if(data.checkNumberIntervalExistAjax == "exist"){
        			alert("数量区间已经存在");
        			return false;
        		}else{
        			$.post(url,params,function(data){
        				listPrice();
        			});
        		}
        	
        	});

        }  
        
        function listPrice(){
        	var productId = '<s:property value="#request.productId"/>';
			$("#listPriceForm").attr("action", "productPrice.action?productId="+productId);
        	$("#listPriceForm").submit();
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
    	
    	function edit(valu){
    		displayRegister();
    		var numverIntervalValue=$(valu).attr("name").split("?*")[0];
    		
    		var productIdValue=$("#productId").attr("value");
        	if($("#productId").attr("value")==""){
        		productIdValue=$(valu).attr("name").split("?*")[1];
        	}
			var url="selectPrice.action";
			var params={productId:productIdValue,async: false,numberInterval:numverIntervalValue};
			$.post(url,params,callBackFunction,'json');
    	}
    	
    	function callBackFunction(data){
    	
    		$("#newPriceForm").attr("action","updatePrice.action");
    		var a=new Array();
    		a=data.ajaxResult.split(",");
    		$("#register :text").each(function(){
           		 	$(this).attr("value","");
           		 });
    		$("#startNumber").attr("value",a[0])
    		$("#endNumber").attr("value",a[1]);
    		$("#price").attr("value",a[2]);
    		$("#remark").attr("value",a[3]);
    		$("#productId").attr("value",a[4]);
    		$("#startNumber").attr("disabled",true);
    		$("#endNumber").attr("disabled",true);
    	}
    	
    	function deletePrice(){
    		var productId = '<s:property value="#request.productId"/>';
    		var f_str="";
        	var count=0;
			$("[name='deletePro']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});
			
			var productIdValue=productId;
        	if($("#productId").attr("value")==""){
        		productIdValue=$(valu).attr("name").split("?*")[1];
        	}
			if(confirm("你真的要删除这"+count+"项么？")){
					
					$.post("deletePrice.action",{productId:productIdValue,priceList:f_str},function(data){
						listPrice();
					});
			}
    	}
    	
    	//分页处理
        function prePage(){
        	var productId = '<s:property value="#request.productId"/>';
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
			$("#listPriceForm").attr("action", "productPrice.action?currentPage="+currentPage+"&&productId="+productId);
        	$("#listPriceForm").submit();
        }

		function nextPage(){
		    var productId = '<s:property value="#request.productId"/>';
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#listPriceForm").attr("action", "productPrice.action?currentPage="+currentPage+"&&productId="+productId);
        	$("#listPriceForm").submit();
		}
</script> 

</head>

<body>
<form id="listPriceForm" method="post" action=productPrice.action>
</form>
<div id="supply" class="CENTER">
<div id="top">
    	<span style="color:#FFF;"><h2>供应商所提供产品量价关系</h2></span>
</div>
    
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr style=" font-weight:bold;" class="TITLE">
        	<td >选择</td>
            <td >数量区间</td>
            <td >度量单位</td>
            <td >价格（元）<input type="hidden" name="productId" id="productId" value="<s:property value="supplierProduct.productId"/>"/></td>
        </tr>
        <s:iterator id="element" value="#request.productPriceList">
        <tr>
        	<td ><input type="checkbox" name="deletePro" value="<s:property value="#element.numberInterval"/>"/></td>
            <td ><s:property value="#element.numberInterval"/></td>
            <td ><s:property value="#element.measureUnit"/></td>
            <td ><s:property value="#element.price"/></td>
        </tr>
       </s:iterator>
        <tr>
        <tr>
            <td colspan="3">
    
            </td>
            <td colspan="2">
            	<input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	        	<span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	        	<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />
            </td>
        </tr>
    </table>
	<div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
