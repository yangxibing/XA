<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>采购订单管理-基地</title>
<link href="../../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../../javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript"> 
		$().ready( function (){
				$.post("getAjaxDropDownList!returnSupplierIdNameList.action",function(data) {
					$.each(data.supplierIdNameList,function(i,value){
							$("#supplierIdQuery").append("<option value="+value.partnerId+">"+value.partnerName+"</option>");
					});

		            $("#supplierIdQuery option").each(function(){
		            	if($(this).attr("value")=='<s:property value="#request.baseOrderVO.supplierId"/>'){
		            		$(this).attr("selected", true);
		            	}
		            });
				});
				

				$("#orderStateQuery option").each(function(){
	            	if($(this).attr("value")=='<s:property value="#request.baseOrderVO.orderState"/>'){
	            		$(this).attr("selected", true);
	            	}
	            });
	            $("#CPIIdQuery").attr("value", '<s:property value="#request.baseOrderVO.CPIId"/>');
	            

	            
				//点击新建按钮后，异步获取供应商列表，集中采购信息列表，计划采购列表, 收货地址列表
				$("#newBaseOrderButton").click( function(){
					hideInfo();    
		            var subMenu=document.getElementById("register");
		            subMenu.style.display = "block";
		            $("#productDetailTr").hide();
		            $("#addProductTr").hide();
		            $("#productPriceTr").hide();
		            $("#baseOrderIdEdit").text("编号自动生成");
					getDropDownListForNew();
					$("#addUpdateBaseOrder").attr("action", "addBaseOrder.action");
					});	


				//当新建或编辑时，选择供应商下拉列表时，需要改变产品目录链接的supplierId
				//$("#supplierIdEdit").change( function() {
					//$("#supplierProductCatalogLink").
					//});	

						
			});


		function getDropDownListForNew() {
			//点击新建按钮后，异步获取供应商列表，集中采购信息列表，计划采购列表,
			$.post("getAjaxDropDownList!returnSupplierIdNameList.action",function(data) {
				$("#supplierIdEdit").empty();
				//$("#supplierIdEdit").append("<option value=\"\">------请选择------</option>");
				$.each(data.supplierIdNameList,function(i,value){					
						$("#supplierIdEdit").append("<option value="+value.partnerId+">"+value.partnerName+"</option>");
					});
				});

			$.post("getAjaxDropDownList!returnCentralizedPurchaseIdList.action", function(data){
				$("#CPIIdEdit").empty();
				$("#CPIIdEdit").append("<option value=\"\"></option>");
				$.each(data.centralizedPurchaseIdList, function(i,value) {
						$("#CPIIdEdit").append("<option value="+value.cpPurchaseInfoId+">"+value.cpPurchaseInfoId + value.cpPurchaseInfoTitle+"</option>");
					});
				});
			$.post("getAjaxDropDownList!returnPlanedPurchaseIdList.action", function(data){
				$("#PPIIdEdit").empty();
				$("#PPIIdEdit").append("<option value=\"\"></option>");
				$.each(data.planedPurchaseIdList, function(i,value) {
						$("#PPIIdEdit").append("<option value="+value.cpPurchaseInfoId+">"+value.cpPurchaseInfoId + value.cpPurchaseInfoTitle+"</option>");
					});
				});

			//异步获取  收货地址列表
			$.post("getAjaxDropDownList!returnBaseReceiveAddressList", function(data) {
				$("#receiveAddressTableEdit>tr").remove();
				var addressTableStr = "";
				var defaultAddressId = "";
				$.each(data.baseReceiveAddressList, function(i, value) {
						addressTableStr += "<tr> ";
						addressTableStr += "<td><input type=\"radio\" name=\"baseReceiveAddress\" id=\"addressRadioEdit\" value=\"" + value.addressId;
						if (value.defaultOrNot == true) {
							addressTableStr += "\" checked=\"true\" /></td>";
							defaultAddressId = value.addressId;
						} else {
							addressTableStr += "\" /></td>";
						}
						
						addressTableStr += "<td>" + value.shippingAddress + "</td>"
				 			+ "<td>" + value.zipCode + "</td>"
				 			+ "<td>" + value.contacter + "</td>"
				 			+ "<td>" + value.telephone + "</td>";
				 		if (value.defaultOrNot == false) {
							addressTableStr += "<td><input type=\"button\" id=\"setDefaultAddressEdit\" onclick=\"setDefaultAddress(this)\" value=\"设为默认收货地址\"  class=\"BUTTON\" name=\"" + value.addressId + "\" /></td>";
						} else {
							addressTableStr += "<td><input type=\"button\" id=\"setDefaultAddressEdit\" onclick=\"setDefaultAddress(this)\" value=\"设为默认收货地址\"  class=\"BUTTON\" name=\"" + value.addressId + "\" /></td>";
						}
				 		addressTableStr += "</tr>";								
						
					});
				$("#receiveAddressTableEdit").append(addressTableStr);

				$("input[id='setDefaultAddressEdit']").each(function(){
					if($(this).attr("name")== defaultAddressId){
						$(this).hide();
					}
				});
					  
				});

			//异步获取产品代码及名称下拉列表
			var supplierIdValue = $("#supplierIdEdit").attr("value");
			$.post("getAjaxDropDownList!returnSupplierProductList", {supplierId:supplierIdValue},function(data) {
				$("#productIdSelectEdit").empty();
				$.each(data.supplierProductList, function(i,value) {
						
						$("#productIdSelectEdit").append("<option value=\""+value.productId+" "+ value.productName+" "+value.supplierName+" "+value.measureUnit+" "+ value.basePrice+"\"> "+value.productId + " " + value.productName+"</option>");
					});
				});		
		}

		//供应商选择改变时，对应产品下拉列表改变
		function supplierIdSelectChange() {
			//异步获取产品代码及名称下拉列表
			var supplierIdValue = $("#supplierIdEdit").attr("value");
			$.post("getAjaxDropDownList!returnSupplierProductList", {supplierId:supplierIdValue},function(data) {
				$("#productIdSelectEdit").empty();
				$.each(data.supplierProductList, function(i,value) {
						
						$("#productIdSelectEdit").append("<option value=\""+value.productId+" "+ value.productName+" "+value.supplierName+" "+value.measureUnit+" "+ value.basePrice+"\"> "+value.productId + " " + value.productName+"</option>");
					});
				});	
		}

		
		//点击订单详情异步显示采购订单详情页面
		function displayBaseOrderDetailInfo(valu) {	
			hideRegister();    
            var subMenu=document.getElementById("Info");
            subMenu.style.display = "block";        
        	var baseOrderIdValue=$(valu).attr("name");
			var url='getBaseOrderDetail.action';
			var params={baseOrderId:baseOrderIdValue,async: false};
			$.post(url,params,function(data) {

				    //基地采购订单基本信息
					var baseOrder = data.baseOrderX;
					$("#baseOrderIdInfo").text(baseOrder.baseOrderId);
					$("#supplierNameInfo").text(baseOrder.supplierName);
					$("#CPIIdInfo").text(baseOrder.CPIId);
					$("#PPIIdInfo").text(baseOrder.PPIId);
					$("#deliverDateInfo").text(baseOrder.deliverDate);
					$("#depositInfo").text(baseOrder.deposit);
                	$("#fareInfo").text(baseOrder.fare);
                	$("#totalPriceInfo").text(baseOrder.totalPrice);

					//订单产品详情
					var productPrice = 0.0;
					$("#productTableInfo>tr").remove();
					$.each(data.baseOrderProductDetail, function(i, value) {

							var str = "<tr>" +
								"<td><a href='#'>" + value.productId + value.productName+"</a></td>" +
								"<td>" + value.supplierName + "</td>" +
								"<td>" + value.measureUnit + "</td>" +
								"<td>" + value.price + "</td>" +
								"<td>" + value.number + "</td>" +
								"<td>"+value.price*value.number+"</td>" +
								"</tr>";
      						$("#productTableInfo").append(str);
      						productPrice=productPrice + value.price*value.number;
						});
					$("#productPriceInfo").text(productPrice);


					//地址信息
					var address = data.receiveGoodsAddress;
					$("#receiveAddressInfo").text(address.shippingAddress +"，"+ address.zipCode +"，" + address.contacter +"，" + address.telephone);
                	
				},'json');		    
		}
		
		
		//点击编辑按钮时回插入数据
		function displayRegister(valu) {
			hideInfo();    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
            $("#productDetailTr").hide();
            $("#addProductTr").hide();
            $("#productPriceTr").hide();

            getDropDownListForNew();

        	$("#addUpdateBaseOrder").attr("action", "updateBaseOrder.action");
            var baseOrderIdValue = $(valu).attr("name");
            var url = "selectBaseOrder.action";
            var params={baseOrderId:baseOrderIdValue,async: false};
            $.post(url, params, function(data) {
                
            		//基地采购订单基本信息
					var baseOrder = data.baseOrderX;
					$("#baseOrderIdEdit").text(baseOrder.baseOrderId);
					$("#supplierIdEdit option").each(function() {
						if($(this).attr("value") == baseOrder.supplierId) {
							$(this).attr("selected", true);
						}
					});
					$("#CPIIdEdit option").each(function() {
						if($(this).attr("value") == baseOrder.CPIId) {
							$(this).attr("selected", true);
						}
					});
					$("#PPIIdEdit option").each(function() {
						if($(this).attr("value") == baseOrder.PPIId) {
							$(this).attr("selected", true);
						}
					});
					$("#deliverDateEdit").attr("value", baseOrder.deliverDate);
					$("#depositEdit").attr("value", baseOrder.deposit);
					$("#fareEdit").attr("value", baseOrder.fare);
					$("#totalPriceEdit").text(baseOrder.totalPrice);
                	
            		//选中哪一条地址信息
            		$("input[name='baseReceiveAddress']").each( function(){
                			if($(this).attr("value") == baseOrder.receiveAddressId) {
                				$(this).attr("checked", "true");
                			} else {
                				$(this).attr("checked", "false");
                			}
                			
                		});            		           	

            		//显示产品详情列表
					var productPrice = 0.0;
					$.each(data.baseOrderProductDetail, function(i, value) {

							var str = "<tr id=\"originalProduct\">" +
								"<td><a href='#'>" + value.productId + value.productName+"</a></td>" +
								"<td>" + value.supplierName + "</td>" +
								"<td>" + value.measureUnit + "</td>" +
								"<td>" + value.price + "</td>" +
								"<td>" + value.number + "</td>" +
								"<td>"+value.price*value.number+"</td>" +
								"</tr>";
      						$("#productTableEdit").append(str);
      						productPrice=productPrice + value.price*value.number;
						});
					$("#productPriceEdit").text(productPrice);
            				
                }, 'json')
            
        }

		
		//显示订单详细表
        function displayProductDetail(){
        	supplierIdSelectChange();
        	$("#productDetailTr").show("slow");
            $("#addProductTr").show("slow");
            $("#productPriceTr").show("slow");
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


		//全选按钮对应事件
        function allSelected(){
        	if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='baseOrderItem']").attr("checked",true);
        	}
        	else {
        		$("[name='baseOrderItem']").attr("checked",false);
        	}
        }
        
        //删除选中的采购订单条目：但注意只能删除处于未提交状态的订单
		function deleteBaseOrder(){
			
			var f_str="";
        	var count=0;
        	var total=0;
			$("[name='baseOrderItem']").each( function(){
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
						$.post("deleteBaseOrder.action",{baseOrderIdListForDel:f_str},function(data){
							$("#listBaseOrder").submit();
						});
					}
				}
				else if(count>0 && total == count){
					if(confirm("确实要删除所选的订单吗？")){
						$.post("deleteBaseOrder.action",{baseOrderIdListForDel:f_str},function(data){
							$("#listBaseOrder").submit();
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


		//收货人收货地址管理
     	function setDefaultAddress(valu){
     		var defaultAddressIdValue = $(valu).attr("name");
     		var params={addressId:defaultAddressIdValue};
     		var url = "setBaseOrderDefaultAddress.action";
     		$.post(url, params, function(data){
     			alert("设置成功！");
     			$("input[id='setDefaultAddressEdit']").each( function(){
     				if($(this).attr("name") != defaultAddressIdValue){
     					$(this).show();
     				} else {
     					$(this).hide();
     				}
     			});
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
		        		submitTotalPrice += tbody.rows[index].cells[3].innerText*tbody.rows[index].cells[4].innerText;
		        	}
		        	goodsTotalPrice += submitTotalPrice*1.0;
		        	$("#productPriceEdit").text(goodsTotalPrice);
		        	
		        	totalPrice += $("#fareEdit").attr("value")*1.0;
		        	totalPrice += goodsTotalPrice;	        	
		        	$("#totalPriceEdit").text(totalPrice);
		 } 


		//在订单明细增加或编辑产品时检查输入的产品采购数量并动态显示产品货款＝产品价格*产品数量
		function checkNumber(valu){
     		if($(valu).attr("value")!= "" && $(valu).attr("value") <= 0) {
     			alert("采购数量不可以为负值！");
     			$(valu).attr("value", "");
     			$("#productTotalEdit").text("");
     		} else if($(valu).attr("value")!= "" && $(valu).attr("value") > 0) {
     			$("#productTotalEdit").text($("#numberEdit").attr("value")*$("#priceEdit").text());
     		} else {
     			$("#productTotalEdit").text("");
     		}
     	} 

		//当改变产品列表选项时动态显示供应商名称，度量单位，价格
		function productSelectChange(select){
     		var value = select.options[select.selectedIndex].value; 
     		$("#supplierNameEdit").text(value.split(" ")[2]);
     		$("#measureUnitEdit").text(value.split(" ")[3]);
     		$("#priceEdit").text(value.split(" ")[4]); 
     		$("#numberEdit").attr("value", "");
     		$("#productTotalEdit").text("");
     	}

     	//增加产品时动态更新产品货款和总货款
     	function addProductEdit(valu) {
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
							+ "<td>" + name[4] + "</td>"
							+ "<td>" + number + "</td>"
							+ "<td>" + itemTotalPrice + "</td>"
							+ "</tr>";
				tbody.append(appendStr);
				
				$("#productIdSelectEdit").attr("selectedIndex", "0");
				name = select.options["0"].value.split(" ");
				$("#supplierNameEdit").text(name[2]);
				$("#measureUnitEdit").text(name[3]);
				$("#priceEdit").text(name[4])
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



     	//***********************************************************************************************
     	//保存产品时提取页面数据并提交到后台
     	//***********************************************************************************************

     			function saveBaseOrder(valu){
     	        	var url=$("#addUpdateBaseOrder").attr("action");
     	        	
     	        	//从页面中获取订单信息用于提交       	
     	        	var orderStateValue = "1";
     	        	if($(valu).attr("value") == "保存"){
     	        		orderStateValue = "0";
     	        	}
     	        	
     	        	var baseOrderIdValue = $("#baseOrderIdEdit").text();
     	        	
     	        	var select = document.getElementById("supplierIdEdit");
     	        	var supplierIdValue = select.options[select.selectedIndex].value;
     	        	select = document.getElementById("CPIIdEdit");
     	        	var CPIIdValue = select.options[select.selectedIndex].value;
     	        	select = document.getElementById("PPIIdEdit");
     	        	var PPIIdValue = select.options[select.selectedIndex].value;
     	        	
     	        	var deliverDateValue = $("#deliverDateEdit").attr("value");
     	        	var depositValue = $("#depositEdit").attr("value");       //定金
     	        	var fareValue = $("#fareEdit").attr("value");             //运费
     	        	var totalPriceValue = $("#totalPriceEdit").text();        //总货款
     	        	
     	        	var receiveAddressIdValue = "";
     	        	$("input[name='baseReceiveAddress']").each(function(){
     					if($(this).attr("checked")==true){
     						receiveAddressIdValue = $(this).attr("value");
     					}
     				});
     	        	
     				//从页面中获取订单中所有新增的产品用于提交
     				var addListValue = "";
     				$("tr[id='newAddProduct']").each(function(){
     					addListValue += this.cells[0].innerText + " " 
     							+ this.cells[2].innerText + " " + this.cells[3].innerText + " "
     							+ this.cells[4].innerText + " " + this.cells[5].innerText + ",";
     				});
     				
     				var originalListValue = "";
     				$("tr[id='originalProduct']").each(function(){
     					originalListValue += this.cells[0].innerText + " " 
     							+ this.cells[1].innerText + " " + this.cells[2].innerText + " "
     							+ this.cells[3].innerText + " " + this.cells[4].innerText + ",";
     				});	
     				
     				var params = {baseOrderId:baseOrderIdValue,
     								orderState:orderStateValue,
     								supplierId:supplierIdValue,
     								CPIId:CPIIdValue,
     								PPIId:PPIIdValue,
     								deliverDate:deliverDateValue,
     								deposit:depositValue,
     								fare:fareValue,
     								totalPrice:totalPriceValue,
     								receiveAddressId:receiveAddressIdValue,
     								baseOrderProductAddList:addListValue,
     								baseOrderProductOriginalList:originalListValue,
     								async: false};
     								
     				$.post(url,params,function(data){
     					$("#listBaseOrder").submit();
     				});				
     			}

//***************************************************************************************
//**********************倒数第一栏事件处理
//***************************************************************************************
		//退货
		function baseRejectedMag(valu){
     		var baseOrderIdValue = $(valu).attr("name");
     		$("#rejectedbaseOrderId").attr("value", baseOrderIdValue);
     		$("#baseRejectedMag").submit();
		}
     	     	
//***************************************************************************************
//**********************倒数第二、三栏事件处理
//***************************************************************************************
		//支付定金
		function payForDepositBase(valu){
			var baseOrderIdValue = $(valu).attr("name");
			$("#baseOrderIdHidden").attr("value", baseOrderIdValue);
			$("#payForDepositBase").submit();			
		}

		//确认到货
		function comfirmReceiveGoodsBase(valu){
			var baseOrderIdValue = $(valu).attr("name");
			$("#confirmReceiveGoodsHidden").attr("value", baseOrderIdValue);
			$("#comfirmReceiveGoodsBase").submit();
		}

		//支付余款
		function payForGoodsBase(valu){
			var baseOrderIdValue = $(valu).attr("name");
			$("#payForDepositHidden").attr("value", baseOrderIdValue);
			$("#payForGoodsBase").submit();
		}


		//取消事件
		function cancelBaseOrder(valu){
			var baseOrderIdValue = $(valu).attr("name");
			var params = {baseOrderId:baseOrderIdValue,async: false};	
			$.post("cancelBaseOrder.action",params,function(data){
				$("#listBaseOrder").submit();
			});	
		}

		//分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#listBaseOrder").attr("action", "listBaseOrder.action?currentPage="+currentPage);
        	$("#listBaseOrder").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#listBaseOrder").attr("action", "listBaseOrder.action?currentPage="+currentPage);
        	$("#listBaseOrder").submit();
		}


		//管理物流地址
     	function goodsAddressManage(){
     		$("#goodsAddressManage").submit();
     	}


     	//退货详情
     	function baseRejectedInfo(valu){
      		var baseOrderIdValue = $(valu).attr("name");
     		$("#rejectedBaseOrderIdInfo").attr("value", baseOrderIdValue);
     		$("#baseRejectedInfo").submit();    		
     	}

     	//物流详情
     	function logisticsInformation(valu){
     		var baseOrderIdValue = $(valu).attr("name");
     		$("#logisticsBaseOrderId").attr("value", baseOrderIdValue);
     		$("#logisticsInformation").submit();
     	}
		
</script>
<style>
#supply #showlist{ font-size:12px;}
#processTD{text-align:left;height:40px;}
#processTD #contentSpan{width:250px; margin-left:20px; margin-top:10px; font-size:16px; font-weight:bold;}
#Info #processTD #contentSpan{width:250px; margin-left:20px; margin-top:5px; font-size:16px; font-weight:bold;}
#process{ margin-top:4px; margin-right:4px;}
#supply #register{ background-color:#F4EEEA;}
#supply #Info{ background-color:#F4EEEA;}
#supply #register #registCnt{margin-top:10px;}
#supply #Info #registCnt{margin-top:10px;}

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
#rightDown{ margin-right:23px; margin-bottom:20px;}
#CPIIdEdit{width:150px;}
#PPIIdEdit{width:150px;}
</style>

</head>

<body>

<form id="payForDepositBase" action="payForDepositBase.action">
	<input type="hidden" name="baseOrderId" id="baseOrderIdHidden"  value="" />
</form>
<form id="comfirmReceiveGoodsBase" action="comfirmReceiveGoodsBase.action">
	<input type="hidden" name="baseOrderId" id="confirmReceiveGoodsHidden" value="" />
</form>
<form id="payForGoodsBase" action="payForGoodsBase.action">
	<input type="hidden" name="baseOrderId" id="payForDepositHidden" value="" />
</form>
<form id="baseRejectedMag" action="baseRejectedMag.action" >
	<input type="hidden" name="baseOrderId" id="rejectedbaseOrderId" value="" />
</form>

<form id="baseRejectedInfo" action="baseRejectedInfo.action" >
	<input type="hidden" name="baseOrderId" id="rejectedBaseOrderIdInfo" value="" />
</form>

<form id="logisticsInformation" action="baseOrderLogisticsInformation.action">
	<input type="hidden" name="baseOrderId" id="logisticsBaseOrderId" value="" />
</form>

<form id="goodsAddressManage" action="goodsAddressManage.action">
	<input type="hidden" name="sendOrReceive" id="sendOrReceiveHidden" value="true"/>
</form>

<div id="supply" class="CENTER">
<div id="top">
  <span style="color:#FFF;"><h2>采购订单管理-基地</h2></span>
</div>

<!-- 查询模块：根据输入参数查询基地订单 -->
<form id="listBaseOrder" action="listBaseOrder.action" method="post">
    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE">
        	<td><span class="TITLESPAN1">组合条件查询</span></td>
            <td colspan="6"></td>
        </tr>
        <tr>
        	<td class="BORDER" align="right">订单状态</td>
            <td class="BORDER">
            	<select name="orderState" id="orderStateQuery">
                	<option value="-1">全部状态</option>
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
            <td class="BORDER" align="right">集中采购信息代码</td>
            <td class="BORDER"><input type="text" class="INPUTTEXT" name="CPIId" id="CPIIdQuery"/></td>
            <td class="BORDER" align="right">供应商</td>
            <td class="BORDER">
            	<select name="supplierId" id="supplierIdQuery">
            		<option value="">全部供应商</option>
            	</select>
            </td>
            <td align="right" class="BORDER">
            	<input type="submit" class="BUTTON" value="查询" />
            </td>
        </tr>
    </table>
</form>


<!-- 显示查询列表模块 -->
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="2px;">
    	<tr class="TITLE" style="font-weight:bold;">
        	<td>选择</td>
            <td>采购订单代码</td>
            <td>供应商</td>
            <td>订单状态</td>
            <td>定金（元）</td>
            <td>运费（元）</td>
            <td>总货款（元）</td>
            <td>集中采购信息代码</td>
            <td colspan="3">&nbsp;</td>
        </tr>
        <s:iterator id="element" value="#request.query">
        	<tr class="HOVER">
        		<td><input name="baseOrderItem" type="checkbox" value="<s:property value="#element.baseOrderId"/>" id="<s:property value="#element.orderState"/>"/></td>
        		<td><s:property value="#element.baseOrderId"/></td>
        		<td><s:property value="#element.supplierName"/></td>
        		<td>
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
	          	 <td><s:property value="#element.deposit"/></td>
	          	 <td><s:property value="#element.fare"/></td>
	          	 <td><s:property value="#element.totalPrice"/></td>
	          	 <td><s:property value="#element.CPIId"/></td>
	          	 <!-- 倒数第三列：信息详情栏 -->
	          	 <td>
	          	 		<s:if test="%{#element.orderState==0}"><!-- 未提交 -->
							<input type="button" name="<s:property value="#element.baseOrderId"/>" id="editBaseOrderButton" onclick="displayRegister(this)" value="编辑" class="ARTBUTTON"/>
						</s:if>
	          	    	<s:elseif test="%{#element.orderState==1}"><!-- 订单提交未支付定金 -->
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="displayBaseOrderDetailInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="cancelBaseOrder(this)" value="取消" class="ARTBUTTON"/>
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==2}"><!-- 订单提交已支付定金 -->
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="displayBaseOrderDetailInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="cancelBaseOrder(this)" value="取消" class="ARTBUTTON"/>		
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==3}"><!-- 取消 -->
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="displayBaseOrderDetailInfo(this)" value="订单详情" class="ARTBUTTON"/>
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==4}"><!-- 已经确认发货 -->
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="displayBaseOrderDetailInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="logisticsInformation(this)" value="物流详情" class="ARTBUTTON"/>	          	    	
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==5}"><!-- 已经确认到货未支付货款 -->
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="displayBaseOrderDetailInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="logisticsInformation(this)" value="物流详情" class="ARTBUTTON"/>	          	    		          	    	
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==6}"><!-- 交易完成 -->
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="displayBaseOrderDetailInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="logisticsInformation(this)" value="物流详情" class="ARTBUTTON"/><br />	          	    	
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="baseRejectedMag(this)" value="退货" class="ARTBUTTON"/>      	    		          	    	
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==7}"><!-- 申请退货 -->
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="displayBaseOrderDetailInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="baseRejectedInfo(this)" value="退货详情" class="ARTBUTTON"/>	          	    		
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==8}"><!-- 退货收货 -->
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="displayBaseOrderDetailInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="baseRejectedInfo(this)" value="退货详情" class="ARTBUTTON"/>	          	    			          	    	
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==9}"><!-- 退货成功 -->
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="displayBaseOrderDetailInfo(this)" value="订单详情" class="ARTBUTTON"/><br />
	          	    		<input type="button" name="<s:property value="#element.baseOrderId"/>" onclick="baseRejectedInfo(this)" value="退货详情" class="ARTBUTTON"/>         	    			          	    		          	    	
	          	    	</s:elseif>
	          	    	<s:else><!-- 其他默认未提交 -->
							<input type="button" name="<s:property value="#element.baseOrderId"/>" id="editBaseOrderButton" onclick="displayRegister(this)" value="编辑" class="ARTBUTTON"/>	          	    	
	          	    	</s:else>
	          	 </td>
	          	 
	          	 <!-- 倒数第二列：定金状态栏 -->
	            <td>
	            		<s:if test="%{#element.orderState==1}"><!-- 订单提交未支付定金 -->
							<input type="button" class="BUTTON" onclick="payForDepositBase(this)" name="<s:property value="#element.baseOrderId"/>" value="支付定金" />
	            		</s:if>
	          	    	<s:elseif test="%{#element.orderState==2}"><!-- 订单提交已支付定金 -->
	          	    		已经支付定金
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==3}"><!-- 取消 -->
	          	    		<s:if test="%{#element.deposit==0.0}">已经支付定金</s:if>
	          	    		<s:else>未支付定金</s:else>
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==4}"><!-- 已经确认发货 -->
	          	    		<s:if test="%{#element.deposit==0.0}">已经支付定金</s:if>
	          	    		<s:else>未支付定金</s:else>
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==5}"><!-- 已经确认到货未支付货款 -->
	          	    		<s:if test="%{#element.deposit==0.0}">已经支付定金</s:if>
	          	    		<s:else>未支付定金</s:else>	          	    	
	          	    	</s:elseif>
	            </td>
	            
	            <!-- 最后一列：货物、货款状态栏 -->
	            <td>
	            		<s:if test="%{#element.orderState==0}"></s:if>
	          	    	<s:elseif test="%{#element.orderState==1}">等待发货</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==2}">等待发货</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==3}"></s:elseif>
	          	    	<s:elseif test="%{#element.orderState==4}">
	          	    		<input type="button" class="BUTTON" onclick="comfirmReceiveGoodsBase(this)" name="<s:property value="#element.baseOrderId"/>" value="确认到货" />
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==5}">已经确认到货<br />
	          	    		<input type="button" class="BUTTON" onclick="payForGoodsBase(this)" name="<s:property value="#element.baseOrderId"/>" value="支付货款" />	          	    	
	          	    	</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==6}">交易完成</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==7}">等待退货收货</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==8}">等待退款</s:elseif>
	          	    	<s:elseif test="%{#element.orderState==9}">已经退款</s:elseif>
	          	    	<s:else></s:else>
	            </td>
        	</tr>
        </s:iterator>
        
        <tr>
        	<td><input type="checkbox" name="allSelectBox" onclick="allSelected()"/>全选</td>
            <td><input type="button" class="BUTTON" onclick="deleteBaseOrder()" value="删除"/>
           	<input type="button" class="BUTTON" id="newBaseOrderButton" value="新建" /></td>
            <td colspan="9" class="UPBOD" align="right">
	            	<input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	            	<span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	            	<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
	       	</td>
        </tr>
    </table>
    
    
