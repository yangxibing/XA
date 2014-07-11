//判断输入长度，字母数字占一个字符，汉字两个字符
function strlen(str){
	var len = 0;
	for(var i=0;i<str.length;i++){
		var c = str.charCodeAt(i);
		if((c>=0x0001&&c<=0x007e)||(0xff60<=c&&c<=0xff9f)){
			len++;
		}else{
			len+=2;
		}
	}
	return len;
}

/*=========================partner验证==================================*/

//验证partnerId，查询
function checkPartnerId(Object){
	
	var value = Object.attr("value");
	var patten = /^[a-z A-Z 0-9]{1,10}$/;
	var flag = patten.test(value);
	if(!flag&&value.length!=0){
		alert("请输入1-10位数字或字母组成的合作伙伴代码");
		return false;
	}
}
//保存时候验证
function checkPartnerId2(Object){
	
	if(Object==null||Object.attr("value").length==0){
		alert("请输入合作伙伴代码");
		return false;
	}
	var value = Object.attr("value");
	var patten = /^[a-z A-Z 0-9]{1,10}$/;
	var flag = patten.test(value);
	if(!flag){
		alert("请输入1-10位数字或字母组成的合作伙伴代码");
		return false;
	}
}


//验证partnerName
function checkPartnerName(Object){
	
	var value = Object.attr("value");
	if(value.length!=0&&strlen(value)>50){
		alert("供应商名称不能多于50个字符");
		return false;
	}
}

//验证address
function checkAddress(Object){
	
	var value=Object.attr("value");
	if(value.length!=0&&strlen(value)>50){
		alert("地址不能多于50个字符");
		return false;
	}
}

//验证网址
function checkWebsite(Object){
	
}

//验证简介
function checkIntroduction(Object){
	
	var value=Object.attr("value");
	if(value.length!=0&&strlen(value)>200){
		alert("简介不能多于200个字符");
		return false;
	}
}

//验证联系人
function checkcontactPerson(Object){
	
	var value=Object.attr("value");
	if(value.length!=0&&strlen(value)>200){
		alert("联系人不能多于16个字符");
		return false;
	}
}

//验证电话格式
function checkTelephone(Object){
	
	var value=Object.attr("value");
	var patten = /^[0-9]{11}$/;//手机号
	var patten2 = /^(0\d{2,3}-?(\d{7,8}))$/;//固定电话
	var flag = patten.test(value);
	var flag2 = patten2.test(value);
	if(value.length!=0&&!flag&&!flag2){
		alert("请输入正确的电话格式");
		return false;
	}
}

//验证传真，固话
function checkFax(Object){
	
	var value=Object.attr("value");
	var patten = /^(0\d{2,3}-?(\d{7,8}))$/;
	var flag = patten.test(value);
	if(value.length!=0&&!flag){
		alert("请输入正确的传真格式");
		return false;
	}
}

//验证邮箱
function checkEmail(Object){
	
	var value = Object.attr("value");
	var patten = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
	if(value.length!=0&&!patten.test(value)){
		alert("邮箱个不正确，请输入正确的邮箱格式");
		return false;
	}

}

//验证邮政编码
function checkZipCode(Object){
	
	var value = Object.attr("value");
	var patten = /^\d{6}$/;
	if(value.length!=0&&!patten.test(value)){
		alert("邮政编码格式输入不正确");
		return false;
	}
}
//验证partner所有的信息
function partnerAllCheck(partnerIdO,partnerNameO,firstAddressO,secondAddressO,webSiteO,introductionO,contractPersionO,telephoneO,faxO,emailO,zipCodeO){
	if(checkPartnerId2(partnerIdO)==false){
		return false;
	}
	if(checkPartnerName(partnerNameO)==false){
		return false;
	}
	if(checkAddress(firstAddressO)==false){
		return false;
	}
	if(checkAddress(secondAddressO)==false){
		return false;
	}
	if(checkWebsite(webSiteO)==false){
		return false;
	}
	if(checkIntroduction(introductionO)==false){
		return false;
	}
	if(checkcontactPerson(contractPersionO)==false){
		return false;
	}
	if(checkTelephone(telephoneO)==false){
		return false;
	}
	if(checkFax(faxO)==false){
		return false;
	}
	if(checkEmail(emailO)==false){
		return false;
	}
	if(checkZipCode(zipCodeO)==false){
		return false;
	}
	return true;
}


