<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>评价</title>

<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link href="../../css/empty.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
	function give_value(obj){
	var status=true;
	var parent_obj=obj.parentNode;
	var i=0;
	while(status){
	   i++;
	   if(parent_obj.nodeName=="UL"){break;}
	   parent_obj=parent_obj.parentNode;
	   if(i>1000){break;}//防止找不到ul发生死循环
	}
	var hidden_input=parent_obj.getElementsByTagName("input")[0];
	if(hidden_input.length<1){/*alert("sorry?\nprogram error!")*/;}
	var txt=obj.firstChild.nodeValue;//确保不能存在空格哦，因为这里用的firstChild
	if(isNaN(parseInt(txt,10))){/*alert('level error!')*/;return false;}
	hidden_input.setAttribute("value",txt.toString());
	//固定选中状态,先找到初始化颜色那个li
	var current_li=parent_obj.getElementsByTagName("li");
	var length=current_li.length;
	var ok_li_obj=null;
	for(var i=0;i<length;i++){
	   if(current_li[i].className.indexOf("current_rating")>=0){
	    ok_li_obj=current_li[i];break;//找到
	   }
	}
	__current_width=txt*14;
	ok_li_obj.style.width=__current_width+"px";
	return false;
	}
</script>

<script type="text/javascript">
	window.onload = function(){
		var tbody = document.getElementById("productScoreTable");
		var length = tbody.rows.length;
		for(var index=0; index<length; index++){
			var str = tbody.rows[index].cells[2].childNodes[0].id;
			if(str.split(" ")[1] != ""){
				tbody.rows[index].cells[2].childNodes[0].style.display="none";
			}
		}		
	}

	function scoreChanged(valu){
		var tbody = document.getElementById("productScoreTable");
		tbody.rows[valu.name].cells[2].childNodes[0].id = tbody.rows[valu.name].cells[2].childNodes[0].id.split(" ")[0] + " " + valu.innerText;
	}
	
	function evaluateProduct(valu){
		var purchaseOrderIdValue = $("#purchaseOrderIdEdit").text();
		var productIdValue = valu.id.split(" ")[0];
		var scoreValue = valu.id.split(" ")[1];
		var params = {purchaseOrderId:purchaseOrderIdValue, productId:productIdValue, score:scoreValue, async: false};
		$.post($("#evaluateForProductUpdate").attr("action"), params, function(data){
			$(valu).hide();
			alert("产品" + valu.value + "评价完成！");
		});
	}
</script>

<style>
	#supply #register{clear:both; display:block; background-color:#FFF; border-width:0;}
	#supply #top{ text-align:left;background-color:#C9E3FE; color:#0F86DA;}
	#supply #top #process{ margin-top:4px; margin-right:4px;}
	#supply #top span{ color:#000;}
	#supply #top span h2{ color:#000;}
	#supply #register #registCnt{ text-align:center; background-color:#FFF;  margin-bottom:20px; margin-top:0;}
	#supply #register #spanLeft1{margin-left:27px; margin-top:5px;}
	.star_rating {list-style:none;margin:-1px 0 0 -1px; padding:0; width:70px; height:12px; position:relative; background:url(../../images/rating_stars.gif) 0 0 repeat-x; overflow:hidden;font-size:0;}
	.star_rating li{padding:0;margin:0;float:left;}
	.star_rating li a{display:block;width:14px;height:12px;text-decoration:none;text-indent:-9000px;z-index:20;position:absolute;padding:0;margin:0;}
	.star_rating li a:hover{background: url(../../images/rating_stars.gif) 0 12px;z-index:2;left:0;}
	.star_rating a.one_star{left:0;}
	.star_rating a.one_star:hover{width:14px;}
	.star_rating a.two_stars{left:14px;}
	.star_rating a.two_stars:hover{width:28px;}
	.star_rating a.three_stars{left:28px;}
	.star_rating a.three_stars:hover{width:42px;}
	.star_rating a.four_stars{left:42px;} 
	.star_rating a.four_stars:hover{width:56px;}
	.star_rating a.five_stars{left:56px;}
	.star_rating a.five_stars:hover{width:70px;}
	.star_rating li.current_rating{background:url(../../images/rating_stars.gif) 0 24px;position:absolute;height:12px;display:block;text-indent:-9000px;z-index:1;left:0;}
	/*end star.css*/
	#star_level{margin:0 0 20px 20px;}
	#star_level p{margin:20px 0 5px 0;}
	td{text-align:center;}
