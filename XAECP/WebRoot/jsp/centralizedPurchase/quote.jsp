<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>报价</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script type="text/javascript"> 
		function displayRegister() {
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
        
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
        function allSelected() {
		    if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='quoteItem']").attr("checked",true);
        	}
        	else {
        		$("[name='quoteItem']").attr("checked",false);
        	}        
        }
        
        //************************************************************
        //删除报价条目：自己去实现deleteQuote.action, queryQuote表单提交
        //************************************************************
        function deleteQuote() {
        	var f_str="";
        	var count=0;
			$("[name='quoteItem']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});
			if(count > 0){
				if(confirm("你真的要删除这些项么？")){
						$.post("deleteQuote.action",{answerPriceIdList:f_str},function(data){
							$("#queryQuote").submit();
						});
				}
			} else {
				alert("未选中任何项！");
			}
        }
        
        //************************************************************
        //新建和编辑报价条目（进打开表单及填充数据）：自己去实现:
        //queryProduct:获取下拉列表内容,内容格式:“id name,id name...”
       	//getQuoteStr:获取指定id的报价单信息用于填充表单
        //************************************************************
		function displayRegister(valu) {  
			if(($(valu).attr("value"))=="新建"){
				$("#addUpdateQuote").attr("action","addQuote.action");
		   		$("#priceInput").value = "";
		   		$("#remarkArea").attr("value", "");
		   		var supplierIdValue = $("#supplierIdHidden").attr("value");
		   		$.post("queryProduct.action",{supplierId:supplierIdValue,async: false}, insertProductList, 'json');
			}else{
				var answerPriceIdValue=$(valu).attr("name");
				var url='getQuoteStr.action';
				var params={answerPriceId:answerPriceIdValue,async: false};
				$.post(url,params,callBackFunction,'json');
			} 
        }
        
        function insertProductList(data) {
        	var str = data.ajaxResult;
        	var productList = new Array();
        	productList = str.split(",");
        	$("#productIdNameSelect").attr("length", "0");
        	var count = productList.length;
        	
        	var optionInfo = "";
        	for(var index=0; index<count; index++){
        		optionInfo += "<option value=\"" + productList[index].split(" ")[0] + "\">" + productList[index] + "</option>";
        	}
        	$("#productIdNameSelect").append(optionInfo);
        	
			var subMenu=document.getElementById("register");
		   	subMenu.style.display = "block";

        }
        
        function callBackFunction(data) {
            
			var datas=data.ajaxResult;
			var a=new Array();
			a=datas.split(",");
			var subMenu=document.getElementById("register");
           	subMenu.style.display = "block";
           	
           	$("#productIdNameSelect").attr("length", "0");
           	var addSelect=document.getElementById("productIdNameSelect");
           	var option=document.createElement('option'); 
			option.value=a[0]; 
			option.innerText=a[0]+" "+a[1]; 
			addSelect.appendChild(option);
            
            $("#priceInput").attr("value",a[2]);
            $("#remarkArea").attr("value",a[3]);
            $("#answerPriceIdHidden").attr("value",a[4]);
           	$("#addUpdateQuote").attr("action","updateQuote.action");        
        }
        
        //************************************************************
        //保存及更新报价条目：自己去实现:
        //addQuote:添加报价单
       	//updateQuote:更新报价单
        //************************************************************
        function saveQuote(valu){
        	var url=$("#addUpdateQuote").attr("action");
        	var answerPriceIdValue = $("#answerPriceIdHidden").attr("value");
        	var askPriceIdValue = $("#askPriceIdHidden").attr("value");
        	var supplierIdValue = $("#supplierIdHidden").attr("value");
        	
        	var productIdValue = "";
			$("#productIdNameSelect option").each(function(){
            	if($(this).attr("selected")==true){
            		productIdValue = $(this).attr("value");
            	}
            });
            var priceValue=$("#priceInput").attr("value");
            var remarkValue = $("#remarkArea").attr("value");
            
			var params={answerPriceId:answerPriceIdValue,
					askPriceId:askPriceIdValue,
					productId:productIdValue,
					supplierId:supplierIdValue,
					price:priceValue,
					remark:remarkValue,
					isAnswerValue:0,
					isSelect:0,					
					async: false};
			$.post(url,params,function(data){
				$("#queryQuote").submit();
			});		
		} 
		
        //************************************************************
        //正式报价：自己去实现:
        //formalQuote.action:更新报价表中的条目
        //************************************************************
        function formalQuote(valu) {
         	var f_str="";
        	var count=0;
			$("[name='quoteItem']").each(function(){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
			});
			if(count > 0){
				if(confirm("请您再确认一遍，准备报价？")){
						$.post("formalQuote.action",{answerPriceIdList:f_str},function(data){
							$("#queryQuoteAfterFormalQuote").submit();
						});
				}
			} else {
				alert("没有报价单可以报价！");
			}     
        }		                       
</script>
<style>
#toptitle{ width:1001px; height:25px;}
#toptitle span{ display:inline; float:right; margin-left:10px; margin-bottom:5px; margin-right:5px; background-color:#E7E1F7;}
#supply #register #registCnt{ width:800px;}
</style>
</head>

<body>
<div id="supply" class="CENTER">
<div id="top">
  <h2><span style="color:#FFF;"> 报价</span></h2>
</div>
<div id="toptitle">
	<span><a href="productManage.html">产品目录</a></span>
</div>
	
	<!-- 辅助区：设置一些辅助的表单及隐藏数据 -->
    <form id="deleteQuote" action="deleteQuote.action"></form>
    
    <!-- 查询表单：按输入条件查询 -->
    <form id="queryQuote" action="queryQuote.action">
		<input type="hidden" name="askPriceId" id="askPriceIdHidden" value="<s:property value="#request.askPriceId"/>" /> 
		<input type="hidden" name="supplierId" id="supplierIdHidden" value="<s:property value="#session.partnerId"/>" />
    </form>
    
    <form id="queryQuoteAfterFormalQuote" action="queryQuoteDetailAfterFormalQuote.action">
		<input type="hidden" name="askPriceId" id="askPriceIdHidden2" value="<s:property value="#request.askPriceId"/>" /> 
		<input type="hidden" name="supplierId" id="supplierIdHidden2" value="<s:property value="#session.partnerId"/>" />
    </form>
	    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
	    	<tr class="TITLE" style="font-weight:bold;">
	        	<td>选择</td>
	            <td>产品代码及名称</td>
	            <td>价格（元）</td>
	            <td>备注</td>
	            <td>&nbsp;</td>
	        </tr>
	        
	  	    <s:iterator id="element" value="#request.query">
	        	<tr class="HOVER">
	        		<td ><input name="quoteItem" type="checkbox" value="<s:property value="#element.answerPriceId"/>"/></td>
	          	    <td ><s:property value="#element.productId"/>&nbsp;&nbsp;<s:property value="#element.productName"/></td>
	           	    <td ><s:property value="#element.price"/></td>
	           	    <td ><s:property value="#element.remark"/></td>
	           	    <td ><input type="button" name="<s:property value="#element.answerPriceId"/>" onclick="displayRegister(this)" value="编辑" class="BUTTON"/></td>
	        	</tr>
	        </s:iterator>
	        
	        <tr>
	        	<td align="left"><input type="checkbox" name="allSelectBox" onclick="allSelected()" />全选</td>
	            <td align="left">
	            	<input type="button" class="BUTTON" onclick="deleteQuote()" value="删除" />
	            	<input type="button" class="BUTTON" onclick="displayRegister(this)" value="新建" />
	            </td>
	            <td colspan="2" class="UPBOD" align="right">
	            	<input type="button" class="BUTTON" value="上一页" />&nbsp;<input type="button" class="BUTTON" value="下一页" />
	            </td>
	            <td >
	            	<input type="button" class="REDBUTTON" onclick="formalQuote(this)" value="正式报价" />
	            </td>
	        </tr>
	    </table>
    
    <!-- 新建保存表单：用于新建及修改报价 -->
    <input type="hidden" name="answerPriceIdHidden" id="answerPriceIdHidden" />
	<form id="addUpdateQuote" action="" >
	  <table id="register" class="CENTER" cellpadding="0">
	      <tr class="TITLE">
	        <td align="left"><b>报价信息</b> 注：<font color="#FF0000">*</font>为必填项</td>
	      </tr>
	      <tr>
	        <td>
	        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
	          <tr>
	            <td class="ALRIGHT">产品代码及名称</td>
	            <td class="ALLEFT">
	            	<select name="productIdNameSelect" id="productIdNameSelect">
	                	<option>XXXXX</option>
	                </select>
	            </td>
	            <td class="ALRIGHT">价格</td>
	            <td class="ALLEFT">
	            	<input type="text" class="SHORTINPUT" name="priceInput" id="priceInput" />（元）
	            </td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">备注</td>
	            <td class="ALLEFT" colspan="3"><textarea name="remarkArea" id="remarkArea" style="width:400px; height:40px;" ></textarea></td>
	          </tr>
	        </table></td>
	      </tr>
	      <tr>
	        <td align="center">
	        	<input type="button" onclick="saveQuote(this)" class="BUTTON" value="保存" />
	          	<input type="reset" class="BUTTON" onclick="hideRegister()" value="取消" />
	        </td>
	      </tr>
	  </table>
	</form>
	
	  <div id="DOWN">
	  			<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.html';" />
	  </div>
</div>
</body>
</html>
