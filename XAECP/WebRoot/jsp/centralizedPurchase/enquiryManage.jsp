<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>询价管理</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<link href="../../css/menu.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>
<script type="text/javascript"> 

//页面初始时，加载产品类型下拉列表，恢复查询状态	
		$(document).ready(function(){
			//$.post($("#queryProductTypeList").attr("action"),{async: false}, insertSearchCondition, 'json');
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
			
			var length = document.getElementsByName(param.productTypeId).length;
			if(length>=1){
				var element = document.getElementsByName(param.productTypeId)[length-1];
				$(element).parent().append(list);
				
				$.each(param.childrenList, function(i, value){
					insertProductTypeBranchRecursive(value);
				});
			}
		}
		
		//用户从下拉列表里选择了产品类型，响应事件
		function selectChanged(param){
			if($(param).parents("form").attr("id") =="queryEnquiry"){
				$("#productTypeQueryModelTD ul li a").eq(0).text($(param).text());
				$("#productTypeQueryModelTD ul li a").eq(0).attr("name", $(param).attr("name"));
				$("#productTypeSelect").attr("value", $(param).attr("name"));
				$("#productTypeNameSelect").attr("value", $(param).text());
				$("#queryEnquiry #mainMenu>ul").hide();			
			} else {
				$("#addUpdateEnquiry ul li a").eq(0).text($(param).text());
				$("#addUpdateEnquiry ul li a").eq(0).attr("name", $(param).attr("name"));
				$("#newProductTypeSelect").attr("value", $(param).attr("name"));
				$("#newProductTypeNameSelect").attr("value", $(param).text());
				$("#addUpdateEnquiry #mainMenu>ul").hide();					
			}
		}
		
		//恢复查询状态
		function recoverSearchState(){
			$("#askPriceIdInput").attr("value", $("#askPriceIdConvertHidden").attr("value"));
			//$("#productTypeSelect").attr("value", $("#productTypeIdConvertHidden").attr("value"));
			
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
		
		function insertProductTypeList(data){ 	
			var str = data.ajaxResult;
        	var addList = new Array();
        	addList = str.split(",");
        	var count = addList.length;
			
			var typeInfo = "<option value=\"\">--请选择--</option>";
			for(var index = 0; index<count; index++){
				typeInfo += "<option value=\"" + addList[index].split(" ")[0] + "\">" + addList[index].split(" ")[1] + "</option>";
			}
			$("#productTypeSelect option").remove();
			$("#productTypeSelect").append(typeInfo);				
		}
		        
        function insertNewProductTypeList(data){
        	var str = data.ajaxResult;
        	var addList = new Array();
        	addList = str.split(",");
        	$("#productTypeSelect").attr("length", "0");
        	var addSelect=document.getElementById("newProductTypeSelect");
        	var index;
        	var count = addList.length;
			for(index=0; index<count; index++){
				var option=document.createElement('option'); 
				option.value=addList[index].split(" ")[0]; 
				option.innerText=addList[index].split(" ")[1]; 
				addSelect.appendChild(option);
			}
			var subMenu=document.getElementById("register");
		   	subMenu.style.display = "block";
		   	insertProductTypeList(data);
        }
 
 //新建、编辑时处理事件       
		function displayRegister(valu) { 
			prepareForAddUpdate();	   		 
			if(($(valu).attr("value"))=="新建"){
				$("#newAskPriceId").text("自动生成");
				$("#addUpdateEnquiry").attr("action","addEnquiry.action");
			}else{
				var enquiryIdValue=$(valu).attr("name");
				var url='getEnquiryStr.action';
				var params={askPriceId:enquiryIdValue,async: false};
				$.post(url,params,callBackFunction,'json');
			} 
			
			var subMenu=document.getElementById("register");
		   	subMenu.style.display = "block";
        }
        
        function prepareForAddUpdate(){
        	$("#newAskPriceId").text("");
		   	$("#newNumber").attr("value", "");
		   	$("#newMeasureUnit").attr("value", "");
		   	$("#newDeadline").attr("value", "");        
        	//$("#newProductTypeSelect").html($("#productTypeSelect").html());
        	
        	var str = $("#productTypeQueryModelTD").html();
        	$("#productTypeEditModelTD").html(str);
        	$("#productTypeEditModelTD input").remove();
        	$("#productTypeEditModelTD").append("<input type=\"hidden\" id=\"newProductTypeSelect\" value=\"\"/><input type=\"hidden\" id=\"newProductTypeNameSelect\" value=\"\"/>");
        	var root = $("#productTypeQueryModelTD #mainMenu ul li").eq(0).children('a').eq(0);
        	$("#productTypeEditModelTD ul li a").eq(0).text(root.text());
        	$("#productTypeEditModelTD ul li a").eq(0).attr("name", root.attr("name"));
        	$("#newProductTypeSelect").attr("value", root.attr("name"));
        	$("#newProductTypeNameSelect").attr("value", root.text());
        	$('#productTypeEditModelTD #menu li').hover(function(){
				$(this).children('ul').show();
			},function(){
				$(this).children('ul').hide();
			});
        }
        
        function callBackFunction(data){
			var datas=data.ajaxResult;
			var a=new Array();
			a=datas.split(",");
			var subMenu=document.getElementById("register");
           	subMenu.style.display = "block";
           	
            $("#newAskPriceId").text(a[0]);
            //$("#newProductTypeSelect option").each(function(){
            //	if($(this).attr("value")==a[1]){
            //		$(this).attr("selected", true);
            //	}
            //});
            
            var root = $(document.getElementsByName(a[1])[0]);
        	$("#productTypeEditModelTD ul li a").eq(0).text(root.text());
        	$("#productTypeEditModelTD ul li a").eq(0).attr("name", root.attr("name"));
        	$("#newProductTypeSelect").attr("value", root.attr("name"));
        	$("#newProductTypeNameSelect").attr("value", root.text());            
            
            $("#newMeasureUnit option").each(function(){
            	if($(this).attr("value")==a[2]){
            		$(this).attr("selected", true);
            	}
            });
            
            $("#newNumber").attr("value",a[3]);
            $("#newDeadline").attr("value",a[4]);
           	$("#addUpdateEnquiry").attr("action","updateEnquiry.action");
		}
        
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
//查看详情时处理事件
		function displayInfo(valu){
            
				var enquiryIdValue=$(valu).attr("name");
				var url='getEnquiryStr.action';
				var params={askPriceId:enquiryIdValue,async: false};
				$.post(url,params,callBackFunc,'json');
		}
		
		function callBackFunc(data){
			var datas=data.ajaxResult;
			var a=new Array();
			a=datas.split(",");
           	
            $("#askPriceIdTd").text(a[0]);
            $("#productTypeTd").text(a[1]);
            $("#productTypeTd").text(document.getElementsByName(a[1])[0].innerText);
            
            
            $("#measureUnitTd").text(a[2]);
            $("#numberTd").text(a[3]);
            $("#deadlineTd").text(a[4]);
            if(a[5] != "null"){
            	$("#remarkTd").text(a[5]);            
            }

           	hideRegister();
			var subMenu=document.getElementById("Info");
           	subMenu.style.display = "block";
		}
		
		function hideInfo(){
			var subMenu=document.getElementById("Info");
            subMenu.style.display = "none";
		}

//全选、删除处理事件		
		function allSelected(){
		    if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='enquiryItem']").attr("checked",true);
        	}
        	else {
        		$("[name='enquiryItem']").attr("checked",false);
        	}
		}
		
		function deleteEquiry(){
			var f_str="";
        	var count=0;
        	var total=0;
			$("[name='enquiryItem']").each(function(){
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
					if(confirm("只有未发布的询价单可以删除，确实要删除其中未发布的询价单吗？")){
						$.post("deleteEnquiry.action",{enquiryList:f_str},function(data){
							$("#queryEnquiry").submit();
						});
					}
				}
				else if(count>0 && total == count){
					if(confirm("确实要删除所选的询价单吗？")){
						$.post("deleteEnquiry.action",{enquiryList:f_str},function(data){
							$("#queryEnquiry").submit();
						});
					}
				}
				else{
					alert("所选询价单中，没有未发布的询价单！");
				}
			} else {
				alert("未选中任何项！");
			}			
		}

