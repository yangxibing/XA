<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>论坛</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/luntanHome.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script type="text/javascript" language="javascript" src="../../javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	function clearArticleContent() {
		$("[name='editor1']").text("");
	}
	function publishTitle() {
		var content = CKEDITOR.instances.editor1.getData();
		var subjectTitleValue = $("#forumTitle").attr("value");
		var url = $("#publishForumForm").attr("action");
		$.post(url, {subjectTitle:subjectTitleValue, subjectContent:content}, funPublishTitleSuccess,'json');
	}

	function funPublishTitleSuccess(data) {
		var result = data.ajaxResultCode;
		if(result == "success") {
			alert("发帖成功");
			window.location.href="forumHome.jsp";
		}
		
	}
</script>

<style>
	#public{ width:920PX; border: solid #A0CFFE; border-width:1px 1px 0 0; margin-bottom:20PX;}
	#public .ALRIGHT{ padding-right:5px; width:100PX; border: solid #A0CFFE; border-width:0 0 1px 1px; text-align:right; font-size:12px; font-weight:bold;}
	#public .ALLEFT{ padding:5PX; border: solid #A0CFFE; border-width:0 0 1px 1px;}
	#forumTitle{ width:500px;}
</style>

</head>

<body>
<div id="whole" class="CENTER">
    <div id="logo" class="CENTER">
    	<img src="../../images/luntan.jpg" align="left"/>
    </div>
<!--[if !IE]>-------------------------------------<![endif]-->
    <div id="daoHang" class="CENTER">   
        <ul id="navigation">
            <li>2012年12月12日 星期日</li>     
            <li><a href="../../home.jsp">基地首页</a></li>
            <li><a href="forumHome.jsp">论坛首页</a></li>
            <li><a href="#">新手须知</a></li>
            <li><a href="#">我要发帖</a></li>
        </ul> 
    </div>
    
    <form action="publishForum.action" method="post" id="publishForumForm">
    <table class="CENTER" id="public" cellpadding="0" cellspacing="0">
        
    	<tr>
    		<td class="ALRIGHT">文章标题</td>
            <td class="ALLEFT"><input type="text" id="forumTitle" name="subjectTitle"/></td>
        </tr>
    
    	<tr>
        	<td class="ALRIGHT">文章内容</td>
        	<td class="ALLEFT">
                <textarea  rows="5" cols="10" name="editor1"></textarea>
                <script type="text/javascript" language="javascript">
                    CKEDITOR.replace("editor1",
                    {
                        toobar:'Basic',
                        uiColor:'#DEF'
                    });
                </script>
             </td>
         </tr>
         
         <tr>
         	<td class="ALRIGHT"></td>
         	<td class="ALLEFT">
            	<input type="button" class="BUTTON" onclick="publishTitle();"value="发表帖子"/>
                <input type="reset" class="BUTTON" value="&nbsp;重写&nbsp;" onclick="clearArticleContent()"/>
            </td>
         </tr>
    </table>
    </form>
    <div id="copyRight" class="CENTER">
        <p align="center">西安印刷包装产业基地版权所有Copyright&copy;2011-2016</p>
        <p align="center">服务热线：029-8966866</p>
    </div>
</div>
</body>
</html>

