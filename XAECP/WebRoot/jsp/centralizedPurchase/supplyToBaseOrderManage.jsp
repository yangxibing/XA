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
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"> 
	    $().ready(function(){
	    	var orderState='<s:property value="baseOrder.orderState"/>';
			$("#orderState option").each(function(){
				if($(this).attr("value")==orderState){
					$(this).attr("selected",true);
				}
			});	
	    });
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
        	
			var a=new Array();
        	a=$(valu).attr("name").split("-");
        	var params={baseOrderId:a[0]};
        	var url="baseOrderProducts.action";
        	if($(valu).attr("value")=="修改订单"){
        		$.post(url,params,function(data){
        			display(data);
        			$("#deposit").attr("disabled",false);
        			$("#fare").attr("disabled",false);
        			$("#totalPrice").attr("disabled",false);
        			$("#addProduct tr").each(function(){
        				$(this).children("td").eq(2).children("input").eq(0).attr("disabled",false);
        			});
        			$("#save").show();
        		},'json');
        	}else if($(valu).attr("value")=="订单详情"){
        		$.post(url,params,function(data){
        			display(data);
        			$("#deposit").attr("disabled",true);
        			$("#fare").attr("disabled",true);
        			$("#totalPrice").attr("disabled",true);
        			$("#addProduct tr").each(function(){
        				$(this).children("td").eq(2).children("input").eq(0).attr("disabled",true);
        			});
        			$("#save").hide();
        		},'json');
        	}else{
        		$.post(url,params,function(data){
        			
        		},'json');
        	}
        } 
        
        function display(data){
        	$("#addProduct tr").each(function(){
        			$(this).remove();
        	});
        	var order=data.baseOrderX;
        			$("[id='baseOrderId']:eq(1)").text(order.baseOrderId);
        			$("#supplierName").text(order.supplierName);
        			$("[id='CPIId']:eq(1)").text(order.CPIId);
        			$("#PPIId").text(order.PPIId);
        			$("#deliverDate").text(order.deliverDate);
        			$("#deposit").attr("value",order.deposit);
        			$("#fare").attr("value",order.fare);
        			$("#totalPrice").attr("value",order.totalPrice);
        			var productPrice=0;
        			$.each(data.productList,function(i,value){
        				var str="<tr>"+
            						"<td><a href='#'>"+value.idName+"</a></td>"+
           							"<td>"+value.measureUnit+"</a></td>"+
           							"<td><input name='"+value.idName+"' type='text' onKeyUp='pricePress(this)' value='"+value.price.toFixed(2)+"'/>"+"</a></td>"+
            						"<td>"+value.number+"</a></td>"+
            					 	"<td>"+value.price*value.number+"</a></td>"+
          						"</tr>"
          				$("#addProduct").append(str);
          				productPrice=productPrice+value.price*value.number;
        			});
        			
        			$.each(data.supplierProducts,function(i,value){
        				if(i==0){
        					$("#measureUnit").text(value.measureUnit);
        					$("#price").text(value.basePrice.toFixed(2));
        				}
        				var str="<option value="+value.productId+"-"+value.productName+">"+value.productId+"-"+value.productName+"</option>";
        				$("#productIdName").append(str);
        				
        			});
        			
        			$("#productPrice").text("产品贷款 "+productPrice+"（元）");
        			displayRegister();
        }
        
        function productSelectChange(valu){
        	var url="selectProductByPId.action";
        	var params={productId:$(valu).attr("value").split("-")[0]};
        	$.post(url,params,function(data){
        		$("#measureUnit").text(data.supplierProduct.measureUnit);
				$("#price").text(data.supplierProduct.basePrice.toFixed(2));        	
        	});
        }
        
        function pricePress(valu){
        	var price=$(valu).attr("value");
        	var name=$(valu).attr("name");
        	$("#addProduct tr").each(function(){
        		var td=$(this).children("td");
        		if(td.eq(0).text()==name){
        			td.eq(4).text(price*td.eq(3).text());
        		}
        	});
        	
        }
        
        //function addProduct(){
        //	if($("#number").text()==null){
        //		alert("请输入采购数量");
        //	}
       // 	var productIdName=$("#productIdName").attr("value");
        //	var measureUnit=$("#measureUnit").text();
        //	var price=Number($("#price").text()).toFixed(2);
        //	var number=$("#number").attr("value");
        //	var allPrice=$("#allPrice").text();
        //	var flag=0;
        //	var productPrice=0;
        //	$("#addProduct tr").each(function(){
       // 		var td=$(this).children("td");
       // 		if(productIdName==td.eq(0).text()&&measureUnit==td.eq(1).text()&&price==td.eq(2).text()){
       // 			td.eq(3).text(Number(td.eq(3).text())+Number(number));
       // 			td.eq(4).text(Number(td.eq(4).text())+Number(allPrice));
       // 			flag=1;
       // 			
       // 		}
       // 	});
       // 	if(flag==0){
       // 		var str="<tr>"+
       //     						"<td><a href='#'>"+productIdName+"</a></td>"+
       //    							"<td>"+measureUnit+"</a></td>"+
      //     							"<td>"+price+"</a></td>"+
      //      						"<td>"+number+"</a></td>"+
     //       					 	"<td>"+allPrice+"</a></td>"+
      //    						"</tr>"
      //    		$("#addProduct").append(str);
      //    	}
          	
       //   	$("#number").attr("value","");
       //   	$("#allPrice").empty();
      ///   	$("#addProduct tr").each(function(){
      //    		productPrice=Number(productPrice)+Number($(this).children("td").eq(4).text());
      //    	});
     //     	$("#productPrice").text("产品货款 "+productPrice+"（元）");
     //     	
      //  }
        
        function saveProduct(){
        	var baseOrderIdV=$("[id='baseOrderId']:eq(1)").text();
        	var depositV=$("#deposit").attr("value");
        	var fareV=$("#fare").attr("value");
        	var totalPriceV=$("#totalPrice").attr("value");
        	var url="updateBaseOrderAndDetail.action";
        	var productStringV="";
       		$("#addProduct tr").each(function(){
       			
        		var td=$(this).children("td");
        		
        		productStringV=productStringV+td.eq(0).text()+","+td.eq(1).text()+","+td.eq(2).children("input").eq(0).attr("value")+","+td.eq(3).text()+","+td.eq(4).text()+"@";
        	});
        	if(productStringV==""){
        		alert("订单中没有任何产品");
        		return false;
        	}
        	var params={baseOrderId:baseOrderIdV,deposit:depositV,fare:fareV,totalPrice:totalPriceV,productString:productStringV};
        	$.post(url,params,function(data){
				$("#addProduct tr").each(function(){
        			$(this).remove();
        		});
        		hideRegister();
        	});
        }
        
        function assure(valu){
        	
        	var purOId=$(valu).attr("name");     	
        	$("#assureForm").attr("action","supplyAssureForm.action?baseOrderId="+purOId);
        	$("#assureForm").submit();
        }
        
        function getReturnGoods(valu){
        	var purOId=$(valu).attr("name");  
        	$("#assureForm").attr("action","getReturnGoodsForm.action?baseOrderId="+purOId);
        	$("#assureForm").submit();
        }
        function payReturnGoods(valu){
        	var purOId=$(valu).attr("name");  
        	$("#assureForm").attr("action","payReturnGoodsForm.action?baseOrderId="+purOId);
        	$("#assureForm").submit();
        }
        function returnGoodsDetail(valu){
        	var purOId=$(valu).attr("name");  
        	$("#assureForm").attr("action","returnGoodsDetailForm.action?baseOrderId="+purOId);
        	$("#assureForm").submit();
        }
        
         function listOrders(){
        	var orderStateV=$("#orderState").attr("value");
        	var CPIIdV=$("#CPIId").attr("value");
        	var baserOrderIdV=$("#baseOrderId").attr("value");	
        	$("#listOrdersForm").attr("action","listSupplierOrders.action?orderState="+orderStateV+"&&CPIId="+CPIIdV+"&&baseOrderId="+baserOrderIdV);
        	$("#listOrdersForm").submit();
        }
        
        //分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#listOrdersForm").attr("action", "listSupplierOrders.action?currentPage="+currentPage);
        	$("#listOrdersForm").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#listOrdersForm").attr("action", "listSupplierOrders.action?currentPage="+currentPage);
        	$("#listOrdersForm").submit();
		}
