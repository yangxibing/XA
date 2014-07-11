<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单管理-采购商</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>

<!-- 脚本区 -->
<script type="text/javascript"> 
		//渲染页面区：也面加载时将保留的参数置入页面，用以保留页面状态（页面提交时已将参数传至后台）
		window.onload = function(){
			$("#orderStateQuery option").each(function(){
            	if($(this).attr("value")=='<s:property value="purchaseOrder.orderState"/>'){
            		$(this).attr("selected", true);
            	}
            });
            $("#CPIIdQuery").attr("value", '<s:property value="purchaseOrder.CPIId"/>');
            $("#purchaseOrderIdQuery").attr("value", '<s:property value="purchaseOrder.purchaseOrderId"/>');
		}
        
        //全选按钮对应事件
        function allSelected(){
        	if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='purchaseOrderItem']").attr("checked",true);
        	}
        	else {
        		$("[name='purchaseOrderItem']").attr("checked",false);
        	}
        }
        
        //删除选中的采购订单条目：但注意只能删除处于未提交状态的订单
		function deletePurchaseOrder(valu){
			var f_str="";
        	var count=0;
        	var total=0;
			$("[name='purchaseOrderItem']").each(function(){
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
					if(confirm("只有未提交的订单可以删除，确实要删除其中未提交的订单吗？")){
						$.post("deletePurchaseOrder.action",{purchaseOrderList:f_str,async: false},function(data){
							$("#queryPurchaseOrderList").submit();
						});
					}
				}
				else if(count>0 && total == count){
					if(confirm("确实要删除所选的订单吗？")){
						$.post("deletePurchaseOrder.action",{purchaseOrderList:f_str,async: false},function(data){
							$("#queryPurchaseOrderList").submit();
						});
					}
				}
				else{
					alert("所选订单中，没有未提交的订单！");
				}
			} else {
				alert("未选中任何项！");
			}
		}
		
//***********************************************************************************************
//点击新建或者编辑后，但在保存前所做的动作
//***********************************************************************************************

//****************
//新建
//****************
		//点击新建或编辑按钮时的操作：取得新建基本信息或取得已有订单信息
		function displayRegister(valu) {
			clearAddUpdatePurchaseOrder(valu);
			if(($(valu).attr("value"))=="新建"){
				$("#addUpdatePurchaseOrder").attr("action","addPurchaseOrder.action");
		   		$.post($("#queryNewInfo").attr("action"),{async: false}, insertNewInfo, 'json');
			}else{
				$("#addUpdatePurchaseOrder").attr("action","updatePurchaseOrder.action");	
				var purchaseOrderIdValue=$(valu).attr("name");
				var url='queryEditInfo.action';
				var params={purchaseOrderId:purchaseOrderIdValue,async: false};
				$.post(url,params,insertEditInfo,'json');
			} 
        }
        
        
        //清空clearAddUpdatePurchaseOrder表单，为新建采购商订单做准备
        function clearAddUpdatePurchaseOrder(){
        	$("#productIdSelectEdit").attr("length", "0");
        	$("#priceEdit").attr("value", "");
        	$("#addressTableEdit>tr").remove();
        	$("#productTableEdit>tr").remove();
        	
        	$("#deliverDateEdit").attr("value", "");
        	$("#productPriceEdit").text("");
        	$("#fareEdit").attr("value", "");
        	$("#totalPriceEdit").text("");
        	$("#depositEdit").text("");
        }
        
        //插入获取的新建基本信息
        function insertNewInfo(data){
        	var datas=data.newInfo;
			var array=new Array();
			array=datas.split(";");
			var productInfo = array[0];
			var purchaserInfo = array[1];
			var addressInfo = array[2];
			insertProductInfo(productInfo);
			insertPurchaseInfo(purchaserInfo);
			insertAddressInfo(addressInfo);
			endNewProcess();
			hideInfo();
			var subMenu=document.getElementById("register");
		   	subMenu.style.display = "block";
        }
        
        //在新建、编辑时，插入所有产品到下拉框供用户“增加产品”时使用
        function insertProductInfo(productInfo){
        	var addList = productInfo.split(",");
        	var count = addList.length;
        	
			var optionInfo = "";
			for(var index = 0; index<count; index++){
				optionInfo += "<option value=\"" + addList[index] + "\">" + addList[index].split(" ")[0] + " " + addList[index].split(" ")[1] + "</option>";
			}
			$("#productIdSelectEdit option").remove();
			$("#productIdSelectEdit").append(optionInfo);	       	
        	
			var addSelect=document.getElementById("productIdSelectEdit");
     		var name = addSelect.options[addSelect.selectedIndex].value; 
     		$("#measureUnitEdit").text(name.split(" ")[2]);
     		$("#priceEdit").text(name.split(" ")[3]); 
     		$("#numberEdit").attr("value", "");
     		$("#productTotalEdit").text("");
			
        }
        
        //插入采购商的信息，即插入定金到隐藏控件
        function insertPurchaseInfo(purchaserInfo){
        	$("#orderRateHidden").attr("value", purchaserInfo.split(",")[0]);
        }
        
        //在新建、编辑时，插入当前用户的所有收货地址信息，供用户选择
        function insertAddressInfo(addressInfo){
        	if(addressInfo==""){return;}
        	var tbody = $("#addressTableEdit");
        	var addressList = addressInfo.split(",");
        	var num = addressList.length;
        	var tableStr = "";
        	var defaultAddressId = "";
        	 //为表格循环插入行
			 for (var i = 0 ; i < num ; i++)
			 {
			 	tableStr += "<tr>"
			 		+ "<td><input type=\"radio\" name=\"addressRadioEdit\" id=\"addressEdit\" value=\"" + addressList[i].split(" ")[0];
			 	if (addressList[i].split(" ")[5] == "1"){
			 		tableStr += "\" checked=\"true\" /></td>";
			 	} else {
			 		tableStr += "\" /></td>";
			 	}
			 	tableStr += "<td>" + addressList[i].split(" ")[1] + "</td>"
			 		+ "<td>" + addressList[i].split(" ")[2] + "</td>"
			 		+ "<td>" + addressList[i].split(" ")[3] + "</td>"
			 		+ "<td>" + addressList[i].split(" ")[4] + "</td>";
			 	if(addressList[i].split(" ")[5] == "0"){
			 		tableStr += "<td><input type=\"button\" id=\"setDefaultAddressEdit\" onclick=\"setDefaultAddress(this)\" value=\"设为默认收货地址\"  class=\"BUTTON\" name=\"" + addressList[i].split(" ")[0] + "\" /></td>";
			 	} else {
			 		tableStr += "<td><input type=\"button\" id=\"setDefaultAddressEdit\" onclick=\"setDefaultAddress(this)\" value=\"设为默认收货地址\"  class=\"BUTTON\" name=\"" + addressList[i].split(" ")[0] + "\" /></td>";
			 		defaultAddressId = addressList[i].split(" ")[0];
			 	}
			 	tableStr += "</tr>";
			}
			tbody.append(tableStr);
			
			$("input[id='setDefaultAddressEdit']").each(function(){
				if($(this).attr("name")==defaultAddressId){
					$(this).hide();
				}
			});	  
        }
        
        function endNewProcess(){
        	$("#purchaseOrderIdEdit").text("自动编码生成");
        }
 