//保存时处理事件		
		function saveEnquiry(valu){
        	var url=$("#addUpdateEnquiry").attr("action");
        	var askPriceIdValue = $("#newAskPriceId").text();
        	var productTypeIdValue = $("#newProductTypeSelect").attr("value");
            var numberValue=$("#newNumber").attr("value");
            if(checkNumberValue(numberValue)==false)
				return false;
            if(numberValue == null || numberValue == "" || numberValue == "null"){
            	numberValue = 0;
            }
            var measureUnitValue = "";
			$("#newMeasureUnit option").each(function(){
            	if($(this).attr("selected")==true){
            		measureUnitValue = $(this).attr("value");
            	}
            });                    
            var deadlineValue=$("#newDeadline").attr("value");
            var askPriceStateValue = 1;
            if($(valu).attr("value") == "保存"){
            	askPriceStateValue = 0;
            }
			var params={askPriceId:askPriceIdValue,
					productTypeId:productTypeIdValue,
					number:numberValue,
					measureUnit:measureUnitValue,
					deadline:deadlineValue,
					askPriceState:askPriceStateValue,
					async: false};
			$.post(url,params,function(data){
				$("#queryEnquiry").submit();
			});		
		}

//比价时处理事件		
		function priceCompareInformation(valu){
			var enquiryIdValue=$(valu).attr("name");
			$("#askPriceIdHidden").attr("value", enquiryIdValue);
			$("#askPriceStateHidden").attr("value", 2);
			$("#priceCompare").attr("action", "priceCompareInfo.action");
			$("#priceCompare").submit();
		}
		
		function priceCompareManage(valu){
			var enquiryIdValue=$(valu).attr("name");
			$("#askPriceIdHidden").attr("value", enquiryIdValue);
			$("#askPriceStateHidden").attr("value", 1);
			$("#priceCompare").attr("action", "priceCompareMag.action");
			$("#priceCompare").submit();
		}
		
        //分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#queryEnquiry").attr("action", "queryEnquiry.action?currentPage="+currentPage);
        	$("#queryEnquiry").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
        	$("#queryEnquiry").attr("action", "queryEnquiry.action?currentPage="+currentPage);
        	$("#queryEnquiry").submit();
		}		
