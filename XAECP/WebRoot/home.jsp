<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>西安印刷包装行业信息发布及集中采购网站</title>
<link href="css/global.css" rel="stylesheet" type="text/css"/>
<link href="css/home.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="javascript/jquery-1.5.2.min.js"></script>

<script type="text/javascript" language="javascript">    
        function displaySubMenu(li) {    
            var subMenu = li.getElementsByTagName("ul")[0];    
            subMenu.style.display = "block";
        }    
        function hideSubMenu(li) {    
            var subMenu = li.getElementsByTagName("ul")[0];    
            subMenu.style.display = "none";    
        }
		window.onload = function(){
		var pdome = document.getElementById("priceDome");
		var pdome1 = document.getElementById("priceDome1");
		var pdome2 = document.getElementById("priceDome2");
		pdome2.innerHTML = pdome1.innerHTML;
		
		function pmarquee(){
			pdome.scrollTop = (pdome.scrollTop<=pdome1.scrollHeight)?pdome.scrollTop+1:1;
			}
		var pmarTime = window.setInterval(pmarquee,50);
		pdome.onmouseover = function(){ window.clearInterval(pmarTime)}
		pdome.onmouseout = function(){ pmarTime = window.setInterval(pmarquee,50)}		
			
			
		var cdome = document.getElementById("caiGouDome");
		var cdome1 = document.getElementById("caiGouDome1");
		var cdome2 = document.getElementById("caiGouDome2");
		cdome2.innerHTML = cdome1.innerHTML;
		
		function cmarquee(){
			cdome.scrollTop = (cdome.scrollTop<=cdome1.scrollHeight)?cdome.scrollTop+1:1;
			}
		var cmarTime = window.setInterval(cmarquee,50);
		cdome.onmouseover = function(){ window.clearInterval(cmarTime)}
		cdome.onmouseout = function(){ cmarTime = window.setInterval(cmarquee,50)}
		
		////////////////////////////////////////////////////////////////////
		var jdome = document.getElementById("joinDome");
		var jdome1 = document.getElementById("joinDome1");
		var jdome2 = document.getElementById("joinDome2");
		jdome2.innerHTML = jdome1.innerHTML;
		
		function jmarquee(){
			jdome.scrollTop = (jdome.scrollTop<=jdome1.scrollHeight)?jdome.scrollTop+1:1;
			}
		var jmarTime = window.setInterval(jmarquee,50);
		jdome.onmouseover = function(){ window.clearInterval(jmarTime)}
		jdome.onmouseout = function(){ jmarTime = window.setInterval(jmarquee,50)}	
		
		////////////////////////////////////////////////////////////////////////
		var ldome = document.getElementById("ljDome");
		var ldome1 = document.getElementById("ljDome1");
		var ldome2 = document.getElementById("ljDome2");
		ldome2.innerHTML = ldome1.innerHTML;
		
		function lmarquee(){
			ldome.scrollTop = (ldome.scrollTop<=ldome1.scrollHeight)?ldome.scrollTop+1:1;
			}
		var lmarTime = window.setInterval(lmarquee,50);
		ldome.onmouseover = function(){ window.clearInterval(lmarTime)}
		ldome.onmouseout = function(){ lmarTime = window.setInterval(lmarquee,50)}
		}
		////////////////////////////////////////////////////////////////////////

		$().ready(function(){
//王永康start
			//显示菜单
			var actorIdV = <%=session.getAttribute("actorId")%>;
			listLog(actorIdV);
			//显示广告信息
			advertHotLine();
			//主页显示采购商列表
			showSupplier();
			//列出采购招标信息
			var url="listAllSupplyPurchaseInformation.action";
			$.post(url,function(data){
				$.each(data.ptName,function(i,value){
					var str="<li><a href='jsp/purchaseTenderInfo/getPTbyid.action?id="+value.id+"' target=\"_blank\">"+value.title+"</a></li>"
					var destination="";
					if(i<7){
						destination=$("#leftPT");
					}
					if(i>=7 && i<14){
						destination=$("#middlePT");
					}
					if(i>=14 && i<21){
						destination=$("#rightPT");
					}
					destination.append(str);
				});
			});
			//前一步是否是备份还原数据库
			backupOrRestore();
//王永康end
			
			//hubo显示诚信供应商供货信息
			showSupplierGoodsInfo();

//姜国强start
			//获取新闻、公告信息
			var newsBulletinUrl = $("#homeNewsBulletinList").attr("action");
			$.post(newsBulletinUrl, {async:false}, insertNewsBulletinList, "json");

			//获取集中采购信息
			var centralizedPurchaseUrl = $("#homeCentralizedPurchaseList").attr("action");
			$.post(centralizedPurchaseUrl, {async:false}, insertCentralizedPurchaseList, "json");

			//获取价格行情
			var priveQuotationUrl = $("#homePriceQuotationList").attr("action");
			$.post(priveQuotationUrl, {async:false}, insertPriceQuotationList, "json");

			//获取评标专家信息
			var biddingExpertUrl = $("#homeBiddingExpertList").attr("action");
			$.post(biddingExpertUrl, {async:false}, insertBiddingExpertList, "json");

			//登录信息处理
			loginStateProcess();

			//当前登录时间处理
			currentTimeProcess();				
//姜国强end
			
		});
