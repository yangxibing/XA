<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理收/发货地址</title>
<link href="/XAECP/css/supply.css" rel="stylesheet" type="text/css"/>
<link href="/XAECP/css/global.css" rel="stylesheet" type="text/css"/>
<link href="/XAECP/css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="/XAECP/javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="/XAECP/javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
		window.onload = function(){
			if('<s:property value="#request.sendOrReceiveTag"/>' == "true"){
				$("#sendOrReceiveHidden").attr("value", "true");
				
				$("#goodsAddressManageTitle").text("管理发货地址");
				$("#contacterHeader").text("发货人");
				$("#telephoneHeader").text("发货人电话");
				$("#goodsAddressEditTitle").text("发货地址");
				$("#contacterLabel").text("发货人");
				$("#telephoneLabel").text("发货人电话");
			} else {
				$("#sendOrReceiveHidden").attr("value", "false");
				
				$("#goodsAddressManageTitle").text("管理收货地址");
				$("#contacterHeader").text("收货人");
				$("#telephoneHeader").text("收货人电话");
				$("#goodsAddressEditTitle").text("收货地址");
				$("#contacterLabel").text("收货人");
				$("#telephoneLabel").text("收货人电话");
			}
		}

		function displayRegister(valu) {
			if(($(valu).attr("value"))=="新建"){
				$("#addUpdateGoodsAddress").attr("action","addGoodsAddress.action");
		   		 $("#register :text").each(function(){
		   		 	$(this).attr("value","");
		   		 });
		   		 $("#addressIdEdit").text("代码自动生成");
		   		 $("#defaultOrNotEdit").attr("checked", false);
			}else{
				$("#addUpdateGoodsAddress").attr("action","updateGoodsAddress.action");
				var addressIdValue=$(valu).attr("name");
				var url=$("#getGoodsAddressById").attr("action");
				var params={addressId:addressIdValue,async: false};
				$.post(url,params,callBackFunction,'json');
			} 
			    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
        
        function callBackFunction(data){
        	var datas=data.addressInfo;
			var arr = new Array();
			arr = datas.split(",");
           	
           	$("#addressIdEdit").text(arr[0]);
           	$("#contacterEdit").attr("value", arr[3]);
           	$("#shippingAddressEdit").attr("value", arr[1]);
           	$("#telephoneEdit").attr("value", arr[4]);
           	$("#zipCodeEdit").attr("value", arr[2]);
           	if(arr[5] == "1"){
           		$("#defaultOrNotEdit").attr("checked", true);
           	} else {
           		$("#defaultOrNotEdit").attr("checked", false);
           	}
        }
        
        function saveGoodsAddress(valu){
        	var url=$("#addUpdateGoodsAddress").attr("action");
        	var addressIdValue = $("#addressIdEdit").text();
        	var contacterValue = $("#contacterEdit").attr("value");
        	var shippingAddressValue = $("#shippingAddressEdit").attr("value");
        	var telephoneValue = $("#telephoneEdit").attr("value");
        	var zipCodeValue = $("#zipCodeEdit").attr("value");
        	var defaultOrNotValue = false;
        	if(checkSendOrReceiveAddress(addressIdValue, contacterValue, telephoneValue, zipCodeValue)==false)
        		return false;
        	if($("#defaultOrNotEdit").attr("checked") == true){
        		defaultOrNotValue = true;
        	}
        	var sendOrReceiveValue = $("#sendOrReceiveHidden").attr("value");
        	
        	var params = {addressId:addressIdValue,
        			contacter:contacterValue,
        			shippingAddress:shippingAddressValue,
        			telephone:telephoneValue,
        			zipCode:zipCodeValue,
        			defaultOrNot:defaultOrNotValue,
        			sendOrReceive:sendOrReceiveValue,
        			async: false};
        			
        	$.post(url, params, function(data){
        		$("#goodsAddressManage").submit();
        	});
   		}
        
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
        function allSelected(){
            if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='goodAddressItem']").attr("checked",true);
        	}
        	else {
        		$("[name='goodAddressItem']").attr("checked",false);
        	}
        }
        
        function deleteGoodsAddress(){
			var f_str="";
        	var count=0;
			$("[name='goodAddressItem']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});
			if(count > 0){
				if(confirm("确定要删除所中的物流地址吗？")){
						$.post("deleteGoodsAddress.action",{addressList:f_str,async: false},function(data){
							$("#goodsAddressManage").submit();
						});
				}
			} else {
				alert("未选中任何项！");
			}
		}
</script>
</head>

<body>
	<!-- 辅助的或带有说明意思的控件 -->
	<form id="goodsAddressManage" action="goodsAddressManage.action">
		<input type="hidden" name="sendOrReceive" id="sendOrReceiveHidden" value="false"/>
	</form>
	<form id="deleteGoodsAddress" action="deleteGoodsAddress.action"></form>
	<form id="getGoodsAddressById" action="getGoodsAddressById.action"></form>

	<div id="supply" class="CENTER">
	<div id="top">
	  <h2><span style="color:#FFF;"><label id="goodsAddressManageTitle">管理收货地址</label></span></h2>
	</div>
	
	    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
	    	<tr class="TITLE" style="font-weight:bold;">
	        	<td>选择</td>
	            <td>地址代码</td>
	            <td>地址</td>
	            <td>邮编</td>
	            <td><label id="contacterHeader">收货人</label></td>
	            <td><label id="telephoneHeader">收货人电话</label></td>
	            <td>是否默认地址</td>
	            <td>&nbsp;</td>
	        </tr>
	        <s:iterator id="element" value="#request.query">
		        <tr class="HOVER">
		        	<td ><input name="goodAddressItem" type="checkbox" class="INPUTTEXT" value="<s:property value="#element.addressId"/>" /></td>
		            <td ><s:property value="#element.addressId"/></td>
		            <td ><s:property value="#element.shippingAddress"/></td>
		            <td ><s:property value="#element.zipCode"/></td>
		            <td><s:property value="#element.contacter"/></td>
		            <td ><s:property value="#element.telephone"/></td>
		            <td >
						<s:if test="%{#element.defaultOrNot==true}">是</s:if>
						<s:else>否</s:else>
					</td>
		            <td><input type="button" class="BUTTON" name="<s:property value="#element.addressId"/>" onclick="displayRegister(this)" value="编辑"/></td>
		        </tr>
		    </s:iterator>
	        <tr>
		        <td colspan="2" align="left"><input type="checkbox" name="allSelectBox" onclick="allSelected()" />全选</td>
	            <td colspan="6" align="left">
	            	<input type="button" class="BUTTON" onclick="deleteGoodsAddress()" value="删除" />
	            	<input type="button" class="BUTTON" onclick="displayRegister(this)" value="新建" />
	            </td>
	        </tr>
	    </table>
	<form id="addUpdateGoodsAddress" action="addUpdateGoodsAddress.action">
	  <table id="register" class="CENTER" cellpadding="0">
	      <tr class="TITLE">
	        <td align="left"><b><label id="goodsAddressEditTitle">收货地址</label></b></td>
	      </tr>
	      <tr>
	        <td>
	        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
	          <tr>
	            <td class="ALRIGHT">地址代码</td>
	            <td class="ALLEFT"><label id="addressIdEdit"></label></td>
	            <td class="ALRIGHT"><label id="contacterLabel">收货人</label></td>
	            <td class="ALLEFT"><input type="text" class="INPUTTEXT" id="contacterEdit"/></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">地址</td>
	            <td class="ALLEFT"><input type="text" class="INPUTTEXT" id="shippingAddressEdit"/></td>
	            <td class="ALRIGHT"><label id="telephoneLabel">收货人电话</label></td>
	            <td class="ALLEFT"><input type="text" class="INPUTTEXT" id="telephoneEdit"/></td>
	          </tr>
	          <tr>
	          	<td class="ALRIGHT">邮编</td>
	            <td class="ALLEFT"><input type="text" class="INPUTTEXT" id="zipCodeEdit"/></td>
	            <td class="ALRIGHT">是否默认地址</td>
	            <td><input type="checkbox" id="defaultOrNotEdit"/></td>
	          </tr>
	        </table></td>
	      </tr>
	      <tr>
	        <td align="center"><input type="button" onclick="saveGoodsAddress(this)" class="BUTTON" value="保存" />
	          <input type="reset" class="BUTTON" onclick="hideRegister()" value="取消" /></td>
	      </tr>
	  </table>
	</form>
	  <div id="DOWN">
	  		<input type="button" class="BUTTON" value="返回主页" onclick="history.go(-1);" />
	  </div>
	</div>
</body>
</html>