</script>

<style>
	#toptitle{ width:1001px; height:25px;}
	#toptitle span{ display:inline; float:right; margin-left:10px; margin-bottom:5PX; margin-right:25px;}
	#supply #search{clear:both; margin-top:0;}
	*+html #supply #search{margin-top:-25px;}
	#supply #register #registCnt{ width:600px;}
	#supply #Info tr>td{width:950px;}
</style>
</head>

<body>
	<input type="hidden" name="askPriceIdConvert" id="askPriceIdConvertHidden" value="<s:property value="#request.enquiryVO.askPriceId"/>"/>
	<input type="hidden" name="productTypeIdConvert" id="productTypeIdConvertHidden" value="<s:property value="#request.enquiryVO.productTypeId"/>"/>
	<input type="hidden" id="productTypeIdStateHidden" value='<s:property value="#request.enquiryVO.productTypeId"/>'/>
	<input type="hidden" id="productTypeNameStateHidden" value='<s:property value="#request.enquiryVO.productTypeName"/>'/>

	<div id="supply" class="CENTER">
	<div id="top">
	  <span style="color:#FFF;"><h2>询价管理</h2></span>
	</div>
	<div id="toptitle">
		<span><a class="ARTA" href="listPlanedPurchaseInfo.action">计划采购需求</a></span>
		<span><a class="ARTA" href="queryCentralizedPurchaseList.action">集中采购需求</a></span>
	</div>
	
	<form id="queryProductTypeList" action="queryProductTypeList.action"></form>
	<form id="queryProductTypeListServerSide" action="queryProductTypeListServerSide.action"></form>
	<form id="deleteEnquiry" action="deleteEnquiry.action"></form>
	<form id="priceCompare" action="priceCompareInfo.action">
		<input type="hidden" name="askPriceId" id="askPriceIdHidden" />
		<input type="hidden" name="askPriceState" id="askPriceStateHidden" />
	</form>
	
	<form id="queryEnquiry" action="queryEnquiry.action" method="post">
		<table id="search" class="CENTER" cellspacing="0" cellpadding="0">
	    	<tr class="TITLE">
	        	<td><b>&nbsp;组合条件查询</b></td>
	            <td colspan="4">&nbsp;</td>
	        </tr>
	        <tr>
	        	<td class="BORDER" align="right">询价单代码</td>
	            <td class="BORDER"><input type="text" class="INPUTTEXT" name="askPriceId" id="askPriceIdInput"/></td>
	            <td class="BORDER" align="right">产品类型</td>
