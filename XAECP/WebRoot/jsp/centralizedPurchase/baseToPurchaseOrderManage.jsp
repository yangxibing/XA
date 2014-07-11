<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>销售订单管理-基地</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script type="text/javascript">
		$().ready(function(){
			var purchaserId='<s:property value="purchaseOrder.purchaserId"/>';
			$.post("getAllPurchasers.action",function(data){
				$.each(data.purchasers,function(i,value){
					var s="<option value="+value.partnerId+">"+value.partnerName+"</>"
					$("#purchaserId").append(s);
					
				});
				$("#purchaserId option").each(function(){
					if($(this).attr("value")==purchaserId){
						$(this).attr("selected",true);
					}
				});	
			});	
			
			
			var orderState='<s:property value="purchaseOrder.orderState"/>';
			$("#orderState option").each(function(){
				
				if($(this).attr("value")==orderState){
					$(this).attr("selected",true);
				}
			});	
			
			
		});
		
		function count(){
			var str=$("#productPrice").text();
			var n=str.replace(/\D/g,"");
			var count=Number(n)+Number($("#fare").attr("value"));
			$("#allPrice").attr("value",count);
			var ownOrder=count*Number($("#orderRate").attr("value"));
			$("#ownOrder").text(ownOrder.toFixed(2));
			
		}
		function count2(){
			var ownOrder=Number($("#orderRate").attr("value"))*Number($("#allPrice").attr("value"));
			$("#ownOrder").text(ownOrder.toFixed(2));
		}
		function displayRegister() {
			hideInfo();    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
		function displayInfo() {
			hideRegister();    
            var subMenu=document.getElementById("Info");
            subMenu.style.display = "block";
        }
		function hideInfo() {    
            var subMenu=document.getElementById("Info");
            subMenu.style.display = "none";
        }
        function changeOrder(valu){
        	
        	$("#orderDate").text($(valu).attr("title").toLocaleString());
			var a=new Array();
        	a=$(valu).attr("name").split("-");
        	$("#orderNum").text(a[0]);
        	$("#orderRate").attr("value",a[1]);
        	var params={purId:a[0]};
        	var url="selectProducts.action";
        	if($(valu).attr("value")=="修改订单"){
        		$.post(url,params,function(data){
        			display(data,"修改订单");
        			$("#fare").attr("value","");
        			$("#fare").attr("disabled",false);
        			$("#allPrice").attr("value","");
        			$("#allPrice").attr("disabled",false);
        			$("#save").show();
        			$("#cancel").show();
        			$("#three").show();
        			$("#returnNumber").hide();
        			$("#assuregetGoods").hide();
        			displayRegister();
        		},'json');
        	}else if($(valu).attr("value")=="订单详情"){
        		$.post(url,params,function(data){
        			display(data,"订单详情");
        			var a=new Array();
        			a=$(valu).attr("name").split("-");
        			$("#fare").attr("value",a[2]);
        			$("#fare").attr("disabled",true);
        			$("#allPrice").attr("value",a[3]);
        			$("#allPrice").attr("disabled",true);
        			var count=Number(a[3])*Number($("#orderRate").attr("value"));
        			$("#ownOrder").text("应支付定金"+count.toFixed(2));
        			$("#save").hide();
        			$("#cancel").hide();
        			$("#contentSpan").text("订单详情");
        			$("#returnNumber").hide();
        			$("#three").show();
        			$("#assuregetGoods").hide();
        			displayRegister();
        		},'json');
        	}else{
        		$.post(url,params,function(data){
        			display(data,"退货详情");
        			var a=new Array();
        			a=$(valu).attr("name").split("-");
        			$("#fare").attr("value",a[2]);
        			$("#fare").attr("disabled",true);
        			$("#allPrice").attr("value",a[3]);
        			$("#allPrice").attr("disabled",true);
        			var count=Number(a[3])*Number($("#orderRate").attr("value"));
        			$("#save").hide();
        			$("#cancel").hide();
        			$("#contentSpan").text("退货详情");
        			$("#returnNumber").show();
        			$("#ownOrder").text("实际退货款："+a[4]);
        			$("#three").hide();
        			if($(valu).attr("value")=="退货详情"){
        				$("#assuregetGoods").hide();
        				
        				
        			}else if($(valu).attr("value")=="退货收货"){
        				$("#assuregetGoods").show();
        				$("#contentSpan").text("退货收货");
        				$("#assuregetGoods").attr("value","确认收到退货");
        			}else{
        				$("#assuregetGoods").attr("value","支付退款"+a[4]+"（元）");
        			}
        			displayRegister();
        		},'json');
        	}
        } 
        
        function display(data,str){
        	
        	$("#registCnt tr:gt(0)").remove();
        	var a=new Array();
        	var allCount=0;
        	var productPrice=0;
        	a=data.ajaxResult.split(",");
        	var appendStr=""
        	for(var i=0;i<a.length-1;i++){
        		var b=new Array();
        		b=a[i].split("[]");
        		var count=0;
        		
        		$("#allPrice").attr("name",b[0]);
        		if(str=="退货详情"){
        			count=Number(b[3])*Number(b[5]);
        			productPrice+=count;
        			appendStr="<tr>"+
        									"<td>"+b[1]+"</td>"+
        									"<td>"+b[2]+"</td>"+
        									"<td>"+b[3]+"</td>"+
        									"<td>"+b[4]+"</td>"+
        									"<td>"+b[5]+"</td>"+
        									"<td>"+count+"</td>"+
        								"</tr>"
        		}else{
        			count=Number(b[3])*Number(b[4]);
        			productPrice+=count;
        			appendStr="<tr>"+
        									"<td><a href=\"\">"+b[1]+"</a></td>"+
        									"<td>"+b[2]+"</td>"+
        									"<td>"+b[3]+"</td>"+
        									"<td>"+b[4]+"</td>"+
        									"<td>"+count+"</td>"+
        								"</tr>"
        		}
        		$("#registCnt").append(appendStr);
        	}
        	if(str=="退货详情"||str=="支付退货款"){
        		$("#productPrice").text("累计退货款      "+productPrice+"    元");
        		$("#fareDiv").hide();
        		$("#allPriceDiv").hide();
        		
        	}else{
        		$("#productPrice").text("产品货款      "+productPrice+"    元");
        		$("#fareDiv").show();
        		$("#allPriceDiv").show();
        	}
        }
        
        function saveInfo(){
        	var url="saveOrder.action";
        	var params={
        				purOId:$("#orderNum").html(),
        				fare:$("#fare").attr("value"),
        				totalPrice:$("#allPrice").attr("value")
        				};
        			
        	$.post(url,params,function(data){
        		hideRegister();
        		listPurchaseOrder();
        	});
        }
        
        function assure(valu){
        	
        	var purOId=$(valu).attr("name");      	
        	$("#assureForm").attr("action","assureForm.action?purOId="+purOId);
        	$("#assureForm").submit();
        }
        
        function listPurchaseOrder(){
        	$("#listOrdersForm").submit();
        }
        
        function listOrders(){
        	var orderStateV=$("#orderState").attr("value");
        	var CPIIdV=$("#CPIId").attr("value");
        	var purchaserIdV=$("#purchaserId").attr("value");	
        	$("#listOrdersForm").attr("action","listOrders.action?orderState="+orderStateV+"&&CPIId="+CPIIdV+"&&purchaserId="+purchaserIdV);
        	$("#listOrdersForm").submit();
        }
        
        function returnOrder(){
        
        }
        function assureGetGoods(valu){
        	if($(valu).attr("value")=="确认收到退货"){
        		if(confirm("确定收到退货么？")){
        			var url="assuerGetGoods.action";
        			var productsV="";
        			$("#registCnt tr:gt(0)").each(function(){
        				productsV=productsV+$(this).children("td").eq(0).text()+","+$(this).children("td").eq(4).text()+"@";
        			});
        			var params={purchaseOrderId:$("#orderNum").text(),products:productsV};
        			$.post(url,params,function(data){
        				listOrders();
        			});
        		}
        	}else{
        		if(confirm("确定支付退款么？")){
        			var url="assuerPayGoods.action";
        			var params={purchaseOrderId:$("#orderNum").text()};
        			$.post(url,params,function(data){
        				listOrders();
        			});
        		}
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
        	$("#listOrdersForm").attr("action", "listOrders.action?currentPage="+currentPage+"&&purchaserId="+$("#purchaserId").attr("value"));
        	$("#listOrdersForm").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#listOrdersForm").attr("action", "listOrders.action?currentPage="+currentPage+"&&purchaserId="+$("#purchaserId").attr("value"));
        	$("#listOrdersForm").submit();
		}
</script>
<style>
#supply #showlist{ font-size:12px;}
#processTD{text-align:left; height:30px;}
#processTD #contentSpan{width:250px; margin-left:10px; font-size:16px; font-weight:bold;}
#supply #register{ background-color:#F4EEEA;}
#supply #Info{background-color:#F4EEEA; }
#supply #register #registCnt{ margin-top:0;}
#supply #Info #registCnt{ margin-top:0;}
#supply #register #spanLeft1{margin-left:25px; margin-top:10px; font-size:12px;}
#supply #Info #spanLeft1{margin-left:25px; margin-top:10px; font-size:12px;}
#spanRight1{margin-right:25px; margin-top:5px; margin-bottom:2px;}
.ORDERCONTENT{ font-size:18px; font-weight:bold; width:300px; height:40px; background-color:#4468E3; color:#fff; border:2px solid #AAA; vertical-align:middle; margin-top:5px;}
#threeWhole{ width:606px; height:44px;}
#threeWhole #one{ float:left; width:150px; height:44px;}
#threeWhole .ORDERCONTENT{ float:left;}
#threeWhole #three{ float:left; margin-left:5px; width:130px; height:15px; font-size:12px; margin-top:30px; background-color:#C9D1E9; border:1px solid #BBB;}
#assuregetGoods{height:40px; width:250px; margin-top:10px;}
.spanClass{color:red}
</style>

</head>

<body>
<form action="selectProducts.action"></form>
<form  id="assureForm" method="post"></form>
<form id="listOrdersForm" method="post"></form>
<div id="supply" class="CENTER">
<div id="top">
  <span><h2>销售订单管理-基地</h2></span>
</div>
    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE">
        	<td><b>组合条件查询</b></td>
            <td colspan="6"></td>
        </tr>
        <tr>
        	<td  align="right">订单状态</td>
            <td >
            	<select id="orderState" name="orderState">
                	<option value=''>----请选择订单状态----</option>
                	<option value='1'>订单提交未支付定金</option>
                	<option value='2'>订单提交已支付定金</option>
                	<option value='3'>取消</option>
                	<option value='4'>已经确认发货</option>
                	<option value='5'>已经确认到货未付款</option>
                	<option value='6'>交易完成</option>
                	<option value='7'>申请退货</option>
                	<option value='8'>退货收货</option>
                	<option value='9'>退货成功</option>
                </select>
            </td>
            <td  align="right">集中采购信息代码</td>
            <td ><input id="CPIId" type="text" value="<s:property value="purchaseOrder.CPIId"/>"class="INPUTTEXT" name="CPIId" /></td>
            <td  align="right">采购商名称</td>
            <td >
            	<select id="purchaserId" name="purchaserId">
                	<option value=''>--- 请选择采购商---</option>
                </select>
            </td>
            <td align="right" >
            	<input type="button" onclick="listOrders()" class="BUTTON" value="查询" />
                <input type="reset" class="BUTTON" value="清空" />
            </td>
        </tr>
    </table>

	
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="2px;">
    	
    	<tr class="TITLE" style="font-weight:bold;">
            <td>订单代码</td>
            <td>采购商名称</td>
            <td>订单状态</td>
            <td>是否支付定金</td>
            <td>定金（元）</td>
            <td>运费（元）</td>
            <td>总货款（元）</td>
            <td>集中采购信息代码</td>
            <td>收货地址</td>
            <td colspan="2">&nbsp;</td>
        </tr>
        <s:iterator id="element" value="#request.query" >
        <tr class="HOVER">
            <td ><s:property value="#element.purchaseOrderId"/></td>
            <td ><s:property value="#element.purchaserName"/></td>
            <td ><s:property value="#element.orderStateName"/></td>
            <td >
            	<s:if test="%{#element.deposit==null}">×</s:if>
            	<s:else>√</s:else>
            </td>
            <td >
            	<s:property value="#element.deposit"/>
            </td>
            <td ><s:property value="#element.fare"/></td>
            <td ><s:property value="#element.totalPrice"/></td>
            <td ><a href="#"><s:property value="#element.CPIId"/></a></td>
            <td><s:property value="#element.sendAddress"/></td>
            <td>
            	<s:if test="%{#element.orderState<=2}">
            		<input type="button"  class="ARTBUTTON"  title="<s:property value="#element.deliverDate"/>" name="<s:property value="#element.purchaseOrderId"/>-<s:property value="#element.orderRate"/>" onclick="changeOrder(this);" value="修改订单"><br/>
            		<label>&nbsp;</label>
            	</s:if>
            	<!--<s:if test="%{#element.orderState==2}">
            		<input type="button"  class="ARTBUTTON" title="<s:property value="#element.deliverDate"/>" name="<s:property value="#element.purchaseOrderId"/>-<s:property value="#element.orderRate"/>-<s:property value="#element.fare"/>-<s:property value="#element.totalPrice"/>" onClick="changeOrder(this)" value="订单详情"><br/>
            		<label>&nbsp;</label>
            	</s:if>
            	--><s:if test="%{#element.orderState>=3&&#element.orderState<=6}">
            		<input type="button"  class="ARTBUTTON" title="<s:property value="#element.deliverDate"/>" name="<s:property value="#element.purchaseOrderId"/>-<s:property value="#element.orderRate"/>-<s:property value="#element.fare"/>-<s:property value="#element.totalPrice"/>" onClick="changeOrder(this)" value="订单详情"><br/>
            		<input type="button"  class="ARTBUTTON" onclick="displayRegister();" value="物流详情"></input>
            	</s:if>
            	<s:if test="%{#element.orderState>6}">
            		<input type="button"  class="ARTBUTTON" title="<s:property value="#element.deliverDate"/>" name="<s:property value="#element.purchaseOrderId"/>-<s:property value="#element.orderRate"/>-<s:property value="#element.fare"/>-<s:property value="#element.totalPrice"/>" onClick="changeOrder(this)" value="订单详情"><br/>
            		<input type="button"  class="ARTBUTTON" title="<s:property value="#element.deliverDate"/>" name="<s:property value="#element.purchaseOrderId"/>-<s:property value="#element.orderRate"/>-<s:property value="#element.fare"/>-<s:property value="#element.totalPrice"/>-<s:property value="#element.actualRefund"/>" onClick="changeOrder(this)" value="退货详情">
            	</s:if>
            </td>
            <td>
            	<s:if test="%{#element.orderState<=2}">
            		<input class="BUTTON" type="button" onclick="assure(this)" name="<s:property value="#element.purchaseOrderId"/>" value="确认发货"/>
            	</s:if>
            	<s:if test="%{#element.orderState==4}">
            		<span class="spanClass">等待到货确认</span>
            	</s:if>
            	<s:if test="%{#element.orderState==5}">
            		<span class="spanClass">等待支付货款</span>
            	</s:if>
            	<s:if test="%{#element.orderState==7}">
            		<input class="BUTTON" type="button" title="<s:property value="#element.deliverDate"/>" name="<s:property value="#element.purchaseOrderId"/>-<s:property value="#element.orderRate"/>-<s:property value="#element.fare"/>-<s:property value="#element.totalPrice"/>-<s:property value="#element.actualRefund"/>" onClick="changeOrder(this)" value="退货收货"/>
            	</s:if>
            	<s:if test="%{#element.orderState==8}">
            		<input class="BUTTON" type="button" title="<s:property value="#element.deliverDate"/>" name="<s:property value="#element.purchaseOrderId"/>-<s:property value="#element.orderRate"/>-<s:property value="#element.fare"/>-<s:property value="#element.totalPrice"/>-<s:property value="#element.actualRefund"/>" onClick="changeOrder(this)" value="支付退货款"/>
            	</s:if>
            	<s:if test="%{#element.orderState==9}">
            		<span class="spanClass">退货完成</span>
            	</s:if>
            </td>
        </tr>
        </s:iterator>
        <tr>
	       <td colspan="10" align="right">
	           <input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	           <span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	           <input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
	       </td>   
	       <td>&nbsp;&nbsp;</td>     
	   </tr>
    </table>
<form id="saveOrderForm" method="post">
  <table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr class="TITLE">
        <td id="processTD">
            <span id="contentSpan" class="FLOATLEFT">修改订单</span>
        </td>
      </tr>
      <tr>	
      	<td>
        	<span id="spanLeft1" class="FLOATLEFT">采购订单代码：<span id="orderNum"></span> &nbsp;&nbsp;交货日期：<span id="orderDate"></span></span>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <tr>
            <td>产品代码及名称</td>
            <td>度量单位</td>
            <td>价格（元）</td>
            <td>采购数量</td>
            <td id="returnNumber">退货数量</td>
            <td>合计（元）</td>
          </tr>
        </table></td>
      </tr>
      <tr>
      	<td align="center">
            <div class="ORDERCONTENT"><span id="productPrice"></span></div>
            <div id="fareDiv" class="ORDERCONTENT"><span>运费：<input id="fare" type="text" onkeyup="count()"/>（元）</span></div>
            <div id="allPriceDiv" class="ORDERCONTENT"><span>总货款：<input  id="allPrice" type="text" onkeyup="count2()"/>（元）</span></div>
            <div id="threeWhole">
            	<div id="one"></div>
            	<div class="ORDERCONTENT"><span id="ownOrderSpan"><label id="ownOrder" ></label> （元）</span></div>
                <div id="three">=总货款*定金比率</div>
            </div>
        </td>
      </tr>
       <tr>
          <td><input type="button" id="assuregetGoods" class="BIGREDBUTTON" onclick="assureGetGoods(this)" class="BUTTON" value="确认收到退货" /></td>
       </tr>
      <tr>
        <td align="center"><input type="button" id="save" onclick="saveInfo();" class="BIGBUTTON" value="保存" />
          <input type="button" class="BIGBUTTON" id="cancel" onclick="hideRegister()" value="取消" /></td>          
      </tr>
  </table>
</form >
  <table id="Info" class="CENTER" cellpadding="0" cellspacing="0">
      <tr class="TITLE">
        <td id="processTD">
            <span id="contentSpan" class="FLOATLEFT">订单详情</span>
        </td>
      </tr>
      <tr>	
      	<td>
        	<span id="spanLeft1" class="FLOATLEFT">采购订单代码：XXXXX &nbsp;&nbsp;交货日期：XXXXX</span>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <tr>
            <td>产品代码及名称</td>
            <td>度量单位</td>
            <td>价格（元）</td>
            <td>采购数量</td>
            <td>合计（元）</td>
          </tr>
        </table></td>
      </tr>
      <tr>
      	<td align="center" style="padding-bottom:5px;">
            <div class="ORDERCONTENT"><span>产品货款：</span></div>
            <div class="ORDERCONTENT"><span>运费：*****（元）</span></div>
            <div class="ORDERCONTENT"><span>总货款：********（元）</span></div>
            <div id="threeWhole">
            	<div id="one"></div>
            	<div class="ORDERCONTENT"></div>
                <div id="three">=总货款*定金比率<input type="hidden" id="orderRate" name="dd"></div>
            </div>
        </td>
      </tr>
  </table>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