<!-- 新建和编辑订单模块-->
<form id="addUpdateBaseOrder" action="" >
  <div class="EMPTYDIV"></div>
  <table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr class="TITLE">
        <td id="processTD">
            <span id="contentSpan" class="FLOATLEFT">采购订单</span>
             <div id="process" class="FLOATRIGHT">
                <div class="ARTLEFTDIV"><span>交易仅需四步</span></div>
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
            </div>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <tr>
            <td class="ALRIGHT">采购订单代码</td>
            <td class="ALLEFT"><label id="baseOrderIdEdit"></label></td>
            <td class="ALRIGHT">供应商名称</td>
            <td class="ALLEFT">
            	<select name="supplierId" id="supplierIdEdit" onchange="supplierIdSelectChange()">
            	</select>
            </td>
          </tr>
          <tr>
            <td class="ALRIGHT">集中采购信息代码</td>
            <td class="ALLEFT">
            	<select name="CPIId" id="CPIIdEdit">
            		
            	</select>
            	<a class="ARTA" href="../../centralizedPurchase/queryCentralizedPurchaseList.action" title="查看集中采购需求" target="_blank">集中采购需求</a>
            </td>
            <td class="ALRIGHT">计划采购信息代码</td>
            <td class="ALLEFT">
            	<select name="PPIId" id="PPIIdEdit">
            	</select>
            	<a class="ARTA" href="../../planedPurchase/listPlanedPurchaseInfo.action" title="查看计划采购需求" target="_blank">计划采购需求</a></td>
          </tr>
          <tr>
            <td class="ALRIGHT">交货日期</td>
            <td class="ALLEFT"><input type="text" class="SMALLINPUT" onclick="WdatePicker()" name="deliverDate" id="deliverDateEdit"/></td>
            <td class="ALRIGHT">应支付定金</td>
            <td class="ALLEFT"><input  class="SMALLINPUT" type="text" name="deposit" id="depositEdit"/> （元）</td>
          </tr>
          <tr>
            <td class="ALRIGHT">运费</td>
            <td class="ALLEFT"><input  class="SMALLINPUT" type="text" name="fare" id="fareEdit" onkeyup="priceChanged(this)"/> （元）</td>
            <td class="ALRIGHT">总货款</td>
            <td class="ALLEFT"><label id="totalPriceEdit"></label>（元）</td>
          </tr>
        </table></td>
      </tr>
      
      <!-- 收货地址选择模块 -->
      <tr>	
      	<td>
        	<span id="spanLeft1" class="FLOATLEFT">收货地址信息</span>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" style="margin-top:0;" class="CENTER" cellpadding="0" cellspacing="0" align="center">
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
          	<tbody id="receiveAddressTableEdit">
          	</tbody>
        </table>
        </td>
      </tr>
      <tr>
      	<td align="left"><input style="margin-left:25px;" type="button" class="BUTTON" name="manageReceiveAddress" id="manageReceiveAddressEdit" value="管理收货地址" onclick="goodsAddressManage(this)"/></td>
      </tr>
      <tr>
        <td align="center" id="borderTD"><input type="button" onclick="saveBaseOrder(this)" class="BIGBUTTON" value="保存" />
          <input type="button" class="BIGBUTTON" onclick="hideRegister()" value="取消" />
          <input type="button" class="BIGBUTTON" onclick="displayProductDetail()" value="订单明细表" />
          <input type="reset" class="BIGREDBUTTON" onclick="saveBaseOrder(this)" value="保存并提交" /></td>
      </tr>
      
      <tr>
  		<td class="TOPPX">
            <span id="spanRight1" class="FLOATRIGHT"><a id="supplierProductCatalogLink" class="ARTA" href="#">产品目录</a></span>
        </td>
      </tr>
   
      <!-- 产品明细模块 -->
     <tr id="productDetailTr">   	
     	<td>
     	<table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <thead>
          	<tr>
            	<td>产品代码及名称</td>
            	<td>供应商名称</td>
            	<td>度量单位</td>
            	<td>价格（元）</td>
            	<td>采购数量</td>
            	<td>合计（元）</td>
          	</tr>
          </thead>
          <tbody id="productTableEdit">
          </tbody>
          
          <tfoot>
          	<tr>
            	<td>
            		<select name="productId" id="productIdSelectEdit" onchange="productSelectChange(this)">
                		<!-- js动态添加 <option></option> -->
                	</select>
            	</td>
            	<td id="supplierNameEdit"></td>
            	<td id="measureUnitEdit"></td>
            	<td id="priceEdit"></td>
            	<td><input type="text" name="number"  id="numberEdit" onkeyup="checkNumber(this)" style="width:70px;" class="SHORTINPUT" /></td>
            	<td id="productTotalEdit"></td>
          	</tr>
          </tfoot>                    
        </table></td>
     </tr>
     <tr id="addProductTr">
      	<td align="left"><input style="margin-left:25px;" type="button" class="BUTTON" onclick="addProductEdit(this)" value="增加产品" /></td>
      </tr>
      <tr id="productPriceTr">
      	<td align="right">
            <div class="ORDERCONTENT" id="rightDown"><span>产品货款：<label id="productPriceEdit"></label>（元）</span></div>
        </td>
      </tr>
  </table>