</script>
<style>
#supply #showlist{ font-size:12px;}
#processTD{text-align:left; height:40px;}
#processTD #contentSpan{width:250px; margin-left:20px; margin-top:10px; font-size:16px; font-weight:bold;}
#Info #processTD #contentSpan{width:250px; margin-left:20px; margin-top:5px; font-size:16px; font-weight:bold;}
#process{ margin-top:4px; margin-right:4px;}
#supply #register{ background-color:#F4EEEA;}
#supply #Info{ background-color:#F4EEEA;}
#supply #register #registCnt{border-color:#CCC; margin-top:10px;}
#supply #Info #registCnt{border-color:#CCC; margin-top:10px;}
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
</style>

</head>

<body>
<form id="assureForm" method="post"></form>
<div id="supply" class="CENTER">
<form id="listOrdersForm" method="post"></form>

<div id="top">
  <span style="color:#FFF;">
  <h2>订单管理-供应商</h2></span>
</div>
<form>
    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE">
        	<td><b>组合条件查询</b></td>
            <td colspan="6"></td>
        </tr>
        <tr>
        	<td class="BORDER" align="right">订单状态</td>
            <td class="BORDER">
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
            <td class="BORDER" align="right">集中采购信息代码</td>
            <td class="BORDER"><input id="CPIId" type="text" value="<s:property value="baseOrder.CPIId"/>"class="INPUTTEXT" name="CPIId" /></td>
            <td class="BORDER" align="right">订单代码</td>
            <td class="BORDER">
            	<input id="baseOrderId" type="text" value="<s:property value="baseOrder.baseOrderId"/>"class="INPUTTEXT"/>
            </td>
            <td align="right" class="BORDER">
            	<input type="button" onclick="listOrders()" class="BUTTON" value="查询" />
                <input type="reset" class="BUTTON" value="清空" />
            </td>
        </tr>
    </table>
