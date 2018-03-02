<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>线上预装</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
	
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
	    	//alert("${machineInfo.model}");
	    }); 
		function save() {
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
				
	    	    var urlPath =  "${pageContext.request.contextPath}" + "/machine.do/save";
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
	</script>
</head>

<body>
	<jsp:include page="top.jsp" flush="true" />
	
    <div class="view-body" style="min-width:1200px;">
        <div class="container" style="width: 90%;float:left; margin-top: 30px;margin-left: 50px;">
            <table class="table table-striped table-bordered table-hover">
                <caption style="color: black; font-size: 23px; font-family: LiSu">线上预装</caption>
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
                            <input disabled class="inputClass" name="model" id="model" type=text value="${machineInfo.model}" placeholder="&nbsp请输入机器型号......" /> <label class="errorClass" id="testCaseNameError"></label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>预装类型</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <select class="inputClass" name="type" id="type" style="width: 100%; height: 30px;">
                                <option value="0">==请选择==</option>
                                <option value="1">OS</option>
                                <option value="2">AEP</option>
                                <option value="3">BMC</option>
                                <option value="4">BIOS</option>
                            </select> <label class="errorClass" id="temSutError"></label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>主机网络实体地址（Host MAC Address）</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input disabled class="inputClass" name="hostMacAddr" id="hostMacAddr" type=text value="${machineInfo.host_mac}" placeholder="&nbsp请输入主机网络实体地址......" /> <label class="errorClass" id="testCaseIdError"></label>
                        </div>
                    </td>
                </tr>
                
                <tr>
                    <th>OS版本</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" name="osVer" id="osVer" type=text value="" placeholder="&nbsp请输入OS版本......" /> <label class="errorClass" id="testCaseIdError"></label>
                        </div>
                    </td>
                </tr>
                
                <tr>
                    <th>BMC版本</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" name="bmcVer" id="bmcVer" type=text value="" placeholder="&nbsp请输入BMC版本......" /> <label class="errorClass" id="testCaseIdError"></label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>BMC地址</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" name="bmcLocation" id="bmcLocation" type=text value="" placeholder="&nbsp请输入BMC FTP地址......" /> <label class="errorClass" id="testCaseIdError"></label>
                        </div>
                    </td>
                </tr>
                
                <tr>
                    <th>BIOS版本</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" name="biosVer" id="biosVer" type=text value="" placeholder="&nbsp请输入BIOS版本......" /> <label class="errorClass" id="testCaseIdError"></label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>BIOS地址</th>
                    <td colspan="2">
                        <div class="inputDivClass">
                            <input class="inputClass" name="biosLocation" id="biosLocation" type=text value="" placeholder="&nbsp请输入BIOS FTP地址......" /> <label class="errorClass" id="testCaseDescribeError"></label>
                        </div>
                    </td>
                </tr>

                <input hidden name="userLoginId" type=text value="dengzhenhong" />

                <input hidden name="modifyTime" type=text value="2017-09-01" />

            </table>
        </div>
         <input type="submit" value="确认" id="savaBtn" onclick="save();" class="btn btn-large btn-primary" style="position:absolute;right:20px;top:180px;">
        </input>
        <a href="" id="backBth" class="btn btn-large btn-primary" style="position: absolute; right: 20px; top: 220px;">返回前页</a>
    </div>
</body>
</html>