<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>物流供应商目录管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" src="../../javascript/inputTest/check.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/control/scripts/eye-base.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/control/scripts/eye-all.js"></script>
<script type="text/javascript"> 

		$().ready(function(){
				
				$("#partnerLevelQuery").attr("value",'<s:property value="#request.logisticsVO.partnerLevel"/>');	
					
				var check2='<s:property value="#request.logisticsVO.blackList"/>'
				if(check2=="true"){
					$("#blackListQuery").attr("checked",true);
				}
			});
		
		function displayRegister(valu) {
			if(($(valu).attr("value")) == "新建") {
				$("#partnerId").attr("disabled",false);
				$("#addLogistics").attr("action", "addLogistics.action");
				var subMenu=document.getElementById("register");
            	subMenu.style.display = "block";
            	$("#register :text").each( function() {
            		$(this).attr("value","");
            	});
            	$("#introduction").attr("value","");
			} else {
				$("#partnerId").attr("disabled",true);
				var partnerIdValue=$(valu).attr("name");
				var url='selectLogistics.action';
				var params={partnerId:partnerIdValue, async: false};
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
           	$("#addLogistics").attr("action","updateLogistics.action");
		}
        
        
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }
        
        
        function allSelected(){
        	if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='logisticsItem']").attr("checked",true);
        	}
        	else {
        		$("[name='logisticsItem']").attr("checked",false);
        	}
        }
        
        function deleteLogistics(){
        	var f_str="";
        	var count=0;
			$("[name='logisticsItem']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});
			if(confirm("你真的要删除这项么？")){
					$.post("deleteLogistics.action",{logisticsList:f_str},function(data){
						$("#listLogistics").attr("action","listLogistics.action");
						$("#listLogistics").submit();
					});
			}
        }
         
        function saveLogistics(){
        		var url=$("#addLogistics").attr("action");
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
				var provinceValue = $("#province").attr("value");		
				var emailValue=$("#email").attr("value");
				var cityValue = $("#city").attr("value");	
				var zipCodeValue=$("#zipCode").attr("value");
				var websiteValue=$("#website").attr("value");
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
					introduction:introductionValue,
					async: false};

			if(partnerAllCheck($("#partnerId"),$("#partnerName"),$("#firstAddress"),$("#secondAddress"),$("#website"),$("#introduction"),$("#contactPerson"),$("#telephone"),$("#fax"),$("#email"),$("#zipCode"))==false){
					return false;
			};
			if(url.split(".")[0]=="addLogistics"){
					
				$.post("selectPurchaser.action",{partnerId:partnerIdValue},function(data){
					if(data.ajaxResult !=="notExist"){
						alert("物流商代码已经存在，请使用其他代码");
						return false;
					}else{
						$.post(url,params, function(data){
							$("#listLogistics").attr("action","listLogistics.action");
							$("#listLogistics").submit();
						});
					}
				});
					
			}else{
				$.post(url,params, function(data){
					$("#listLogistics").attr("action","listLogistics.action");
					$("#listLogistics").submit();
				});
			}
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
        	$("#listLogistics").attr("action", "listLogistics.action?currentPage="+currentPage);
        	$("#listLogistics").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#listLogistics").attr("action", "listLogistics.action?currentPage="+currentPage);
        	$("#listLogistics").submit();
		}
        
</script>
</head>

<body>
<div id="supply" class="CENTER">
<div id="top">
  <span><h2>物流供应商目录管理</h2></span>
