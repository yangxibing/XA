<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>价格行情管理</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>
<script type="text/javascript"> 
		function displayRegister(valu) {    
            if(($(valu).attr("value"))=="新建"){
				$("#addUpdatePriceQuotation").attr("action","addPriceQuotation.action");
		   		 $("#register :text").each(function(){
		   		 	$(this).attr("value","");
		   		 });
		   		 $("#addUpdateSelect").attr("length", "0");
		   		 $.post("getQuotationAddList",{async: false},insertQuotationAddList, 'json');
			}else{
				var productIdValue=$(valu).attr("name");
				var url=$("#getPriceQuotationById").attr("action");
				var params={productId:productIdValue,async: false};
				$.post(url,params,callBackFunction,'json');
			} 
			
			var subMenu=document.getElementById("register");
           	subMenu.style.display = "block";
        }
        
        function insertQuotationAddList(data){
        	var str = data.ajaxResult;
        	var addList = new Array();
        	addList = str.split(",");
        	var count = addList.length;
        	var optionStr = "";
			for(var index=0; index<count; index++){
				optionStr += "<option value=\"" + addList[index] + "\">" + addList[index] + "</option>"
			}
			$("#addUpdateSelect option").remove();
			$("#addUpdateSelect").append(optionStr);
        }
        
        function callBackFunction(data){
			var datas=data.ajaxResult;
			var arr = new Array();
			arr = datas.split(",");
           	
           	var optionStr = "<option value=\"" + arr[0] + "\">" + arr[0] + "</option>";
           	$("#addUpdateSelect option").remove();
           	$("#addUpdateSelect").append(optionStr);
			
            $("#price").attr("value",arr[1]);
           	$("#number").attr("value",arr[2]);
           	$("#addUpdatePriceQuotation").attr("action","updatePriceQuotation.action");
		}
		
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
        function allSelected(){
        	if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='priceQuotationItem']").attr("checked",true);
        	}
        	else {
        		$("[name='priceQuotationItem']").attr("checked",false);
        	}
        }
   
   		function savePriceQuotation(valu){
        	var url=$("#addUpdatePriceQuotation").attr("action");
        	var productIdValue = "";
			$("#addUpdateSelect option").each(function(){
            	if($(this).attr("selected")==true){
            		productIdValue = $(this).attr("value").split(" ")[0];
            	}
            });
    		var priceValue=$("#price").attr("value");
			var numberValue=$("#number").attr("value");
			if(checkPriceQuotation(priceValue, numberValue)==false)
				return false
			var params={productId:productIdValue,
					price:priceValue,
					number:numberValue,
					async: false};
			$.post(url,params,function(data){
				$("#queryPriceQuotation").submit();
			});
   		}

		function deletePriceQuotation(){
			var f_str="";
        	var count=0;
			$("[name='priceQuotationItem']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});
			if(count > 0){
				if(confirm("你真的要删除这些项么？")){
						$.post("deletePriceQuotation.action",{quotationList:f_str},function(data){
							$("#queryPriceQuotation").submit();
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
        	$("#queryPriceQuotation").attr("action", "queryPriceQuotation.action?currentPage="+currentPage);
        	$("#queryPriceQuotation").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
        	$("#queryPriceQuotation").attr("action", "queryPriceQuotation.action?currentPage="+currentPage);
        	$("#queryPriceQuotation").submit();
		}
</script>

<style>
	#supply #register #registCnt{ width:500px;}
</style>

</head>
<body>
	<div id="supply" class="CENTER">
	<div id="top">
	  <span><h2>价格行情管理</h2></span>
	</div>
	
	<form action="queryPriceQuotation.action" id="queryPriceQuotation" method="post"></form>
	<form action="getPriceQuotationById.action" id="getPriceQuotationById"></form>
	<form action="queryPriceQuotation.action" id="queryPriceQuotation"></form>
	<form action="deletePriceQuotation.action" id="deletePriceQuotation"></form>
	
	    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
	    	<tr class="TITLE" style="font-weight:bold;">
	        	<td>选择</td>
	            <td>产品代码</td>
	            <td>产品名称</td>
	            <td>供应商名称</td>
	            <td>产品类别</td>
	            <td>度量单位</td>
	            <td>规格</td>
	            <td>价格（元）</td>
	            <td>库存数量</td>
	            <td>&nbsp;</td>
	        </tr>
	        <s:iterator id="element" value="#request.query">
	        <tr class="HOVER">
	        	<td ><input name="priceQuotationItem" type="checkbox" class="INPUTTEXT" value="<s:property value="#element.productId"/>" /></td>
	            <td ><s:property value="#element.productId"/></td>
	            <td ><s:property value="#element.productName"/></td>
	            <td ><s:property value="#element.supplierName"/></td>
	            <td><s:property value="#element.productTypeName"/></td>
	            <td ><s:property value="#element.measureUnit"/></td>
	            <td ><s:property value="#element.format"/></td>
	            <td><s:property value="#element.price"/></td>            
	            <td><s:property value="#element.number"/></td>
	            <td><input type="button" class="BUTTON" name="<s:property value="#element.productId"/>" onclick="displayRegister(this)" value="编辑"/></td>
	        </tr>
	        </s:iterator>
	        
	        <tr>
	        	<td colspan="2" align="left"><input type="checkbox" name="allSelectBox" onclick="allSelected()" />全部选中</td>
	            <td><input type="button" class="BUTTON" onclick="deletePriceQuotation()" value="删除" /></td>
	            <td><input type="button" class="BUTTON" onclick="displayRegister(this)" value="新建" /></td>
	            <td colspan="7" class="UPBOD" align="right">
	            	<input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	            	<span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	            	<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />
	            </td>
	        </tr>
	    </table>
	    
	<form id="addUpdatePriceQuotation" action="">
	  <table id="register" class="CENTER" cellpadding="0" cellspacing="0">
	      <tr class="TITLE">
	        <td align="left"><b>价格行情</b> <span class="SPAN12PX">注：<font color="#FF0000">*</font>为必填项</span></td>
	        
	      </tr>
	      <tr>
	        <td colspan="2">
	        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
	          <tr>
	            <td class="ALRIGHT">产品代码及名称</td>
	            <td class="ALLEFT">
	            	<select id="addUpdateSelect">
	            		<option value="id">--请选择--</option>
	                </select>
	            	<font color="#FF0000">*</font>
	            </td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">价格（元）</td>
	            <td class="ALLEFT"><input type="text" name="price" id="price" style="height:12px;" class="INPUTTEXT"/></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">库存数量</td>
	            <td class="ALLEFT"><input type="text" name="number" id="number" style="height:12px;" class="INPUTTEXT" /></td>
	          </tr>
	        </table></td>
	      </tr>
	      <tr>
	        <td align="center" colspan="2"><input type="button" onclick="savePriceQuotation(this)" class="BUTTON" value="保存" />
	          <input type="reset" class="BUTTON" onclick="hideRegister()" value="取消" /></td>
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

