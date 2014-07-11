<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>权限分配</title>
<link href="../../css/supply.css" rel="stylesheet" type="text/css"/>
<link href="../../css/global.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="../../css/jquery.treeview.css" />
<link rel="stylesheet" href="../../css/screen.css" />

<script type="text/javascript" src="../../javascript/My97DatePicker/WdatePicker.js"></script>

<script language="javascript" src="../../javascript/jquery-1.5.2.min.js"></script>
<script src="../../javascript/jquery.cookie.js" type="text/javascript"></script>
<script src="../../javascript/jquery.treeview.js" type="text/javascript"></script>

	<script type="text/javascript">
		
		$().ready(function(){
			
		
			var url = "listFunction.action";
			$.post(url,function(data){
				$.each(data.functions,function(i,value){
					if(value.functionId.split("-").length==1 ){
						var str="<li ><div ></div><input  name='"+value.functionId+"' type=\"checkbox\" onClick=\"checkBoxChecked(this)\"/>"+value.functionName+
								"<ul style=\"display: none;\" id="+value.functionId+" ></ul>"+"</li>";
						$("#tree").append(str);
					}if(value.functionId.split("-").length==2){
						
						var str = "<li ><div></div><input  type=checkbox onClick=\"checkBoxChecked(this)\" name='"+value.functionId+"'/>"+value.functionName+
						"<ul style=\"display:none;\" id="+value.functionId+"></ul>"+"</li>";
						var id = value.functionId.split("-")[0];
						$("#"+id).append(str);
					}if(value.functionId.split("-").length==3){
						var str = "<li ><input onClick='checkAllChecked(this)' type=checkbox name='"+value.functionId+"'/>"+value.functionName+"</li>";
						var id = value.functionId.split("-")[0]+"-"+value.functionId.split("-")[1];
						$("#"+id).append(str);
					}
				});
				
				$("#tree li").each(function(){
					if($(this).has("li")){
						//$(this).addClass("expandable");
						$(this).children("div").eq(0).addClass("hitarea expandable-hitarea");
					}
				});
				
				$("#tree").treeview({
					collapsed: true,
					animated: "fast",
					control:"#sidetreecontrol",
					prerendered: true,
					persist: "location"
				});
				
			});
			
			
		});
		
		function save(valu){
			var actorIdV=<%=request.getParameter("actorId")%>;
			var functionIdsV = "";
			$("#tree input").each(function(){
				if($(this).attr("checked")==true){
					functionIdsV = functionIdsV + $(this).attr("name") + ",";
				}
			});
			var url = "saveActorFunction.action";
			var params = {actorId:actorIdV,functionIds:functionIdsV};
			$.post(url,params,function(data){
				alert("权限修改成功");
				$("#listActorsForm").submit();
			});
		}
		
		function checkBoxChecked(valu){
			var id = $(valu).attr("name");
			if($(valu).attr("checked")==true){
				$("#"+id+" input").each(function(){
					$(this).attr("checked",true);
				});
			}else{
				$("#"+id+" input").each(function(){
					$(this).attr("checked",false);
				});
			}
			
			checkAllChecked(valu);
		}
		
		function checkAllChecked(valu){
			var str=$(valu).attr("name");
			var all=0;
			var flag=0;
			str=str.substring(0,str.length-3);
			$("#"+str+" input").each(function(){
				if($(this).attr("checked")==true){
					flag++;
				}
				all++;
			});
			
			if(all==flag){
				$("input[name="+str+"]").attr("checked",true);
			}
		}
	</script>
<style>
	#sidetree{ margin-top:10px; margin-bottom:10px; padding:10px; background-color:#CBE4FE; width:600px; border:2px groove #70B7FE;}
	#inputDiv{ width:800px; text-align:center;}
	#supply{ width:800px;}
	#supply #top{ width:800px;}
	#supply #DOWN{ width:800px;}
</style>
</head>

<body>
<form id="listActorsForm" method="post" action="listActors.action"></form>

<div id="supply" class="CENTER">
    <div id="top">
      	<span><h2>权限分配</h2></span>
    </div>
    
    <div id="sidetree" class="CENTER">
    	<div class="treeheader">&nbsp;</div>
  		<div id="sidetreecontrol"> <a class="ARTA" href="?#">全部收起</a> | <a class="ARTA" href="?#">全部展开</a> </div>
    	<ul class="treeview" id="tree">
        	
    	</ul>
    </div>
    
    <div id="inputDiv" class="CENTER" align="center">
    	<input type="button" name="<s:property value="#request.actorId"/>" onclick="save(this);"  class="BUTTON" value="保存" />
        <input type="button" class="BUTTON" value="取消" />
    </div>

    <div id="DOWN">
  		<input type="button" class="BUTTON" value="返回主页" onClick="javascript:window.location='../../home.jsp';" />
    </div>
</div>
</body>
</html>
