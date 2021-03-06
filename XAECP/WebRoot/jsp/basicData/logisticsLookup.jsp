<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>物流供应商目录查看</title>
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
			var url='selectLogistics.action';
			var params={partnerId:partnerIdValue, async: false};
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
        	$("#lookupLogistics").attr("action", "lookupLogistics.action?currentPage="+currentPage);
        	$("#lookupLogistics").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#lookupLogistics").attr("action", "lookupLogistics.action?currentPage="+currentPage);
        	$("#lookupLogistics").submit();
		}
</script>
</head>

<body>
<div id="supply" class="CENTER">
<div id="top">
  <span style="color:#FFF;"><h2>物流供应商目录查看</h2></span>
</div>
    <form action="lookupLogistics.action" id="lookupLogistics" method="post">
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
            <td class="BORDER" align="left" colspan="2"><input name="blackList" id="blackListQuery" type="checkbox" value="true" />是否列入黑名单</td>
            <td colspan="2" align="right" class="BORDER">
            	<input type="submit" class="BUTTON" value="查询" />
                <input type="button" onclick="resetButtonClick()"  class="BUTTON" value="清空" />
            </td>
    	</tr>
    </table>
    </form>
    
    
    <form action="editLogistics.action" method="post" id="editLogistics">
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE" style="font-weight:bold;">
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
            <td><input type="button" class="BUTTON" name="<s:property value="#element.partnerId"/>" onclick="displayRegister(this)" value="详细"/></td>
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
        <td align="left"><b>&nbsp;物流供应商详细信息</b></td>
      </tr>
      <tr>
        <td><table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
          <tr>
            <td class="ALRIGHT">物流供应商代码&nbsp;</td>
            <td class="ALLEFT" id="partnerId"></td>
            <td class="ALRIGHT">物流供应商级别&nbsp;</td>
            <td class="ALLEFT" id="partnerLevel"></td>
          </tr>
          <tr>
            <td class="ALRIGHT">物流供应商名称&nbsp;</td>
            <td class="ALLEFT" id="partnerName"><s:property value="#request.logisticsItem.partnerName"/></td>
            <td class="ALRIGHT">是否列入黑名单&nbsp;</td>
            <td class="ALLEFT" id="blackList"><s:property value="#request.logisticsItem.blackList"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">第一地址&nbsp;</td>
            <td class="ALLEFT" id="firstAddress"><s:property value="#request.logisticsItem.firstAddress"/></td>
            <td class="ALRIGHT">联系人&nbsp;</td>
            <td class="ALLEFT" id="contactPerson"><s:property value="#request.logisticsItem.contactPerson"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">第二地址&nbsp;</td>
            <td class="ALLEFT" id="secondAddress"><s:property value="#request.logisticsItem.secondAddress"/></td>
            <td class="ALRIGHT">电话&nbsp;</td>
            <td class="ALLEFT" id="telephone"><s:property value="#request.logisticsItem.telephone"/></td>
          </tr>
       	  <tr>
            <td class="ALRIGHT">国家&nbsp;</td>
            <td class="ALLEFT" id="country"><s:property value="#request.logisticsItem.country"/></td>
            <td class="ALRIGHT">传真&nbsp;</td>
            <td class="ALLEFT" id="fax"><s:property value="#request.logisticsItem.fax"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">省/州&nbsp;</td>
            <td class="ALLEFT" id="province"><s:property value="#request.logisticsItem.province"/></td>
            <td class="ALRIGHT">Email地址&nbsp;</td>
            <td class="ALLEFT" id="email"><s:property value="#request.logisticsItem.email"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">城市&nbsp;</td>
            <td class="ALLEFT" id="city"><s:property value="#request.logisticsItem.city"/></td>
            <td class="ALRIGHT">邮政编码&nbsp;</td>
            <td class="ALLEFT" id="zipCode"><s:property value="#request.logisticsItem.zipCode"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">网址</td>
            <td class="ALLEFT" colspan="3" id="website"><s:property value="#request.logisticsItem.website"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">简介</td>
            <td class="ALLEFT" colspan="3" id="introduction"><s:property value="#request.logisticsItem.introduction"/></td>
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