</div>
	<form action="listLogistics.action" id="listLogistics" method="post">
    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE">
        	<td><span class="TITLESPAN1">组合条件查询</span></td>
            <td colspan="5"></td>
        </tr>
        <tr>
        	<td class="BORDER" align="right">物流供应商代码</td>
            <td class="BORDER"><input name="partnerId" id="partnerIdQuery" type="text" class="INPUTTEXT" value="<s:property value='#request.logisticsVO.partnerId'/>"/></td>
            <td class="BORDER" align="right">物流供应商名称</td>
            <td class="BORDER"><input name="partnerName" id="partnerNameQuery" type="text" value="<s:property value='#request.logisticsVO.partnerName'/>" class="INPUTTEXT"/></td>
            <td class="BORDER" align="right">所在城市</td>
            <td class="BORDER">
                	<input type="hidden" id="provinceInput"  class="INPUTTEXT" onClick="eye.selectCity.show('cityQuery', this);"/>
            		<input type="text" id="cityQuery" name="city" class="INPUTTEXT" onClick="eye.selectCity.show('provinceInput', this);" value="<s:property value="#request.logisticsVO.city"/>"/>
            </td>
        </tr>
        <tr>
        	<td class="BORDER" align="right">物流供应商级别</td>
            <td class="BORDER" align="left">
            	<select name="partnerLevel" id="partnerLevelQuery">
            		<option value="">全部级别</option>
                	<option value="0">第0级</option>
                	<option value="1">第1级</option>
               	    <option value="2">第2级</option>
                	<option value="3">第3级</option>
                	<option value="4">第4级</option>
                </select>
            </td>
            <td class="BORDER" align="left" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="blackList" id="blackListQuery" type="checkbox" value="true" />是否列入黑名单</td>
            <td colspan="2" align="right" class="BORDER">
            	<input type="submit" class="BUTTON" value="查询" />
                <input type="button" onclick="resetButtonClick()" class="BUTTON" value="清空" />
            </td>
    	</tr>
    </table>
    </form>
    
    <form action="editLogistics.action" method="post" id="editLogistics">
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE" style="font-weight:bold;">
        	<td>选择</td>
            <td>级别</td>
            <td>物流供应商代码</td>
            <td>物流供应商名称</td>
            <td>网址</td>
            <td>是否列入黑名单</td>
            <td>地址</td>
            <td colspan="2">&nbsp;</td>
        </tr>
        
        <s:iterator id="element" value="#request.query">
        <tr class="HOVER">
        	<td ><input name="logisticsItem" type="checkbox" class="INPUTTEXT" value="<s:property value="#element.partnerId"/>" /></td>
            <td ><s:property value="#element.partnerLevel"/></td>
            <td ><s:property value="#element.partnerId"/></td>
            <td ><s:property value="#element.partnerName"/></td>
            <td><s:property value="#element.website"/></td>
            <td>
            	<s:if test="%{#element.blackList==true}">
            		√
            	</s:if>
            	<s:else>
           	    	×
           	    </s:else>
            </td>
            <td><s:property value="#element.firstAddress"/></td>
            <td><input type="button" class="BUTTON" name="<s:property value="#element.partnerId"/>" onclick="displayRegister(this)" value="编辑"/></td>
        </tr>
        </s:iterator>
        
        
        <tr>
        	<td><input name="allSelectBox" type="checkbox" onclick="allSelected()"/>全选</td>
        	<td><input type="button" class="BUTTON" onclick="deleteLogistics()" value="删除" />
        	<input type="button" class="BUTTON" onclick="displayRegister(this)" value="新建" /></td>
            <td colspan="6" align="right">
	            <input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	            <span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	            <input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
	        </td>
        </tr>
    </table>    
    </form>
    
    
  <form action="updateLogistics.action" method="post" id="addLogistics">
    
  <table id="register" class="CENTER" cellpadding="0">
      <tr class="TITLE">
        <td align="left"><span class="TITLESPAN1"><b>物流供应商信息</b></span> <span class="TITLESPAN2">注：<font color="#FF0000">*</font>为必填项</sapn></td>
      </tr>
      <tr>
        <td><table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
          <tr>
            <td class="ALRIGHT">物流供应商代码</td>
            <td class="ALLEFT"><input name="partnerId" id="partnerId" type="text" class="INPUTTEXT"/>
              <font color="#FF0000">*</font></td>
            <td class="ALRIGHT">物流供应商级别</td>
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
            <td class="ALRIGHT">物流供应商名称</td>
            <td class="ALLEFT"><input name="partnerName" id="partnerName" type="text" class="INPUTTEXT" /></td>
            <td class="ALRIGHT">是否列入黑名单</td>
            <td class="ALLEFT">
            	<input type="radio" name="blackList" id="blackListYes" />
                                     是
              <input type="radio" name="blackList" id="blackListNo" value="false" checked="checked"/>
                                     否</td>
          </tr>
          <tr>
            <td class="ALRIGHT">第一地址</td>
            <td class="ALLEFT"><input name="firstAddress" id="firstAddress" type="text" class="INPUTTEXT" /></td>
            <td class="ALRIGHT">联系人</td>
            <td class="ALLEFT"><input name="contactPerson" id="contactPerson" type="text" class="INPUTTEXT" /></td>
          </tr>
          <tr>
            <td class="ALRIGHT">第二地址</td>
            <td class="ALLEFT"><input name="secondAddress" id="secondAddress" type="text" class="INPUTTEXT"  /></td>
            <td class="ALRIGHT">电话</td>
            <td class="ALLEFT"><input name="telephone" id="telephone" type="text" class="INPUTTEXT" /></td>
          </tr>
          <tr>
            <td class="ALRIGHT">国家</td>
            <td class="ALLEFT">中国 </td>
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
            <td class="ALLEFT"><input type="text" id="city" class="INPUTTEXT" onClick="eye.selectCity.show('province', this);" /></td>
            <td class="ALRIGHT">邮政编码</td>
            <td class="ALLEFT"><input name="zipCode" id="zipCode" type="text" class="INPUTTEXT" /></td>
          </tr>
          <tr>
            <td class="ALRIGHT">网址</td>
            <td class="ALLEFT" colspan="3"><input style="width:400px;" name="website" id="website" type="text" class="INPUTTEXT"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">简介</td>
            <td class="ALLEFT" colspan="3"><textarea name="introduction" id="introduction" style="width:400px; height:40px;" ></textarea></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td align="center">
          <input type="button" class="BUTTON" onclick="saveLogistics()" value="保存" />
          <input type="reset" class="BUTTON" onclick="hideRegister()" value="取消" />
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

