$(function() {
	/*
	 * 1. 得到所有的错误信息，循环遍历之。调用一个方法来确定是否显示错误信息！
	 */
	$(".errorClass").each(function() {
		showError($(this));// 遍历每个元素，使用每个元素来调用showError方法
	});

	/*
	 * 2. 输入框得到焦点隐藏错误信息
	 */
	$(".inputClass").focus(function() {
		var labelId = $(this).attr("id") + "Error";// 通过输入框找到对应的label的id
		$("#" + labelId).text("");// 把label的内容清空！
		showError($("#" + labelId));// 隐藏没有信息的label
	});

	/*
	 * 3. 输入框失去焦点进行校验
	 */
	$(".inputClass").blur(
			function() {
				var id = $(this).attr("id");// 获取当前输入框的id
				var funName = "validate" + id.substring(0, 1).toUpperCase()
						+ id.substring(1) + "()";// 得到对应的校验函数名
				eval(funName);// 执行函数调用
			});

	/*
	 * 4. 表单提交时进行校验
	 */
	$("#editTestTaskForm").submit(function() {
		var bool = true;// 表示校验通过
		if (!validateTestTaskName()) {
			bool = false;
		}
		if (!validateSpecialCaseName()) {
			bool = false;
		}
		if (!validateMachineType()) {
			bool = false;
		}
		if (!validateTestCategory()) {
			bool = false;
		}
		if (!validateTestTaskDescribe()) {
			bool = false;
		}
		if (!validatePoolType()) {
			bool = false;
		}
		if (!validatePoolSuitOrCase()) {
			bool = false;
		}
		if (!validateMachineInfo()) {
			bool = false;
		}
		if(bool){//提交数据
			var id = $("#id").val();
			var testTaskName = $("#testTaskName").val();
			var specialCaseName = $("#specialCaseName").val();
			var machineType = $("#machineType").val();
			var testCategory = $("#testCategory").val();
			var testTaskDescribe = $("#testTaskDescribe").val();
			var poolType = $("#poolType").val();
			var poolSuitOrCase = $("#poolSuitOrCase").val();
			//var machineInfo = $("#machineInfo").val();
			var temInfo=$("#temInfo").val();
			var sutInfo=$("#sutInfo").val();
			var urlPath = document.getElementById("path").value+"/testTask.do/update";
			var testCaseCount= $("#testCaseCount").val();
			var testCaseInfo= $("#testCaseInfo").val();
			var process=$("#process").val();
			var testtask = {
				"id" : id,
				"testTaskName" : testTaskName,
				"specialCaseName" : specialCaseName,
				"machineType" : machineType,
				"testCategory" : testCategory,
				"testTaskDescribe" : testTaskDescribe,
				"poolType" : poolType,
				"poolSuitOrCase" : poolSuitOrCase,
				"temInfo" : temInfo,
				"sutInfo" : sutInfo,
				"testCaseCount" : testCaseCount,
				"testCaseInfo" : testCaseInfo,
				"process":process
			}
			$.ajax({
				data : JSON.stringify(testtask),
				type : "POST",
				contentType : 'application/json; charset=utf-8',
				url : urlPath,
				dataType : "text",
				error : function(data) {
					alert("出错了:" + data);
				},
				success : function(data) {
					alert("保存成功:" + data);

				}
			});
		}
		return false;
	});
});

