$(function() {
	/*
	 * 1. 得到所有的错误信息，循环遍历之。调用一个方法来确定是否显示错误信息！
	 */
	$(".errorClass").each(function() {
		showError($(this));//遍历每个元素，使用每个元素来调用showError方法
	});

	/*
	 * 3. 输入框得到焦点隐藏错误信息
	 */
	$(".inputClass").focus(function() {
		var labelId = $(this).attr("id") + "Error";//通过输入框找到对应的label的id
		$("#" + labelId).text("");//把label的内容清空！
		showError($("#" + labelId));//隐藏没有信息的label
	});
	
	/*
	 * 4. 输入框失去焦点进行校验
	 */
	$(".inputClass").blur(function() {
		var id = $(this).attr("id");//获取当前输入框的id
		var funName = "validate" + id.substring(0,1).toUpperCase() + id.substring(1) + "()";//得到对应的校验函数名
		eval(funName);//执行函数调用
	});
	
	/*
	 * 5. 表单提交时进行校验
	 */
	$("#editTestSuitForm").submit(function() {
		
		var bool = true;//表示校验通过
		if(!validateTestSuitName()) {
			bool = false;
		}
		if(!validateTemSut()) {
			bool = false;
		}
		if(!validateTestSuitCategory()) {
			bool = false;
		}		
		if(!validateTestSuitDescribe()) {
			bool = false;
		}
		if(!validateTestSuitExplain()) {
			bool = false;
		}
		if(bool){//提交数据
			var id = $("#id").val();
			var testSuitName = $("#testSuitName").val();
			var temSut = $("#temSut").find("option:selected").text();
			var testSuitCategory = $("#testSuitCategory").find("option:selected").text();
			var testSuitDescribe = $("#testSuitDescribe").find("option:selected").text();
			var testSuitExplain = $("#testSuitExplain").find("option:selected").text();
			//var modifyTime = getNowFormatDate();
			//var userLoginId = "dengzhenhong";
			var testCaseInfo= $("#testCaseInfo").val();
			var testSuitExplain= $("#testSuitExplain").val();
			var urlPath = document.getElementById("path").value+"/testSuitDeveloper.do/update";
			var desPath = document.getElementById("path").value+"/testSuitDeveloper.do/index.view";
			var testsuit = {
				"id":id,
				"testSuitName" : testSuitName,
				"temSut":temSut,
				"testSuitCategory":testSuitCategory,
				"testSuitDescribe":testSuitDescribe,
				"testCaseInfo":testCaseInfo,
				"testSuitExplain":testSuitExplain,
			}
			$.ajax({
				data : JSON.stringify(testsuit),
				type : "POST",
				contentType : 'application/json; charset=utf-8',
				url : urlPath,
				dataType : "text",
				error : function(data) {
					alert("出错了:" + data);
				},
				success : function(data) {
					alert("保存成功:" + data);
					location.href=desPath;        
				}
			});
		}
		return false;
	});
});

function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes()
            + seperator2 + date.getSeconds();
    return currentdate;
}

function validateTestSuitName() {
	var id = "testSuitName";
	var value = $("#" + id).val();//获取输入框内容
	/*
	 * 1. 非空校验
	 */
	if(!value) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("套件名称不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if(value.length < 3 || value.length > 20) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("长度必须在3-20之间！");
		showError($("#" + id + "Error"));
		return false;
	}
	return true;
}

function validateTestSuitId() {
	var id = "testSuitId";
	var value = $("#" + id).val();//获取输入框内容
	/*
	 * 1. 非空校验
	 */
	if(!value) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("套件编号不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if(value.length < 3 || value.length > 20) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("长度必须在3-20之间！");
		showError($("#" + id + "Error"));
		return false;
	}
	
	return true;
}

function validateTestSuitDescribe() {
	var id = "testSuitDescribe";
	var value = $("#" + id).val();//获取输入框内容
	
	if(value == 0)
	{
		$("#" + id + "Error").text("请选择套件描述！");
		showError($("#" + id + "Error"));
		return false;
	}
	return true;
}

function validateTestSuitExplain() {
	var id = "testSuitExplain";
	var value = $("#" + id).val();//获取输入框内容
	/*````````````
	 * 1. 非空校验
	 */
	if(!value) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("套件说明不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if(value.length < 3 || value.length > 20) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("长度必须在3-20之间！");
		showError($("#" + id + "Error"));
		return false;
	}
	return true;
}

function validateScriptConfigName() {
	var id = "scriptConfigName";
	var value = $("#" + id).val();//获取输入框内容
	/*
	 * 1. 非空校验
	 */
	if(!value) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("名称不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if(value.length < 3 || value.length > 20) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("长度必须在3-20之间！");
		showError($("#" + id + "Error"));
		return false;
	}
	
	return true;
}

function validateScriptConfigParm() {
	var id = "scriptConfigParm";
	var value = $("#" + id).val();//获取输入框内容
	/*
	 * 1. 非空校验
	 */
	if(!value) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("参数不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if(value.length < 3 || value.length > 20) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("长度必须在3-20之间！");
		showError($("#" + id + "Error"));
		return false;
	}
	
	return true;
}

function validateScriptExplain() {
	var id = "scriptExplain";
	var value = $("#" + id).val();//获取输入框内容
	/*
	 * 1. 非空校验
	 */
	if(!value) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("脚本说明不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if(value.length < 3 || value.length > 20) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("长度必须在3-20之间！");
		showError($("#" + id + "Error"));
		return false;
	}
	return true;
}