</form>

    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="2px;">
    	
    	<tr class="TITLE" style="font-weight:bold;">
            <td>订单代码</td>
            <td>订单状态</td>
            <td>是否支付定金</td>
            <td>定金（元）</td>
            <td>运费（元）</td>
            <td>总货款（元）</td>
            <td>集中采购信息代码</td>
            <td>交货日期</td>
            <td colspan="2">&nbsp;</td>
        </tr>
        <s:iterator id="element" value="#request.baseOrders" >
        <tr class="HOVER">
            <td ><s:property value="#element.baseOrderId"/></td>
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
            <td><s:property value="#element.deliverDate"/></td>
            <td>
            	<s:if test="%{#element.orderState<=2}">
            		<input type="button"  class="ARTBUTTON"  name="<s:property value="#element.baseOrderId"/>" onclick="changeOrder(this);" value="修改订单"><br/>
            		<label>&nbsp;</label>
            	</s:if>
            	<s:if test="%{#element.orderState>=3&&#element.orderState<=6}">
            		<input type="button"  class="ARTBUTTON"  name="<s:property value="#element.baseOrderId"/>" onClick="changeOrder(this)" value="订单详情"><br/>
            		<input type="button"  class="ARTBUTTON" onclick="displayRegister();" value="物流详情"></input>
            	</s:if>
            	<s:if test="%{#element.orderState>6}">
            		<input type="button"  class="ARTBUTTON" title="<s:property value="#element.deliverDate"/>" name="<s:property value="#element.baseOrderId"/>-<s:property value="#element.orderRate"/>-<s:property value="#element.fare"/>-<s:property value="#element.totalPrice"/>" onClick="changeOrder(this)" value="订单详情"><br/>
            		<input type="button"  class="ARTBUTTON" title="<s:property value="#element.deliverDate"/>" name="<s:property value="#element.baseOrderId"/>" onClick="returnGoodsDetail(this)" value="退货详情">
            	</s:if>
            </td>
            <td>
            	<s:if test="%{#element.orderState<=2}">
            		<input class="BUTTON" type="button" onclick="assure(this)" name="<s:property value="#element.baseOrderId"/>" value="确认发货"/>
            	</s:if>
            	<s:if test="%{#element.orderState==4}">
            		<span  style="color:red" class="spanClass">等待到货确认</span>
            	</s:if>
            	<s:if test="%{#element.orderState==5}">
            		<span style="color:red"class="spanClass">等待支付货款</span>
            	</s:if>
            	<s:if test="%{#element.orderState==7}">
            		<input class="BUTTON" type="button" title="<s:property value="#element.deliverDate"/>" name="<s:property value="#element.baseOrderId"/>" onClick="getReturnGoods(this)" value="退货收获"/>
            	</s:if>
            	<s:if test="%{#element.orderState==8}">
            		<input class="BUTTON" type="button" title="<s:property value="#element.deliverDate"/>" name="<s:property value="#element.baseOrderId"/>" onClick="payReturnGoods(this)" value="支付退货款"/>
            	</s:if>
            	<s:if test="%{#element.orderState==9}">
            		<span style="color:red" class="spanClass">退货完成</span>
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
	   </tr>
    </table>
