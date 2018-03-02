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
	$(".inputClass").blur(
			function() {
				var id = $(this).attr("id");// 获取当前输入框的id
				var funName = "validate" + id.substring(0, 1).toUpperCase()
						+ id.substring(1) + "()";// 得到对应的校验函数名
				eval(funName);// 执行函数调用
	});
	
	/*
	 * 5. 表单提交时进行校验
	 */
	$("#editTestCaseForm").submit(function() {
		//alert("nimei");
		var bool = true;//表示校验通过
		if(!validateTestCaseName()) {
			bool = false;
		}
		if(!validateTestCaseId()) {
			bool = false;
		}
		if(!validateTestCaseDescribe()) {
			bool = false;
		}
		if(!validateScriptConfigName()) {
			bool = false;
		}
		if(!validateScriptConfigParm()) {
			bool = false;
		}
		if(!validateScriptExplain()) {
			bool = false;
		}
		if(!validateTemSut()) {
			bool = false;
		}
		if(!validateTestCategory()) {
			bool = false;
		}
		if(bool){
			var id = $("#id").val();
			var testCaseName=$("#testCaseName").val();
			var temSut = $("#temSut").find("option:selected").text();
			var testCaseId = $("#testCaseId").val();
			var testCategory = $("#testCategory").find("option:selected").text();
			var testCaseDescribe = $("#testCaseDescribe").val();
			var scriptConfigName = $("#scriptConfigName").val();
			var scriptConfigSrcPath = $("#scriptConfigSrcPath").val();
			var scriptConfigDesPath = $("#scriptConfigDesPath").val();
			var logPath = $("#logPath").val();		
			var scriptRecordType = $("#scriptRecordType").find("option:selected").text();
			var scriptConfigParm = $("#scriptConfigParm").val();		
			var scriptExplain = $("#scriptExplain").val();		
			var urlPath = document.getElementById("path").value+"/testCaseDeveloper.do/update";
			var desPath = document.getElementById("path").value+"/testCaseDeveloper.do/index.view";
			var testcase = {
					"id":id,
					"testCaseName":testCaseName,
					"temSut":temSut,
					"testCaseId":testCaseId,
					"testCategory":testCategory,
					"testCaseDescribe":testCaseDescribe,
					"scriptConfigName":scriptConfigName,
					"scriptConfigSrcPath":scriptConfigSrcPath,
					"scriptConfigDesPath":scriptConfigDesPath,
					"logPath":logPath,
					"scriptRecordType":scriptRecordType,
					"scriptConfigParm":scriptConfigParm,
					"scriptExplain":scriptExplain,
					};
			 $.ajax({  
			        data:JSON.stringify(testcase),  
			        type:"POST",
			        contentType :'application/json; charset=utf-8',
			        url:urlPath, 
			        dataType: "text",
			        error:function(data){  
			            alert("出错了！！:"+data);  
			        },  
			        success:function(data){  
			            alert("success:"+data);
			            location.href=desPath;        
			        }  
			 });  
		}
		return false;
	});
});

function validateTestCaseName() {
	var id = "testCaseName";
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
		$("#" + id + "Error").text("用例名称不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if(value.length < 3 || value.length > 45) {
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

function validateTestCaseId() {
	var id = "testCaseId";
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
		$("#" + id + "Error").text("测试用例编号不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if(value.length < 3 || value.length > 45) {
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

function validateTestCaseDescribe() {
	var id = "testCaseDescribe";
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
		$("#" + id + "Error").text("测试用例描述不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if(value.length < 3 || value.length > 45) {
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
	if(value.length < 3 || value.length > 45) {
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
	if(value.length < 3 || value.length > 45) {
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
	if(value.length < 3 || value.length > 45) {
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

function validateTestCategory() {
	var id = "testCategory";
	var value = $("#" + id).val();//获取输入框内容
	
	if(value == 0)
	{
		$("#" + id + "Error").text("请测试类别！");
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
