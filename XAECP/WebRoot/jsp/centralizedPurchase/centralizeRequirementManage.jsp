<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>集中采购需求管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>

<script type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"> 
		function displayRegister() { 
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        function assuerDemand(valu){
        	$("#products>tr").each(function(){
        		$(this).remove();
        	});
        	var cpPurchaseInfoIdV=$(valu).attr("name");
        	var url="selectProductsByCPIIdAndSupplierId.action";
        	var params={cpPurchaseInfoId:cpPurchaseInfoIdV};
        	$.post(url,params,function(data){
        		
        		$.each(data.productList,function(i,value){
        			var str="<tr>"+
            						"<td><a href='#'>"+value.productId+"</a></td>"+
           							"<td>"+value.productName+"</td>"+
           							"<td>"+value.measureUnit+"</td>"+
            						"<td>"+value.price+"</td>"+
            					 	"<td><input type='text' onKeyUp='keyUp(this)' name='"+value.productId+"'/></td>"+
          							"<td></td>"+
          						"</tr>";
          				$("#CPIId").attr("value",value.CPIId);
          				$("#products").append(str);
        		});
        		
        		$.each(data.goodsAddress,function(i,value){
        			var redio="";
        			var addressButton="<td><input type='button' onclick='defaultAddress(this)' id='address' value='设为默认收货地址' name='"+value.addressId+"'/></td>";
        			if(value.defaultOrNot=="1"){
        				redio="<td><input  type='radio' name='radio' checked='true' ></input></td>";
        			}else{
        				redio="<td><input  name='radio' type='radio'></input></td>";
        			}
        			var str="<tr>"+
            						redio+
           							"<td>"+value.sendAddress+"</td>"+
           							"<td>"+value.zipCode+"</td>"+
            						"<td>"+value.contacter+"</td>"+
            					 	"<td>"+value.telephone+"</td>"+
          							addressButton+
          						"</tr>";
          				$("#address").append(str);
        		});
        		$("#orderRate").attr("value",data.orderRate);
        		
        		$("#address>tr").each(function(){
        			
        			var td=$(this).children("td");
        			if(td.eq(0).children("input").eq(0).attr("checked")==false){
        				td.eq(5).children("input").eq(0).show();
        			}else{
        				td.eq(5).children("input").eq(0).hide();
        			}
        		});
        		displayRegister();
        	});
        }
        
        function cancelDemand(valu){
        	var cpi = $(valu).attr("name");
        	var params={CPIId:cpi};
        	var url = "cancelDemand.action";
        	$.post(url,params,function(){
        		$("#listCPRForm").submit();
        	});
        }
        
        function keyUp(valu){
        	var obj=$(valu).parent().parent().children("td");
        	obj.eq(5).text(obj.eq(3).text()*$(valu).attr("value"));
        	var productPrice=0;
        	$("#products>tr").each(function(){
        		var td=$(this).children("td");
        		if(td.eq(5).text()!=""){
        			productPrice=Number(productPrice)+Number(td.eq(5).text());
        		}
        	});
        	$("#productPrice").text(productPrice);
        	$("#allPrice").text(Number(productPrice)+Number($("#fare").attr("value")));
			var own=Number($("#allPrice").text())*Number($("#orderRate").attr("value"));
        	$("#ownOrder").text(own.toFixed(2));        }
        
        function fareChange(valu){
        	if(checkWare($(valu).attr("value"))==false){
        		return false;
        	}
        		
        	$("#allPrice").text(Number($("#productPrice").text())+Number($(valu).attr("value")));
        	var own=Number($("#allPrice").text())*Number($("#orderRate").attr("value"));
        	$("#ownOrder").text(own.toFixed(2));
        	
        }
        
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
	
	function submitOrder(){
	
		var orderStateV=1;
		var deliverDateV=$("#deliverDate").attr("value");
		var receiveAddressIdV="";
		$("#address>tr").each(function(){
			var td=$(this).children("td");
			if(td.eq(0).children("input").eq(0).attr("checked")==true){
				receiveAddressIdV=td.eq(5).children("input").eq(0).attr("name");
			}
		});
		var fareV=$("#fare").attr("value");
		var totalPriceV=$("#allPrice").text();
		var CPIIdV=$("#CPIId").attr("value");
		var productsV="";
		$("#products>tr").each(function(){
			var td=$(this).children("td");
			if(td.eq(4).children("input").eq(0).attr("value")!=null&&td.eq(4).children("input").eq(0).attr("value")!=""){
				productsV=productsV+td.eq(0).text()+"-"+td.eq(2).text()+"-"+td.eq(3).text()+"-"+td.eq(4).children("input").eq(0).attr("value")+",";
			}
		});
		if(productsV==""){
			alert("您没有选择任何产品");
			return false;
		}
		var params={orderState:orderStateV,
					deliverDate:deliverDateV,
					receiveAddressId:receiveAddressIdV,
					fare:fareV,
					totalPrice:totalPriceV,
					CPIId:CPIIdV,
					products:productsV
					};
		var url="submitCPIOrder.action";
		
		$.post(url,params,function(data){
			$("#listCPRForm").submit();
		});
	}

	function goodsAddressManage(){
		$("#goodsAddressManageForm").attr("action","goodsAddressManage.action?sendOrReceive=0");
		$("#goodsAddressManageForm").submit();
	}

	 //分页处理
    function prePage(){
    	var currentPage = Number($("#currentPageTag").text());
    	var totalPage = Number($("#totalPageTag").text());
    	if(currentPage<=1){
    		return false;
    	}
    	currentPage = currentPage - 1;
    	$("#listCPRForm").attr("action", "listCPR.action?currentPage="+currentPage);
    	$("#listCPRForm").submit();
    }

	function nextPage(){
		var currentPage = Number($("#currentPageTag").text()); 	
		var totalPage = Number($("#totalPageTag").text());
		if(currentPage>=totalPage){
			return false;
		}
		currentPage = currentPage + 1;
		$("#listCPRForm").attr("action", "listCPR.action?currentPage="+currentPage);
    	$("#listCPRForm").submit();
	}
</script>
<style>
#supply #showlist{ font-size:14px; margin-top:20px;}
#processTD{text-align:left;}
#processTD #contentSpan{width:250px;margin-top:10px; margin-left:3px; font-size:16px; font-weight:bold;}
#process{ margin-top:4px; margin-right:4px;}
#supply #register{ background-color:#FFF;}

#supply #register #registCnt{ text-align:center; margin-top:0; margin-bottom:0;}
#supply #register #spanLeft1{margin-left:25px; margin-top:2px; margin-bottom:2px;}
#supply #register #spanRight1{margin-right:25px; margin-top:2px; margin-bottom:2px;}
#supply #Info #registCnt{ text-align:center; margin-top:0; margin-bottom:0;}
#supply #Info #spanLeft1{margin-left:25px; margin-top:2px; margin-bottom:2px;}
#supply #Info #spanRight1{margin-right:25px; margin-top:2px;margin-bottom:2px;}
.TOPPX{ padding-top:10PX;}
.ORDERCONTENT{ font-size:18px; font-weight:bold; width:300px; height:40px; color:#fff; border:2px solid #AAA; vertical-align:middle; margin-top:5px;}
#threeWhole{ width:606px; height:44px;}
#threeWhole #one{ float:left; width:150px; height:44px;}
#threeWhole .ORDERCONTENT{ float:left;}
#threeWhole #three{ float:left; margin-left:5px; width:130px; height:15px; font-size:12px; margin-top:30px; background-color:#C9D1E9; border:1px solid #BBB;}
</style>

</head>

<body>
<form id="listCPRForm" action="listCPR.action" method="post"></form>
<form id="goodsAddressManageForm"  method="post"></form>
<div id="supply" class="CENTER">
<div id="top">
  <span><h2>集中采购需求管理</h2></span>
</div>
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="2px;">
    	<tr class="TITLE">
        	<td>集中采购信息标题</td>
            <td>产品类型</td>
            <td>度量单位</td>
            <td>需求数量</td>
            <td>需求状态</td>
            <td>申报时间</td>
            <td>操作</td>
        </tr>
        <s:iterator id="element" value="#request.centralizeDemand">
        <tr class="HOVER">
        	<td ><a href="getCPIByCPIId.action?cpPurchaseInfoId=<s:property value='#request.cpPurchaseInfoId'/>"><s:property value="#element.cpPurchaseInfoTitle"/></a></td>
            <td ><s:property value="#element.productTypeId"/></td>
            <td ><s:property value="#element.measureUnit"/></td>
            <td ><s:property value="#element.demandNumber"/></td>
            <td ><s:property value="#element.demandStateName"/></td>
            <td ><s:property value="#element.reportDemandTime"/></td>
            <td>
            	<s:if test="%{#element.demandState<2}">
            		<span class="ARTSPAN">等待价格发布</span><br />
            	</s:if>
            	<s:if test="%{#element.demandState<=2}">
                	<input type="button" onclick="assuerDemand(this);" name="<s:property value="#element.cpPurchaseInfoId"/>" class="BUTTON" value="确认需求" />
                	<input type="button" onclick="cancelDemand(this)" name="<s:property value="#element.cpPurchaseInfoId"/>" class="BUTTON" value="取消需求" />
                </s:if>
                <s:if test="%{#element.demandState==4}">
                	<span class="ARTSPAN">已经生成订单</span><br />
                </s:if>
            </td>
        </tr>
        </s:iterator>
        <tr>
            <td colspan="8" align="right">
               <input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	           <span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	           <input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
            </td>
        </tr>
    </table>
<form>
	<div class="EMPTYDIV"></div>
  <table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr class="TITLE">
        <td id="processTD">
            <span id="contentSpan" class="FLOATLEFT">需求确认信息</span>
             <input type="hidden" id="CPIId"/>
             <div id="process" class="FLOATRIGHT">
                <div class="ARTLEFTDIV"><span>交易仅需六步<span></div>
                <div class="ARTDIV">
                    <span>提交需求</span>
                </div>
                <div class="BLUEDIV">
                    <span>提交订单</span>
                </div>
                <div class="ARTDIV">
                    <span>支付定金</span>
                </div>
                <div class="ARTDIV">
                    <span>确认到货</span>
                </div>
                <div class="ARTDIV">
                    <span>支付货款</span>
                </div>
                <div class="ARTDIV">
                    <span>用后评价</span>
                </div>
            </div>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" style="margin-top:10px;" class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <thead>
          	<tr>
            	<td>产品代码</td>
            	<td>产品名称</td>
            	<td>度量单位</td>
            	<td>价格（元）</td>
            	<td>最终数量</td>
            	<td>合计（元）</td>
            </tr>
          </thead>
          <tbody id="products">
          
          </tbody>
        </table></td>
      </tr>
      <tr>
      	<td align="center">
        	<div class="ORDERCONTENT"><span>交货日期：<input id="deliverDate" type="text" onclick="WdatePicker();"/></span></div>
            <div class="ORDERCONTENT">产品货款：<label id="productPrice">0</label>（元）</div>
            <div class="ORDERCONTENT"><span>运费：<input id="fare" onkeyup="fareChange(this)" type="text" />（元）</span></div>
            <div class="ORDERCONTENT">总货款：<label id="allPrice">0</label>（元）</div>
            <div id="threeWhole">
            	<div id="one"></div>
            	<div class="ORDERCONTENT">应支付定金：<label id="ownOrder"></label>（元）</div>
                <div id="three">=总货款*定金比率</div>
            </div>
            <input type="hidden" id="orderRate"/>
        </td>
      </tr>
      <tr>	
      	<td>
        	<span id="spanLeft1" class="FLOATLEFT">收货地址信息</span>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <thead>
          <tr>
            <td>选择</td>
            <td>收货地址</td>
            <td>邮编</td>
            <td>收货人</td>
            <td>联系电话</td>
            <td>地址操作</td>
          </tr>
          </thead>
          <tbody id="address">
          
          </tbody>
        </table></td>
      </tr>
      <tr>
      	<td align="left"><input style="margin-left:25px;" type="button" onclick="goodsAddressManage();" class="BUTTON" value="管理收货地址" /></td>
      </tr>
      <tr>
        <td align="center"><input type="button" onClick="submitOrder();" class="BIGREDBUTTON" value="提交订单" /></td>
      </tr>
  </table>
</form>
  <div class="EMPTYDIV"></div>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
  </div>
</div>

<div>
</div>
</body>
</html>
