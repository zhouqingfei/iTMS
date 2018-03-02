/*$(function() {
	
		$("#addUserForm").submit(function() {
			alert("ww");
			var userId= $("#userId").val();
			var email= $("#email").val();
			var phone= $("#phone").val();
			var password= $("#password").val();
			var roleIds= [];
			roleIds.push($("#roleIds").val());
			var urlPath = document.getElementById("path").value+"/user.do/add";
		    var desPath = document.getElementById("path").value;
			var user={
					"userId":userId,
					"email":email,
					"phone":phone,
					"password":password,
					"roleIds":roleIds,				
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
			            //location.href=desPath;        
			        },  
			 });  
		
	});
});

*/

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
	
	
	$("#addNumberForm").submit(function() {
		//alert("nimei333");
		var bool = true;//表示校验通过11
		
		if(!validateUserId()) {
			bool = false;
		}
		
		if(bool){
			var userId= $("#userId").val();
			var urlPath = document.getElementById("path").value+"/userLeader.do/addNumber";
	        var desPath = document.getElementById("path").value+"/userAdminLeader.do/userAdmin.view";
	        var user={
					"userId":userId,
					
					
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
			            alert(data);
			            //location.href=desPath;        
			        },  
			 });  
		}
		return false;
	});
});
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

function showError(ele) {
	var text = ele.text();//获取元素的内容
	if(!text) {//如果没有内容
		ele.css("display", "none");//隐藏元素
	} else {//如果有内容
		ele.css("display", "");//显示元素
	}
}