</style>

</head>

<body>

<form id="evaluateForProductUpdate" action="evaluateForProductUpdate.action"></form>
<div id="supply" class="CENTER">
    <div id="top">
      <span style="width:250px; margin-left:20px;" class="FLOATLEFT"><h2>评价</h2></span>
     	 <div id="process" class="FLOATRIGHT">
            <div class="ARTLEFTDIV"><span>交易仅需五步</span></div>
            <div class="ARTDIV">
                <span>提交订单</span>
            </div>
            <div class="ARTDIV">
                <span>支付定金</span>
            </div>
            <div class="ARTDIV">
                <span>确认到货</span>
            </div>
            <div class="ARTDIV">
                <span>支付货款</span>
            </div>
            <div class="BLUEDIV">
                <span>用后评价</span>
            </div>
        </div>
</div>
<table id="register" class="CENTER" cellpadding="0" cellspacing="0">
	<tr>	
      	<td>
        	<span id="spanLeft1" class="FLOATLEFT">采购订单代码：<label id="purchaseOrderIdEdit"><s:property value="#request.purchaseOrder.purchaseOrderId"/></label></span>
        </td>
  </tr>
      <tr>
        <td>
        <table id="registCnt" class="CENTER" cellpadding="2px;" cellspacing="0">
        	<thead>
        		<tr class="TITLE">
		            <td>产品代码及名称</td>
		            <td>评价分值</td>
		            <td>提交</td>
          		</tr>
        	</thead>
			<tbody id="productScoreTable">
	        		<s:iterator id="element" value="#request.query" status="status">
				        <tr id="productItem" class="HOVER">
				            <td ><input type="button" class="ARTBUTTON" onclick="" name="<s:property value="#element.productId"/>" value="<s:property value="#element.productId"/> <s:property value="#element.productName"/>"/></td>
				            <td >
				                <ul class="star_rating">
					                <li style="display:none;">
					                 <input type="text" name="price" value="" />
					                </li>
					                <li class="current_rating">default level</li>
					                <li><a href="#" title="1 of 5 stars" class="one_star" onclick="give_value(this);scoreChanged(this)" name="<s:property value="#status.index"/>" >1</a></li>
					                <li><a href="#" title="2 of 5 stars" class="two_stars" onclick="give_value(this);scoreChanged(this)" name="<s:property value="#status.index"/>" >2</a></li>
					                <li><a href="#" title="3 of 5 stars" class="three_stars" onclick="give_value(this);scoreChanged(this)" name="<s:property value="#status.index"/>" >3</a></li>
					                <li><a href="#" title="4 of 5 stars" class="four_stars" onclick="give_value(this);scoreChanged(this)" name="<s:property value="#status.index"/>" >4</a></li>
					                <li><a href="#" title="5 of 5 stars" class="five_stars" onclick="give_value(this);scoreChanged(this)" name="<s:property value="#status.index"/>" >5</a></li>
				                </ul>				            
				            </td>
				            <td ><input type="button" class="BUTTON" onclick="evaluateProduct(this)" value="确定" name="<s:property value="#status.index"/>" id="<s:property value="#element.productId"/> <s:property value="#element.score"/>" /></td>
				        </tr>
			  		</s:iterator>			
			</tbody>
        </table></td>
      </tr>
</table>
  <div id="DOWN">
	<input type="button" class="BUTTON" onclick="window.open('../../home.jsp','_blank')" value="返回首页"/>
</div>
</div>
</body>
</html>
