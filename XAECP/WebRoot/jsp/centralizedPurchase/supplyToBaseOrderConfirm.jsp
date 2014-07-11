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
<script language="javascript">
	$().ready(function(){
		var productPrice=0;
		$("td[id='all']").each(function(){
			productPrice+=Number($(this).text());
		});
		$("#productPrice").text(productPrice);
		
		$("input[id='address']").each(function(){
			if($(this).attr("title").split("-")[4]=="1"){
				$(this).hide();
			}
		});
		$("input[name='selectAddress']").each(function(){
			if($(this).attr("title").split("-")[1]=="1"){
				$(this).attr("checked",true);
			}
		});
	});
	
	function defaultAddress(valu){
		var defaultValue=$(valu).attr("name");
		var a="";
		$("input[id='address']").each(function(){
			if($(this).attr("name")!=defaultValue){
				a=a+$(this).attr("name")+"-";
			}
		});
		a=a+","+defaultValue;
		var url="defaultAddress.action";
		var params={addresses:a};
		$.post(url,params,function(data){
			$("input[id='address']").each(function(){
				if($(this).attr("name")==defaultValue){
					$(this).hide();
				}else{
					$(this).show();
					$(this).attr("value","设为默认收货地址");
				}
			});
		});
	}
	
	function sendGoods(valu){
		var logisticsSupplierIdV=$("#logistics").attr("value");
		var logisticsOrderIdV=$("#logisticsOrderId").attr("value");
		var baseOrderIdV=$(valu).attr("name");
		var url="supplyAssureSendGoods.action";
		var addressIdV=""
		$("input[name='selectAddress']").each(function(){
			if($(this).attr("checked")=="true"){
			
				addressIdV=$(this).attr("title").split("-")[0];
			}
		});
		var params={baseOrderId:baseOrderIdV,
					logisticsSupplierId:logisticsSupplierIdV,
					logisticsOrderId:logisticsOrderIdV,
					sendAddressId:addressIdV};
		$.post(url,params,function(data){
			alert("确认发货成功！");
			$("#toFrontpageForm").submit();
		});
		
	}
</script>
<style>
#supply #showlist{ font-size:12px;}
#processTD{text-align:left;background-color:#DEEBF7; height:40px;}
#processTD #contentSpan{width:250px; margin-left:20px; margin-top:10px; font-size:16px; font-weight:bold;}
#Info #processTD #contentSpan{width:250px; margin-left:20px; margin-top:5px; font-size:16px; font-weight:bold;}
#process{ margin-top:4px; margin-right:4px;}
#supply #register{ background-color:#F4EEEA;}
#supply #Info{ background-color:#F4EEEA;}
#supply #register #registCnt{border-color:#CCC;}
#supply #Info #registCnt{border-color:#CCC;}
#supply #register #registCnt td{ border-color:#CCC;}
#supply #Info #registCnt td{ border-color:#CCC;}