//****************
//编辑
//****************
		//编辑时取得后台数据后插入页面中
		function insertEditInfo(data){
			var datas=data.editInfo;
			var array=new Array();
			array=datas.split(";");
			var productInfo = array[0];
			var purchaserInfo = array[1];
			var addressInfo = array[2];
			var purchaseOrderInfo = array[3];
			var purchaseOrderDetailInfo = array[4];
			
			insertProductInfo(productInfo);
			insertPurchaseInfo(purchaserInfo);
			insertAddressInfo(addressInfo);
			insertPurchaseOrderInfo(purchaseOrderInfo);
			insertPurchaseOrderDetailEdit(purchaseOrderDetailInfo);
			priceChanged();
			endEitProcess();
			hideInfo();
			var subMenu=document.getElementById("register");
		   	subMenu.style.display = "block";
		}
		
		//插入订单信息，包括交货日期、运费、总货款、地址代码
		function insertPurchaseOrderInfo(purchaseOrderInfo){
			$("#currentPurchaseOrderIdHidden").attr("value", purchaseOrderInfo.split(" ")[0]);
			$("#deliverDateEdit").attr("value", purchaseOrderInfo.split(" ")[1]);
        	$("#fareEdit").attr("value", purchaseOrderInfo.split(" ")[2]);
        	$("input[name='addressRadioEdit']").each(function(){
  				 if($(this).attr("value")==purchaseOrderInfo.split(" ")[4]){
   					 $(this).attr("checked", "true");
  				 }
			});
		}
		
		//插入订单中的产品到页面中，包括产品代码、度量单位、数量、价格
		function insertPurchaseOrderDetailEdit(purchaseOrderDetailInfo){
			if(purchaseOrderDetailInfo == ""){return;}
			var tbody = $("#productTableEdit");
			var tableStr = "";
			var details = purchaseOrderDetailInfo.split(",");
			var length = details.length;
			for(var index=0; index<length; index++){
				tableStr += "<tr id=\"originalProduct\">"
						+ "<td>" + details[index].split(" ")[0] + " " + details[index].split(" ")[1] + "</td>"
						+ "<td>" + details[index].split(" ")[2] + "</td>"
						+ "<td>" + details[index].split(" ")[3] + "</td>"
						+ "<td>" + details[index].split(" ")[4] + "</td>"
						+ "<td>" + details[index].split(" ")[3]*details[index].split(" ")[4] + "</td>"
						+ "</tr>";
			}
			tbody.append(tableStr);
		}
		
		//做一些插入工作之外琐碎的工作
		function endEitProcess(){
			$("#purchaseOrderIdEdit").text($("#currentPurchaseOrderIdHidden").attr("value"));
		}
		       
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }

//***********************************************************************************************
//订单详情页面：当点击订单详情按钮时把数据传回后台，并回显
//***********************************************************************************************
		function displayInfo(valu) {
			var purchaseOrderIdValue=$(valu).attr("name");
			var url='queryDetailInfo.action';
			var params={purchaseOrderId:purchaseOrderIdValue,async: false};
			$.post(url,params,insertDetailInfo,'json');
			$("#purchaseOrderIdInfo").text(purchaseOrderIdValue);
			
			hideRegister();    
            var subMenu=document.getElementById("Info");
            subMenu.style.display = "block";
        }
        
 		//把取回的数据插入详情表
 		function insertDetailInfo(data){
 			var datas=data.detailInfo;
			var array=new Array();
			array=datas.split(";");
			var purchaserInfo = array[0];
			var purchaseOrderInfo = array[1];
			var purchaseOrderDetailInfo = array[2];
			var goodsAddressInfo = array[3];
			
			clearDetailInfo();
			insertPurchaseDetail(purchaserInfo);
			insertAddressDetail(goodsAddressInfo);
			insertPurchaseOrderDetail(purchaseOrderInfo);
			insertPurchaseOrderDetailInfo(purchaseOrderDetailInfo);
 		}
 		
 		//清楚详情表中的一些数据
 		function clearDetailInfo(){
 			$("#productTableInfo>tr").remove();
 		}
 		
 		//插入采购商详情
 		function insertPurchaseDetail(purchaserInfo){
 			$("#orderRateHidden").attr("value", purchaserInfo.split(",")[0]);
 		}
 		
 		function insertAddressDetail(goodsAddressInfo){
 			var str = goodsAddressInfo.split(" ")[0]+"，"+goodsAddressInfo.split(" ")[1]+"，"+goodsAddressInfo.split(" ")[2]+"，"+goodsAddressInfo.split(" ")[3];
 			$("#receiveAddressInfo").text(str);
 		}
 		
 		function insertPurchaseOrderDetail(purchaseOrderInfo){
 			$("#deliverDateInfo").text(purchaseOrderInfo.split(" ")[1]);
 			$("#fareInfo").text(purchaseOrderInfo.split(" ")[2]);
 			$("#totalPriceInfo").text(purchaseOrderInfo.split(" ")[3]);
 			$("#goodsPriceInfo").text($("#totalPriceInfo").text()*1.0-$("#fareInfo").text());
 			$("#depositInfo").text(($("#totalPriceInfo").text()*$("#orderRateHidden").attr("value")).toFixed(2));
 		}
 		
 		function insertPurchaseOrderDetailInfo(purchaseOrderDetailInfo){
 			if(purchaseOrderDetailInfo == ""){return;}
 			var tbody = $("#productTableInfo");
			var tableStr = "";
			var details = purchaseOrderDetailInfo.split(",");
			var length = details.length;
			for(var index=0; index<length; index++){
				tableStr += "<tr id=\"productTrInfo\">"
						+ "<td>" + details[index].split(" ")[0] + " " + details[index].split(" ")[1] + "</td>"
						+ "<td>" + details[index].split(" ")[2] + "</td>"
						+ "<td>" + details[index].split(" ")[3] + "</td>"
						+ "<td>" + details[index].split(" ")[4] + "</td>"
						+ "<td>" + details[index].split(" ")[3]*details[index].split(" ")[4] + "</td>"
						+ "</tr>";
			}
			tbody.append(tableStr);
 		}
 		
		function hideInfo() {    
            var subMenu=document.getElementById("Info");
            subMenu.style.display = "none";
        }
        
//***********************************************************************************************
//保存产品时提取页面数据并提交到后台
//***********************************************************************************************

		function savePurchaseOrder(valu){
        	var url=$("#addUpdatePurchaseOrder").attr("action");
        	
        	//从页面中获取订单信息用于提交
        	var purchaseOrderIdValue = $("#currentPurchaseOrderIdHidden").attr("value");
        	var orderStateValue = "1";
        	if($(valu).attr("value") == "保存"){
        		orderStateValue = "0";
        	}

        	var deliverDateValue = $("#deliverDateEdit").attr("value");
        	var receiveAddressIdValue = "";
        	$("input[name='addressRadioEdit']").each(function(){
				if($(this).attr("checked")==true){
					receiveAddressIdValue = $(this).attr("value");
				}
			});
			var fareValue = $("#fareEdit").attr("value");
			var totalPriceValue = $("#totalPriceEdit").text();
			
			//从页面中获取订单中所有新增的产品用于提交
			var purchaseOrderDetailListValue = "";
			$("tr[id='newAddProduct']").each(function(){
				purchaseOrderDetailListValue += this.cells[0].innerText + " " 
						+ this.cells[1].innerText + " " + this.cells[2].innerText + " "
						+ this.cells[3].innerText + ",";
 			});

 			var purchaseOrderDetailOriginalListValue = "";
			$("tr[id='originalProduct']").each(function(){
				purchaseOrderDetailOriginalListValue += this.cells[0].innerText + " " 
						+ this.cells[1].innerText + " " + this.cells[2].innerText + " "
						+ this.cells[3].innerText + ",";
 			});

			var params={purchaseOrderId:purchaseOrderIdValue,
					orderState:orderStateValue,
					deliverDate:deliverDateValue,
					receiveAddressId:receiveAddressIdValue,
					fare:fareValue,
					totalPrice:totalPriceValue,
					purchaseOrderDetailList:purchaseOrderDetailListValue,
					purchaseOrderDetailOriginalList:purchaseOrderDetailOriginalListValue,
					async: false};
			$.post(url,params,function(data){
				$("#queryPurchaseOrderList").submit();
			});		
		}
        
