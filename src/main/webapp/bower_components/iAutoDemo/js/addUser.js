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
	
	
	$("#addUserForm").submit(function() {
		//alert("ins");
		var bool = true;//表示校验通过11
		if(!validateEmail()) {
			bool = false;
		}
		if(!validateUserId()) {
			bool = false;
		}
		if(!validatePhone()) {
			bool = false;
		}
		if(!validateQq()) {
			bool = false;
		}
		if(!validateWeChat()) {
			bool = false;
		}
		if(!validatePassword()) {
			bool = false;
		}
		if(!validateRoleIds()) {
			bool = false;
		}
		if(bool){
			var userId= $("#userId").val();
			var email= $("#email").val();
			var phone= $("#phone").val();
			var password= $("#password").val();
			var roleIds= [];
			roleIds.push($("#roleIds").val());
			var qq= $("#qq").val();
			var weChat= $("#weChat").val();
			var loginId= $("#loginId").val();
			var urlPath = document.getElementById("path").value+"/user.do/add";
	        var desPath = document.getElementById("path").value;
	        var user={
					"userId":userId,
					"email":email,
					"phone":phone,
					"password":password,
					"roleIds":roleIds,
					"qq":qq,
					"weChat":weChat,
					"loginId":loginId,
					
			};
			 $.ajax({  
			        data:JSON.stringify(user),  
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
			        },  
			 });  
		}
		return false;
	});
});
function validateEmail() {
	var id = "email";
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
		$("#" + id + "Error").text("邮箱地址不能为空！");
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
		$("#" + id + "Error").text("长度必须在3-45之间！");
		showError($("#" + id + "Error"));
		return false;
	}
	
	if(((value.split('@')).length-1)!=1)
	{
		$("#" + id + "Error").text("邮件名称必须符合公司规范!");
		showError($("#" + id + "Error"));
		return false;
	}
	
	var emailAdd = value.split('@')[1];
	if(emailAdd == "inspur.com"){
		
	}
	else{
		$("#" + id + "Error").text("邮件后缀必须为inspur.com!");
		showError($("#" + id + "Error"));
		return false;

	}
		
	var point=value.indexOf('@');
    document.getElementById("loginId").value=value.substring(0,point);
		 
	return true;
}

function validateUserId() {
	var id = "userId";
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
		$("#" + id + "Error").text("用户名称不能为空！");
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
		$("#" + id + "Error").text("长度必须在3-45之间！");
		showError($("#" + id + "Error"));
		return false;
	}
	 
	
	return true;
}

function validatePhone() {
	var id = "phone";
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
		$("#" + id + "Error").text("手机号不能为空！");
		showError($("#" + id + "Error"));
		return false;
	}
	/*
	 * 2. 长度校验
	 */
	if(value.length != 11) {
		/*
		 * 获取对应的label
		 * 添加错误信息
		 * 显示label
		 */
		$("#" + id + "Error").text("手机号码长度必须为11位！");
		showError($("#" + id + "Error"));
		return false;
	}
	 
	
	return true;
}

function validateQq() {
	var id = "qq";
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
		$("#" + id + "Error").text("QQ号不能为空！");
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
		$("#" + id + "Error").text("长度必须在3-45之间！");
		showError($("#" + id + "Error"));
		return false;
	}
	 
	
	return true;
}

function validateWeChat() {
	var id = "weChat";
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
		$("#" + id + "Error").text("微信号不能为空！");
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
		$("#" + id + "Error").text("长度必须在3-45之间！");
		showError($("#" + id + "Error"));
		return false;
	}
	 
	
	return true;
}

function validatePassword() {
	var id = "password";
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
		$("#" + id + "Error").text("密码不能为空！");
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
		$("#" + id + "Error").text("长度必须在3-45之间！");
		showError($("#" + id + "Error"));
		return false;
	}
	 
	
	return true;
}
function validateRoleIds() {
	var id = "roleIds";
	var value = $("#" + id).val();//获取输入框内容
	
	if(value == 0)
	{
		$("#" + id + "Error").text("请选择权限！");
		showError($("#" + id + "Error"));
		return false;
	}
	return true;
}
function showError(ele) {
	var text = ele.text();//获取元素的内容
	if(!text) {//如果没有内容
		ele.css("display", "none");//隐藏元素
	} else {//如果有内容
		ele.css("display", "");//显示元素
	}
}



