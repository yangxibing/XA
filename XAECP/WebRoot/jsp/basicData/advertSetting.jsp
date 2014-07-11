<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>广告位设置</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript">
	$().ready(function(){
		var up = "<%=request.getAttribute("upload")%>";
		if(up!=null&&up=="success"){
			alert("上传成功");
		}
	});
</script>
<style>
	#table{ clear:both;}
	#supply #search{ width:750px;}
	#supply #search .FILE{ width:400px;}
</style>

</head>

<body>
<div id="supply" class="CENTER">
<div id="top">
  <span style="color:#FFF;"><h2>广告位设置</h2></span>
</div>
	<form action="upload.action" method="post" id="upload" enctype="multipart/form-data">

<table id="table" class="CENTER">
<tr>
	<td>
    <table id="search" class="CENTER" cellspacing="0" cellpadding="2px" align="center">
        <tr>
        	<td  align="right">1号广告位</td>
            <td align="center"><input class="FILE" name="advertising1" type="file"/></td>
            <td >1003×61</td>
       </tr>
       <tr>
        	<td  align="right">2号广告位</td>
            <td align="center"><input class="FILE" name="advertising2" type="file"/></td>
            <td >195×43</td>
       </tr>
       <tr>
        	<td  align="right">3号广告位</td>
            <td align="center"><input class="FILE" name="advertising3" type="file"/></td>
            <td >682×61</td>
       </tr>
       <tr>
        	<td  align="right">4号广告位</td>
            <td align="center"><input class="FILE" name="advertising4" type="file"/></td>
            <td >318×57</td>
       </tr>
       <tr>
        	<td  align="right">5号广告位</td>
            <td align="center"><input class="FILE" name="advertising5" type="file"/></td>
            <td >318×57</td>
       </tr>
       <tr>
        	<td  align="right">6号广告位</td>
            <td align="center"><input class="FILE" name="advertising6" type="file"/></td>
            <td >318×57</td>
       </tr>
      </table>
     
      </td>
</tr>
<tr align="center">
	<td><input type="submit"  value="保存" class="BUTTON" />&nbsp;<input type="button" value="取消" class="BUTTON" />
    </td>     
</tr>
</table>
  </form>   
  <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
  </div>
</div>
</body>
</html>