//***********************************************************************************************
//增加产品时改变产品参数时的响应事件
//***********************************************************************************************
        
        //产品数量发生变化时，更新界面中合计、产品货款、总货款、应支付定金
        function priceChanged(valu){
        	var totalPrice = 0.0;
            var goodsTotalPrice = 0.0;
            
            var productTotalPrice = $("#priceEdit").text()*$("#numberEdit").attr("value");
            $("#productTotalEdit").text(productTotalPrice);
            goodsTotalPrice += productTotalPrice;
            
            var submitTotalPrice = 0.0;
        	var tbody = document.getElementById("productTableEdit");
        	var num = tbody.rows.length;
        	for(var index=0; index<num; index++){
        		submitTotalPrice += tbody.rows[index].cells[2].innerText*tbody.rows[index].cells[3].innerText;
        	}
        	goodsTotalPrice += submitTotalPrice*1.0;
        	$("#productPriceEdit").text(goodsTotalPrice);
        	
        	totalPrice += $("#fareEdit").attr("value")*1.0;
        	totalPrice += goodsTotalPrice;
        	
        	$("#totalPriceEdit").text(totalPrice);
        	$("#depositEdit").text($("#totalPriceEdit").text()*$("#orderRateHidden").attr("value"));
        } 
        
     	function productSelectChange(select){
     		var name = select.options[select.selectedIndex].value; 
     		$("#measureUnitEdit").text(name.split(" ")[2]);
     		$("#priceEdit").text(name.split(" ")[3]); 
     		$("#numberEdit").attr("value", "");
     		$("#productTotalEdit").text("");
     	}
     	
     	function addProductEdit(valu){
     		if($("#numberEdit").attr("value")!="" && $("#numberEdit").attr("value") > 0){
				var tbody = $("#productTableEdit");
				
				var select = document.getElementById("productIdSelectEdit");
				var name = select.options[select.selectedIndex].value.split(" ");
				var number = $("#numberEdit").attr("value");
				var itemTotalPrice = $("#productTotalEdit").text();
				var appendStr = "";
					appendStr += "<tr id=\"newAddProduct\">"
							+ "<td>" + name[0] + " " + name[1] + "</td>"
							+ "<td>" + name[2] + "</td>"
							+ "<td>" + name[3] + "</td>"
							+ "<td>" + number + "</td>"
							+ "<td>" + itemTotalPrice + "</td>"
							+ "</tr>";
				tbody.append(appendStr);
				
				$("#productIdSelectEdit").attr("selectedIndex", "0");
				name = select.options["0"].value.split(" ");
				$("#measureUnitEdit").text(name[2]);
				$("#priceEdit").text(name[3])
				$("#numberEdit").attr("value", ""); 
				$("#productTotalEdit").text("");
				
				priceChanged(valu);			
     		}
     		else {
     			alert("采购数量不可以为空或负值！");
     			$("#numberEdit").attr("value", "");
     			$("#productTotalEdit").text("");
     		}
     	} 
     	
     	function checkNumber(valu){
     		if(checkNumberValue(checkNumberValue)==false)
     			return false;
     		else if($(valu).attr("value")!= "" && $(valu).attr("value") <= 0) {
     			alert("采购数量不可以为负值！");
     			$(valu).attr("value", "");
     			$("#productTotalEdit").text("");
     		} else if($(valu).attr("value")!= "" && $(valu).attr("value") > 0) {
     			$("#productTotalEdit").text($("#numberEdit").attr("value")*$("#priceEdit").text());
     		} else {
     			$("#productTotalEdit").text("");
     		}
     	} 
     	
     	//收货人收货地址管理
     	function setDefaultAddress(valu){
     		var defaultAddressIdValue = $(valu).attr("name");
     		var params={addressId:defaultAddressIdValue};
     		var url = $("#setDefaultAddress").attr("action");
     		$.post(url, params, function(data){
     			$("input[id='setDefaultAddressEdit']").each(function(){
     				if($(this).attr("name") != defaultAddressIdValue){
     					$(this).show();
     				} else {
     					$(this).hide();
     				}
     			});
     		});
     	}
     	
//***********************************************************************************************
//订单查询列表右侧第三栏相关按钮响应事件
//***********************************************************************************************     	

		//取消事件
		function cancelPurchaseOrder(valu){
			var purchaseOrderIdValue = $(valu).attr("name");
			var url = $("#cancelPurchaseOrder").attr("action");
			var params = {purchaseOrderId:purchaseOrderIdValue,async: false};
			
			$.post(url,params,function(data){
				$("#queryPurchaseOrderList").submit();
			});	
		}
     
     	//物流详情
     	function logisticsInformation(valu){
     		var purchaseOrderIdValue = $(valu).attr("name");
     		$("#logisticsPurchaseOrderId").attr("value", purchaseOrderIdValue);
     		$("#logisticsInformation").submit();
     	}
     	
     	//管理物流地址
     	function goodsAddressManage(){
     		$("#goodsAddressManage").submit();
     	}
     	
     	//退货
     	function purchaseRejectedMag(valu){
     		var purchaseOrderIdValue = $(valu).attr("name");
     		$("#rejectedPurchaseOrderId").attr("value", purchaseOrderIdValue);
     		$("#purchaseRejectedMag").submit();
     	}
     	
     	//退货详情
     	function purchaseRejectedInfo(valu){
      		var purchaseOrderIdValue = $(valu).attr("name");
     		$("#rejectedPurchaseOrderIdInfo").attr("value", purchaseOrderIdValue);
     		$("#purchaseRejectedInfo").submit();    		
     	}
     	
     	//评价
     	function evaluateForProduct(valu){
     		var purchaseOrderIdValue = $(valu).attr("name");
     		$("#evaluateForProductHidden").attr("value", purchaseOrderIdValue);
     		$("#evaluateForProduct").submit();
     	}
     	
