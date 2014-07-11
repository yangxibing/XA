<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>评标委员会专家管理</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>

<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript"> 
		window.onload = function(){
			recoverSearchState();
		}
		
		function recoverSearchState(){
			$("#workUnitQuery").attr("value", $("#workUnitConvertHidden").attr("value"));
			$("#titleQuery").attr("value", $("#titleConvertHidden").attr("value"));
			$("#minAgeQuery").attr("value", $("#minAgeConvertHidden").attr("value"));
			$("#maxAgeQuery").attr("value", $("#maxAgeConvertHidden").attr("value"));
		}

		function displayRegister(valu) { 
			$("#changePhotoTag").attr("value", "false");   
		    if(($(valu).attr("value"))=="新建"){
				$("#addUpdateExpert").attr("action","addExpert.action");
				var subMenu=document.getElementById("register");
		   		 subMenu.style.display = "block";
		   		 $("#register :text").each(function(){
		   		 	$(this).attr("value","");
		   		 });
		   		 $("#photograph").attr("value", "");
		   		 $("#personalProfile").attr("value", "");
			}else{		
				var expertIdValue=$(valu).attr("name");
				var url='getExpertById.action';
				var params={expertId:expertIdValue,async: false};
				$.post(url,params,callBackFunction,'json');
			} 
		}
		
        function callBackFunction(data){
			var datas=data.ajaxResult;
			var a=new Array();
			a=datas.split(",");
			var subMenu=document.getElementById("register");
           	subMenu.style.display = "block";
            $("#expertId").attr("value",a[0]);
            $("#expertName").attr("value",a[1]);
            $("#birthday").attr("value",a[2]);
            $("#workUnit").attr("value",a[3]);
            $("#title").attr("value",a[4]);
            $("#personalProfile").attr("value",a[5]);
            $("#photograph").attr("value",a[6]);
            $("#telephone").attr("value",a[7]);
            $("#fax").attr("value",a[8]);
            $("#email").attr("value",a[9]);
            $("#website").attr("value",a[10]);
           	$("#addUpdateExpert").attr("action","updateExpert.action");
		}
		
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
        }

        function allSelected(){
        	if($("[name='allSelectBox']").attr("checked")==true){
        		$("[name='expertItem']").attr("checked",true);
        	}
        	else {
        		$("[name='expertItem']").attr("checked",false);
        	}
        }
        
        function deleteExpert(){
        	var f_str="";
        	var count=0;
			$("[name='expertItem']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});

			if(count > 0){
				if(confirm("你真的要删除这些项么？")){
					$.post("deleteExpert.action",{expertList:f_str},function(data){
						$("#queryExpert").attr("action","queryExpert.action");
						$("#queryExpert").submit();
					});
				}
			} else {
				alert("未选中任何项！");
			}
        }
        
		function saveExpert(){
    		var url=$("#addUpdateExpert").attr("action");
    		var expertIdValue=$("#expertId").attr("value");
			var expertNameValue=$("#expertName").attr("value");
			var birthdayValue=$("#birthday").attr("value");
			var workUnitValue=$("#workUnit").attr("value");
			var titleValue=$("#title").attr("value");
			var personalProfileValue=$("#personalProfile").attr("value");
			var telephoneValue=$("#telephone").attr("value");
			var photographValue=$("#photograph").attr("value");
			var faxValue=$("#fax").attr("value");	
			var emailValue=$("#email").attr("value");
			var websiteValue=$("#website").attr("value");
			var changePhotoTagValue=$("#changePhotoTag").attr("value");
			var params={expertId:expertIdValue,
					expertName:expertNameValue,
					birthday:birthdayValue,
					workUnit:workUnitValue,
					title:titleValue,
					personalProfile:personalProfileValue,
					telephone:telephoneValue,
					photograph:photographValue,
					fax:faxValue,
					email:emailValue,
					website:websiteValue,
					changePhotoTag:true,
					async: false};
		$.post(url,params,function(data){
			$("#queryExpert").submit();
		});
	}

	function changePhoto(){
		$("#changePhotoTag").attr("value", "true");
	}
	
        //分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#queryExpert").attr("action", "queryExpert.action?currentPage="+currentPage);
        	$("#queryExpert").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#queryExpert").attr("action", "queryExpert.action?currentPage="+currentPage);
        	$("#queryExpert").submit();
		}	
