<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head><title>�ļ��ϴ�</title>
  </head>
  <center>
  <h1>Struts2 ����ϴ�</h1>
  	<form action="upload.action" method="post" enctype="multipart/form-data">
  		<table>
  			<tr>
  				<td>�û�����</td>
  				<td><input type="text" name="username"></td>
  			</tr>
  			<tr>
  				<td>�ļ��ϴ�1��</td>
  				<td><input type="file" name="myFile"></td>
  			</tr>
  			<tr>
  				<td>�ļ��ϴ�2��</td>
  				<td><input type="file" name="myFile"></td>
  			</tr> 
  			<tr>
  				<td><input type="submit" value="�ϴ�"></td>
  				<td><input type="reset" value="����"></td>
  			</tr>
  		</table>
  	</form>
  </center>
  <body>
  </body>
</html>