//***********************************************************************************************
//订单查询列表右侧第一、二栏相关按钮响应事件
//***********************************************************************************************    
		//支付定金
		function payForDeposit(valu){
			var purchaseOrderIdValue = $(valu).attr("name");
			$("#payForDepositHidden").attr("value", purchaseOrderIdValue);
			$("#payForDeposit").submit();
		}
		
		//确认到货
		function comfirmReceiveGoods(valu){
			var purchaseOrderIdValue = $(valu).attr("name");
			$("#confirmReceiveGoodsHidden").attr("value", purchaseOrderIdValue);
			$("#comfirmReceiveGoods").submit();
		}
		
		//支付货款
		function payForGoods(valu){
			var purchaseOrderIdValue = $(valu).attr("name");
			$("#payForGoodsHidden").attr("value", purchaseOrderIdValue);
			$("#payForGoods").submit();
		}
		
		//分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#queryPurchaseOrderList").attr("action", "queryPurchaseOrderList.action?currentPage="+currentPage);
        	$("#queryPurchaseOrderList").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#queryPurchaseOrderList").attr("action", "queryPurchaseOrderList.action?currentPage="+currentPage);
        	$("#queryPurchaseOrderList").submit();
		}
</script>

<!-- 页面显示控制区 -->
<style>
	#supply #showlist{ font-size:12px;}
	#supply #showlist .stage{ width:65px;}
	#supply #showlist .addressTD{ width:180px;}
	#processTD{text-align:left;}
	#processTD #contentSpan{width:250px;margin-top:10px; margin-left:3px; font-size:16px; font-weight:bold;}
	#process{ margin-top:4px; margin-right:4px;}
	#supply #register{ background-color:#F4EEEA;}
	
	#supply #register #registCnt{ text-align:center; margin-top:0; margin-bottom:0;}
	#supply #register #spanLeft1{margin-left:25px; margin-top:2px; margin-bottom:2px;}
	#supply #register #spanRight1{margin-right:25px; margin-top:2px; margin-bottom:2px;}
	#supply #Info #registCnt{ text-align:center; margin-top:0; margin-bottom:0;}
	#supply #Info #spanLeft1{margin-left:25px; margin-top:2px; margin-bottom:2px;}
	#supply #Info #spanRight1{margin-right:25px; margin-top:2px; margin-bottom:2px;}
	.TOPPX{ padding-top:10PX;}
	.ORDERCONTENT{ font-size:18px; font-weight:bold; width:300px; height:40px; background-color:#4468E3; color:#fff; border:2px solid #AAA; vertical-align:middle; margin-top:5px;}
	#threeWhole{ width:606px; height:44px;}
	#threeWhole #one{ float:left; width:150px; height:44px;}
	#threeWhole .ORDERCONTENT{ float:left;}
	#threeWhole #three{ float:left; margin-left:5px; width:130px; height:15px; font-size:12px; margin-top:30px; background-color:#C9D1E9; border:1px solid #BBB;}
</style>

</head>

<body>
<div id="supply" class="CENTER">
<div id="top">
  <span><h2>订单管理-采购商</h2></span>
</div>

<!-- 辅助区说明区：用于添加辅助的，带有提示作用的控件 -->
<form id="queryNewInfo" action="queryNewInfo.action"></form>
<form id="queryEditInfo" action="queryEditInfo.action"></form>
<form id="queryDetailInfo" action="queryDetailInfo.action"></form>
<form id="setDefaultAddress" action="setDefaultAddress.action"></form>
<form id="cancelPurchaseOrder" action="cancelPurchaseOrder.action"></form>
<form id="comfirmReceiveGoods" action="comfirmReceiveGoods.action">
	<input type="hidden" name="purchaseOrderId" id="confirmReceiveGoodsHidden" value="" />
</form>
<form id="payForDeposit" action="payForDeposit.action">
	<input type="hidden" name="purchaseOrderId" id="payForDepositHidden" value="" />
</form>
<form id="payForGoods" action="payForGoods.action">
	<input type="hidden" name="purchaseOrderId" id="payForGoodsHidden" value="" />
</form>
<form id="evaluateForProduct" action="evaluateForProduct.action">
	<input type="hidden" name="purchaseOrderId" id="evaluateForProductHidden"/>
</form>
<form id="purchaseRejectedMag" action="purchaseRejectedMag.action" >
	<input type="hidden" name="purchaseOrderId" id="rejectedPurchaseOrderId" value="" />
</form>
<form id="purchaseRejectedInfo" action="purchaseRejectedInfo.action" >
	<input type="hidden" name="purchaseOrderId" id="rejectedPurchaseOrderIdInfo" value="" />
</form>
<form id="logisticsInformation" action="logisticsInformation.action">
	<input type="hidden" name="purchaseOrderId" id="logisticsPurchaseOrderId" value="" />
</form>
<form id="goodsAddressManage" action="goodsAddressManage.action">
	<input type="hidden" name="sendOrReceive" id="sendOrReceiveHidden" value="false"/>
</form>
<input type="hidden" id="orderRateHidden" value="" />
<input type="hidden" id="currentPurchaseOrderIdHidden" value="" />

<!-- 查询模块：根据输入参数查询采购商订单 -->
<form id="queryPurchaseOrderList" action="queryPurchaseOrderList.action" method="post">
    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE">
        	<td><span class="TITLESPAN1">组合条件查询</span></td>
            <td colspan="6"></td>
        </tr>
        <tr>
        	<td  align="right">订单状态</td>
            <td>
            	<select name="orderState" id="orderStateQuery">
                	<option value="-1">--请选择--</option>
                	<option value="0">未提交</option>
                	<option value="1">订单提交未支付定金</option>
                	<option value="2">订单提交已支付定金</option>
                	<option value="3">取消</option>
                	<option value="4">已经确认发货</option>
                	<option value="5">已经确认到货未支付货款</option>
                	<option value="6">交易完成</option>
                	<option value="7">申请退货</option>
                	<option value="8">退货收货</option>
                	<option value="9">退货成功</option>
                </select>
            </td>
            <td  align="right">集中采购信息代码</td>
            <td ><input type="text" class="INPUTTEXT" name="CPIId" id="CPIIdQuery" /></td>
            <td  align="right">订单代码</td>
            <td ><input type="text" class="INPUTTEXT" name="purchaseOrderId" id="purchaseOrderIdQuery" /></td>
            <td align="right" >
            	<input type="submit" class="BUTTON" value="查询" />
            </td>
        </tr>
    </table>
</form>

    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="2px;">
    	<tr class="TITLE">
        	<td>选择</td>
            <td>订单代码</td>
            <td>订单状态</td>
            <td>定金（元）</td>
            <td>运费（元）</td>
            <td>总货款（元）</td>
            <td>集中采购信息代码</td>
            <td>收货地址</td>
            <td colspan="3">&nbsp;</td>
        </tr>        
		    <s:iterator id="element" value="#request.query">
	        	<tr class="HOVER">
	        		<td ><input name="purchaseOrderItem" type="checkbox" value="<s:property value="#element.purchaseOrderId"/>" id="<s:property value="#element.orderState"/>"/></td>
	          	    <td><s:property value="#element.purchaseOrderId"/></td>  
	          	    <td class="stage">
	          	    	<s:if test="%{#element.orderState==0}">未提交</s:if>
	          	    	<s:elseif test="%{#element.orderState==1}">订单提交未支付定金</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==2}">订单提交已支付定金</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==3}">取消</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==4}">已经确认发货</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==5}">已经确认到货未支付货款</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==6}">交易完成</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==7}">申请退货</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==8}">退货收货</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==9}">退货成功</s:elseif>
	          	    	<s:else>未提交</s:else>
	          	    </td>	    
	          	    <td ><s:property value="#element.deposit"/></td>
	           	    <td ><s:property value="#element.fare"/></td>
	           	    <td ><s:property value="#element.totalPrice"/></td>
	           	    <td ><s:property value="#element.CPIId"/></td>
					<td class="addressTD"><s:property value="#element.receiveAddress"/></td>
					<!-- 倒数第三列：信息详情栏 -->
	            	<td>
	          	    	<s:if test="%{#element.orderState==0}"><!-- 未提交 -->
	          	    		<s:if test="%{#element.CPIId==null || #element.CPIId==''}">
								<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="displayRegister(this)" value="编辑" class="ARTBUTTON"/>
	          	    		</s:if>
						</s:if>
	          	    	<s:elseif test="%{#element.orderState==1}"><!-- 订单提交未支付定金 -->
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="displayInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<s:if test="%{#element.CPIId==null || #element.CPIId==''}">
	          	    			<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="cancelPurchaseOrder(this)" value="取消" class="ARTBUTTON"/>
	          	    		</s:if>
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==2}"><!-- 订单提交已支付定金 -->
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="displayInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<s:if test="%{#element.CPIId==null || #element.CPIId==''}">
	          	    			<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="cancelPurchaseOrder(this)" value="取消" class="ARTBUTTON"/>		
	          	    		</s:if>
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==3}"><!-- 取消 -->
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="displayInfo(this)" value="订单详情" class="ARTBUTTON"/>
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==4}"><!-- 已经确认发货 -->
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="displayInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="logisticsInformation(this)" value="物流详情" class="ARTBUTTON"/>	          	    	
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==5}"><!-- 已经确认到货未支付货款 -->
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="displayInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="logisticsInformation(this)" value="物流详情" class="ARTBUTTON"/>	          	    		          	    	
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==6}"><!-- 交易完成 -->
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="displayInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="logisticsInformation(this)" value="物流详情" class="ARTBUTTON"/><br />	          	    	
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="purchaseRejectedMag(this)" value="退货" class="ARTBUTTON"/><br />
	          	    		<s:if test="%{#element.evaluateNumber!=null}">
	  	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="evaluateForProduct(this)" value="评价" class="ARTBUTTON"/>	          	    		          	    	        	    			
	          	    		</s:if>
	          	    		<s:else>
	          	    			已经评价
	          	    		</s:else>
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==7}"><!-- 申请退货 -->
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="displayInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="purchaseRejectedInfo(this)" value="退货详情" class="ARTBUTTON"/><br />
	          	    		<s:if test="%{#element.evaluateNumber!=null}">
	  	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="evaluateForProduct(this)" value="评价" class="ARTBUTTON"/>	          	    		          	    	        	    			
	          	    		</s:if>
	          	    		<s:else>
	          	    			已经评价
	          	    		</s:else>  	          	    		
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==8}"><!-- 退货收货 -->
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="displayInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="purchaseRejectedInfo(this)" value="退货详情" class="ARTBUTTON"/><br />
	          	    		<s:if test="%{#element.evaluateNumber!=null}">
	  	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="evaluateForProduct(this)" value="评价" class="ARTBUTTON"/>	          	    		          	    	        	    			
	          	    		</s:if>
	          	    		<s:else>
	          	    			已经评价
	          	    		</s:else>	          	    			          	    	
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==9}"><!-- 退货成功 -->
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="displayInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="purchaseRejectedInfo(this)" value="退货详情" class="ARTBUTTON"/><br />
	          	    		<s:if test="%{#element.evaluateNumber!=null}">
	  	          	    		<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="evaluateForProduct(this)" value="评价" class="ARTBUTTON"/>	          	    		          	    	        	    			
	          	    		</s:if>
	          	    		<s:else>
	          	    			已经评价
	          	    		</s:else>          	    			          	    		          	    	
	          	    	</s:elseif>
	          	    	<s:else><!-- 其他默认未提交 -->
							<input type="button" name="<s:property value="#element.purchaseOrderId"/>" onclick="displayRegister(this)" value="编辑" class="ARTBUTTON"/>	          	    	
	          	    	</s:else>
	            	</td>
	            	
	            	<!-- 倒数第二列：定金状态栏 -->
	            	<td>
	            		<s:if test="%{#element.orderState==1}"><!-- 订单提交未支付定金 -->
	            			<input type="button" class="BUTTON" onclick="payForDeposit(this)" name="<s:property value="#element.purchaseOrderId"/>" value="支付定金" />
	            		</s:if>
	          	    	<s:elseif test="%{#element.orderState==2}"><!-- 订单提交已支付定金 -->
	          	    		已经支付定金
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==3}"><!-- 取消 -->
	          	    		<s:if test="%{#element.deposit==0.0}">未支付定金</s:if>
	          	    		<s:else>已经支付定金</s:else>
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==4}"><!-- 已经确认发货 -->
	          	    		<s:if test="%{#element.deposit==0.0}">未支付定金</s:if>
	          	    		<s:else>已经支付定金</s:else>
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==5}"><!-- 已经确认到货未支付货款 -->
	          	    		<s:if test="%{#element.deposit==0.0}">未支付定金</s:if>
	          	    		<s:else>已经支付定金</s:else>	          	    	
	          	    	</s:elseif>
	            	</td>
	            	
	            	<!-- 最后一列：货物、货款状态栏 -->
	            	<td>
	            		<s:if test="%{#element.orderState==0}"></s:if>
	          	    	<s:elseif test="%{#element.orderState==1}">等待发货</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==2}">等待发货</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==3}"></s:elseif>
	          	    	<s:elseif test="%{#element.orderState==4}">确认发货<br />
	          	    		<input type="button" class="BUTTON" onclick="comfirmReceiveGoods(this)" name="<s:property value="#element.purchaseOrderId"/>" value="确认到货" />
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==5}">已经确认到货<br />
	          	    		<input type="button" class="BUTTON" onclick="payForGoods(this)" name="<s:property value="#element.purchaseOrderId"/>" value="支付货款" />
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==6}">交易完成</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==7}">等待退货</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==8}">等待退款</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==9}">已经退款</s:elseif>
	          	    	<s:else></s:else>
	            	</td>
	        	</tr>
	        </s:iterator>        
        <tr>
        	<td><input type="checkbox" name="allSelectBox" onclick="allSelected()" />全选</td>
            <td><input type="button" class="BUTTON" onclick="deletePurchaseOrder(this)" value="删除" /></td>
            <td><input type="button" class="BUTTON" onclick="displayRegister(this)" value="新建" /></td>
            <td colspan="8" class="UPBOD" align="right">
                <input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
                <span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
                <input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />
            </td>
        </tr>
    </table>
    
    
