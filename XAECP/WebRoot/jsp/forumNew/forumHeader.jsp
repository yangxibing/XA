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

<script type="text/javascript">
		$(document).ready(function(){
			currentTimeProcess();		
		});


		function jumpToPostPage() {
			if('<s:property value="#session.bbsUserId"/>' != null && '<s:property value="#session.bbsUserId"/>' != ""){
				//用户已经登录
				window.location.href="forumPublish.jsp";	
			} else {
				alert("请先登录！");
			}
		}

		//插入当前登录时间
		function currentTimeProcess(){
			var now = new Date();
		       
	        var year = now.getFullYear();       //年
	        var month = now.getMonth() + 1;     //月
	        var date = now.getDate();            //日

	        var day = "";
	        switch(now.getDay()){
        		case "0": day="日";break;		        
	        	case 1: day="一";break;
	        	case 2: day="二";break;
	        	case 3: day="三";break;
	        	case 4: day="四";break;
	        	case 5: day="五";break;
	        	case 6: day="六";break;
				default:  day="日";
		    }

	        $("#first").text(year+"年"+month+"月"+date+"日 星期"+day);
		}
</script>

</head>

<body>
<!--[if !IE]>-------------------------------------<![endif]-->
    <div id="daoHang" class="CENTER">   
        <ul id="navigation">
            <li id="first"><!-- 2012年12月12日 星期日 --></li>     
            <li><a href="../../home.jsp">基地首页</a></li>
            <li><a href="forumHome.jsp">论坛首页</a></li>
            <li><a href="forumHelp.jsp">新手须知</a></li>
            <li><a href="#" onclick="jumpToPostPage();">我要发帖</a></li>
           <!--  <li><a href="forumPublic.jsp">我要发帖</a></li> --> 
        </ul> 
    </div>
</body>
</html>