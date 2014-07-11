<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>采购商目录查看</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/control/scripts/eye-base.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/control/scripts/eye-all.js"></script>

<script type="text/javascript"> 
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

		function displayRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "block";
        }
        
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        } 
        
		function displayRegister(valu) {
				var partnerIdValue=$(valu).attr("name");
				var url='selectPurchaser.action';
				var params={partnerId:partnerIdValue,async: false};
				$.post(url,params,callBackFunction,'json');
        }
        
        function callBackFunction(data){
			var datas=data.ajaxResult;
			var a=new Array();
			a=datas.split(",");
			var subMenu=document.getElementById("register");
           	subMenu.style.display = "block";
            $("#partnerId").text(a[0]);
            $("#partnerName").text(a[1]);
            $("#firstAddress").text(a[2]);
            $("#secondAddress").text(a[3]);
            $("#country").text(a[4]);
            $("#province").text(a[5]);
            $("#city").text(a[6]);            
            $("#website").text(a[7]);
            $("#introduction").text(a[8]);
            switch(a[9]){
            	case "0":
            		$("#partnerLevel").text("第0级");
            		break;
            	case "1":
            		$("#partnerLevel").text("第1级");
            		break;
            	case "2":
            		$("#partnerLevel").text("第2级");
            		break;
            	case "3":
            		$("#partnerLevel").text("第3级");
            		break;
            	case "4":
            		$("#partnerLevel").text("第4级");
            		break;
            	default:
            		$("#partnerLevel").text("第0级");
            }
            if(a[10]=="true"){
            	$("#blackList").text("是");
            }else{
            	$("#blackList").text("否");
            }
            $("#contactPerson").text(a[11]);
            $("#telephone").text(a[12]);
            $("#fax").text(a[13]);
            $("#email").text(a[14]);
            $("#zipCode").text(a[15]);
            $("#orderRate").text(a[16]);
           	//$("#addSupplier").attr("action","updateSupplier.action");
		}
		
		function resetButtonClick(){
			$("#partnerIdQuery").attr("value","");
			$("#partnerNameQuery").attr("value","");
			$("#cityQuery").attr("value","");
		}
		
		//分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#lookupPurchaser").attr("action", "lookupPurchaser.action?currentPage="+currentPage);
        	$("#lookupPurchaser").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
        	$("#lookupPurchaser").attr("action", "lookupPurchaser.action?currentPage="+currentPage);
        	$("#lookupPurchaser").submit();
		}
</script> 
 
