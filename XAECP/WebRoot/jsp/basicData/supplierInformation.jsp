<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>供应商信息查看</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" >
$().ready(function(){
		var url='selectSupplier.action';
		var partnerIdValue = <%=request.getParameter("supplierId")%>;
		var params={partnerId:partnerIdValue,async: false};
		$.post(url,params,function(data){
			var datas=data.ajaxResult;
			var a=new Array();
			a=datas.split(",");
            $("#partnerId").text(a[0]);
            $("#partnerName").text(a[1]);
            $("#firstAddress").text(a[2]);
            $("#secondAddress").text(a[3]);
            $("#country").text(a[4]);
            $("#province").text(a[5]);
            $("#city").text(a[6]);
            $("#website").text(a[7]);
            $("#introduction").text(a[8]);
            if(a[9]=="true"){
            	$("#integrity").text("是");
            }else{
            	$("#integrity").text("否");
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
		});
	});

</script>

<style>
#supply #register{ clear:both; display:block;background-color:#FFF; border-width:0;}
#supply #register #registCnt{margin-top:10px;background-color:#C0DFFE;}
.ALRIGHT{ color:#A26D00;}
</style>
</head>

<body>
<div id="supply" class="CENTER">
<div id="top">
  <span><h2>供应商信息查看</h2></span>
</div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="0" cellspacing="0">
          <tr>
            <td class="ALRIGHT">供应商代码&nbsp;</td>
            <td class="ALLEFT" id="partnerId"></td>
            <td class="ALRIGHT" >是否诚信供应商&nbsp;</td>
            <td class="ALLEFT" id="integrity"></td>
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">供应商名称&nbsp;</td>
            <td class="ALLEFT" id="partnerName"></td>
            <td class="ALRIGHT">是否列入黑名单&nbsp;</td>
            <td class="ALLEFT" id="blackList">
          </tr>
          <tr>
            <td class="ALRIGHT">第一地址&nbsp;</td>
            <td class="ALLEFT" id="firstAddress"></td>
            <td class="ALRIGHT">联系人&nbsp;</td>
            <td class="ALLEFT" id="contractPersion"></td>
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">第二地址&nbsp;</td>
            <td class="ALLEFT" id="secondAddress"></td>
            <td class="ALRIGHT">电话&nbsp;</td>
            <td class="ALLEFT" id="telephone"></td>
          </tr>
          <tr>
            <td class="ALRIGHT">国家&nbsp;</td>
            <td class="ALLEFT" id="country"></td>
            <td class="ALRIGHT">传真&nbsp;</td>
            <td class="ALLEFT" id="fax"></td>
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">省/州&nbsp;</td>
            <td class="ALLEFT" id="province"></td>
            <td class="ALRIGHT">Email地址&nbsp;</td>
            <td class="ALLEFT" id="email"></td>
          </tr>
          <tr>
            <td class="ALRIGHT">城市&nbsp;</td>
            <td class="ALLEFT" id="city"></td>
            <td class="ALRIGHT">邮政编码&nbsp;</td>
            <td class="ALLEFT" id="zipCode"></td>
          </tr>
          <tr class="EEE">
            <td class="ALRIGHT">网址&nbsp;</td>
            <td class="ALLEFT" colspan="3" id="website"></td>
          </tr>
          <tr>
            <td class="ALRIGHT">简介&nbsp;</td>
            <td class="ALLEFT" colspan="3" id="introduction"></td>
          </tr>
        </table></td>
      </tr>
  </table>
<div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
</div>
</div>
</body>
</html>
