<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>价格发布</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
	function addPublishPrice(){
		if($("#publishPriceItem>tr:last option").length <= $("#publishPriceItem>tr").length){
			alert("发布价格的条目数量不能大于可供选择的产品数！");
			return;
		}
		
		var item = "<tr id=\"productItem\" class=\"HOVER\">";
		item += $("#publishPriceItem>tr:last").html();
		item += "</tr>";
				
		$("#publishPriceItem").append(item);
	}
	
	function checkNumber(valu){
		    if($(valu).attr("value")!= "" && $(valu).attr("value") <= 0) {
     			alert("产品价格不可以为负值！");
     			$(valu).attr("value", "");
     		} else if($(valu).attr("value")!= "" && $(valu).attr("value") > 0) {
     			
     		} else {
     			alert("产品价格格式不正确！");
     			$(valu).attr("value", "");
     		}	
	}
	
	function publishPriceCommit(valu){
		var cpPurchaseInfoIdValue = $("#cpPurchaseInfoIdHidden").val();
		var priceListValue = "";
		var productIdList = "";
		var continueTag = true;
		$("#publishPriceItem>tr").each(function(){
			var productId = $(this).children("td").eq(1).children("select").eq(0).val();
			var number = $(this).children("td").eq(3).children("input").eq(0).val();
			if(number != ""){
				if(productIdList.indexOf(productId) == -1){
					productIdList += productId + " ";
					priceListValue += productId + " " + number + ",";						
				} else {
					alert("同一产品重复发布价格，请确认后再发布！");	
					continueTag = false;
					return false;
				}
			}
		});
		if(continueTag == false){
			return false;
		}
		
		var params = {cpPurchaseInfoId:cpPurchaseInfoIdValue, priceList:priceListValue, async:false};
		var url = $("#publishPriceCommit").attr("action");
		$.post(url, params, function(){
			$(valu).hide();
			alert("发布价格成功！");
			$("#queryCentralizedPurchaseList").submit();
		});
	}
	
	function selectchange(valu){
		$(valu).parent().next("td").next("td").children("input").eq(0).val("");
	}
</script>

<style>
	#supply #register{clear:both; display:block; background-color:#FFF; border-width:0;}
	#supply #register #registCnt{margin-top:0;}
	#supply #register #registCnt .ALRIGHT{ color:#000;}
	#rightSpace{ margin-right:25px;}
</style>
</head>

<body>

	<form id="publishPriceCommit" action="publishPriceCommit.action"></form>
	<form id="queryCentralizedPurchaseList" action="queryCentralizedPurchaseList.action">
		<input type="hidden" id="cpPurchaseInfoIdHidden" value="<s:property value="#request.centralizedPurchase.cpPurchaseInfoId"/>"/>
		<input type="hidden" name="centralizedPurchaseState" value="3" />
	</form>

	<div id="supply" class="CENTER">
	<div id="top">
	  <h2><span style="color:#FFF;">价格发布</span></h2>
	</div>
	<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
		 <tr>
	     	<td align="center">
	        	<span id="rightSpace" class="FLOATRIGHT"><input type="button" class="ARTBUTTON" onclick="addPublishPrice()" value="新增价格"/></span>
	        </td>
	     </tr>
	      <tr>
	        <td>
	        <table id="registCnt" class="CENTER" cellpadding="2px;" cellspacing="0">
	        	<tbody id="publishPriceItem">
				        <tr id="productItem" class="HOVER">
				            <td class="ALRIGHT">产品代码及名称</td>
				            <td class="ALLEFT">
				            	<select id="productSelectList" onchange="selectchange(this)">
				            		<s:iterator id="element" value="#request.query" >
				            			<option value="<s:property value="#element.productId"/>" ><s:property value="#element.productId"/> <s:property value="#element.productName"/></option>
				            		</s:iterator>
				            	</select>
				            </td>
				            <td class="ALRIGHT">价格（元）</td>
				            <td class="ALLEFT"><input type="text" id="priceEdit" onkeyup="checkNumber(this)" /></td>
				        </tr>
			  	</tbody>
	        </table></td>
	      </tr>
	      <tr>
	      	<td style=" height:40px; vertical-align:bottom; text-align:center;"> 
	        	<input type="button" value="发布价格"  class="BUTTON" onclick="publishPriceCommit(this)" />
	        </td> 
	      </tr>
	  </table>
	  <div id="DOWN">
		<input type="button" class="BUTTON" onclick="window.open('home.html','_blank')" value="返回首页"/>
	</div>
	</div>
</body>
</html>