function validateTemSut() {
	var id = "temSut";
	var value = $("#" + id).val();//获取输入框内容
	
	if(value == 0)
	{
		$("#" + id + "Error").text("请选择执行类型！");
		showError($("#" + id + "Error"));
		return false;
	}
	return true;
}

function validateTestSuitCategory() {
	var id = "testSuitCategory";
	var value = $("#" + id).val();//获取输入框内容
	
	if(value == 0)
	{
		$("#" + id + "Error").text("请选择测试类别！");
		showError($("#" + id + "Error"));
		return false;
	}
	return true;
}

/*
 * 判断当前元素是否存在内容，如果存在显示，不页面不显示！
 */
function showError(ele) {
	var text = ele.text();//获取元素的内容
	if(!text) {//如果没有内容
		ele.css("display", "none");//隐藏元素
	} else {//如果有内容
		ele.css("display", "");//显示元素
	}
}

function addTestCase(a){
	var thisRowIndex = $(a).parent().prev().prev().text()
	var thisSelId = "tc" + thisRowIndex + "Sel";
	var rowCount = parseInt(document.getElementById("testCaseListTable").rows.length);
	if(hasUnselected()){
		alert("请先选择测试用例再增加！")
	}
	else{
		$("#testCaseInfo").val(updateTCListInfo());
		var trId = "tc" + thisRowIndex;
		var newRowIndex = parseInt(thisRowIndex) + 1;
		
		for(i=rowCount;i>=parseInt(thisRowIndex)+1;i--){
			var indexId = "tc" + i + "Index";
			var obj = $("#" + indexId);					
			obj.text(i+1);
			var j = i+1;
			var test = "tc" + j + "Index";
			obj.attr("id",test);
			
			var thisSelId = "tc" + i + "Sel";
			var selObj = $("#" + thisSelId);					
			var j = i+1;
			var test = "tc" + j + "Sel";
		    selObj.attr("id",test);
		}			
		
		insertTr(thisRowIndex);
		addOptions(newRowIndex);									
		document.getElementById("testSuitInfoTable").rows[6].cells[0].rowSpan = rowCount + 1;
	}				
}

function insertTr(index){
    var newIndex = parseInt(index) + 1;
	var newRow=document.getElementById('testCaseListTable').insertRow(index)
	newRow.style = "margin-top:5px;";
	var td1=newRow.insertCell(0)				   
	td1.innerHTML="<td>" + newIndex + "</td>";
	td1.id = "tc" + newIndex + "Index";;
	td1.style = "width:150px"
	var td2=newRow.insertCell(1)
	td2.innerHTML="<td><div><select class='inputClass'  id='tc" + newIndex + "Sel' onchange='selChange(this)'></select></div></td>";
	var td3=newRow.insertCell(2)				    
	td3.innerHTML="<td><a name='describe' onclick='showDescribe(this)'>说明</a> <a onclick='deleteRow(this)'>删除</a> <a onclick='addTestCase(this)'>插入</a></td>";
}

function addOptions(newRowIndex){
    var newSelId = "tc" + newRowIndex + "Sel";
	var tc1Sel = document.getElementById("tc1Sel");
	var optionsCount = tc1Sel.options.length;
	var newTestCaseSel = document.getElementById(newSelId);
	for(var i = 0;i < optionsCount;i++){
		var newOption = document.createElement("option");
		newOption.value = tc1Sel.options[i].value;
		newOption.innerText = tc1Sel.options[i].innerText;
		newTestCaseSel.appendChild(newOption);
	}
}

function deleteRow(a){					
	var rowNum = parseInt($(a).parent().prev().prev().text());
	var rowCount = parseInt(document.getElementById("testSuitInfoTable").rows[6].cells[0].getAttribute("rowSpan"));
	if(rowCount == 1){
		alert("第一行不能删除！");
	}
	else{
		$(a).parent().parent().remove();
		for(i=rowCount;i>=parseInt(rowNum)+1;i--){
			var indexId = "tc" + i + "Index";
			var indexObj = $("#" + indexId);					
			indexObj.text(i-1);
			var j = i-1;
			var test = "tc" + j + "Index";
		    indexObj.attr("id",test);
			
			var selId = "tc" + i + "Sel";
			var selObj = $("#" + selId);					
			var j = i-1;
			var test = "tc" + j + "Sel";
		    selObj.attr("id",test);
		}
		var newRowSpan = parseInt(rowCount) - 1;
		document.getElementById("testSuitInfoTable").rows[6].cells[0].rowSpan = newRowSpan;
	}
	$("#testCaseInfo").val(updateTCListInfo());	
}
function updateTCListInfo(){				
	var len = document.getElementById("testCaseListTable").rows.length;
	var tcListInfo = "";
	for(var i=1;i<=len;i++){
		var tcSelId = "tc" + i +  "Sel";
		var tcSelValue = $("#" + tcSelId).val();
		var info = ","  + tcSelValue;
		if(i == 1){
			tcListInfo +=  tcSelValue;	
		}
		else{
			tcListInfo += info;
		}
	}
	return tcListInfo;
}
function selChange(a){				
	var selValue = $(a).val();
	
	if(selValue != 0){
		$("#testCaseInfo").val(updateTCListInfo());
	}
}
function hasUnselected(){				
	var len = document.getElementById("testCaseListTable").rows.length;
	var result = false;
	for(var i=1;i<=len;i++){
		var tcSelId = "tc" + i +  "Sel";
		var tcSelValue = $("#" + tcSelId).val();
		if(tcSelValue == 0){
			result = true;	
		}
	}
	return result;
}