//姜国强start
		//插入集中采购信息
		function insertCentralizedPurchaseList(data){
			var purchaseInfo = "";
			$.each(data.purchaseListAjax, function(i, value){
				purchaseInfo += "<p><img src=\"images/mark.png\" /> <a href=\"#\" onclick=\"applyCentralizedPurchaseProcess(this)\" name=\"jsp/centralizedPurchase/centralizedPurchaseApply.action?cpPurchaseInfoId=" + value.cpPurchaseInfoId + "\" >【" + value.cpPurchaseInfoId + "期集中采购】" + value.cpPurchaseInfoTitle + "</a></p>";
			});
			$("#caiGouDome1 p").remove();
			var centralizedPurchaseInfoModel = document.getElementById("caiGouDome1");
			$(centralizedPurchaseInfoModel).html(purchaseInfo);
		}

		//集中采购申请处理
		function applyCentralizedPurchaseProcess(param){
			//if($("#loginStateTag").attr("value") == "login"){
				window.open($(param).attr("name"));
			//} else {
			//	alert("您尚未登录，请先登录系统！");
			//}
		}

		//插入新闻、公告信息
		function insertNewsBulletinList(data){
			var newsInfo = "";
			$.each(data.newsListAjax, function(i, value){
				newsInfo += "<li class=\"listItem\"> <span class=\"newsleft\"><a href=\"jsp/baseInformation/queryNewsBulletinInfo.action?id=" + value.id + "\" target=\"_blank\">";
				if(value.publishType == 0){
					newsInfo += "【新闻】";
				} else {
					newsInfo += "【公告】";
				}
				newsInfo += value.title + "</a></span> <span class=\"newsright\">[" + value.publishDate + "]</span> </li>";		
			});
			$("#homeNewsListModel li").remove();
			var newsBulletinListModel = document.getElementById("homeNewsListModel");
			$(newsBulletinListModel).html(newsInfo);
		}

		//插入价格行情信息
		function insertPriceQuotationList(data){
			var priceInfo = "";
			$.each(data.priceListAjax, function(i, value){
				priceInfo += "<p><span class=\"BLUESPAN\">" + value.productName + ":</span> " + value.price + " <SPAN class=\"SMALLSPAN\">元</SPAN> </p>";
			});
			$("#priceDome1 p").remove();
			var priceQuotationInfoModel = document.getElementById("priceDome1");
			$(priceQuotationInfoModel).html(priceInfo);
		}

		//插入评标专家信息
		function insertBiddingExpertList(data){
			var expertInfo = "<tr>";
			$.each(data.expertListAjax, function(i, value){
				expertInfo += "<td align='center'><a href=\"jsp/basicData/selectExpert.action?expertId=" + value.expertId + "\" target=\"_blank\"><img src=\"" + value.photograph + "\" ></img></a></td>";
			});
			expertInfo += "</tr><tr>";
			$.each(data.expertListAjax, function(i, value){
				expertInfo += "<td align='center'>" + value.expertName + "</td>";
			});
			expertInfo += "</tr>";		
			$("#expertTable tr").remove();
			var biddingExpertInfoModel = document.getElementById("expertTable");
			$(biddingExpertInfoModel).append(expertInfo);
		}
				
		//处理登录状态
		function loginStateProcess(){
			if('<s:property value="#session.userId"/>' != null && '<s:property value="#session.userId"/>' != ""){
				//用户已经登录
				$("#XAUserLoginModel").hide();
				$("#XAUserLogoutModel").show();
				$("#loginStateTag").attr("value", "login");				
			} else {
				//用户未登录
				$("#XAUserLoginModel").show();
				$("#XAUserLogoutModel").hide();
				$("#loginStateTag").attr("value", "logout");
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

		function registerMember(){
			window.open("jsp/systemManage/register.jsp");
		}

		//用户登录
		function XAUserLogin(){
			
			var userIdValue = $("#userIdLogin").attr("value");
			var passwordValue = $("#passwordLogin").attr("value");
			var params = {userId:userIdValue, password:passwordValue, async:false};
			var url = $("#XAUserLogin").attr("action");
			$.post(url, params, loginCallBack, "json");
		}

		function loginCallBack(data){
			if(data.loginAjax == "SUCCESS"&&data.checkPassOrNotAjax == "pass"){
				//成功登录
				$("#XAUserNameLabel").text(data.userAjax.userName);
				$("#XAUserIdLabel").html(data.userAjax.userId);
				$("#XAUserLoginModel").hide();
				$("#XAUserLogoutModel").show();
				$("#loginStateTag").attr("value", "login");
				listLog(data.sessionValue.substring(1,data.sessionValue.length-1));
			} else if(data.checkPassOrNotAjax == "notPass"){
				alert("您还没有通过审批");
				return false
			}else {
				//登录不成功
				
				$("#XAUserLoginModel").show();
				$("#XAUserLogoutModel").hide();
				$("#loginStateTag").attr("value", "logout");
				alert("请检查登录信息后重新登录！");
			}
		}

		//用户退出
		function XAUserLogout(){
			var url = $("#XAUserLogout").attr("action");
			$.post(url, {async:false}, function(data){
				if(data.logoutAjax == "SUCCESS"){
					$("#userIdLogin").attr("value", "");
					$("#passwordLogin").attr("value", "");
					$("#XAUserLoginModel").show();
					$("#XAUserLogoutModel").hide();
					$("#loginStateTag").attr("value", "logout");
					listLog(data.sessionValue);
				}
			}, "json");		
		}

		//修改密码
		function XAUserModifyPassword(){
			window.open("jsp/systemManage/passwordModify.jsp");
		}

		function listLog(sessionValue){
			//移除掉所有的菜单项
			var i=0;
			for(i=0;i<8;i++){
				$("#0"+i+">li").each(function(){
					$(this).remove();
				});
			}
			//列出当前登录用户的菜单
			var actorIdV = sessionValue;
			if(actorIdV==null){
				actorIdV = 'default';
			}
			var loginUserLog = "listFunction.action";
			var params = {actorId:actorIdV};
			$.post(loginUserLog, params, function(data){
				$.each(data.functions,function(i,value){
					var ft = new Array();
					ft = value.functionId.split("-");
					if(ft.length==2){
						var str = "<li onmouseover='displaySubMenu(this)' onmouseout='hideSubMenu(this)'><a  href='"+value.url+"'>"+value.functionName+"</a><ul id='"+value.functionId+"'></ul></li>";
						$("#"+ft[0]).append(str);
					}if(ft.length==3 && ft[0]=="00"){
						var id = "#"+ft[0]+"-"+ft[1];
						if($("#"+ft[0]+"-"+ft[1]).length==0){
							var id="#"+ft[0];
						}
						 var str = "<li><a href='"+value.url+"' target='_blank'>"+value.functionName+"</a></li>";
						 $(id).append(str); 
					}
				});
			});
		}

		function homeNewsBulletinSearch(){
			var str = $("#newsSearch").attr("value");
			$("#homeNewsBulletinSearchTitle").attr("value", str);
			$("#homeNewsBulletinSearch").submit();
		}

		function reportAnalysisProcess(){
			if($("#loginStateTag").attr("value") == "login"){
				window.open("jsp/systemManage/reportAnalysis.action");
			} else {
				alert("您尚未登录，请先登录再尝试此功能！");
			}
		}

//姜国强end

//wangyongakng.pt
		function advertHotLine(){
			var url = "getHotLineAndAdvert.action";
			$.post(url,function(data){
				var str = data.hotlineAdvertisementAjax.serviceHotlineContent;
				
				var hotlines = new Array();
				hotlines = str.split(",");
				var i = 0;
				for(i=0;i<hotlines.length;i++){
					$("#telCnt").append("<P>"+hotlines[i]+"</p>");
				}
				//广告位设置广告
				$("#advt1").attr("src","images/advert/"+data.hotlineAdvertisementAjax.advertising1);
				$("#advt2").attr("src","images/advert/"+data.hotlineAdvertisementAjax.advertising2);
				$("#advt3").attr("src","images/advert/"+data.hotlineAdvertisementAjax.advertising3);
				$("#advt4").attr("src","images/advert/"+data.hotlineAdvertisementAjax.advertising4);
				$("#advt5").attr("src","images/advert/"+data.hotlineAdvertisementAjax.advertising5);
				$("#advt6").attr("src","images/advert/"+data.hotlineAdvertisementAjax.advertising6);
			});
		}

		function showSupplier(){
			var url = "homeShowSupplier.action";
			$.post(url,function(data){
				$.each(data.homeShowSupplier,function(i,value){
					var destination;
					var str = "<li><a href=\"jsp/basicData/supplierInformation.jsp?supplierId='"+value.partnerId+"'\">"+value.partnerName+"</a></li>";
					if(i<7){
						destination = $("#leftSupplier");
					}
					if(i>=7&&i<14){
						destination = $("#middleSupplier");
					}
					if(i>=14&&i<21){
						destination = $("#rightSupplier");
					}
					destination.append(str);
				});
			});
		}

		function backup(){
			var url = "backup.action";
			$.post(url,function(data){
				alert("数据库备份成功");
			});
		}

		function restore(){
			var url = "restore.action";
			$.post(url,function(data){
				alert("数据库恢复成功");
			});
		}

		function backupOrRestore(){
			var br = "<%=request.getAttribute("backup")%>";
			var br2 = "<%=request.getAttribute("restore")%>";
			if(br!=null&&br=="success"){
				alert("系统备份成功");
			}
			if(br2!=null&&br2=="success"){
				alert("系统恢复成功");
			}
			
		}


		//hubo显示诚信供应商供货信息
		function showSupplierGoodsInfo() {
			var url="listSupplyGoodsInfoInHome.action";
			$.post(url,function(data){
				$.each(data.supplyGoodsInfoLinkList,function(i,value){
					var str="<li><a href='jsp/supplyInfo/getSupplyGoodsInfoById.action?id="+value.id+"'>"+value.title+"</a></li>"
					var destination="";
					if(i<5){
						destination=$("#leftSupplyGoods");
					}
					if(i>=5 && i<10){
						destination=$("#middleSupplyGoods");
					}
					if(i>=10 && i<15){
						destination=$("#rightSupplyGoods");
					}
					destination.append(str);
				});
			});
		}
</script>
</head>

<body>

<!-- 以下标签用于辅助页面显示，供js使用 -->
<input type="hidden" id="loginStateTag" value="logout" />
<form id="homeNewsBulletinSearch" action="homeNewsBulletinSearch.action" method="post">
	<input type="hidden" id="homeNewsBulletinSearchTitle" name="title" value="" />
</form>
<form id="homeNewsBulletinList" action="homeNewsBulletinList.action"></form>
<form id="homeCentralizedPurchaseList" action="homeCentralizedPurchaseList.action"></form>
<form id="homePriceQuotationList" action="homePriceQuotationList.action"></form>
<form id="homeBiddingExpertList" action="homeBiddingExpertList.action"></form>
<form id="XAUserLogin" action="XAUserLogin.action"></form>
<form id="XAUserLogout" action="XAUserLogout.action"></form>
<div id="whole" class="CENTER">
<!--[if !IE]>-------------------------------------<![endif]-->
    <!----------------login--------------------->
    <table id="login" cellpadding="0" cellspacing="0" class="CENTER">
        <tr>
            <td align="left" id="loginLeft">西安印刷包装行业信息发布及集中采购网站</td>
            
            <td align="right">
            	<div id="XAUserLoginModel">
	            	用户名：<input id="userIdLogin" type="text" class="HOMETEXT"/>
	           	 	密码：     <input id="passwordLogin" type="password" class="HOMETEXT" />
			            <input onclick="XAUserLogin()" type="button" class="HOMEBUTTON" value="登录" />
			            <input type="button" class="HOMEBUTTON" onclick="registerMember()" value="注册会员" />
			            <input type="button" class="HOMEBUTTON" onclick="javascript:window.location='jsp/systemManage/getBackPassword.jsp';" value="忘记密码？" />
	            </div>
	            <div id="XAUserLogoutModel">
	            	你好，<label id="XAUserNameLabel"><s:property value="#session.userName"/></label>&nbsp;&nbsp;&nbsp;&nbsp;
	            	账号：<label id="XAUserIdLabel"><s:property value="#session.userId"/></label>&nbsp;&nbsp;&nbsp;&nbsp;
	            	<input onclick="XAUserModifyPassword()" type="button" class="HOMEBUTTON" value="修改密码" />
	            	<input onclick="XAUserLogout()" type="button" class="HOMEBUTTON" value="退出" />
	            </div>
            </td>
        </tr>
    </table>
<!--[if !IE]>-------------------------------------<![endif]-->
    <div id="logo" class="CENTER">
    	<img src="images/logo.png" align="left"/>
    </div>
<!--[if !IE]>-------------------------------------<![endif]-->
    <div id="daoHang" class="CENTER">   
        <ul id="navigation">
            <li id="first"><!-- 2012年12月12日 星期日 --></li>     
            <li id="home">
                <a href="#">首页</a>
            </li>
            <li id="changeState" onmouseover="displaySubMenu(this)" onmouseout="hideSubMenu(this)"><a  href="#">基础数据</a>
            <ul id="00">
                
            </ul>
        </li>
        <li id="changeState" onmouseover="displaySubMenu(this)" onmouseout="hideSubMenu(this)"><a  href="#">信息管理</a>
        	<ul class=sub_ybjd_net id="01">
                
            </ul>
        </li>
        <li id="changeState" onmouseover="displaySubMenu(this)" onmouseout="hideSubMenu(this)"><a  href="#">需求管理</a>
        	<ul class=sub_ybjd_net id="02">
               
            </ul>
        </li>
        <li id="changeState" onmouseover="displaySubMenu(this)" onmouseout="hideSubMenu(this)"><a  href="#">询比价管理</a>
            <ul class=sub_ybjd_net id="03">
                
            </ul>
        </li>
        <li id="changeState" onmouseover="displaySubMenu(this)" onmouseout="hideSubMenu(this)"><a  href="#">订单管理</a>
            <ul class=sub_ybjd_net id="04">
                
            </ul>
        </li>
        <li id="changeState" id="05"><a onclick="reportAnalysisProcess()" href="#">统计报表</a></li>
        <li id="bbs"><a  href="jsp/forumNew/forumHome.jsp">BBS</a></li>
        <li id="changeState" onmouseover="displaySubMenu(this)" onmouseout="hideSubMenu(this)" ><a  href="#">系统维护</a>
            <ul id="07">
        
            </ul>
        </li>
        </ul> 
    </div>
    
    <div id="content" class="CENTER">
<!--[if !IE]>-------------------------------------<![endif]-->
        <div id="adv1" class="CENTER">
            <img id="advt1" />
        </div>
<!--[if !IE]>-------------------------------------<![endif]-->
	  <div id="leftList">
    	<div id="tel" class="DIVTITLE">
        	<span class="TITLELEFTSPAN">服务热线</span>
        </div>
        <div id="telCnt" class="DIVCNT">
        	
        </div>
        
        <div id="adv2">
        	 <img id="advt2" />
        </div>
        
        <div id="price" class="DIVTITLE">
        	<span class="TITLELEFTSPAN">价格行情</span>
            <span class="FLOATRIGHT"><a href="jsp/baseInformation/quotationInformation.action"  target="_blank">更多</a></span>
        </div>
        <div id="priceCnt" class="DIVCNT">
        	<dl id="priceDome">
                <dt id="priceDome1">
<!--       
                  <p><span class="BLUESPAN">金：</span>999.99 <SPAN class="SMALLSPAN">元</SPAN> </p>
 -->
              	</dt>
           	 	<dd id="priceDome2"></dd>
           </dl>
        </div>
      </div>
      
  <!--[if !IE]>-------------------------------------<![endif]-->
  
      <div id="middleList"> 
        <div id="news" class="DIVTITLE">
        	<span class="TITLELEFTSPAN">新闻/公告</span>
            <span class="FLOATRIGHT" id="searchSpan">新闻搜索：<input type="text" id="newsSearch"/><img id="searchImg" onclick="homeNewsBulletinSearch();" src="images/search.png"/><a class="TITLEA" href="jsp/baseInformation/homeNewsBulletinMore.action">更多</a></span>
        </div>
        <div id="newsCnt" class="DIVCNT">
        <ul id="homeNewsListModel">
<!-- 
          <li class="listItem"> <span class="newsleft"><a href="#">【新闻】关于中央国家机关2011年政府供货</a></span> <span class="newsright">[2011-09-14]</span> </li>
 -->
        </ul>
        </div>
      </div>
      
   <!--[if !IE]>-------------------------------------<![endif]-->
   
      <div id="rightList">
      	<div id="caiGou" class="DIVTITLE">
        	<span class="TITLELEFTSPAN">集中采购信息</span>
            <span class="FLOATRIGHT"><a class="TITLEA" href="jsp/centralizedPurchase/homeCentralizedPurchaseMore.action">更多</a></span>
        </div>
        <div id="caiGouCnt" class="DIVCNT">
        	<dl id="caiGouDome">
               <dt id="caiGouDome1">
<!-- 
                  <p><img src="images/mark.png" /><a href="#">JXXXXXXXXXXXXXXX</a></p>
 -->
              </dt>
              <dd id="caiGouDome2"></dd>
            </dl>
        </div>
        <div id="adv4">
        	 <img id="advt4" />
        </div>
        <div id="joinCmp" class="DIVTITLE">
        	<span class="TITLELEFTSPAN">最新加盟企业</span>
        </div>
        <div id="joinCmpCnt" class="DIVCNT">
        	<dl id="joinDome">
                <dt id="joinDome1">
                  <p><img src="images/mark.png" /><a href="#">登封福中特种电器元件有限公司</a></p>
                  <p><img src="images/mark.png" /><a href="#">厦门博骐贸易有限公司</a></p>
                  <p><img src="images/mark.png" /><a href="#">青岛华旭阳工贸有限公司</a></p>
                  <p><img src="images/mark.png" /><a href="#">上海裕涛机电设备有限公司</a></p>
                  <p><img src="images/mark.png" /><a href="#">凯隆印刷包装有限公司</a></p>
                  <p><img src="images/mark.png" /><a href="#">深圳市科田塑胶有限公司</a></p>
                  <p><img src="images/mark.png" /><a href="#">上海绿邦包装印刷有限公司</a></p>
                  <p><img src="images/mark.png" /><a href="#">上海鑫茂实业有限公司</a></p>
                  <p><img src="images/mark.png" /><a href="#">深圳市源铭昊全能彩印设备有限</a></p>
                  <p><img src="images/mark.png" /><a href="#">纸箱纸盒,彩箱彩盒,内外包装箱</a></p>
               </dt>
               <dd id="joinDome2"></dd>
            </dl> 
        </div>
        <div id="adv5">
        	 <img id="advt5" />
        </div>
        <div id="cmpLj" class="DIVTITLE">
        	<span class="TITLELEFTSPAN">企业链接</span>
            <span class="FLOATRIGHT"><a class="TITLEA" href="#">更多</a></span>
        </div>
        <div id="cmpLjCnt" class="DIVCNT">
        	<dl id="ljDome">
                <dt id="ljDome1">
                  <p><img src="images/mark.png" /><a href="#">温州市财顺包装机械有限公</a></p>
                  <p><img src="images/mark.png" /><a href="#">宁波我要印电子商务有限公</a></p>
                  <p><img src="images/mark.png" /><a href="#">温州市财顺包装机械有限公</a></p>
                  <p><img src="images/mark.png" /><a href="#">安徽紫江印刷物资有限公司</a></p>
                  <p><img src="images/mark.png" /><a href="#">广州市依锐印刷涂料技术有</a></p>
                  <p><img src="images/mark.png" /><a href="#">中山市爱达森制版有限公司</a></p>
                  <p><img src="images/mark.png" /><a href="#">杭州耀阳(明阳)计算机技</a></p>
                  <p><img src="images/mark.png" /><a href="#">东莞市忠印机械有限公司</a></p>
                  <p><img src="images/mark.png" /><a href="#">安阳市兴达印刷机械有限公</a></p>
                  <p><img src="images/mark.png" /><a href="#">威华模切机械有限公司</a></p>
              </dt>
              <dd id="ljDome2"></dd>
			</dl>
        </div>
        <div id="adv6">
        	 <img id="advt6" />
        </div>
      </div> 
      
    <!--[if !IE]>-------------------------------------<![endif]-->
    
      	<div id="adv3">
      		 <img id="advt3" />
      	</div>
      	<div id="proInfo" class="DIVTITLE">
      		<span class="TITLELEFTSPAN">最新产品信息</span>
            <span class="FLOATRIGHT"><a class="TITLEA" href="#">更多</a></span>
      	</div>
      	<div id="proInfoCnt" class="DIVCNT">
        <table id="prdTable" class="CENTER" cellpadding="0" cellspacing="0">
        	<tr class="prdTr">
            	<td>
                	<table id="leftTable" class="prdTableCnt" cellpadding="0" cellspacing="0">
                    	<tr>
                        	<td><a href="#" target="_blank" class="prdTitle">包装用纸</a></td>
                            <td><a href="#" target="_blank" >箱板纸</a></td>
                            <td><a href="#" target="_blank" >茶板纸</a></td>
                            <td><a href="#" target="_blank" >瓦楞纸</a></td>
                            <td><a href="#" target="_blank" >牛皮纸</a></td>
                            <td><a href="#" target="_blank" >牛卡纸</a></td>
                        </tr>
                        <tr>
                        	<td><a href="#" target="_blank">白卡纸</a></td>
                            <td><a href="#" target="_blank" >白板纸</a></td>
                            <td><a href="#" target="_blank" >羊皮纸</a></td>
                            <td><a href="#" target="_blank" >卷烟纸</a></td>
                            <td><a href="#" target="_blank" >硅油纸</a></td>
                            <td><a href="#" target="_blank" >玻璃纸</a></td>
                        </tr>
                        <tr>
                        	<td><a href="#" target="_blank">防油纸</a></td>
                            <td><a href="#" target="_blank" >透明纸</a></td>
                            <td><a href="#" target="_blank" >铝箔纸</a></td>
                            <td><a href="#" target="_blank" >新闻纸</a></td>
                            <td><a href="#" target="_blank" >铜板纸</a></td>
                            <td><a href="#" target="_blank" >商标纸</a></td>
                        </tr>
                    </table>
                </td>
                <td>
                	<table class="prdTableCnt" cellpadding="0" cellspacing="0">
                    	<tr>
                        	<td><a href="#" target="_blank"  class="prdTitle">印刷用纸</a></td>
                            <td><a href="#" target="_blank" >新闻纸</a></td>
                            <td><a href="#" target="_blank" >铜版纸</a></td>
                            <td><a href="#" target="_blank" >轻涂纸</a></td>
                            <td><a href="#" target="_blank" >轻型纸</a></td>
                            <td><a href="#" target="_blank" >双胶纸</a></td>
                        </tr>
                        <tr>
                        	<td><a href="#" target="_blank" >书写纸</a></td>
                            <td><a href="#" target="_blank" >字典纸</a></td>
                            <td><a href="#" target="_blank" >书刊纸</a></td>
                            <td><a href="#" target="_blank" >牛皮纸</a></td>
                            <td><a href="#" target="_blank" >烫画纸</a></td>
                            <td><a href="#" target="_blank" >铝箔纸</a></td>
                        </tr>
						<tr>
                        	<td><a href="#" target="_blank" >邮票纸</a></td>
                            <td><a href="#" target="_blank" >字典纸</a></td>
                            <td><a href="#" target="_blank" >瓦楞纸</a></td>
                            <td><a href="#" target="_blank" >白纸板</a></td>
                            <td><a href="#" target="_blank" >艺术纸</a></td>
                            <td><a href="#" target="_blank" >双胶纸</a></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="prdTr">
            	<td>
                	<table id="leftTable" class="prdTableCnt" cellpadding="0" cellspacing="0">
                    	<tr>
                        	<td><a href="#" target="_blank"  class="prdTitle">印刷油墨</a></td>
                            <td><a href="#" target="_blank" >胶印油墨</a></td>
                            <td><a href="#" target="_blank" >水性油墨</a></td>
                            <td><a href="#" target="_blank" >凹印油墨</a></td>
                            <td><a href="#" target="_blank" >玻璃油墨</a></td>
                        </tr>
                        <tr>
                            <td><a href="#" target="_blank" >网版油墨</a></td>
                            <td><a href="#" target="_blank" >珠光油墨</a></td>
                            <td><a href="#" target="_blank" >UV油墨</a></td>
                            <td><a href="#" target="_blank" >防伪油墨</a></td>
                            <td><a href="#" target="_blank" >其它油墨</a></td>
                        </tr>
						<tr>
                            <td><a href="#" target="_blank" >网版油墨</a></td>
                            <td><a href="#" target="_blank" >珠光油墨</a></td>
                            <td><a href="#" target="_blank" >UV油墨</a></td>
                            <td><a href="#" target="_blank" >防伪油墨</a></td>
                            <td><a href="#" target="_blank" >其它油墨</a></td>
                        </tr>
                    </table>
                </td>
                <td>
                	<table class="prdTableCnt" cellpadding="0" cellspacing="0">
                    	<tr>
                        	<td><a href="#" target="_blank"  class="prdTitle">印艺服务</a></td>
                            <td><a href="#" target="_blank" >印前设备</a></td>
                            <td><a href="#" target="_blank" >印后设备</a></td>
                            <td><a href="#" target="_blank" >印刷设备</a></td>
                            <td><a href="#" target="_blank" >印刷配件</a></td>
                        </tr>
                        <tr>
                        	<td><a href="#" target="_blank" >印刷耗材</a></td>
                            <td><a href="#" target="_blank" >印前服务</a></td>
                            <td><a href="#" target="_blank" >印艺服务</a></td>
                            <td><a href="#" target="_blank" >书刊印刷</a></td>
                            <td><a href="#" target="_blank" >表格印刷</a></td>
                        </tr>
						<tr>
                        	<td><a href="#" target="_blank" >手提袋印刷</a></td>
                            <td><a href="#" target="_blank" >报业印刷</a></td>
                            <td><a href="#" target="_blank" >家具印刷</a></td>
                            <td><a href="#" target="_blank" >家电印刷</a></td>
                            <td><a href="#" target="_blank" >表格印刷</a></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="prdTr">
            	<td>
                	<table id="leftTable" class="prdTableCnt" cellpadding="0" cellspacing="0">
                    	<tr>
                        	<td><a href="#" target="_blank"  class="prdTitle">纸品加工机械</a></td>
                            <td><a href="#" target="_blank" >分切机</a></td>
                            <td><a href="#" target="_blank" >复卷机</a></td>
                            <td><a href="#" target="_blank" >纸制品加工</a></td>
                            <td><a href="#" target="_blank" >包装机械</a></td>
                        </tr>
						<tr>
                        	<td><a href="#" target="_blank" >真空泵</a></td>
                            <td><a href="#" target="_blank" >印刷刀片</a></td>
                            <td><a href="#" target="_blank" >工业皮带</a></td>
                            <td><a href="#" target="_blank" >供墨系统</a></td>
                            <td><a href="#" target="_blank" >包装机械</a></td>
                        </tr>
						<tr>
                        	<td><a href="#" target="_blank" >制版设备</a></td>
                            <td><a href="#" target="_blank" >喷绘系统</a></td>
                            <td><a href="#" target="_blank" >胶印机</a></td>
                            <td><a href="#" target="_blank" >制版系统</a></td>
                            <td><a href="#" target="_blank" >包装机械</a></td>
                        </tr>
                    </table>
                </td>
                <td>
                	<table class="prdTableCnt" cellpadding="0" cellspacing="0">
                    	<tr>
                        	<td ><a href="#" target="_blank"  class="prdTitle">包装机械</a></td>
                            <td><a href="#" target="_blank" >封口机</a></td>
                            <td><a href="#" target="_blank" >灌装机</a></td>
                            <td><a href="#" target="_blank" >填充机</a></td>
                            <td><a href="#" target="_blank" >打包机</a></td>
                        </tr>
                        <tr>
                        	<td ><a href="#" target="_blank" >缠绕机</a></td>
                            <td><a href="#" target="_blank" >裹包机</a></td>
                            <td><a href="#" target="_blank" >胶水机</a></td>
                            <td><a href="#" target="_blank" >捆扎机</a></td>
                            <td><a href="#" target="_blank" >钉箱机</a></td>
                        </tr>
                        <tr>
                        	<td ><a href="#" target="_blank">切角机</a></td>
                            <td><a href="#" target="_blank" >贴窗机</a></td>
                            <td><a href="#" target="_blank" >预印机</a></td>
                            <td><a href="#" target="_blank" >裱纸机</a></td>
                            <td><a href="#" target="_blank" >贴面机</a></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
      	</div>
        
    <!--[if !IE]>-------------------------------------<![endif]-->
     
     	<div id="vip" class="DIVTITLE">
        	<span class="TITLELEFTSPAN">诚信会员供货信息</span>
            <span class="FLOATRIGHT"><a class="TITLEA" href="jsp/supplyInfo/homeSupplyInfoMore.action">更多</a></span>
        </div>
        <div id="vipCnt" class="DIVCNT">
        	<div id="left">
                <ul class="artlist" id="leftSupplyGoods"> 
                 
                </ul>
            </div>
            <div id="middle">
                <ul class="artlist" id="middleSupplyGoods">
                   
                </ul>
            </div>
            <div id="right">
                <ul class="artlist" id="rightSupplyGoods">
             
                </ul>
            </div>
        </div>
        <div id="zhaoBiao" class="DIVTITLE">
        	<span class="TITLELEFTSPAN">采购/招标信息</span>
            <span class="FLOATRIGHT"><a class="TITLEA" href="jsp/purchaseTenderInfo/homeCaigouInfoMore.action">更多</a></span>
        </div>
        <div id="zhaoBiaoCnt" class="DIVCNT">
        	<div id="left">
                <ul class="artlist" id="leftPT">
                </ul>
            </div>
            <div id="middle">
                <ul class="artlist" id="middlePT">
                   
                </ul>
            </div>
            <div id="right">
                <ul class="artlist" id="rightPT">
                    
                </ul>
            </div>
        </div>
        <div id="joinSup" class="DIVTITLE">
        	<span class="TITLELEFTSPAN">加盟供应商</span>
            <span class="FLOATRIGHT"><a class="TITLEA" href="jsp/basicData/homeShowSupplierMore.action">更多</a></span>
        </div>
        <div id="joinSupCnt" class="DIVCNT">
        	<div id="left">
                <ul class="artlist" id="leftSupplier">
                    
                </ul>
            </div>
            <div id="middle">
                <ul class="artlist" id="middleSupplier"> 
                    
                </ul>
            </div>
            <div id="right">
                <ul class="artlist" id="rightSupplier">
                    
                </ul>
            </div>
        </div>
        <div id="expert" class="DIVTITLE">
        	<span class="TITLELEFTSPAN">评标专家</span>
        </div>
        <div id="expertCnt" class="DIVCNT">
        	<table id="expertTable" cellpadding="2px" cellspacing="0" align="center">
<!-- 
                <tr>
                    <td align="center"><a href="expertInformation.html"><img src="images/expert.jpg" /></a></td>
                </tr>
                <tr>
                    <td align="center">expert</td>
        		</tr>
 -->        		
       		</table>
        </div>
        <div id="friendLj">
        	<table cellpadding="0" cellspacing="0">
        	<tr>
            	<td><a href="http://www.ccgp.gov.cn" target="_blank"><img src="images/www.ccgp.gov.cn.gif" /></a></td>
                <td><a href="http://www.gov.cn" target="_blank"><img  src="images/www.gov.cn.gif" /></a></td>
                <td><a href="http://www.bgpc.gov.cn" target="_blank"><img  src="images/www.bgpc.gov.cn.gif" /></a></td>
                <td><a href="http://www.gpcgd.com" target="_blank"><img src="images/www.gpcgd.com.gif" /></a></td>
                <td><a href="http://www.gxgp.cn" target="_blank"><img src="images/www.gxgp.cn.gif" /></a></td>
                <td><a href="http://www.shzfcg.gov.cn" target="_blank"><img src="images/www.shzfcg.gov.cn.gif" /></a></td>
                <td><a href="http://www.cgpn.org" target="_blank"><img src="images/www.cgpn.org.jpg" /></a></td>
            </tr>
            <tr>
            	<td><a href="http://www.chinaeg.gov.cn" target="_blank"><img src="images/www.chinaeg.gov.cn.gif" /></a></td>
                <td><a href="http://www.zfcg.com" target="_blank"><img  src="images/www.zfcg.com.gif" /></a></td>
                <td><a href="http://www.zycg.gov.cn" target="_blank"><img  src="images/www.zycg.gov.cn.gif" /></a></td>
                <td><a href="http://http://www.hacker.cn/" target="_blank"><img  src="images/www.hacker.cn.gif" /></a></td>
                <td><a href="http://www.cipb.com" target="_blank"><img  src="images/www.cipb.com.cn.gif" /></a></td>
                <td><a href="http://www.wndhw.com" target="_blank"><img  src="images/www.wndhw.com.bmp" /></a></td>
                <td><a href="http://www.sbiao360.com/cms/user/index.jsp" target="_blank"><img  src="images/www.sbiao360.com.gif" /></a></td>
            </tr>
        </table>
        </div>
        <div id="copyRight">
        	<p align="center">西安印刷包装产业基地版权所有Copyright&copy;2011-2016</p>
            <p align="center">服务热线：029-8966866</p>
        </div>
    </div>


</div>


</body>
</html>