/*=========================product验证==================================*/

//验证productId
function checkProductId(Object){
	
	var value = Object.attr("value");
	var patten = /^[a-z A-Z 0-9 - _]{1,20}$/;
	if(value.length!=0&&!patten.test(value)){
		alert("请输入由少于20个字母数字下划线组成的产品代码");
		return false;
	}else 
		return true;
}
//验证productNzme
function checkProductName(Object){
	
	var value = Object.attr("value");
	if(value.length!=0&&strlen(value)>30){
		alert("产品名称过长，请输入少于30个字符");
		return false;
	}else 
		return true;
}

//验证产品基准价格
function checkPrice(Object){
	
	var value = Object.attr("value");
	var patten = /^[0-9]{1,10}(\.[0-9]{0,2})?$/;
	var flag = patten.test(value);
	if(value.length==0){
		alert("请输入基准价格")
	}else{
		if(!flag){
			alert("请输入整数为不超过10位，小数位不超过2位的基准价格");
			return false;
		}else 
			return true;
	}
}

//验证度量单位
function checkMeasureUnit(Object){
	
	var value = Object.attr("value");
	if(value.length!=0&&strlen(value)>10){
		alert("度量单位过长，请输入正确的度量单位");
		return false;
	}else 
		return true;
	
}

//验证规格
function checkFormat(Object){
	
	var value = Object.attr("value");
	if(value.length!=0&&strlen(value)>30){
		alert("规格太长，请输入小于30个字符的规格");
		return false;
	}else 
		return true;
	
}

//验证备注
function checkRemark(Object){
	
	var value = Object.attr("value");
	if(value.length!=0&&strlen(value)>100){
		alert("备注过长，请输入小于100个字符的备注");
		return false;
	}else 
		return true;
	
}

//验证product所有
function productAllCheck(productIdO, productNameO, basePriceO, measureO, formatO, remarkO){

	if(!checkProductId(productIdO)){
		return false;
	}
	if(!checkProductName(productNameO)){
		return false;
	}
	if(!checkPrice(basePriceO)){
		return false;
	}
	if(!checkMeasureUnit(measureO)){
		return false;
	}
	if(!checkFormat(formatO)){
		return false;
	}
	if(!checkRemark(remarkO)){
		return false;
	}
	return true;
}


function checkNumber(numberO){
	
	var value=numberO.attr("value");
	var patten = /^\d{1,9}$/;
	if(!patten.test(value)){
		alert("数量区间数字太大或没有输入数量区间");
		return false;
	}if(value<0){
		alert("数量区间不能为负");
		return false
	}
	return true;
}
//量价关系
function priceRelationCheck(startNumber, endNumber, priceObject, Remark){
	if(endNumber.attr("value")<startNumber.attr("value")){
		alert("数量区间不正确");
		return false;
	}
	if(!checkNumber(startNumber)){
		return false;
	}
	if(!checkNumber(endNumber)){
		return false;
	}
	if(!checkPrice(priceObject)){
		return false;
	}
	if(!checkRemark(Remark)){
		return false;
	}
	return true;
}


/*===================产品类别验证=============================*/

function checkProductTypeId(value){
	
	var patten = /^[a-z A-Z 0-9 - _]{1,10}$/;
	if(value.length!=0&&!patten.test(value)){
		alert("请输入由少于20个字母数字下划线组成的产品类别代码");
		return false;
	}else 
		return true;
}

function checkProductTypeName(value){
	
	if(value.length!=0&&strlen(value)>30){
		alert("产品类别名称过长，请输入少于30个字符");
		return false;
	}else 
		return true;
}

function checkRemarkValue(value){
	
	if(value.length!=0&&strlen(value)>100){
		alert("备注过长，请输入小于100个字符的备注");
		return false;
	}else 
		return true;
}


function checkAllProductType(productId, productName, remark){
	
	if(!checkProductTypeId(productId)){
		
		return false;
	}
	if(!checkProductTypeName(productName)){
		
		return false;
	}
	if(!checkRemarkValue(remark)){
	
		return false;
	}
	return true;
}

//定金比例
function checkOrderRate(value){
	var patten = /^0(\.[0-9]{0,2})?$/;
	if(value.length!=0&&!patten.test(value)){
		alert("定金比率格式不对，请输入形如0.12的格式");
		return false;
	}return true;
	
}


