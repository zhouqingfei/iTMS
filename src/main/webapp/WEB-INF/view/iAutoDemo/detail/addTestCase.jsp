<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>新增测试用例</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/addTestCase.js"></script>
	
	<style>
		.container {
			width: 90%;
			margin-left: 200px;
			margin-top: 30px;
		}
		
		.table {
			border: 2px;
		}
		
		.table th, .table td, .table caption {
			text-align: center;
			vertical-align: middle !important;
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
		
		.table tbody tr td {
			padding: 0px 0px 0px 0px;
			height: 30px;
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
		function changeName() {
			var testCaseName = "";
		    var temSut = $("#temSut").find("option:selected").text();
		    var testCategory = $("#testCategory").find("option:selected").text();
		    var testCaseDescribe = $("#testCaseDescribe").val();
			if(temSut != "==请选择=="){
				testCaseName = temSut + "_";
			}
			else{
				testCaseName = "_"
			}
			if(testCategory != "==请选择=="){
				testCaseName = testCaseName + testCategory;
			}
			else{
				testCaseName = testCaseName + "_"
			}
			if(testCaseDescribe != ""){
				testCaseName =  testCaseName  + "_" + testCaseDescribe;
			}
			
			$("#testCaseName").val(testCaseName);
		}	
	</script>
</head>

<body>
	<jsp:include page="top.jsp" flush="true" />

	<div class="view-body">
		<div class="container">
			<form class="form-inline" id="addTestCaseForm">	
				<table class="table table-striped table-bordered table-hover">
					<caption style="color: black; font-size: 23px; font-family: LiSu">新增测试用例</caption>
					<tr>
						<th width="120px">用例序号</th>
						<td colspan="2">
							<div class="inputDivClass">
								<input class="inputClass" name="id" id="id" type=text value=""
									placeholder="&nbsp案例序号......" />
							</div>
						</td>
					</tr>

					<tr>
						<th>用例名称</th>
						<td colspan="2">
							<div class="inputDivClass">
								<input disabled class="inputClass" name="testCaseName" id="testCaseName"
									type=text value="" placeholder="&nbsp请输入案例名称......" /> <label
									class="errorClass" id="testCaseNameError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th>执行类型</th>
						<td colspan="2">
							<div class="inputDivClass">
								<select  onchange="changeName()" class="inputClass" name="temSut" id="temSut"
									style="width: 100%; height: 30px;">
									<option value="0">==请选择==</option>
									<option value="1">SUT</option>
									<option value="2">TEM</option>
								</select> <label class="errorClass" id="temSutError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th>测试用例编号</th>
						<td colspan="2">
							<div class="inputDivClass">
								<input class="inputClass" name="testCaseId" id="testCaseId"
									type=text value="" placeholder="&nbsp请输入测试案例编号......" /> <label
									class="errorClass" id="testCaseIdError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th>测试类别</th>
						<td colspan="2">
							<div class="inputDivClass">
								<select onchange="changeName()" class="inputClass" name="testCategory" id="testCategory"
									style="width: 100%; height: 30px;">
									<option value="0">==请选择==</option>
									<option value="1">SIT</option>
									<option value="2">BIOS</option>
									<option value="3">BMC</option>
									<option value="4">Other</option>
								</select> <label class="errorClass" id="testCategoryError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th>用例描述</th>
						<td colspan="2">
							<div class="inputDivClass">
								<input oninput="changeName();" onpropertychange="changeName();" class="inputClass" name="testCaseDescribe"
									id="testCaseDescribe" type=text value=""
									placeholder="&nbsp请输入测试描述......" /> <label class="errorClass"
									id="testCaseDescribeError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th rowspan="7" style="background: #FFF;">测试脚本设置</th>
						<th width="180px">脚本名称</th>
						<td>
							<div class="inputDivClass">
								<input class="inputClass" name="scriptConfigName"
									id="scriptConfigName" type=text value=""
									placeholder="&nbsp请输入脚本名称......" /> <label class="errorClass"
									id="scriptConfigNameError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th>脚本下载路径</th>
						<td>
							<div class="inputDivClass">
								<input class="inputClass" name="scriptConfigSrcPath" id="scriptConfigSrcPath" type=text
									value="/usr/local/Inspur/BMC" /> <label class="errorClass"
									id="scriptConfigSrcPatheError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th>脚本执行路径</th>
						<td>
							<div class="inputDivClass">
								<input class="inputClass" name="scriptConfigDesPath" id="scriptConfigDesPath" type=text
									value="/usr/local/Inspur/BMC" /> <label class="errorClass"
									id="scriptConfigDesPathError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th>日志存放路径</th>
						<td>
							<div class="inputDivClass">
								<input class="inputClass" name="logPath" id="logPath" type=text
									value="/usr/local/Inspur/AEP/BMC/Log" /> <label
									class="errorClass" id="LogPathError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th>脚本档案类型</th>
						<td>
							<div class="inputDivClass">
								<select class="inputClass" name="scriptRecordType" id="scriptRecordType"
									style="width: 100%; height: 30px;">
									<option value="0">==请选择==</option>
									<option value="1">*.sh</option>
									<option value="2">*.jar</option>
									<option value="3">*.py</option>
									<option value="4">*.exe</option>
								</select> <label class="errorClass" id=""></label>
							</div>
						</td>
					</tr>

					<tr>
						<th>脚本参数</th>
						<td>
							<div class="inputDivClass">
								<input class="inputClass" name="scriptConfigParm"
									id="scriptConfigParm" type=text value=""
									placeholder="&nbsp请输入参数......" /> <label class="errorClass"
									id="scriptConfigParmError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th>脚本说明</th>
						<td>
							<div class="inputDivClass">
								<input class="inputClass" name="scriptExplain"
									id="scriptExplain" type=text value=""
									placeholder="&nbsp请输入脚本说明......" /> <label class="errorClass"
									id="scriptExplainError"></label>
							</div>
						</td>
					</tr>
					<input hidden name="userLoginId" type=text value="dengzhenhong" />

					<input hidden name="modifyTime" type=text value="2017-09-01" />

				</table>
			
				<input type="submit" value="储存用例" class="btn btn-large btn-primary"
					style="position: absolute; right: 20px; top: 170px;">
				</input>
			</form>
			<input hidden id="path" value="${pageContext.request.contextPath}" />
			<a href="${pageContext.request.contextPath}/testCase.do/index.view"
				class="btn btn-large btn-primary"
				style="position: absolute; right: 20px; top: 220px;">返回前页</a>
			
		</div>
	</div>
</body>
</html>