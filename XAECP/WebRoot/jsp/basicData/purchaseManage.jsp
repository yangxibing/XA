<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>采购商目录管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/control/scripts/eye-base.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/control/scripts/eye-all.js"></script>

<script type="text/javascript" charset="utf-8">
		window.onload = function(){
			recoverQueryState();
		}

		function recoverQueryState(){
			$("#partnerIdQuery").attr("value", $("#partnerIdConvertHidden").attr("value"));
			$("#partnerNameQuery").attr("value", $("#partnerNameConvertHidden").attr("value"));
			$("#cityQuery").attr("value", $("#cityConvertHidden").attr("value"));
			//$("#partnerLevelQuery").attr("value", $("#partnerLevelConvertHidden").attr("value"));
			$("#partnerLevelQuery option").each(function(){
				if($(this).attr("value")==$("#partnerLevelConvertHidden").attr("value")){
					$(this).attr("selected", true);
				}				
			});			
			$("#blackListQuery").attr("checked", false);
			if($("#blackListConvertHidden").attr("value") == "true"){
				$("#blackListQuery").attr("checked", true);
			}
		}

        function displayRegister(valu) {    
            if(($(valu).attr("value"))=="新建"){
				$("#addPurchaser").attr("action","addPurchaser.action");
				var subMenu=document.getElementById("register");
           		 subMenu.style.display = "block";
           		 $("#register :text").each(function(){
           		 	$(this).attr("value","");
           		 });
           		 $("#partnerId").attr("disabled",false);
           		 $("#introduction").attr("value", "");
			}else{				
				var partnerIdValue=$(valu).attr("name");
				var url='selectPurchaser.action';
				var params={partnerId:partnerIdValue,async: false};
				$.post(url,params,callBackFunction,'json');
			} 
        }
        
        function callBackFunction(data){
			var datas=data.ajaxResult;
			var a=new Array();
			a=datas.split(",");
			var subMenu=document.getElementById("register");
           	subMenu.style.display = "block";
            $("#partnerId").attr("value",a[0]);
            $("#partnerName").attr("value",a[1]);
            $("#firstAddress").attr("value",a[2]);
            $("#secondAddress").attr("value",a[3]);
            //$("#country").attr("value",a[4]);
            $("#province").attr("value",a[5]);
            $("#city").attr("value",a[6]);
            $("#website").attr("value",a[7]);
            $("#introduction").attr("value",a[8]);
            $("#partnerLevel option").each(
            	function(){
            		if($(this).val()==a[9]){
            			$(this).attr("selected", true);
            		}
            	}
            );
            if(a[10]=="true"){
            	$("#blackListYes").attr("checked",true);
            }else{
            	$("#blackListNo").attr("checked",true);
            }
            $("#contactPerson").attr("value",a[11]);
            $("#telephone").attr("value",a[12]);
            $("#fax").attr("value",a[13]);
            $("#email").attr("value",a[14]);
            $("#zipCode").attr("value",a[15]);
            $("#orderRate").attr("value",a[16]);
            $("#partnerId").attr("disabled",true);
           	$("#addPurchaser").attr("action","updatePurchaser.action");
		}
		
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }    
        
        function allSelected(){
        	if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='purchaserItem']").attr("checked",true);
        	}
        	else {
        		$("[name='purchaserItem']").attr("checked",false);
        	}
        }
        
        function deletePurchaser(){
        	var f_str="";
        	var count=0;
			$("[name='purchaserItem']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});
			if(count > 0){
				if(confirm("你真的要删除这些项么？")){
					$.post("deletePurchaser.action",{purchaserList:f_str},function(data){
						$("#listPurchaser").attr("action","listPurchaser.action");
						$("#listPurchaser").submit();
					});
				}
			} else {
				alert("未选中任何项！");
			}
        }
        
        function savePurchaser(){
        		var url=$("#addPurchaser").attr("action");
        		var partnerIdValue=$("#partnerId").attr("value");
				var partnerLevelValue=$("#partnerLevel").attr("value");
				var partnerNameValue=$("#partnerName").attr("value");
				var blackListValue = false;
				if($("#blackListYes").attr("checked")==true){
					blackListValue = true;
				}
				var firstAddressValue=$("#firstAddress").attr("value");
				var contactPersonValue=$("#contactPerson").attr("value");
				var secondAddressValue=$("#secondAddress").attr("value");
				var telephoneValue=$("#telephone").attr("value");
				var countryValue = "";
				var countryValue = $("#country").attr("value");
				var faxValue=$("#fax").attr("value");
				var provinceValue = $("#province").attr("value");		
				var emailValue=$("#email").attr("value");
				var cityValue = $("#city").attr("value");	
				var zipCodeValue=$("#zipCode").attr("value");
				var websiteValue=$("#website").attr("value");
				var orderRateValue=$("#orderRate").attr("value");
				var introductionValue=$("#introduction").attr("value");
				var params={partnerId:partnerIdValue,
					partnerLevel:partnerLevelValue,
					partnerName:partnerNameValue,
					blackList:blackListValue,
					firstAddress:firstAddressValue,
					contactPerson:contactPersonValue,
					secondAddress:secondAddressValue,
					telephone:telephoneValue,
					country:countryValue,
					fax:faxValue,
					province:provinceValue,
					email:emailValue,
					city:cityValue,
					zipCode:zipCodeValue,
					website:websiteValue,
					orderRate:orderRateValue,
					introduction:introductionValue,
					async: false};
				//验证输入
				if(checkOrderRate(orderRateValue)==false){
					return false;
				}
				if(partnerAllCheck($("#partnerId"),$("#partnerName"),$("#firstAddress"),$("#secondAddress"),$("#website"),$("#introduction"),$("#contactPerson"),$("#telephone"),$("#fax"),$("#email"),$("#zipCode"))==false){
					return false;
				};
				if(url.split(".")[0]=="addPurchaser"){
					
					$.post("selectPurchaser.action",{partnerId:partnerIdValue},function(data){
						if(data.ajaxResult !=="notExist"){
							alert("供应商代码已经存在，请使用其他代码");
							return false;
						}else{
							$.post(url,params,function(data){
								$("#listPurchaser").attr("action","listPurchaser.action");
								$("#listPurchaser").submit();
							});
						}
					});
					
				}else{
					$.post(url,params,function(data){
						$("#listPurchaser").attr("action","listPurchaser.action");
						$("#listPurchaser").submit();
					});
				}
				
		
        }
        
        function savePurchaserNew(){
    		var url=$("#addPurchaser").attr("action");
    		var partnerIdValue=$("#partnerId").attr("value");
			var partnerLevelValue=$("#partnerLevel").attr("value");
			var partnerNameValue=$("#partnerName").attr("value");
			var blackListValue = false;
			if($("#blackListYes").attr("checked")==true){
				blackListValue = true;
			}
			var firstAddressValue=$("#firstAddress").attr("value");
			var contactPersonValue=$("#contactPerson").attr("value");
			var secondAddressValue=$("#secondAddress").attr("value");
			var telephoneValue=$("#telephone").attr("value");
			var countryValue = "";
			$("#country option").each(function(){
        		if($(this).attr("selected")==true){
        			countryValue = $(this).attr("value");
        		}
        	});
			var faxValue=$("#fax").attr("value");
			var provinceValue = "";
			$("#province option").each(function(){
        		if($(this).attr("selected")==true){
        			provinceValue = $(this).attr("value");
        		}
        	}); 		
			var emailValue=$("#email").attr("value");
			var cityValue = "";
			$("#city option").each(function(){
        		if($(this).attr("selected")==true){
        			cityValue = $(this).attr("value");
        		}
        	}); 	
			var zipCodeValue=$("#zipCode").attr("value");
			var websiteValue=$("#website").attr("value");
			var orderRateValue=$("#orderRate").attr("value");
			var introductionValue=$("#introduction").attr("value");
			var params={partnerId:partnerIdValue,
				partnerLevel:partnerLevelValue,
				partnerName:partnerNameValue,
				blackList:blackListValue,
				firstAddress:firstAddressValue,
				contactPerson:contactPersonValue,
				secondAddress:secondAddressValue,
				telephone:telephoneValue,
				country:countryValue,
				fax:faxValue,
				province:provinceValue,
				email:emailValue,
				city:cityValue,
				zipCode:zipCodeValue,
				website:websiteValue,
				orderRate:orderRateValue,
				introduction:introductionValue,
				async: false};
			$.post(url,params,function(data){
				$("#listPurchaser").attr("action","listPurchaser.action");
				//$("#listPurchaser").submit();
				$.post("listPurchaser.action", {async: false}, function(){
					$("#addPurchaser").attr("action","addPurchaser.action");
					var subMenu=document.getElementById("register");
		       		subMenu.style.display = "block";
		       		$("#register :text").each(function(){
		       			$(this).attr("value","");
		       		});
				});
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
        	$("#listPurchaser").attr("action", "listPurchaser.action?currentPage="+currentPage);
        	$("#listPurchaser").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#listPurchaser").attr("action", "listPurchaser.action?currentPage="+currentPage);
        	$("#listPurchaser").submit();
		}
</script>  

</head>

<body>

	<input type="hidden" name="partnerIdConvert" id="partnerIdConvertHidden" value="<s:property value="#request.purchaser.partnerId"/>" />
	<input type="hidden" name="partnerNameConvert" id="partnerNameConvertHidden" value="<s:property value="#request.purchaser.partnerName"/>" />
	<input type="hidden" name="cityConvert" id="cityConvertHidden" value="<s:property value="#request.purchaser.city"/>" />
	<input type="hidden" name="partnerLevelConvert" id="partnerLevelConvertHidden" value="<s:property value="#request.purchaser.partnerLevel"/>" />
	<input type="hidden" name="blackListConvert" id="blackListConvertHidden" value="<s:property value="#request.purchaser.blackList"/>" />

	<form action="selectPurchaser.action" id="selectPurchaser"></form>
	
	<div id="supply" class="CENTER">
	<div id="top">
	  <span><h2>采购商目录管理</h2></span>
	</div>
	
	<form action="listPurchaser.action" id="listPurchaser" method="post">
	    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
	    	<tr class="TITLE">
	        	<td><b>组合条件查询</b></td>
	            <td colspan="5"></td>
	        </tr>
	        <tr>
	        	<td class="BORDER" align="right">采购商代码</td>
	            <td class="BORDER"><input name="partnerId" id="partnerIdQuery" type="text" class="INPUTTEXT"/></td>
	            <td class="BORDER" align="right">采购商名称</td>
	            <td class="BORDER"><input name="partnerName" id="partnerNameQuery" type="text" class="INPUTTEXT"/></td>
	            <td class="BORDER" align="right">所在城市</td>
	            <td class="BORDER">
                	<input type="hidden" id="provinceInput"  class="INPUTTEXT" onClick="eye.selectCity.show('cityQuery', this);"/>
            		<input type="text" id="cityQuery" name="city" class="INPUTTEXT" onClick="eye.selectCity.show('provinceInput', this);" value="<s:property value="supplier.city"/>"/>
            	</td>
	        </tr>
	        <tr>
	        	<td class="BORDER" align="right">采购商级别</td>
	            <td class="BORDER" align="left">
	            	<select name="partnerLevel" id="partnerLevelQuery" >
	            	<option value="">-所有级别-</option>
	            	<option value="0">第0级</option>
	                <option value="1">第1级</option>
	                <option value="2">第2级</option>
	                <option value="3">第3级</option>
	                <option value="4">第4级</option>
	                </select>
	            </td>
	            <td class="BORDER" align="left" colspan="2"><input name="blackList" id="blackListQuery" type="checkbox" value="true"/>是否列入黑名单</td>
	            <td colspan="2" align="right" class="BORDER">
	            	<input type="submit" class="BUTTON" value="查询" />
	                <input type="reset" class="BUTTON" value="清空" />
	                &nbsp;&nbsp;
	            </td>
	    	</tr>
	    </table>
	</form>
	    
	<form action="editPurchaser.action" method="post" id="editPurchaser">
	    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
	    	<tr class="TITLE" style="font-weight:bold;">
	        	<td>选择</td>
	            <td>级别</td>
	            <td>采购商代码</td>
	            <td>采购商名称</td>
	            <td>定金比率</td>
	            <td>是否列入黑名单</td>
	            <td>地址</td>
	            <td colspan="2">&nbsp;</td>
	        </tr>
	        <s:iterator id="element" value="#request.query">
	        	<tr class="HOVER">
	        		<td ><input name="purchaserItem" type="checkbox" class="INPUTTEXT" value="<s:property value="#element.partnerId"/>"/></td>
	          	    <td ><s:property value="#element.partnerLevel"/></td>
	           	    <td ><s:property value="#element.partnerId"/></td>
	           	    <td ><s:property value="#element.partnerName"/></td>
	           	    <td ><s:property value="#element.orderRate"/></td>
	           	    <td><s:if test="%{#element.blackList==true}">
	           	    		√
	           	    	</s:if>
	           	    	<s:else>
	           	    		×
	           	    	</s:else>
	           	    	</td>
	            	<td>&nbsp;<s:property value="#element.firstAddress"/></td>
	            	<td><input type="button" class="BUTTON" name="<s:property value="#element.partnerId"/>" onclick="displayRegister(this)" value="编辑"/></td>
	        	</tr>
	        </s:iterator>
	        <tr>
	        	<td><input name="allSelectBox" type="checkbox" onclick="allSelected()"/>全部选中</td>
	            <td><input type="button" class="BUTTON" onclick="deletePurchaser()" value="删除" /></td>
	            <td><input type="button" class="BUTTON" onclick="displayRegister(this)" value="新建" /></td>
	            <td colspan="5" align="right">
	            	<input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	            	<span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	           		<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
	            </td>
	            
	        </tr>
	    </table>
	</form>
	    
	<form action="updatePurchaser.action" method="post" id="addPurchaser">
	  	<table id="register" class="CENTER" cellpadding="0">
	      <tr class="TITLE">
	        <td align="left"><b>采购商信息</b> 注：<font color="#FF0000">*</font>为必填项</td>
	      </tr>
	      <tr>
	        <td><table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
	          <tr>
	            <td class="ALRIGHT">采购商代码</td>
	            <td class="ALLEFT"><input name="partnerId" id="partnerId" type="text" class="INPUTTEXT"/>
	              <font color="#FF0000">*</font></td>
	            <td class="ALRIGHT">采购商级别</td>
	            <td class="ALLEFT">
	            	<select name="partnerLevel" id="partnerLevel" >
	            	<option value="0">第0级</option>
	                <option value="1">第1级</option>
	                <option value="2">第2级</option>
	                <option value="3">第3级</option>
	                <option value="4">第4级</option>
	                </select>
	            </td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">采购商名称</td>
	            <td class="ALLEFT"><input name="partnerName" id="partnerName" type="text" class="INPUTTEXT" /></td>
	            <td class="ALRIGHT">是否列入黑名单</td>
	            <td class="ALLEFT"><input type="radio" name="blackList" id="blackListYes" />是
	              <input type="radio" name="blackList" id="blackListNo" value="false" checked="checked"/>否
	            </td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">公司地址</td>
	            <td class="ALLEFT"><input name="firstAddress" id="firstAddress" type="text" class="INPUTTEXT" /></td>
	            <td class="ALRIGHT">联系人</td>
	            <td class="ALLEFT"><input name="contactPerson" id="contactPerson" type="text" class="INPUTTEXT" /></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">默认物流地址</td>
	            <td class="ALLEFT"><input name="secondAddress" id="secondAddress" type="text" class="INPUTTEXT"  /></td>
	            <td class="ALRIGHT">电话</td>
	            <td class="ALLEFT"><input name="telephone" id="telephone" type="text" class="INPUTTEXT" /></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">国家</td>
	            <td class="ALLEFT">中国</td>
	            <td class="ALRIGHT">传真</td>
	            <td class="ALLEFT"><input name="fax" id="fax" type="text" class="INPUTTEXT" /></td>
	          </tr>
	          <tr>
	              <td class="ALRIGHT">省/州</td>
            	  <td class="ALLEFT">
            	      <input type="text" id="province" class="INPUTTEXT"  onClick="eye.selectCity.show(this, 'city');"/>
                  </td>
	            <td class="ALRIGHT">Email地址</td>
	            <td class="ALLEFT"><input name="email" id="email" type="text" class="INPUTTEXT" /></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">城市</td>
            	<td class="ALLEFT"><input type="text" id="city" class="INPUTTEXT" onClick="eye.selectCity.show('province', this);" />
            	</td>
	            <td class="ALRIGHT">邮政编码</td>
	            <td class="ALLEFT"><input name="zipCode" id="zipCode" type="text" class="INPUTTEXT" /></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">网址</td>
	            <td class="ALLEFT"><input name="website" id="website" type="text" class="INPUTTEXT" /></td>
	            <td class="ALRIGHT">定金比率</td>
	            <td class="ALLEFT"> <input name="orderRate" id="orderRate" type="text" class="INPUTTEXT" /></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">简介</td>
	            <td class="ALLEFT" colspan="3"><textarea name="introduction" id="introduction" style="width:400px; height:40px;" ></textarea></td>
	          </tr>
	        </table></td>
	      </tr>
	      <tr>
	        <td align="center">
	          <input type="button" class="BUTTON" onclick="savePurchaser()" value="保  存" />
	          <input type="reset" class="BUTTON" onclick="hideRegister()" value="取  消" />
	        </td>
	      </tr>
	  	</table>
	</form>
	  
	  <div id="DOWN">
	  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
	  </div>
	</div>
</body>
</html>
