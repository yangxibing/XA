<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>比价单</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
 	function allSelected(){
			if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='quoteItem']").attr("checked",true);
        	}
        	else {
        		$("[name='quoteItem']").attr("checked",false);
        	}
	}
	
	function publishPriceCompare(){
			var f_str="";
			var askPriceIdValue = $("#askPriceIdHidden").attr("value");
        	var count=0;
			$("[name='quoteItem']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});
			if(count > 0){
				if(confirm("请确认您选择的报价单，准备发布？")){
						$.post("publishPriceCompare.action",{quoteList:f_str, askPriceId:askPriceIdValue},function(data){
							$("#publishPriceButton").attr("disabled", "disabled");
							confirm("比价结果发布成功！");
							$("#queryEnquiry").submit();
						});
				}
			} else {
				alert("未选中任何项！");
			}
	}
</script>
</head>

<body>

<form id="queryEnquiry" action="queryEnquiry.action">
	<input type="hidden" name="askPriceId" id="askPriceIdInput" value="<s:property value="#request.enquiryId"/>" />
</form>

<div id="supply" class="CENTER">
<div id="top">
  <span style="color:#FFF;"><h2>比价单</h2></span>
</div>
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE" style="font-weight:bold;">
        	<td>选择</td>
            <td>产品代码及名称</td>
            <td>供应商名称</td>
            <td>价格（元）</td>
            <td>备注</td>
        </tr>
  	    <s:iterator id="element" value="#request.query">
        	<tr class="HOVER">
        		<td ><input name="quoteItem" type="checkbox" value="<s:property value="#element.answerPriceId"/>"/></td>
          	    <td ><s:property value="#element.productId"/>&nbsp;&nbsp;<s:property value="#element.productName"/></td>
           	    <td ><s:property value="#element.supplierName"/></td>
           	    <td ><s:property value="#element.price"/></td>
           	    <td ><s:property value="#element.remark"/></td>
        	</tr>
        </s:iterator>
        <tr>
        	<td align="left"><input type="checkbox" name="allSelectBox" onclick="allSelected()" />全选</td>
            <td colspan="4"></td>
        </tr>
    </table>
  <div id="DOWNUP" align="center">
  		<input type="button" class="REDBUTTON" id="publishPriceButton" onclick="publishPriceCompare()" value="发布比价结果" />
  </div>
  <input type="hidden" name="askPriceIdHidden" id="askPriceIdHidden" value="<s:property value="#request.enquiryId"/>"/>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