<form id="addUpdatePurchaseOrder" action="" >
	<div class="EMPTYDIV"></div>
  	<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr class="TITLE">
        <td id="processTD">
            <span id="contentSpan" class="FLOATLEFT">采购订单</span>
             <div id="process" class="FLOATRIGHT">
                <div class="ARTLEFTDIV"><span>交易仅需五步</span></div>
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
      	<td class="TOPPX">
        	<span id="spanLeft1" class="FLOATLEFT">采购订单代码：<label id="purchaseOrderIdEdit">自动编号生成</label></span>
            <span id="spanRight1" class="FLOATRIGHT"><a class="ARTA" href="../baseInformation/quotationInformation.action">价格行情</a></span>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0" align="center">
	         <thead>
		          <tr>
			            <td>产品代码及名称</td>
			            <td>度量单位</td>
			            <td>价格（元）</td>
			            <td>采购数量</td>
			            <td>合计（元）</td>
		          </tr>
	          </thead>
	          <tbody id="productTableEdit">
          			<!-- 存放已添加产品列表 -->
	          </tbody>
	          <tfoot>
	          	  <tr>
		            <td>
		            	<select name="productId" id="productIdSelectEdit" onchange="productSelectChange(this)">
		            		<!-- <option></option> -->
		                </select>
		            </td>
		            <td id="measureUnitEdit"></td>
		            <td id="priceEdit"></td>
		            <td><input type="text" name="number"  id="numberEdit" onkeyup="checkNumber(this)" style="width:70px;" class="SHORTINPUT" /></td>
		            <td id="productTotalEdit"></td>
	             </tr>
	          </tfoot>
        </table>
        </td>
      </tr>
      <tr>
      	<td align="left"><input type="button" class="BUTTON" onclick="addProductEdit(this)" value="增加产品"  style="margin-left:25px;"/></td>
      </tr>
      <tr>
      	<td align="center">
        	<div class="ORDERCONTENT"><span>交货日期：<input type="text" name="deliverDate" id="deliverDateEdit" onclick="WdatePicker();" /></span></div>
            <div class="ORDERCONTENT"><span>产品货款：<label id="productPriceEdit"></label>（元）</span></div>
            <div class="ORDERCONTENT"><span>运费：<input type="text" name="fare" id="fareEdit" onkeyup="priceChanged(this)" />（元）</span></div>
            <div class="ORDERCONTENT"><span>总货款：<label id="totalPriceEdit"></label>（元）</span></div>
            <div id="threeWhole">
            	<div id="one"></div>
            	<div class="ORDERCONTENT"><span>应支付定金：<label id="depositEdit"></label>（元）</span></div>
                <div id="three">=总货款*定金比率</div>
            </div>
        </td>
      </tr>
      <tr>	
      	<td>
        	<span id="spanLeft1" class="FLOATLEFT">收货地址信息</span>
        </td>
      </tr>
      <tr>
        <td>
        <!-- registCnt -->
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <thead>
	          <tr>
	            <td>选择</td>
	            <td>收货地址</td>
	            <td>邮编</td>
	            <td>收货人</td>
	            <td>联系电话</td>
	            <td>&nbsp;&nbsp;</td>
	          </tr>
          </thead>
          <tbody id="addressTableEdit">
          </tbody>
