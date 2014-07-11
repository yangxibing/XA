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
<script language="javascript" src="../../javascript/inputTest/check.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/control/scripts/eye-base.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/control/scripts/eye-all.js"></script>
<script type="text/javascript">
	$().ready(function(){
		
		var check='<s:property value="supplier.integrity"/>'
		if(check=="true"){
			$("#integrity").attr("checked",true);
		}
		
		var check2='<s:property value="supplier.blackList"/>'
		if(check2=="true"){
			$("#blackList").attr("checked",true);
		}
	});
		
		function displayRegister(valu) {    
           
            if(($(valu).attr("value"))=="新建"){
				$("#addSupplier").attr("action","addSupplier.action");
				var subMenu=document.getElementById("register");
           		 subMenu.style.display = "block";
           		 $("#register :text").each(function(){
           		 	$(this).attr("value","");
           		 });
           		 $("#introduction").attr("value","");
           		 $("#partnerId").attr("disabled",false);
			}if($(valu).attr("value")=="编辑"){
				
				var partnerIdValue=$(valu).attr("name");
				var url='selectSupplier.action';
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
            $("#partnerId").attr("disabled",true);
            $("#partnerName").attr("value",a[1]);
            $("#firstAddress").attr("value",a[2]);
            $("#secondAddress").attr("value",a[3]);
			$("#province").attr("value",a[5]);
            $("#city").attr("value",a[6]);
            $("#website").attr("value",a[7]);
            $("#introduction").attr("value",a[8]);
            if(a[9]=="true"){
            	$("#integrityYes").attr("checked",true);
            }else{
            	$("#integrityNo").attr("checked",true);
            }
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
           	$("#addSupplier").attr("action","updateSupplier.action");
		}
		function save(){
				var id=$("#partnerId").attr("value");
				var name=$("#partnerName").attr("value");
				var first=$("#firstAddress").attr("value");
				var second=$("#secondAddress").attr("value");
				var country = "中国";
				var province=$("#province").attr("value");;
				var city=$("#city").attr("value");
				var website=$("#website").attr("value");
				var zipCode=$("#zipCode").attr("value");
				var integrity;
				if($("#integrityYes").attr("checked")==true){
					integrity=true;
				}else{integrity =false;}
				var blackList;
				if($("#blackListYes").attr("checked")==true){
					blackList=true;
				}else{blackList =false;}
				var contactPerson=$("#contactPerson").attr("value");
				var telephone=$("#telephone").attr("value");
				var fax=$("#fax").attr("value");
				var email=$("#email").attr("value");
				var introduction=$("#introduction").attr("value");
				var partnerType = 0;
				//checkPartnerId($("#partnerId"));
				if(id==null||id.length==0){
					alert("请输入供应商代码");
					return false;
				}
				//验证输入
				if(partnerAllCheck($("#partnerId"),$("#partnerName"),$("#firstAddress"),$("#secondAddress"),$("#website"),$("#introduction"),$("#contactPerson"),$("#telephone"),$("#fax"),$("#email"),$("#zipCode"))==false){
					return false;
				};
				var params={partnerId:id,partnerName:name,firstAddress:first,secondAddress:second,country:country,province:province,city:city,website:website,introduction:introduction,integrity:integrity,blackList:blackList,contactPerson:contactPerson,telephone:telephone,fax:fax,email:email,zipCode:zipCode,partnerType:0};
				
				var url=$("#addSupplier").attr("action");
				if(url.split(".")[0]=="addSupplier"){
					$.post("selectSupplier.action",{partnerId:id},function(data){
						if(data.ajaxResult != "notExist"){
							alert("供应商代码已经存在");
							return false;
						}else{
							$.post(url,params,function(data){
								listSupplier();
           		 			});
						}
					});
				}else{
					$.post(url,params,function(data){
						listSupplier();
           		 	});
				}
				
		}
		function saveAndNew(){
			save();
		}
		function hideRegister() {    
            var subMenu=document.getElementById("register");
            subMenu.style.display = "none";
            if($(this).attr("value")=="保存"){
            	$("#addSupplier").submit();
            }
        }   
        function allSelected(valu){
        	if($(valu).attr("checked")==true){
        		$("input[name='deleteSup']").each(function(){
        			$(this).attr("checked",true);
        		});
        	}else{
        		$("input[name='deleteSup']").each(function(){
        			$(this).attr("checked",false);
        		});
        	}
        }
        function deleteSupplier(){
        	var f_str="";
        	var count=0;
			$("[name='deleteSup']").each(function(){
  				 if($(this).attr("checked")==true){
   					 f_str +=$(this).attr("value")+",";
   					 count++;
  				 }
			});
			if(confirm("你真的要删除这项么？")){
					$.post("deleteSupplier.action",{supplierList:f_str},function(data){
						$("#listSupplier").attr("action","listSupplier.action");
						$("#listSupplier").submit();
					});
			}
        }
        
        function listSupplier(){
        	$("#listSupplier").attr("action","listSupplier.action");
        	$("#listSupplier").submit();
        }
        
        function productDetail(valu){
        	var value=$(valu).attr("name");
        	$("#productDetailForm").attr("action","listSupplierProduct.action");
        	$("#detailP").attr("value",value);
        	$("#productDetailForm").submit();
        }


		//分页处理
        function prePage(){
        	var currentPage = Number($("#currentPageTag").text());
        	var totalPage = Number($("#totalPageTag").text());
        	if(currentPage<=1){
        		return false;
        	}
        	currentPage = currentPage - 1;
        	$("#listSupplier").attr("action", "listSupplier.action?currentPage="+currentPage);
        	$("#listSupplier").submit();
        }

		function nextPage(){
			var currentPage = Number($("#currentPageTag").text()); 	
			var totalPage = Number($("#totalPageTag").text());
			if(currentPage>=totalPage){
				return false;
			}
			currentPage = currentPage + 1;
			$("#listSupplier").attr("action", "listSupplier.action?currentPage="+currentPage);
        	$("#listSupplier").submit();
		}
       
</script>  

</head>

<body>
<form id="selectSupplier"></form>
<form id="productDetailForm"><input type="hidden" name="supplierId" id="detailP"/></form>
<div id="supply" class="CENTER">
<div id="top">
  <span><h2>供应商目录管理</h2></span>
</div>
	<form  method="post" id="listSupplier">
    <table id="search" class="CENTER" cellspacing="0" cellpadding="0" width="800" height="74">
    	<tr class="TITLE">
        	<td><b>组合条件查询</b></td>
            <td colspan="5"></td>
        </tr>
        <tr>
        	<td class="BORDER" align="right">供应商代码</td>
            <td class="BORDER"><input type="text" name="partnerId" class="INPUTTEXT" value="<s:property value="supplier.partnerId"/>" onblur="checkPartnerId(this)"/></td>
            <td class="BORDER" align="right">供应商名称</td>
            <td class="BORDER"><input type="text" name="partnerName" class="INPUTTEXT" value="<s:property value="supplier.partnerName"/>" onblur="checkPartnerName(this)"/></td>
            <td class="BORDER" align="right">所在城市</td>
            <td class="BORDER">
                <input type="hidden" id="provinceInput"  class="INPUTTEXT" onClick="eye.selectCity.show('cityInput', this);"/>
            	<input type="text" id="cityInput" name="city" class="INPUTTEXT" onClick="eye.selectCity.show('provinceInput', this);" value="<s:property value="supplier.city"/>"/>
            </td>
        </tr>
        <tr>
        	<td class="BORDER" align="right">
        		<input type="checkbox" name="integrity" value="true" id="integrity"/>是否诚信
        	</td>
            <td class="BORDER" align="right">
            	<input type="checkbox"  name="blackList" value="true" id="blackList"/>是否列入黑名单
            </td>
            <td colspan="4" align="right" class="BORDER">
            	<input type="button" class="BUTTON" onClick="listSupplier()" value="查询" />
                <input type="button" class="BUTTON" value="清空" />
            </td>
    	</tr>
    </table>
    </form>
    <table id="showlist" class="CENTER" cellspacing="0" cellpadding="0">
    	<tr class="TITLE" style="font-weight:bold;">
        	<td>选择</td>
            <td>诚信级别</td>
            <td>供应商代码</td>
            <td>供应商名称</td>
            <td>是否诚信</td>
            <td>是否列入黑名单</td>
            <td>地址</td>
            <td colspan="2">&nbsp;</td>
        </tr>
        <s:iterator id="element" value="#request.query">
        	<tr class="HOVER">
        		<td ><input type="checkbox" class="INPUTTEXT" name="deleteSup" value="<s:property value='#element.partnerId'/>"/></td>
          	    <td ><s:property value="#element.integrityLevel"/></td>
           	    <td ><s:property value="#element.partnerId"/></td>
           	    <td ><s:property value="#element.partnerName"/></td>
           	    <td><s:if test="%{#element.integrity==true}">
           	    		<input type="checkbox" class="INPUTTEXT" checked="checked" disabled/>
           	    	</s:if>
           	    	<s:else>
           	    		<input type="checkbox" class="INPUTTEXT" disabled/> 
           	    	</s:else>
           	    </td>
           	    <td><s:if test="%{#element.blackList==true}">
           	    		<input type="checkbox" class="INPUTTEXT" checked="checked" disabled/>
           	    	</s:if>
           	    	<s:else>
           	    		<input type="checkbox" class="INPUTTEXT" disabled/>
           	    	</s:else>
           	    	</td>
            	<td><s:property value="#element.firstAddress"/></td>
            	<td><input type="button" class="BUTTON" name="<s:property value='#element.partnerId'/>" onclick="displayRegister(this)"  value="编辑"/></td>
            	<td><input type="button" class="BUTTON" name="<s:property value='#element.partnerId'/>"  onClick="productDetail(this)"  value="产品明细"/></td>
        	</tr>
        </s:iterator>
        
        <tr>
        	<td><input type="checkbox" onClick="allSelected(this)" />全部选中</td>
            <td><input type="button" class="BUTTON" name="删除"  onclick="deleteSupplier()" value="删除"/></td>
            <td><input type="button" class="BUTTON" name="新建" onclick="displayRegister(this)" value="新建" /></td>
            <td colspan="4" class="UPBOD"></td>
            <td colspan="2">
            	<input type="button" onclick="prePage();" class="BUTTON" value="上一页" />
	        	<span id="currentPageTag"><s:property value="#request.currentPage"/></span>/<span id="totalPageTag"><s:property value="#request.totalPage"/></span>
	        	<input type="button" onclick="nextPage();" class="BUTTON" value="下一页" />	
	        </td>
        </tr>
    </table>
  <form  method="post" id="addSupplier">
  <table id="register" class="CENTER" cellpadding ="0">
      <tr class="TITLE">
        <td align="left"><b>供应商信息</b> 注：<font color="#FF0000">*</font>为必填项</td>
      </tr>
      <tr>
        <td><table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
          <tr>
            <td class="ALRIGHT" >供应商代码</td>
            <td class="ALLEFT"><input name="partnerId" id="partnerId" type="text" class="INPUTTEXT"/>
              <font color="#FF0000">*</font></td>
            <td class="ALRIGHT">是否诚信供应商</td>
            <td class="ALLEFT">
            	<input type="radio" name="integrity"  id="integrityYes" checked="checked" value="true"/>是
                <input type="radio" name="integrity" id="integrityNo" value="false"/>否 
            </td>
          </tr>
          <tr>
            <td class="ALRIGHT">供应商名称</td>
            <td class="ALLEFT"><input type="text"  name="partnerName" id="partnerName" class="INPUTTEXT"/></td>
            <td class="ALRIGHT">是否列入黑名单</td>
            <td class="ALLEFT"><input type="radio" id="blackListYes" name="blackList" value="true"/>
              是
              <input type="radio" name="blackList" id="blackListNo" value="false" checked="checked"/>
              否 </td>
          </tr>
          <tr>
            <td class="ALRIGHT">第一地址</td>
            <td class="ALLEFT"><input type="text" name="firstAddress"  id="firstAddress" class="INPUTTEXT"/></td>
            <td class="ALRIGHT">联系人</td>
            <td class="ALLEFT"><input type="text" name="contactPerson" id="contactPerson" class="INPUTTEXT"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">第二地址</td>
            <td class="ALLEFT"><input type="text" name="secondAddress"  id="secondAddress" class="INPUTTEXT"/></td>
            <td class="ALRIGHT">电话</td>
            <td class="ALLEFT"><input type="text" name="telephone" id="telephone" class="INPUTTEXT"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">国家</td>
            <td class="ALLEFT">中国
           </td>
            <td class="ALRIGHT" >传真</td>
            <td class="ALLEFT"><input name="fax" type="text"  id="fax" class="INPUTTEXT"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">省/州</td>
            <td class="ALLEFT">
            	<input type="text" id="province" class="INPUTTEXT"  onClick="eye.selectCity.show(this, 'city');"/>
            </td>
            <td class="ALRIGHT">Email地址</td>
            <td class="ALLEFT"><input type="text" name="email" id="email" class="INPUTTEXT"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">城市</td>
            <td class="ALLEFT"><input type="text" id="city" class="INPUTTEXT" onClick="eye.selectCity.show('province', this);" />
            </td>
            <td class="ALRIGHT">邮政编码</td>
            <td class="ALLEFT"><input type="text" name="zipCode"  id="zipCode" class="INPUTTEXT"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">网址</td>
            <td class="ALLEFT" colspan="3"><input style="width:400px;" name="website"  id="website" type="text" class="INPUTTEXT"/></td>
          </tr>
          <tr>
            <td class="ALRIGHT">简介</td>
            <td class="ALLEFT" colspan="3"><textarea name="textarea" name="introduction" id="introduction" style="width:400px; height:40px;"></textarea></td>
          	
          </tr>
        </table></td>
      </tr>
      <tr>
        <td align="center"><input type="button" onclick="save()" class="BUTTON" value="保存" />
          <input type="button" class="BUTTON" onclick="hideRegister(this)" value="取消" /></td>
      </tr>
  </table>
  </form>
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