<!--        
	            <td class="BORDER">
	            	<select name="productTypeId" id="productTypeSelect" style="width:150px;">
	            		<option>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
	                </select>
	            </td>
-->		            
	            <td id="productTypeQueryModelTD">
					<ul id="menu" class="first-menu">
					  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a></li>
					</ul>
					<input type="hidden" name="productTypeId" id="productTypeSelect" value=""/>
					<input type="hidden" name="productTypeName" id="productTypeNameSelect" value="根类别"/>				
				</td>
				
	            <td class="BORDER" align="right" style="width:200px;">
	            	<input type="submit" class="BUTTON" value="查询" />
	                <input type="reset" class="BUTTON" value="清空" />
	                &nbsp;&nbsp;
	            </td>
	         </tr>
	    </table>
	</form>
	
	    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="2px">
	    	<tr class="TITLE" style="font-weight:bold;">
	        	<td>选择</td>
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
	        		<td ><input name="enquiryItem" type="checkbox" value="<s:property value="#element.askPriceId"/>" id="<s:property value="#element.askPriceState"/>"/></td>
	          	    <td ><s:property value="#element.askPriceId"/></td>
	           	    <td ><s:property value="#element.productTypeName"/></td>
	           	    <td ><s:property value="#element.askPriceStateStr"/></td>
	           	    <td ><s:property value="#element.number"/></td>
					<td ><s:property value="#element.measureUnit"/></td>
	            	<td><s:property value="#element.deadline"/></td>
	            	<td>
	            		<s:if test="%{#element.askPriceStateStr==\"未发布\"}">
           	    			<input type="button" name="<s:property value="#element.askPriceId"/>" onclick="displayRegister(this)" value="编辑" class="ARTBUTTON"/>
           	    		</s:if>
           	    		<s:elseif test="%{#element.askPriceStateStr==\"已发布\"}">
           	    			<input type="button" name="<s:property value="#element.askPriceId"/>" onclick="displayInfo(this)" value="询价单详情" class="ARTBUTTON"/>
           	    		</s:elseif>
           	    		<s:else>
           	    			<input type="button" name="<s:property value="#element.askPriceId"/>" onclick="displayInfo(this)" value="询价单详情" class="ARTBUTTON"/><br />
           	    			<input type="button" name="<s:property value="#element.askPriceId"/>" onclick="priceCompareInformation(this)" value="比价单详情" class="ARTBUTTON"/>
           	    		</s:else>
	            	</td>
	            	<td>
	            		<s:if test="%{#element.askPriceStateStr==\"已发布\"}">
	            			<span>等待报价</span><br />
                			<input type="button" name="<s:property value="#element.askPriceId"/>" onclick="priceCompareManage(this)" value="比价" class="BUTTON"/>
	            		</s:if>
	            	</td>
	        	</tr>
	        </s:iterator>

	        <tr>
	        	<td align="left"><input type="checkbox" name="allSelectBox" onclick="allSelected()" />全选</td>
	            <td colspan="3" align="left">
	            	<input type="button" class="BUTTON" onclick="deleteEquiry()" value="删除" />
	            	<input type="button" class="BUTTON" onclick="displayRegister(this)" value="新建" /></td>
	            <td colspan="5" class="UPBOD" align="right">
	            	<input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	            	<span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	            	<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />
	            </td>
	        </tr>
	    </table>
	<div class="EMPTYDIV"></div>
	<form id="addUpdateEnquiry" action="">
	  <table id="register" class="CENTER" cellpadding="0" cellspacing="0">
	      <tr class="TITLE">
	        <td align="left"><b>&nbsp;询价单信息</b> <span class="TITLESPAN2">注：<font color="#FF0000">*</font>为必填项</span></td>
	      </tr>
	      <tr>
	        <td>
	        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
	          <tr>
	            <td class="ALRIGHT">询价单代码</td>
	            <td class="ALLEFT">
	            	<!--  <input type="text" name="newAskPriceId" id="newAskPriceId" value="自动生成" disabled="disabled" /> -->
	            	<label name="newAskPriceId" id="newAskPriceId"></label>
	            </td>
	            <td class="ALRIGHT">产品类型</td>