//supplyPurchaseInformation
function checkTitle(value){
	
	if(value==null||value.length==0){
		
		alert("标题不能为空");
		return false;
	}
	if(strlen(value)>60){
		
		alert("请输入不超过60个字符的标题");
		return false;
	}
	return true;
}

function checkContent(value){
	
	if(strlen(value)>2000){
		
		alert("内容输入过长");
		return false;
	}
	return true;
}

function checkAllSupplyProduct(title, content){
	
	if(checkTitle(title)==false)
		return flase;
	if(checkContent(content)==false)
		return false;
	return true;
}

//新闻公告管理
function checkNewsTitle(value){
	
if(value==null||value.length==0){
		
		alert("标题不能为空");
		return false;
	}
	if(strlen(value)>100){
		
		alert("请输入不超过100个字符的标题");
		return false;
	}
	return true;
}

function checkNews(title, content){
	
	if(checkNewsTitle(title)==false)
		return false;
	if(checkContent(content)==false)
		return false;
	return true;
}

function checkNumberValue(value){
	var patten = /^\d{1,9}$/;
	if(!patten.test(value)){
		alert("数量格式不正确");
		return false;
	}if(value<0){
		alert("数量不能为负");
		return false
	}
	return true;
}

function checkWare(value){
	
	var patten = /^\d{0,9}$/;
	if(!patten.test(value)){
		alert("运费格式不正确");
		return false;
	}if(value<0){
		alert("运费不能为负");
		return false
	}
	return true;
}
function checkPriceValue(value){
	var patten = /^[0-9]{1,10}(\.[0-9]{0,2})?$/;
	var flag = patten.test(value);
	if(value.length==0){
		alert("价格不能为空")
		return false;
	}else{
		if(!flag){
			alert("请输入整数为不超过10位，小数位不超过2位的基准价格");
			return false;
		}else 
			return true;
	}
}
//价格行情管理
function checkPriceQuotation(price, number){
	
	if(checkPriceValue(price)==false)
		return false;
	if(checkNumberValue(number)==false)
		return false;
	return true;
	
}

function checkMeasureUnitValue(value){
	
	if(value.length!=0&&strlen(value)>10){
		alert("度量单位过长，请输入正确的度量单位");
		return false;
	}else 
		return true;
	
}

 function checkTelephoneValue(value){
	
	var patten = /^[0-9]{11}$/;//手机号
	var patten2 = /^(0\d{2,3}-?(\d{7,8}))$/;//固定电话
	var flag = patten.test(value);
	var flag2 = patten2.test(value);
	if(value.length!=0&&!flag&&!flag2){
		alert("请输入正确的电话格式");
		return false;
	}
}
//集中采购
function checkCPPI(title, measureUnit, telephone, startPrice, endPrice,content){
	if(checkTitle(title)==false)
		return false;
	if(checkMeasureUnitValue(measureUnit)==false)
		return false;
	if(checkTelephoneValue(telephone)==false)
		return false;
	if(checkPriceValue(startPrice)==false)
		return false;
	if(checkPriceValue(endPrice)==false)
		return false;
	if(checkContent(content)==false)
		return false;
	return true;
	
}

function checkContactPerson(value){
	
	if(strlen(value)>16){
		alert("收货人输入字符太多，请输入少于16个字符");
		return false;
	}
	return true;
}

function checkAddressValue(value){
	
	if(strlen(value)>50){
		alert("地址输入字符太多");
		return false;
	}
	return true;
}

function checkZipCodeValue(Object){
	
	var patten = /^\d{6}$/;
	if(value.length!=0&&!patten.test(value)){
		alert("邮政编码格式输入不正确");
		return false;
	}
}

//验证收货地址
function checkSendOrReceiveAddress(name, address, telephone, zipCode){
	
	if(checkContactPerson(name)==false)
		return false;
	if(checkAddressValue(address)==false)
		return false;
	if(checkZipCodeValue(zipCode)==false)
		return false;
	if(checkTelephoneValue(telephone)==false)
		return false;
	return true;
}

//计划采购信息管理验证
function checkPlanedPurchase(title, number){
	if(checkTitle(title)==false)
		return false;
	if(checkNumberValue(number)==false)
		return false;
	return true;
	
}