<form>
  <table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr class="TITLE">
        <td id="processTD">
            <span id="contentSpan" class="FLOATLEFT">修改订单</span>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <tr>
            <td  class="ALRIGHT">采购订单代码</td>
            <td id="baseOrderId" class="ALLEFT"></td>
            <td  class="ALRIGHT">供应商名称</td>
            <td id="supplierName" class="ALLEFT"></td>
          </tr>
          <tr>
            <td class="ALRIGHT">集中采购信息代码</td>
            <td id="CPIId" class="ALLEFT"></td>
            <td class="ALRIGHT">计划采购信息代码</td>
            <td id="PPIId" class="ALLEFT"></tr>
          <tr>
            <td class="ALRIGHT">交货日期</td>
            <td id="deliverDate" class="ALLEFT"></td>
            <td class="ALRIGHT">应支付定金</td>
            <td class="ALLEFT"><input  id="deposit" class="SMALLINPUT" type="text"/> （元）</td>
          </tr>
          <tr>
            <td class="ALRIGHT">运费</td>
            <td class="ALLEFT"><input  id="fare" class="SMALLINPUT" type="text"/> （元）</td>
            <td class="ALRIGHT">总货款</td>
            <td class="ALLEFT"><input  id="totalPrice" class="SMALLINPUT" type="text"/> （元）</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td id="borderTD"></td>
      </tr>
     <tr>
     	<td>
     	<table  id="registCnt" class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <thead>
          <tr>
            <td>产品代码及名称</td>
            <td>度量单位</td>
            <td>价格（元）</td>
            <td>采购数量</td>
            <td>合计（元）</td>
          </tr>
          </thead>
          <tbody id="addProduct">
          
          </tbody>
          <!--<tfoot>
          	<tr>
          		<td><select id="productIdName" onChange="productSelectChange(this);"></select></td>
            	<td id="measureUnit"></td>
            	<td id="price"></td>
            	<td><input onkeyUp="numberPress(this);" type="text" id="number"/></td>
            	<td id="allPrice"></td>
          	</tr>
          --></tfoot>
        </table></td>
     </tr>
     <!--<tr>
      	<td align="left"><input style="margin-left:25px;" onClick="addProduct();" type="button" class="BUTTON" value="增加产品" /></td>
      </tr>
      --><tr>
      	<td align="right">
            <div class="ORDERCONTENT" id="rightDown"><span id="productPrice"></span></div>
        </td>
      </tr>
      <tr>
      	<td align="right">
            <input type="button" id="save" onClick="saveProduct();" style="margin-right:25px; margin-bottom:5px;" class="BUTTON" value="保存" />
        </td>
      </tr>
  </table>
</form>
   <table id="Info" class="CENTER" cellpadding="0" cellspacing="0">
   </table>	
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
