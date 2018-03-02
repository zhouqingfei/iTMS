<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>新建机器信息</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
<%-- <script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/addTestCase.js"></script> --%>
	
	<style>        
        .table {
            border: 2px;
        }
        
        .table th,
        .table td {
            vertical-align: middle!important;
        }
        
        .table th {
            width: 30%;
        }
        
        .table caption {
            text-align: center;
            vertical-align: middle!important;
        }
        
        .table th {
            font-size: 15px;
        }
        
        .table tr {
            width: 200px;
        }
        
        .table td {
            font-size: 13px;
        }
        
        .table td select {
            width: 100%;
            height: 100%;
        }
        
        .ul li a {
            background-color: #31B0D5;
        }
        
        .errorClass {
            color: #f40000;
            font-size: 10pt;
            position: absolute;
            top: 5px;
            right: 10px;
        }
        
        .inputDivClass {
            position: relative;
            margin-left: 2px;
        }
        
        .inputClass {
            height: 30px;
            border: none;
            width: 100%;
            padding-left: 10px;
        }
	</style>
	<script>
		$(function() {
	    	var type = "${machineInfo.type}";
	    	if(type == "SUT"){
	    		$("#type").val("1");
	    	}
	    	if(type == "TEM"){
	    		$("#type").val("2");
	    	}
	    	
	    	/*
			 * 1. 得到所有的错误信息，循环遍历之。调用一个方法来确定是否显示错误信息！
			 */
			$(".errorClass").each(function() {
				showError($(this));//遍历每个元素，使用每个元素来调用showError方法
			});
	
			/*
			 * 2. 输入框得到焦点隐藏错误信息
			 */
			$(".inputClass").focus(function() {
				var labelId = $(this).attr("id") + "Error";//通过输入框找到对应的label的id
				$("#" + labelId).text("");//把label的内容清空！
				showError($("#" + labelId));//隐藏没有信息的label
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
	    }); 
    
		function save() {
			var bool = true;//表示校验通过
			if(!validateModel()) {
				bool = false;
			}
			if(!validateType()) {
				bool = false;
			}
			if(!validateHostMacAddr()) {
				bool = false;
			}
			if(!validateBmcId()) {
				bool = false;
			}
			if(!validateBmcPwd()) {
				bool = false;
			}
			if(!validateBmcMacAddr()) {
				bool = false;
			}
			if(!validateUser()) {
				bool = false;
			}
			if(!validateComment()) {
				bool = false;
			}
			if(bool)
			{
				var r=confirm("确定存储该机器信息？")
		    	if (r==true)
			    {
					var model=$("#model").val();
					var type = $("#type").find("option:selected").text();
					var host_mac = $("#hostMacAddr").val();
					var bmc_mac = $("#bmcMacAddr").val();
					var user = $("#user").val();
					var bmc_user=$("#bmcId").val();
					var bmc_psd=$("#bmcPwd").val();
					var comment = $("#comment").val();
					
		    	    var urlPath =  "${pageContext.request.contextPath}" + "/machineLeader.do/save";
		    	   // var urlPath = document.getElementById("path").value+"/testCase.do/add";
					var machine = {
							"model":model,
							"type":type,
							"host_mac":host_mac,
							"bmc_mac":bmc_mac,
							"user":user,
							"bmc_user":bmc_user,
							"bmc_psd":bmc_psd,
							"comment":comment,
							};
					 $.ajax({  
					        data:JSON.stringify(machine),   
					        type:"POST",
					        contentType :'application/json; charset=utf-8',
					        url:urlPath, 
					        dataType: "text",
					        error:function(data){  
					            alert("出错了:"+data);  
					        },  
					        success:function(data){
					        	alert("成功:"+data); 
					        }
					});
				}
			}	    
		}
		
		function validateModel() {
			var id = "model";
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
				$("#" + id + "Error").text("机器型号不能为空！");
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
	
		function validateType() {
			var id = "type";
			var value = $("#" + id).val();//获取输入框内容
			
			if(value == 0)
			{
				$("#" + id + "Error").text("请选择机器用途！");
				showError($("#" + id + "Error"));
				return false;
			}
			return true;
		}
	
		function validateHostMacAddr() {
			var id = "hostMacAddr";
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
				$("#" + id + "Error").text("请输入HostMac地址！");
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
	
		function validateBmcId() {
			var id = "bmcId";
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
				$("#" + id + "Error").text("BMC用户名不能为空！");
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
	
		function validateBmcPwd() {
			var id = "bmcPwd";
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
				$("#" + id + "Error").text("BMC密码不能为空！");
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
	
		function validateBmcMacAddr() {
			var id = "bmcMacAddr";
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
				$("#" + id + "Error").text("BMC的Mac地址不能为空！");
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
	
		function validateUser() {
			var id = "user";
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
				$("#" + id + "Error").text("账号不能为空！");
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
		
		function validateComment() {
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

	</script>
</head>

<body>
	<jsp:include page="top.jsp" flush="true" />
	
    <div class="view-body" style="min-width:1480px;">
        <div class="container" style="width: 90%;float:left; margin-top: 30px;margin-left: 50px;">
            <table class="table table-striped table-bordered table-hover">
                <caption style="color: black; font-size: 23px; font-family: LiSu">新建机器信息</caption>
                <tr>
                    <th width="60px">机器序号</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" disabled name="id" id="id" type=text value="${id}" placeholder="&nbsp机器序号......" />
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>机器型号</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" name="model" id="model" type=text value="" placeholder="&nbsp请输入机器型号......" /> <label class="errorClass" id="modelError"></label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>机器用途（待测机SUT/执行机TEM）</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <select class="inputClass" name="type" id="type" style="width: 100%; height: 30px;">
                                <option value="0">==请选择==</option>
                                <option value="1">SUT</option>
                                <option value="2">TEM</option>
                            </select> <label class="errorClass" id="typeError"></label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>主机网络实体地址（Host MAC Address）</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" name="hostMacAddr" id="hostMacAddr" type=text value="" placeholder="&nbsp请输入主机网络实体地址......" /> <label class="errorClass" id="hostMacAddrError"></label>
                        </div>
                    </td>
                </tr>
                
                <tr>
                    <th>BMC登入账号（BMC ID）</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" name="bmcId" id="bmcId" type=text value="" placeholder="&nbsp请输入BMC账号......" /> <label class="errorClass" id="bmcIdError"></label>
                        </div>
                    </td>
                </tr>
                
                <tr>
                    <th>BMC登入密码（BMC PassWord）</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" name="bmcPwd" id="bmcPwd" type=text value="" placeholder="&nbsp请输入BMC密码......" /> <label class="errorClass" id="bmcPwdError"></label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>BMC网络实体地址（BMC MAC Address）</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" name="bmcMacAddr" id="bmcMacAddr" type=text value="" placeholder="&nbsp请输入BMC网络实体地址......" /> <label class="errorClass" id="bmcMacAddrError"></label>
                        </div>
                    </td>
                </tr>
                
                <tr>
                    <th>使用者账号（User）</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" name="user" id="user" type=text value="" placeholder="&nbsp使用者账号......" /> <label class="errorClass" id="userError"></label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>备注（Comment）</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" name="comment" id="comment" type=text value="" placeholder="&nbsp请输入备注......" /> <label class="errorClass" id="testCaseDescribeError"></label>
                        </div>
                    </td>
                </tr>

                <input hidden name="userLoginId" type=text value="dengzhenhong" />

                <input hidden name="modifyTime" type=text value="2017-09-01" />

            </table>
        </div>
         <input type="submit" value="储存信息" id="savaBtn" onclick="save();" class="btn btn-large btn-primary" style="position:absolute;right:20px;top:180px;">
        </input>
        <a href="${pageContext.request.contextPath}/machineLeader.do/addMachine.view" id="backBth" class="btn btn-large btn-primary" style="position: absolute; right: 20px; top: 220px;">返回前页</a>
    </div>
</body>
</html>