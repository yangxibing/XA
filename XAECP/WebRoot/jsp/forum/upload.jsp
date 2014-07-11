<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head><title>文件上传</title>
  </head>
  <center>
  <h1>Struts2 完成上传</h1>
  	<form action="upload.action" method="post" enctype="multipart/form-data">
  		<table>
  			<tr>
  				<td>用户名：</td>
  				<td><input type="text" name="username"></td>
  			</tr>
  			<tr>
  				<td>文件上传1：</td>
  				<td><input type="file" name="myFile"></td>
  			</tr>
  			<tr>
  				<td>文件上传2：</td>
  				<td><input type="file" name="myFile"></td>
  			</tr> 
  			<tr>
  				<td><input type="submit" value="上传"></td>
  				<td><input type="reset" value="重置"></td>
  			</tr>
  		</table>
  	</form>
  </center>
  <body>
  </body>
</html>