</form>

 <table id="Info" class="CENTER" cellpadding="0" cellspacing="0">
      <tr class="TITLE">
        <td id="processTD">
            <span id="contentSpan" class="FLOATLEFT">采购订单详情</span>
        </td>
      </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0" align="center">
          <tr>
            <td class="ALRIGHT">采购订单代码</td>
            <td class="ALLEFT"><label id="baseOrderIdInfo"></label></td>
            <td class="ALRIGHT">供应商名称</td>
            <td class="ALLEFT"><label id="supplierNameInfo"></label></td>
          </tr>
          <tr>
            <td class="ALRIGHT">集中采购信息代码</td>
            <td class="ALLEFT"><label id="CPIIdInfo"></label> </td>
            <td class="ALRIGHT">计划采购信息代码</td>
            <td class="ALLEFT"><label id="PPIIdInfo"></label></td>
           </tr>
          <tr>
            <td class="ALRIGHT">交货日期</td>
            <td class="ALLEFT"><label id="deliverDateInfo"></label></td>
            <td class="ALRIGHT">应支付定金</td>
            <td class="ALLEFT"><label id="depositInfo"></label>（元）</td>
          </tr>
          <tr>
            <td class="ALRIGHT">运费</td>
            <td class="ALLEFT"><label id="fareInfo"></label>（元）</td>
            <td class="ALRIGHT">总货款</td>
            <td class="ALLEFT"><label id="totalPriceInfo"></label>（元）</td>
          </tr>
          <tr>
          	<td class="ALRIGHT">收货地址</td>
            <td class="ALLEFT" colspan="3"><label id="receiveAddressInfo"></label></td>
          </tr>
        </table></td>
      </tr>
      <tr>
      	<td id="borderTD"></td>
      </tr>
     <tr>
     	<td>
     	<table id="registCnt"  class="CENTER" cellpadding="0" cellspacing="0" align="center">
     	<thead>
          <tr>
            <td>产品代码及名称</td>
            <td>供应商名称</td>
            <td>度量单位</td>
            <td>价格（元）</td>
            <td>采购数量</td>
            <td>合计（元）</td>
          </tr>
        </thead>
        <tbody id="productTableInfo">
        </tbody>
        </table>
        </td>
     </tr>
      <tr>
      	<td align="right">
            <div class="ORDERCONTENT" id="rightDown"><span>产品货款：<label id="productPriceInfo"></label>（元）</span></div>
        </td>
      </tr>
  </table>	
  
  <div class="EMPTYDIV"></div>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../../home.jsp';" />
  </div>
</div>
</body>
</html>