</script>  
</head>

<body>

<input type="hidden" name="workUnitConvert" id="workUnitConvertHidden" value="<s:property value="#request.expertVO.workUnit"/>"/>
<input type="hidden" name="titleConvert" id="titleConvertHidden" value="<s:property value="#request.expertVO.title"/>"/>
<input type="hidden" name="minAgeConvert" id="minAgeConvertHidden" value="<s:property value="#request.expertVO.minAge"/>"/>
<input type="hidden" name="maxAgeConvert" id="maxAgeConvertHidden" value="<s:property value="#request.expertVO.maxAge"/>"/>

<div id="supply" class="CENTER">

	<div id="top">
		<span><h2>评标委员会专家管理</h2></span>
	</div>

	<form action="getExpertById.action" id="getExpertById"></form>
	
	<form action="queryExpert.action" id="queryExpert" method="post">
	    <table id="search" class="CENTER" cellspacing="0" cellpadding="0">
	    	<tr class="TITLE">
	        	<td ><b>&nbsp;组合条件查询</b></td>
	            <td colspan="7"></td>
	        </tr>
	        <tr>
	        	<td class="BORDER" align="right">专家工作单位</td>
	            <td class="BORDER"><input type="text" name="workUnit" id="workUnitQuery" class="INPUTTEXT"/></td>
	            <td class="BORDER" align="right">专家职称</td>
	            <td class="BORDER"><input type="text" name="title" id="titleQuery" class="INPUTTEXT"/></td>
	            <td class="BORDER" align="right">年龄区间</td>
	            <td class="BORDER" colspan="3">
	            	&nbsp;<input type="text" name="minAge" id="minAgeQuery" style="width:50px;" class="INPUTTEXT"/>
	            	&nbsp;到&nbsp;
	            	<input type="text" name="maxAge" id="maxAgeQuery" style="width:50px;" class="INPUTTEXT"/>
	            </td>
	        </tr>
	        <tr>
	            <td colspan="8" align="right" class="BORDER">
	            	<input type="submit" id="querySubmit" class="BUTTON" value="查询" />
	                <input type="reset" class="BUTTON" value="清空" />
	                &nbsp;&nbsp;&nbsp;&nbsp;
	            </td>
	    	</tr>
	    </table>
    </form>
    
    <form action="deleteExpert.action" id="deleteExpert"></form>
    
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE" style="font-weight:bold;">
        	<td>选择</td>
            <td>专家代码</td>
            <td>专家姓名</td>
            <td>职称</td>
            <td>工作单位</td>
            <td>电话</td>
            <td>Email</td>
            <td>&nbsp;</td>
        </tr>
 	    <s:iterator id="element" value="#request.query">
        	<tr class="HOVER">
        		<td ><input name="expertItem" type="checkbox" class="INPUTTEXT" value="<s:property value="#element.expertId"/>"/></td>
          	    <td ><s:property value="#element.expertId"/></td>
           	    <td ><s:property value="#element.expertName"/></td>
           	    <td ><s:property value="#element.title"/></td>
           	    <td ><s:property value="#element.workUnit"/></td>
				<td ><s:property value="#element.telephone"/></td>
            	<td>id<s:property value="#element.email"/></td>
            	<td><input type="button" class="BUTTON" name="<s:property value="#element.expertId"/>" onclick="displayRegister(this)" value="编辑"/></td>
        	</tr>
        </s:iterator>
        <tr>
        	<td><input type="checkbox" name="allSelectBox" onclick="allSelected()"/>全部选中</td>
            <td><input type="button" class="BUTTON" onclick="deleteExpert()" value="删除" /></td>
            <td><input type="button" class="BUTTON" onclick="displayRegister(this)" value="新建" /></td>
            <td colspan="5" align="right">
            	<input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
            	<span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
            	<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />
            </td>
        </tr>
    </table>
  <form id="addUpdateExpert" action="" method="post" enctype="multipart/form-data">
	  <table id="register" class="CENTER" cellpadding="0" cellspacing="0">
	      <tr class="TITLE">
	      	<td align="left">&nbsp;<span class="TITLESPAN1">评标委员会专家信息</span> <span class="TITLESPAN2">注：<font color="#FF0000">*</font>为必填项</span></td>
	      </tr>
	      <tr>
	        <td>
	            <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
	              <tr>
	                <td class="ALRIGHT">专家代码</td>
	                <td class="ALLEFT"><input type="text" class="INPUTTEXT" name="expertId" id="expertId" />
	                  <font color="#FF0000">*</font></td>
	                <td class="ALRIGHT">出生年月</td>
	                <td class="ALLEFT"><input type="text" class="INPUTTEXT" name="birthday" id="birthday" onclick="WdatePicker();"/>      
	                </td>
	              </tr>
	              <tr>
	                <td class="ALRIGHT">专家姓名</td>
	                <td class="ALLEFT"><input type="text" class="INPUTTEXT" name="expertName" id="expertName" /></td>
	                <td class="ALRIGHT">工作单位</td>
	                <td class="ALLEFT"><input type="text" class="INPUTTEXT" name="workUnit" id="workUnit" /></td>
	              </tr>
	              <tr>
	                <td class="ALRIGHT">职称</td>
	                <td class="ALLEFT"><input type="text" class="INPUTTEXT" name="title" id="title" value/></td>
	                <td class="ALRIGHT">照片</td>
	                <td class="ALLEFT">
	                <!--  
						<input type="hidden" name="changePhotoTag" id="changePhotoTag" value="true" />
	                    <div style="position:relative; left:0px;">
	                    <span style="margin-left:100px;width:18px;overflow:hidden;">
	                    <input type="file" style="width:227px;margin-left:-100px" id="setProvinceFather" onchange="this.parentNode.nextSibling.value=this.value" />
	                    </span><input type="text" name="photograph" id="photograph" style="width:149px; height:14px; position:absolute;left:0;" value=""/>
						</div>
					-->
						<input class="FILE" style="width:257px;" name="photograph" id="photograph" type="file"/>
	                </td>
	              </tr>
	              <tr>
	                <td class="ALRIGHT">电话</td>
	                <td class="ALLEFT"><input type="text" class="INPUTTEXT" name="telephone" id="telephone" /></td>
	                <td class="ALRIGHT">传真</td>
	                <td class="ALLEFT"><input type="text" class="INPUTTEXT" name="fax" id="fax" /></td>
	              </tr>
	              <tr>
	                <td class="ALRIGHT">Email</td>
	                <td class="ALLEFT"><input type="text" class="INPUTTEXT" name="email" id="email" /></td>
	                <td class="ALRIGHT">网址</td>
	                <td class="ALLEFT"><input type="text" class="INPUTTEXT" name="website" id="website" /></td>
	              </tr>
	              <tr>
	                <td class="ALRIGHT">个人简况</td>
	                <td class="ALLEFT" colspan="3"><textarea name="personalProfile" id="personalProfile" style="width:400px; height:40px;" ></textarea></td>
	              </tr>
	            </table>
	      	</td>
	      </tr>
	      <tr>
	        <td align="center">
	        	<!--  <input type="button" onclick="saveExpert(this)" class="BUTTON" value="保  存" /> -->
	        	<input type="submit" class="BUTTON" value="保  存" />
	          	<input type="reset" class="BUTTON" onclick="hideRegister()" value="取  消" />
	        </td>
	      </tr>
	  </table>
  </form>
  <div class="EMPTYDIV"></div>
  
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onclick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>