<!-- 
		 <tr>
            <td><input type="radio" name="address" id="addressEdit" /></td>
            <td id="receiveAddressEdit"></td>
            <td id="receiveZipCodeEdit"></td>
            <td id="receiverEdit"></td>
            <td id="receiveTelephoneEdit"></td>
            <td><input type="button" id="setDefaultAddressEdit" onclick="setDefaultAddress()" value="设为默认收货地址"  class="BUTTON" /></td>
          </tr>
 -->
        </table></td>
      </tr>
      <tr>
      	<td align="left"><input type="button" class="BUTTON" name="manageReceiveAddress" id="manageReceiveAddressEdit" onclick="goodsAddressManage(this)" value="管理收货地址"  style="margin-left:25px;" /></td>
      </tr>
      <tr>
        <td align="center"><input type="button" onclick="savePurchaseOrder(this)" class="BIGBUTTON" value="保存" />
          <input type="reset" class="BIGBUTTON" onclick="hideRegister()" value="取消" />
          <input type="reset" class="BIGREDBUTTON" onclick="savePurchaseOrder(this)" value="保存并提交" /></td>
      </tr>
  </table>
</form>

  <table id="Info" class="CENTER" cellpadding="0" cellspacing="0">
      <tr class="TITLE">
        <td id="processTD">
            <span id="contentSpan" class="TITLESPAN1">采购订单详情</span>
        </td>
      </tr>
      <tr>	
      	<td class="TOPPX">
        	<span id="spanLeft1" class="FLOATLEFT">采购订单代码：<label id="purchaseOrderIdInfo"></label></span>
            <span id="spanRight1" class="FLOATRIGHT"><a class="ARTA" href="../baseInformation/quotationInformation.action" target="_blank">价格行情</a></span>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <thead>
			 <tr>
            	<td>产品代码及名称</td>
            	<td>度量单位</td>
            	<td>价格（元）</td>
            	<td>采购数量</td>
            	<td>合计（元）</td>
             </tr>          
          </thead>
          <tbody id="productTableInfo">
          		<!-- js动态插入产品列表 -->
          </tbody>
        </table></td>
      </tr>
      <tr>
      	<td>
        	<span id="spanLeft1" class="FLOATLEFT">收货地址：<label id="receiveAddressInfo"></label></span>
        </td>
      </tr>
      <tr>
      	<td>
        	<span id="spanLeft1" class="FLOATLEFT">交货日期：<label id="deliverDateInfo"></label></span>
        </td>
      </tr>
      <tr>
      	<td align="center" style="padding-bottom:15px;">
            <div class="ORDERCONTENT"><span>产品货款：<label id="goodsPriceInfo"></label>（元）</span></div>
            <div class="ORDERCONTENT"><span>运费：<label id="fareInfo"></label>（元）</span></div>
            <div class="ORDERCONTENT"><span>总货款：<label id="totalPriceInfo"></label>（元）</span></div>
            <div id="threeWhole">
            	<div id="one"></div>
            	<div class="ORDERCONTENT"><span>应支付定金：<label id="depositInfo"></label>（元）</span></div>
                <div id="three">=总货款*定金比率</div>
            </div>
        </td>
      </tr>
  </table>
  
  <div class="EMPTYDIV"></div>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
