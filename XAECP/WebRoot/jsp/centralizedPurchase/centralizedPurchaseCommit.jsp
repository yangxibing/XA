<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>集中采购信息</title>

<link href="/XAECP/css/supply.css" rel="stylesheet" type="text/css"/>
<link href="/XAECP/css/global.css" rel="stylesheet" type="text/css"/>
<link href="/XAECP/css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="/XAECP/javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="/XAECP/javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
	function checkNumber(valu){
     		if($(valu).attr("value")!= "" && $(valu).attr("value") <= 0) {
     			alert("采购数量不可以为负值！");
     			$(valu).attr("value", "");
     		} else if($(valu).attr("value")!= "" && $(valu).attr("value") > 0) {
     			
     		} else {
     			$(valu).attr("value", "");
     		}		
	}
				
	function centralizedPurchaseCommitUpdate(valu){
		if($("#demandNumberInput").attr("value") ==""){
			return;
		}
		var demandNumberValue = $("#demandNumberInput").attr("value");
		var cpPurchaseInfoIdValue = $("#cpPurchaseInfoIdHidden").attr("value");
		var params = {demandNumber:demandNumberValue, cpPurchaseInfoId:cpPurchaseInfoIdValue, async:false};
		var url = $("#centralizedPurchaseCommitUpdate").attr("action");
		$.post(url, params, function(data){
			$(valu).hide();
			$("#demandNumberInput").attr("disabled", true);	
			if(data.CPDemandApplyState == "CONFLICT"){
				alert("你已经申请过本次集中采购信息！");
			} else if(data.CPDemandApplyState == "SUCCESS") {
				alert("需求提交成功");				
			}				
		}, 'json');		
	}	

</script>

<style>
#supply #register{ display:block;  background-color:#FFF; border-width:0;}
#supply #register #registCnt{margin-top:10px; background-color:#C0DFFE; width:500px;}
.ALRIGHT{ color:#A26D00;}
#supply #register thead{font-weight:bold;}
</style>
</head>

<body>
	<form id="centralizedPurchaseCommitUpdate" action="centralizedPurchaseCommitUpdate.action">
		<input type="hidden" name="cpPurchaseInfoId" id="cpPurchaseInfoIdHidden" value="<s:property value="#request.centralizedPurchase.cpPurchaseInfoId"/>" />
		<input type="hidden" name="demandNumber" id="demandNumberHidden" value="" />
	</form>

	<div id="supply" class="CENTER">
	<div id="top">
	  <span><h2>集中采购信息</h2></span>
	</div>
	<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
		<thead><tr><td><s:property value="#request.centralizedPurchase.cpPurchaseInfoTitle"/></td></tr></thead>
		<tbody>
	      <tr>
	        <td>
	        <table id="registCnt" class="CENTER" cellpadding="2px;" cellspacing="0">
	          <tr class="EEE">
	            <td class="ALRIGHT">产品类别&nbsp;</td>
	            <td class="ALLEFT"><s:property value="#request.centralizedPurchase.productTypeName"/></td>
	          </tr>
	          <tr class="EEE">
	            <td class="ALRIGHT">需求数量&nbsp;</td>
	            <td class="ALLEFT"><input type="text" id="demandNumberInput" onkeyup="checkNumber(this)" />（<label id="measureUnitLabel"><s:property value="#request.centralizedPurchase.measureUnit"/></label>）</td>
	          </tr>
	        </table></td>
	      </tr>
	      <tr>
	      	<td> <input type="button" value="提交需求" onclick="centralizedPurchaseCommitUpdate(this)" class="BUTTON"/></td> 
	      </tr>
	     </tbody>
	  </table>
	<div id="DOWN">
		<input type="button" class="BUTTON" onclick="javascript:window.location='/XAECP/home.jsp';" value="返回首页"/>
	</div>
	</div>
</body>
</html>
