<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>报价管理</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/menu.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>

<script type="text/javascript"> 
		window.onload = function(){
			//$.post($("#queryProductTypeList").attr("action"),{async: false}, insertProductTypeList, 'json');
			recoverSearchState();
			$.post($("#queryProductTypeListServerSide").attr("action"), {async:false}, insertSearchCondition, 'json');
		}

		function insertSearchCondition(data){
			//insertProductTypeList(data);
			insertProductTypeListClientSide(data);		
		}
		
		//插入全部产品列表
		function insertProductTypeListClientSide(data){
			var root = data.ajaxRoot;
			
			//$("#productTypeQueryModelTD ul li a").eq(0).attr("name", root.productTypeId);
			//$("#productTypeQueryModelTD ul li a").eq(0).text(root.productTypeName);
			//$("#productTypeSelect").attr("value", root.productTypeId);
			//$("#productTypeNameSelect").attr("value", root.productTypeName);	
			
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
		//alert("hello");
		//alert(param.childrenList);
		//alert(param.childrenList.length);
			if(param.childrenList == null || param.childrenList.length == 0){
				return false;
			}
			
			var list = "<ul class=\"third-menu\">";
			$.each(param.childrenList, function(i, value){
				//alert(value.productTypeName);
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
				$("#productTypeSelect").attr("value", $(param).attr("name"));
				$("#productTypeNameSelect").attr("value", $(param).text());
				$("#productTypeQueryModelTD #mainMenu>ul").hide();			
		}
		
		//恢复查询状态
		function recoverSearchState(){
            var id = $("#productTypeIdStateHidden").attr("value");
            var name = $("#productTypeNameStateHidden").attr("value");
            if(id != null && id != ""){
	            $("#productTypeSelect").attr("value", id);
	            $("#productTypeNameSelect").attr("value", name);
				$("#titleMenu").attr("name", id);
				$("#titleMenu").text(name);             	
            } else {
	            $("#productTypeSelect").attr("value", "");
	            $("#productTypeNameSelect").attr("value", "根类别");
				$("#titleMenu").attr("name", "");
				$("#titleMenu").text("根类别");             
            }			
		}		
		
		function insertProductTypeList(data) {    	
			var str = data.ajaxResult;
        	var addList = new Array();
        	addList = str.split(",");
        	$("#productTypeSelect").attr("length", "0");
        	$("#productTypeSelect").append("<option value=\"\">--请选择--</option>");
        	var addSelect=document.getElementById("productTypeSelect");
        	var index;
        	var count = addList.length;
			for(index=0; index<count; index++){
				var option=document.createElement('option'); 
				option.value=addList[index].split(" ")[0]; 
				option.innerText=addList[index].split(" ")[1]; 
				addSelect.appendChild(option);
			}

			$("#productTypeSelect").attr("value", '<s:property value="#request.enquiryVO.productTypeId"/>');
		}
		
		
		function showAskDetails(valu) {
			var askPriceIdValue = $(valu).attr("name");
			var url="getEnquiryForQuoteById.action";
			var params={askPriceId:askPriceIdValue, async: false};
			$.post(url, params, callBackFunction, 'json');
		}
		
		function callBackFunction(data) {
			var datas=data.ajaxResult;
			var a=new Array();
			a=datas.split(",");
			var subMenu=document.getElementById("Info");
            subMenu.style.display = "block";
            $("#askPriceIdAskInfo").text(a[0]);
            $("#productTypeAskInfo").text(a[1]);
            $("#numberAskInfo").text(a[2]);
            $("#measureUnitAskInfo").text(a[3]);
            $("#deadlineAskInfo").text(a[4]);
            $("#remarkAskInfo").text(a[5]);
		}
		
		function answerPrice(valu) {
			var askPriceIdValue = $(valu).attr("name");
			$("#askPriceIdHidden").attr("value", askPriceIdValue);
			//var supplierIdValue = $("#supplierIdHidden").attr("value");
			//var params = {askPriceId:askPriceIdValue, supplierId:supplierIdValue, async: false};
			//var url="queryQuote.action";
			//$.post(url, params);
			//alert("queryQuote.action?askPriceId="+askPriceIdValue+"&supplierId="+supplierIdValue);
			//$("#answerPrice").attr("action", "queryQuote.action?askPriceId="+askPriceIdValue+"&supplierId="+supplierIdValue);
			$("#answerPrice").submit();
		}
		
		function displayAnswerPriceDetail(valu) {
			var askPriceIdValue = $(valu).attr("name");
			$("#askPriceIdHidden2").attr("value", askPriceIdValue);
			$("#answerPrice2").submit();
		}
		
		
		function displayAskAnswerResult(valu) {
			var askPriceIdValue = $(valu).attr("name");			
			$("#askPriceIdHidden3").attr("value", askPriceIdValue);
            $("#askPriceStateHidden3").attr("value", 2);
            $("#queryAskCompareResult").submit();
		}
		function hideInfo(){
			var subMenu=document.getElementById("Info");
            subMenu.style.display = "none";
		}
		
		//分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#queryEnquiryForQuote").attr("action", "queryEnquiryForQuote.action?currentPage="+currentPage);
        	$("#queryEnquiryForQuote").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#queryEnquiryForQuote").attr("action", "queryEnquiryForQuote.action?currentPage="+currentPage);
        	$("#queryEnquiryForQuote").submit();
		}
		
</script>

<style>
	#toptitle{ width:1001px; height:25px;}
	#toptitle span{ display:inline; float:right; margin-left:10px; margin-bottom:5px; margin-right:5px; background-color:#E7E1F7;}
	#supply #register #registCnt{ width:600px;}
	#supply #Info tr>td{width:950px;}
</style>
</head>

<body>

	<input type="hidden" id="productTypeIdStateHidden" value='<s:property value="#request.enquiryVO.productTypeId"/>'/>
	<input type="hidden" id="productTypeNameStateHidden" value='<s:property value="#request.enquiryVO.productTypeName"/>'/>
	<form id="queryProductTypeListServerSide" action="queryProductTypeListServerSide.action"></form>
	<form id="queryProductTypeList" action="queryProductTypeList.action"></form>

	<div id="supply" class="CENTER">
	<div id="top">
	  <span style="color:#FFF;"><h2>报价管理</h2></span>
	</div>
	<!--  
	<form action="getProductTypeInEnquiry.action" id="getProductTypeInEnquiry"></form> 
	-->
	<form id="queryProductType" action="queryProductType.action"></form>
	
	<form action="queryAskCompareResult" id="queryAskCompareResult">
		<input type="hidden" name="askPriceId" id="askPriceIdHidden3" value="" /> 
		<input type="hidden" name="askPriceState" id="askPriceStateHidden3" value="" />
	</form>
	
	<form action="queryQuote.action" id="answerPrice">
		<input type="hidden" name="askPriceId" id="askPriceIdHidden" value="" /> 
	</form>
	
	<form action="queryQuoteDetailAfterFormalQuote.action" id="answerPrice2">
		<input type="hidden" name="askPriceId" id="askPriceIdHidden2" value="" /> 
		<input type="hidden" name="supplierId" id="supplierIdHidden2" value="2008303393" />
	</form>  
	
	<form action="queryEnquiryForQuote.action" id="queryEnquiryForQuote" method="post">
		<table id="search" class="CENTER" cellspacing="0" cellpadding="0">
	    	<tr class="TITLE">
        		<td><b>&nbsp;组合条件查询</b></td>
            	<td colspan="4"></td>
        	</tr>
	        <tr>
	        	<td class="BORDER" align="right">询价单代码</td>
	            <td class="BORDER"><input type="text" class="INPUTTEXT" name="askPriceId" id="askPriceIdInput" value='<s:property value="#request.enquiryVO.askPriceId"/>'/></td>
	            <td class="BORDER" align="right">产品类型</td>
	            <td id="productTypeQueryModelTD">
					<ul id="menu" class="first-menu">
					  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a></li>
					</ul>
					<input type="hidden" name="productTypeId" id="productTypeSelect" value=""/>
					<input type="hidden" name="productTypeName" id="productTypeNameSelect" value="根类别"/>				
				</td>	            
	            <!--  
	            <td class="BORDER">
	            	<select name="productTypeId" id="productTypeSelect"  style="width:150px;">
	            		<option>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
	                </select>
	            </td>
	            -->
	            <td class="BORDER" align="right">
	            	<input type="submit" class="BUTTON" value="查询" />
	                <input type="reset" class="BUTTON" value="重置" />
	            </td>
	         </tr>
	    </table>
	</form>
	  
	   <table id="showlist" class="CENTER" cellspacing="0" cellpadding="2px">
	    	<tr class="TITLE" style="font-weight:bold;">
	            <td>询价单代码</td>
	            <td>产品类型</td>
	            <td>询价状态</td>
	            <td>数量</td>
	            <td>度量单位</td>
	            <td>截止日期</td>
	            <td>&nbsp;</td>
	            <td>&nbsp;</td>
	        </tr>        
		    <s:iterator id="element" value="#request.query">
	        	<tr class="HOVER">
	          	    <td ><s:property value="#element.askPriceId"/></td>
	           	    <td ><s:property value="#element.productTypeName"/></td>
	           	    <td ><s:property value="#element.askPriceStateStr"/></td>
	           	    <td ><s:property value="#element.number"/></td>
					<td ><s:property value="#element.measureUnit"/></td>
	            	<td><s:property value="#element.deadline"/></td>
	            	<td>
	            		<s:if test="%{#element.askPriceState==\"1\"}">
	            			<s:if test="%{#element.isAnswer==true}">
	            				<input type="button" name="<s:property value="#element.askPriceId"/>" onclick="showAskDetails(this);" class="ARTBUTTON" value="询价单详情" /><br/>
	            				<input type="button" name="<s:property value="#element.askPriceId"/>" onclick="displayAnswerPriceDetail(this);" class="ARTBUTTON" value="报价详情"/>
	            			</s:if>
	            			<s:else>
	            				<input type="button" name="<s:property value="#element.askPriceId"/>" onclick="showAskDetails(this);" class="ARTBUTTON" value="询价单详情" />
	            			</s:else>
	            		</s:if>
	            		<s:else>
	            			<input type="button" name="<s:property value="#element.askPriceId"/>" onclick="showAskDetails(this);" class="ARTBUTTON" value="询价单详情" /><br/>
	            			<input type="button" name="<s:property value="#element.askPriceId"/>" onclick="displayAnswerPriceDetail(this);" class="ARTBUTTON" value="报价详情"/><br/>
	            			<input type="button" name="<s:property value="#element.askPriceId"/>" class="ARTBUTTON" value="询比价结果" onclick="displayAskAnswerResult(this);"/>
	            		</s:else>
	            	</td>
	            	<td>
	            		<s:if test="%{#element.askPriceState==\"1\"}">
	            			<s:if test="%{#element.isAnswer==true}">
	            				<span>等待结果</span><br/>
	            			</s:if>
	            			<s:else>
	            				<input type="button" name="<s:property value="#element.askPriceId"/>" class="BUTTON" onclick="answerPrice(this)" value="报价" />
	            			</s:else>
	            		</s:if>
	            		<s:else>
	            		</s:else>
	            	</td>
	        	</tr>
	        </s:iterator>
	        <tr>
	        	<td align="left"></td>
	            <td colspan="3" align="left"></td>
	            <td colspan="3" class="UPBOD" align="right">
	            	<input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	            	<span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	            	<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
	       		</td>
	            <td></td>
	        </tr>
	    </table>

	    
		 <table id="Info" class="CENTER" cellpadding="0">
	      <tr class="TITLE">
	        <td align="left"><b>&nbsp;询价单信息</b></td>
	      </tr>
	      <tr>
	        <td>
	        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
	          <tr>
	            <td class="ALRIGHT">询价单代码&nbsp;</td>
	            <td id="askPriceIdAskInfo" class="ALLEFT"></td>
	            <td class="ALRIGHT">产品类型&nbsp;</td>
	            <td id="productTypeAskInfo" class="ALLEFT"></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">数量&nbsp;</td>
	            <td id="numberAskInfo" class="ALLEFT"></td>
	            <td class="ALRIGHT">度量单位&nbsp;</td>
	            <td id="measureUnitAskInfo" class="ALLEFT"></td>
	          </tr>
	          <tr>
	          	<td class="ALRIGHT">截止日期&nbsp;</td>
	            <td id="deadlineAskInfo" class="ALLEFT"></td>
	            <td class="ALRIGHT">备注&nbsp;</td>
	            <td id="remarkAskInfo" class="ALLEFT"></td>
	          </tr>
	        </table></td>
	      </tr>
	      <tr>
	        <td align="center">
	        	<input type="button" onclick="hideInfo()" class="BUTTON" value="关闭" />
	        </td>
	      </tr>
	  </table>
	
	  <div id="DOWN">
	  	<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
	  </div>
	</div>
</body>
</html>