function validateTestTaskName() {
	var id = "testTaskName";
	var value = $("#" + id).val();// 获取输入框内容
	/*
	 * 1. 非空校验
	 */
	if (!value) {
		/*
		 * 获取对应的label 添加错误信息 显示label
		 */
		$("#" + id + "Error").text("任务名称不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if (value.length < 3 || value.length > 45) {
		/*
		 * 获取对应的label 添加错误信息 显示label
		 */
		$("#" + id + "Error").text("长度必须在3-45之间！");
		showError($("#" + id + "Error"));
		return false;
	}
	return true;
}

function validateSpecialCaseName() {
	var id = "specialCaseName";
	var value = $("#" + id).val();// 获取输入框内容
	/*
	 * 1. 非空校验
	 */
	if (!value) {
		/*
		 * 获取对应的label 添加错误信息 显示label
		 */
		$("#" + id + "Error").text("专案名称不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if (value.length < 3 || value.length > 45) {
		/*
		 * 获取对应的label 添加错误信息 显示label
		 */
		$("#" + id + "Error").text("长度必须在3-45之间！");
		showError($("#" + id + "Error"));
		return false;
	}

	return true;
}

function validateMachineType() {
	var id = "machineType";
	var value = $("#" + id).val();// 获取输入框内容
	/*
	 * 1. 非空校验
	 */
	if (!value) {
		/*
		 * 获取对应的label 添加错误信息 显示label
		 */
		$("#" + id + "Error").text("请输入机器型号！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if (value.length < 3 || value.length > 20) {
		/*
		 * 获取对应的label 添加错误信息 显示label
		 */
		$("#" + id + "Error").text("长度必须在3-20之间！");
		showError($("#" + id + "Error"));
		return false;
	}

	return true;
}

function validateTestCategory() {
	var id = "testCategory";
	var value = $("#" + id).val();// 获取输入框内容

	if (value == 0) {
		$("#" + id + "Error").text("请选择测试类别！");
		showError($("#" + id + "Error"));
		return false;
	}
	return true;
}

function validateTestTaskDescribe() {
	var id = "testTaskDescribe";
	var value = $("#" + id).val();// 获取输入框内容
	/*
	 * ```````````` 1. 非空校验
	 */
	if (!value) {
		/*
		 * 获取对应的label 添加错误信息 显示label
		 */
		$("#" + id + "Error").text("任务描述不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if (value.length < 3 || value.length > 45) {
		/*
		 * 获取对应的label 添加错误信息 显示label
		 */
		$("#" + id + "Error").text("长度必须在3-45之间！");
		showError($("#" + id + "Error"));
		return false;
	}

	return true;
}

function validatePoolType() {
	var id = "poolType";
	var value = $("#" + id).val();// 获取输入框内容

	if (value == 0) {
		$("#" + id + "Error").text("请选择测试库资源类型！");
		showError($("#" + id + "Error"));
		return false;
	}
	return true;
}

function validatePoolSuitOrCase() {
	var id = "poolSuitOrCase";
	var value = $("#" + id).val();// 获取输入框内容

	if (value == 0) {
		$("#" + id + "Error").text("请选择测试库套件或用例！");
		showError($("#" + id + "Error"));
		return false;
	}
	return true;
}

function validateMachineInfo() {
	var id = "machineInfo";
	var value = $("#" + id).val();// 获取输入框内容

	if (value == 0) {
		$("#" + id + "Error").text("请选择机器！");
		showError($("#" + id + "Error"));
		return false;
	}
	return true;
}
/*
 * 判断当前元素是否存在内容，如果存在显示，不页面不显示！
 */
function showError(ele) {
	var text = ele.text();// 获取元素的内容
	if (!text) {// 如果没有内容
		ele.css("display", "none");// 隐藏元素
	} else {// 如果有内容
		ele.css("display", "");// 显示元素
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
		updateTCListInfo();
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
		document.getElementById("testTaskInfoTable").rows[9].cells[0].rowSpan = rowCount + 2;
		
	}				
}

function insertTr(index){
    var newIndex = parseInt(index) + 1;
	var rowIndex = 2*(parseInt(index));
	var newRow=document.getElementById('testCaseListTable').insertRow(rowIndex)
	newRow.style = "border:1px #ddd";
	var td1=newRow.insertCell(0)				   
	td1.innerHTML="<th>" + newIndex + "</th>";
	td1.style = "width:170px;";
	td1.id = "tc" + newIndex + "Index";
	
	
	var td2=newRow.insertCell(1)
	td2.innerHTML="<td><div><select class='inputClass'  id='tc" + newIndex + "Sel' onchange='selChange(this)'></select></div></td>";
	td2.style = "width:450px;";
	
	
	var td3=newRow.insertCell(2);
	td3.style = "border:1px #ddd;border-bottom:1px solid #A3A3A3;";
	td3.innerHTML="<td><a name='describe' onclick='showDescribe(this)'>说明</a> <a onclick='deleteRow(this)'>删除</a> <a onclick='addTestCase(this)'>插入</a></td>";
	document.getElementById("testCaseListTable").rows[rowIndex].cells[2].rowSpan = 2;
	
	var row2Index = rowIndex + 1;
	var new2Row=document.getElementById('testCaseListTable').insertRow(row2Index)
	new2Row.style = "border:1px #ddd;border-bottom:1px solid #A3A3A3;";
	var td4=new2Row.insertCell(0)				   
	td4.innerHTML="<th>Para" + "</th>";
	td4.style = "width:150px;";
	
	var td5=new2Row.insertCell(1)
	var paraId = "tc" + newIndex + "Para";
	td5.innerHTML="<input class='inputClass' style='text-align:center;' name="+ paraId + " id=" + paraId +" onchange='updateTCListInfo()' type=text/>";
	td5.style = "width:450px;";

	$("#" + paraId).bind("input propertychange change",function(event){
		updateTCListInfo();
	});
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
	var oldRowSpan = parseInt(document.getElementById("testTaskInfoTable").rows[9].cells[0].getAttribute("rowSpan"));
	var tcCount = parseInt(document.getElementById("testTaskInfoTable").rows[9].cells[0].getAttribute("rowSpan"))/2;
	if(oldRowSpan == 2){
		alert("第一行不能删除！");
	}
	else{
		$(a).parent().parent().next().remove();
		$(a).parent().parent().remove();	

		for(i=tcCount;i>=parseInt(rowNum)+1;i--){
			var indexId = "tc" + i + "Index";
			var indexObj = $("#" + indexId);					
			indexObj.text(i-1);
			var j = i-1;
			var indexAttr = "tc" + j + "Index";
		    indexObj.attr("id",indexAttr);
			
			var selId = "tc" + i + "Sel";
			var selObj = $("#" + selId);					
			var selAttr = "tc" + j + "Sel";
		    selObj.attr("id",selAttr);
			
			var paraId = "tc" + i + "Para";
			var paraObj = $("#" + paraId);					
			var paraAttr = "tc" + j + "Para";
		    paraObj.attr("id",paraAttr);
		}
		
		var newRowSpan = parseInt(oldRowSpan) - 2;
		document.getElementById("testTaskInfoTable").rows[9].cells[0].rowSpan = newRowSpan;
	}
	updateTCListInfo();
	
}

function updateTCListInfo(){				
	var tcCount = document.getElementById("testCaseListTable").rows.length / 2;
	var tcListInfo = "";
	for(var i=1;i<=tcCount;i++){
		var tcSelId = "tc" + i +  "Sel";
		var tcSelValue = $("#" + tcSelId).val();
		
		var tcParaId = "tc" + i +  "Para";
		var tcParaValue = $("#" + tcParaId).val();
		
		var info = "," + tcSelValue + ";" + tcParaValue;
		if(i == 1){
			tcListInfo +=  tcSelValue  + ";" + tcParaValue;	
		}
		else{
			tcListInfo += info;
		}
	}
	$("#testCaseCount").val(tcCount);
	$("#testCaseInfo").val(tcListInfo);
}

function selChange(a){				
	var selValue = $(a).val();
	
	if(selValue != 0){
		updateTCListInfo();
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