<!--  	            
	            <td class="ALLEFT">
	            	<select name="newProductTypeId" id="newProductTypeSelect" style="width:150px;">
	            		<option>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
	                </select>
	            </td>
-->	            
	            <td id="productTypeEditModelTD" class="ALLEFT">
					<ul id="menu" class="first-menu">
					  <li id="mainMenu" value=""><a href="#" name="" id="titleMenu"> 根类别 </a></li>
					</ul>
					<input type="hidden" name="newProductTypeId" id="newProductTypeSelect" value=""/>
					<input type="hidden" name="newProductTypeName" id="newProductTypeNameSelect" value="根类别"/>				
				</td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">数量</td>
	            <td class="ALLEFT"><input type="text" name="newNumber" id="newNumber" class="SHORTINPUT"/></td>
	            <td class="ALRIGHT">度量单位</td>
	            <td class="ALLEFT">
	            	<select name="newMeasureUnit" id="newMeasureUnit" style="width:150px;">
	            		<option value="">--请选择--</option>
	            		<option value="克(g)">克(g)</option>
	                	<option value="千克(kg)">千克(kg)</option>
	                	<option value="吨(t)">吨(t)</option>
	            		<option value="厘米(cm)">厘米(cm)</option>
	                	<option value="米(m)">米(m)</option>
	                	<option value="千米(km)">千米(km)</option>
	                	<option value="张(p)">张(p)</option>
	                	<option value="盒(b)">盒(b)</option>
	                </select>
	            </td>
	          </tr>
	          <tr>
	          	<td class="ALRIGHT">截止日期</td>
	            <td colspan="3" class="ALLEFT"><input type="text" class="SHORTINPUT" name="newDeadline" id="newDeadline" onclick="WdatePicker();"/></td>
	          </tr>
	        </table></td>
	      </tr>
	      <tr>
	        <td align="center">
	        	<input type="button" onclick="saveEnquiry(this)" class="BUTTON" value="保存" />
	          	<input type="reset" class="BUTTON" onclick="hideRegister()" value="取消" />
	            <input type="reset" class="REDBUTTON" onclick="saveEnquiry(this)" value="保存并发布" />
	        </td>
	      </tr>
	  </table>
	</form>
	
	  <table id="Info" class="CENTER" cellpadding="0" cellspacing="0">
	      <tr class="TITLE">
	        <td align="left"><b>&nbsp;询价单信息</b></td>
	      </tr>
	      <tr>
	        <td>
	        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
	          <tr>
	            <td class="ALRIGHT">询价单代码&nbsp;</td>
	            <td id="askPriceIdTd" class="ALLEFT"></td>
	            <td class="ALRIGHT">产品类型&nbsp;</td>
	            <td id="productTypeTd" class="ALLEFT"></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">数量&nbsp;</td>
	            <td id="numberTd" class="ALLEFT"></td>
	            <td class="ALRIGHT">度量单位&nbsp;</td>
	            <td id="measureUnitTd" class="ALLEFT"></td>
	          </tr>
	          <tr>
	          	<td class="ALRIGHT">截止日期&nbsp;</td>
	            <td id="deadlineTd" class="ALLEFT"></td>
	            <td class="ALRIGHT">备注&nbsp;</td>
	            <td id="remarkTd" class="ALLEFT"></td>
	          </tr>
	        </table></td>
	      </tr>
	  </table>
	<div class="EMPTYDIV"></div>
	  <div id="DOWN">
	  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
	  </div>
	</div>
</body>
</html>