<style>
	.ALRIGHT{ color:#A26D00;}
</style>
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
		  <span><h2>采购商目录查看</h2></span>
		</div>
		
	 	<form action="lookupPurchaser.action" id="lookupPurchaser" method="post">
		    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
		    	<tr class="TITLE">
		        	<td style="border-left-style:solid; border-width:1px; border-color:#FFF;"><b>组合条件查询</b></td>
		            <td colspan="5"></td>
		        </tr>
		        <tr>
		        	<td class="BORDER" align="right">采购商代码</td>
		            <td class="BORDER"><input name="partnerId" id="partnerIdQuery" type="text" class="INPUTTEXT"/></td>
		            <td class="BORDER" align="right">采购商名称</td>
		            <td class="BORDER"><input name="partnerName" id="partnerNameQuery" value="<s:property value="purchaser.partnerName"/>" type="text" class="INPUTTEXT"/></td>
		            <td class="BORDER" align="right">所在城市</td>
		            <td class="BORDER">
                		<input type="hidden" id="provinceInput"  class="INPUTTEXT" onClick="eye.selectCity.show('cityQuery', this);"/>
            			<input type="text" id="cityQuery" name="city" class="INPUTTEXT" onClick="eye.selectCity.show('provinceInput', this);" value="<s:property value="purchaser.city"/>"/>
            		</td>
		        </tr>
		        <tr>
		        	<td class="BORDER" align="right">采购商级别</td>
		            <td class="BORDER" align="left">
		            	<select name="partnerLevel" id="partnerLevelQuery">
		            		<option value="">--请选择--</option>
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
		                <input type="button" onclick="resetButtonClick()"  class="BUTTON" value="清空" />
		                &nbsp;&nbsp;
		            </td>
		    	</tr>
		    </table>
	    </form>
	    
	    <form  method="post" id="editPurchaser">
		    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
		    	<tr class="TITLE" style="font-weight:bold;">
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
		            	<td><s:property value="#element.firstAddress"/></td>
		            	<td><input type="button" id="detail" name="<s:property value="#element.partnerId"/>" onclick="displayRegister(this)" class="BUTTON" value="详细"/></td>
		        	</tr>
		        </s:iterator>
		        <tr>
		            <td colspan="7" align="right">
		            <input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
		            <span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
		            <input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />				
		            </td>
		        </tr>
		    </table>
	    </form>
	    
	  <table id="register" class="CENTER" cellpadding="0">
	      <tr class="TITLE">
	        <td align="left"><b>&nbsp;采购商信息</b></td>
	      </tr>
	      <tr>
	        <td><table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
	          <tr>
	            <td class="ALRIGHT">采购商代码&nbsp;</td>
	            <td class="ALLEFT" id="partnerId"></td>
	            <td class="ALRIGHT">采购商级别&nbsp;</td>
	            <td class="ALLEFT" id="partnerLevel"></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">采购商名称&nbsp;</td>
	            <td class="ALLEFT" id="partnerName"><s:property value="#request.purchaserItem.partnerName"/></td>
	            <td class="ALRIGHT">是否列入黑名单&nbsp;</td>
	            <td class="ALLEFT" id="blackList"><s:property value="#request.purchaserItem.blackList"/>
	               </td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">公司地址&nbsp;</td>
	            <td class="ALLEFT" id="firstAddress"><s:property value="#request.purchaserItem.firstAddress"/></td>
	            <td class="ALRIGHT">联系人&nbsp;</td>
	            <td class="ALLEFT" id="contactPerson"><s:property value="#request.purchaserItem.contactPerson"/></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">默认物流地址&nbsp;</td>
	            <td class="ALLEFT" id="secondAddress"><s:property value="#request.purchaserItem.secondAddress"/></td>
	            <td class="ALRIGHT">电话&nbsp;</td>
	            <td class="ALLEFT" id="telephone"><s:property value="#request.purchaserItem.telephone"/></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">国家&nbsp;</td>
	            <td class="ALLEFT" id="country"><s:property value="#request.purchaserItem.country"/></td>
	            <td class="ALRIGHT">传真&nbsp;</td>
	            <td class="ALLEFT" id="fax"><s:property value="#request.purchaserItem.fax"/></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">省/州&nbsp;</td>
	            <td class="ALLEFT" id="province"><s:property value="#request.purchaserItem.province"/></td>
	            <td class="ALRIGHT">Email地址&nbsp;</td>
	            <td class="ALLEFT" id="email"><s:property value="#request.purchaserItem.email"/></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">城市&nbsp;</td>
	            <td class="ALLEFT" id="city"><s:property value="#request.purchaserItem.city"/></td>
	            <td class="ALRIGHT">邮政编码&nbsp;</td>
	            <td class="ALLEFT" id="zipCode"><s:property value="#request.purchaserItem.zipCode"/></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">网址&nbsp;</td>
	            <td class="ALLEFT" id="website"><s:property value="#request.purchaserItem.website"/></td>
	            <td class="ALRIGHT">定金比率&nbsp;</td>
	            <td class="ALLEFT" id="orderRate"> <s:property value="#request.purchaserItem.orderRate"/></td>
	          </tr>
	          <tr>
	            <td class="ALRIGHT">简介&nbsp;</td>
	            <td class="ALLEFT" colspan="3" id="introduction"><s:property value="#request.purchaserItem.introduction"/></td>
	          </tr>
	        </table></td>
	      </tr>
	  </table>
	  
	  <div id="DOWN">
	  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
	  </div>
	  
	</div>
</body>
</html>