#supply #register #spanLeft1{margin-left:25px; margin-top:5px;}
#supply #Info #spanLeft1{margin-left:25px; margin-top:5px;}
#supply #register #spanRight1{margin-right:25px; margin-top:5px; background-color:#EBD3C9;}
#supply #Info #spanRight1{margin-right:25px; margin-top:5px; background-color:#EBD3C9;}
.ORDERCONTENT{ font-size:18px; font-weight:bold; width:300px; height:40px; background-color:#4468E3; color:#fff; border:2px solid #AAA; vertical-align:middle; margin-top:5px;}
#threeWhole{ width:606px; height:44px;}
#threeWhole #one{ float:left; width:150px; height:44px;}
#threeWhole .ORDERCONTENT{ float:left;}
#threeWhole #three{ float:left; margin-left:5px; width:130px; height:15px; font-size:12px; margin-top:30px; background-color:#C9D1E9; border:1px solid #BBB;}
#supply #register #borderTD{ padding-bottom:5px; border-width:0 0 2px 0; border-style:dotted; border-color:#727BF8;}
#supply #Info #borderTD{ padding-bottom:5px; border-width:0 0 2px 0; border-style:dotted; border-color:#727BF8;}
#rightDown{ margin-right:23px;}
#cntDiv{ width:950px; padding-top:10px;}
#cntDiv span{ float:right;}
#supply #Info{ display:block;}
#providerTab{ width:900px; background-color:#FED8B6; border:2px solid #CCC; border-top-width:1px; border-right-width:1px; font-size:16px; font-weight:bold;}
#Info #providerTab td{ border-width:1px 1px 0 0; border-style:solid; border-color:#CCC;}
</style>

</head>

<body>
<form id="toFrontpageForm" action="listSupplierOrders.action"></form>
<div id="supply" class="CENTER">
<div id="top">
  <span style="color:#FFF;">
  <h2>订单确认发货</h2></span>
</div>
   <table id="Info" class="CENTER" cellpadding="0">
      <tr>
        <td>
        <table id="registCnt" style="margin-top:15px; margin-bottom:10px;" class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <tr>
            <td class="ALRIGHT">采购订单代码</td>
            <td class="ALLEFT"><s:property value="baseOrder.baseOrderId"/></td>
            <td class="ALRIGHT">供应商名称</td>
            <td class="ALLEFT"><s:property value="baseOrder.supplierName"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">集中采购信息代码</td>
            <td class="ALLEFT"><s:property value="baseOrder.CPIId"/> </td>
            <td class="ALRIGHT">计划采购信息代码</td>
            <td class="ALLEFT">XXXXXX</tr>
          <tr>
            <td class="ALRIGHT">交货日期</td>
            <td class="ALLEFT"><s:property value="baseOrder.deliverDate"/></td>
            <td class="ALRIGHT">应支付定金</td>
            <td class="ALLEFT"><s:property value="baseOrder.deposit"/>（元）</td>
          </tr>
          <tr>
            <td class="ALRIGHT">运费</td>
            <td class="ALLEFT"><s:property value="baseOrder.fare"/>（元）</td>
            <td class="ALRIGHT">总货款</td>
            <td class="ALLEFT"><s:property value="baseOrder.totalPrice"/>（元）</td>
          </tr>
          <tr>
          	<td class="ALRIGHT">收货地址</td>
            <td class="ALLEFT" colspan="3"><s:property value="baseOrder.receiveAddress"/></td>
          </tr>
        </table></td>
      </tr>
      <tr>
      	<td id="borderTD"></td>
      </tr>
     <tr>
     	<td>
     	<table id="registCnt" style="margin-top:15px;"  class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <tr>
            <td>产品代码及名称</td>
            <td>度量单位</td>
            <td>价格（元）</td>
            <td>采购数量</td>
            <td>合计（元）</td>
          </tr>
          <s:iterator id="element" value="#request.list">
          <tr id="productList">
            <td><a href="#"><s:property value="#element.idName"/></a></td>
            <td><s:property value="#element.measureUnit"/></td>
            <td><s:property value="#element.price"/></td>
            <td><s:property value="#element.number"/></td>
            <td id="all"><s:property  value="#element.allPrice"/></td>
          </tr>
          </s:iterator>
        </table></td>
     </tr>
      <tr>
      	<td align="right">
            <div class="ORDERCONTENT" id="rightDown"><span>产品货款：<label id="productPrice"></label>（元）</span></div>
        </td>
      </tr>
      <tr>
      	<td>
        	<table class="CENTER">
            	<tr align="left">
                	<td><span>确认发货信息&nbsp;注：<font color="#F00">*</font>为必填项<td>
                </tr>
                <tr>
                	<td>
                    	<table id="providerTab" class="CENTER" cellpadding="2px;" cellspacing="0">
                        	<tr>
                            	<s:select label="物流供应商" id="logistics" list="#request.logistics" headerKey="-1" headerValue="-------------请选择--------------" listKey="partnerId" listValue="partnerName"/>
                           	</tr>
                            <tr>
                            	<td class="ALLEFT">物流单号：</td>
                                <td class="ALLEFT"><input type="text"  id="logisticsOrderId" class="INPUTTEXT" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                	<td align="left" style="padding-top:10px;" valign="bottom"> 发货地址信息</td>
                </tr>
                <tr>
                	<td>
                    	<table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
                        	<tr>
                            	<td>选择</td>
                                <td>发货地址</td>
                                <td>邮编</td>
                                <td>发货人</td>
                                <td>联系电话</td>
                                <td></td>
                            </tr>
                            <s:iterator id="element" value="#request.goodsAddress">
                            <tr>
                            	<td><input name="selectAddress" title="<s:property value="#element.addressId"/>-<s:property value="#element.defaultOrNot"/>" type="radio" /></td>
                                <td><s:property value="#element.sendAddress"/></td>
                                <td><s:property value="#element.zipCode"/></td>
                                <td><s:property value="#element.contacter"/></td>
                                <td><s:property value="#element.telephone"/></td>
                                <td><input id="address" type="button" title="<s:property value="#element.sendAddress"/>-<s:property value="#element.zipCode"/>-<s:property value="#element.contacter"/>-<s:property value="#element.telephone"/>-<s:property value="#element.defaultOrNot"/>" name="<s:property value="#element.addressId"/>" class="BUTTON" onClick="defaultAddress(this);" value="设为默发收货地址" /></td>
                            </tr>
                            </s:iterator>
                        </table>
                    </td>
                </tr>
                <tr>
                	<td><input type="button" class="BUTTON" value="管理发货地址" /></td>
                </tr>
                <tr align="center">
                	<td><input type="button" name="<s:property value="baseOrder.baseOrderId"/>" onclick="sendGoods(this)" class="BIGREDBUTTON" value="确认发货" /></td>
                </tr>
            </table>
        </td>
      </tr>
  </table>	
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
