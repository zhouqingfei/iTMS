<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>编辑测试任务</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/editTestTaskTester.js"></script>
<style>
.container {
	width: 90%;
	margin-left: 100px;
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
	height: 30px;
}

.ul li a {
	background-color: #31B0D5;
}

.table tbody tr td {
	padding: 0px 0px 0px 0px;
	height: 30px;
}

.table tr td a:hover {
	cursor: pointer;
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
	$(document).ready(function() {
			$("#testCategory").val("${testTask.testCategory}");
			$("#poolType").val("${testTask.poolType}");
			$("#poolSuitOrCase").val("${testTask.poolSuitOrCase}");
			$("#machineInfo").val("${testTask.machineInfo}");
			
			$("#testCaseInfo").val("${testTask.testCaseInfo}");
			var testCaseInfo = "${testTask.testCaseInfo}";

			var optionData = [];
			var firstOption = "<option value='0'>==请选择==</option>";
			optionData.push(firstOption);
			<c:forEach var="testCase" items="${testCaseList}">
			var data = "<option value='${testCase.id}'>${testCase.testCaseName}</option>";
			optionData.push(data);
			</c:forEach>			   

			loadTestCase(testCaseInfo, optionData);
			
			
			var temOptionData = [];
		    var sutOptionData = [];
        
		    var firstOption = "<option value='0'>==请选择==</option>";
		    temOptionData.push(firstOption);
		    sutOptionData.push(firstOption);
		   
	        <c:forEach var="tem" items="${temList}">
	            //alert("${tem.model}");
		        var data="<option value='${tem.host_mac}'>${tem.host_mac}(${tem.host_ip},${tem.addr})</option>"; 
		        temOptionData.push(data);
		    </c:forEach>
		    
			$("#temSelect").html("");
   		    for(var i= 0; i < temOptionData.length; i++){    
   		        $("#temSelect").append(temOptionData[i]);  
   		    }      
		    
   		    
   			 <c:forEach var="sut" items="${sutList}">
	         //alert("${tem.model}");
		        var data="<option value='${sut.host_mac}'>${sut.host_mac}(${sut.host_ip},${sut.model})</option>"; 
		        sutOptionData.push(data);
		    </c:forEach>
		    
			$("#sutSelect").html("");
		    for(var i= 0; i < sutOptionData.length; i++){    
		        $("#sutSelect").append(sutOptionData[i]);  
		    }
		    
		    var poolSuitOrCaseName = $("#poolSuitOrCase").val();
	        var type = poolSuitOrCaseName.substring(0,3);
	       
	        if(type == "TEM"){
	        	$("#temSelect").attr("disabled",false);
	        }if(type == "SUT"){
	        	$("#temInfo").val("");
	        	$("#temSelect").attr("disabled",true);
	        	$("#temSelect option:first").prop("selected",'selected');
	        }
		});
	
	function loadTestCase(testCaseInfo, optionData) {
		var testCaseList = testCaseInfo.split(",");
		var testCaseValueList = [];
		var testCaseParamList = [];
		for (var i = 0; i < testCaseList.length; i++) {
			var testCaseInfoList = testCaseList[i].split(";");
			testCaseValueList.push(testCaseInfoList[0]);
			testCaseParamList.push(testCaseInfoList[1]);
		}
		var testCaseCount = testCaseValueList.length;

		$("#testCaseListTable").html("");

		$("#rowSpanTh").attr("rowSpan", testCaseCount)

		var selId = "";

		var count=0;
		for (var i = 0; i < testCaseValueList.length; i++) {
			var newIndex = i + 1;
			var newRow = document.getElementById('testCaseListTable')
					.insertRow(count)
					count++;
			newRow.style = "margin-top:5px;";

			var td1 = newRow.insertCell(0)
			td1.innerHTML = "<td>" + newIndex + "</td>";
			td1.id = "tc" + newIndex + "Index";
			;
			td1.style = "width:150px"

			var td2 = newRow.insertCell(1)
			td2.innerHTML = "<td><div><select class='inputClass'  id='tc"
					+ newIndex
					+ "Sel' onchange='selChange(this)'></select></div></td>";

			var td3 = newRow.insertCell(2)
			td3.innerHTML = "<td><a>说明</a> <a onclick='deleteRow(this)'>删除</a> <a onclick='addTestCase(this)'>插入</a></td>";

			var new2Row = document.getElementById('testCaseListTable')
					.insertRow(count)
					count++;
			new2Row.style = "border:1px #ddd;border-bottom:1px solid #A3A3A3;";
			var td4 = new2Row.insertCell(0)
			td4.innerHTML = "<th>Para" + "</th>";
			td4.style = "width:150px;";
			var td5=new2Row.insertCell(1)
			var paraId = "tc" + newIndex + "Para";
			td5.innerHTML="<input class='inputClass' style='text-align:center;' name="+ paraId + " id=" + paraId +" onchange='updateTCListInfo()' type=text/>";
			td5.style = "width:450px;";
			
			selId = "tc" + newIndex + "Sel";
			for (var j = 0; j < optionData.length; j++) {
				$('#' + selId).append(optionData[j]);
			}
		}

		for (var i = 0; i < testCaseValueList.length; i++) {
			var newIndex = i + 1;
			selId = "tc" + newIndex + "Sel";
			paraId="tc" + newIndex + "Para";
			$('#' + selId).val(testCaseValueList[i])
			$('#' + paraId).val(testCaseParamList[i])
		}
	}
	
	function typeChange(){
        var poolSuitOrCaseName = $("#poolSuitOrCase").val();
        var type = poolSuitOrCaseName.substring(0,3);
       
        if(type == "TEM"){
        	$("#temSelect").attr("disabled",false);
        }if(type == "SUT"){
        	$("#temInfo").val("");
        	$("#temSelect").attr("disabled",true);
        	$("#temSelect option:first").prop("selected",'selected');
        }
    }
    
    function temChange(){
      //  $("#machineInfo").val("");
        var temSelect = $("#temSelect").val();
        $("#temInfo").val(temSelect);
    }
    
    function sutChange(){
    	//$("#temInfo").val("");
        var sutSelect = $("#sutSelect").val();
        $("#sutInfo").val(sutSelect);
    }
</script>
</head>

<body>
	<jsp:include page="top.jsp" flush="true" />
	<div class="view-body">
		<div class="container">
			<form class="form-inline" id="editTestTaskForm">
				<table class="table table-striped table-bordered table-hover"
					name="testTaskInfoTable" id="testTaskInfoTable">
					<caption style="color: black; font-size: 23px; font-family: LiSu">编辑测试任务</caption>
					<tr>
						<th colspan="2">任务编号
						</td>
						<td colspan="3"><input class="inputClass" name="id" id="id"
							type=text value="${testTask.id}" disaabled /></td>
					</tr>

					<tr>
						<th colspan="2">任务名称</th>
						<td colspan="3">
							<div class="inputDivClass">
								<input class="inputClass" name="testTaskName" id="testTaskName"
									placeholder="&nbsp请输入任务名称......" type=text
									value="${testTask.testTaskName}" /> <label class="errorClass"
									id="testTaskNameError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th colspan="2">专案名称</th>
						<td colspan="3">
							<div class="inputDivClass">
								<input class="inputClass" name="specialCaseName"
									id="specialCaseName" placeholder="&nbsp请输入专案名称......" type=text
									value="${testTask.specialCaseName}" /> <label
									class="errorClass" id="specialCaseNameError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th colspan="2">机器型号</th>
						<td colspan="3">
							<div class="inputDivClass">
								<input class="inputClass" name="machineType" id="machineType"
									placeholder="&nbsp请输入机器型号......" type=text
									value="${testTask.machineType}" /> <label class="errorClass"
									id="machineTypeError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th colspan="2">测试类别</th>
						<td colspan="3">
							<div class="inputDivClass">
								<select class="inputClass" name="testCategory" id="testCategory"
									style="width: 100%; height: 30px;">
									<option value="0">==请选择==</option>
									<option value="SIT">SIT</option>
									<option value="BIOS">BIOS</option>
									<option value="BMC">BMC</option>
									<option value="Other">Other</option>
								</select> <label class="errorClass" id="testCategoryError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th colspan="2">任务描述</th>
						<td colspan="3">
							<div class="inputDivClass">
								<input class="inputClass" name="testTaskDescribe"
									id="testTaskDescribe" placeholder="&nbsp请输入任务描述......"
									type=text value="${testTask.testTaskDescribe}" /> <label
									class="errorClass" id="testTaskDescribeError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th colspan="2">测试库资源类型</th>
						<td colspan="3">
							<div class="inputDivClass">
								<select class="inputClass" name="poolType" id="poolType"
									style="width: 100%; height: 30px;">
									<option value="0">==请选择==</option>
									<option value="测试套件">测试套件</option>
									<option value="测试用例">测试用例</option>
								</select> <label class="errorClass" id="poolTypeError"></label>
							</div>
						</td>
					</tr>

					<tr>
						<th colspan="2">测试库套件或用例</th>
						<td colspan="2">
							<div class="inputDivClass">
								<select class="inputClass" name="poolSuitOrCase"
									id="poolSuitOrCase" style="width: 100%; height: 30px;" onchange="typeChange();">
									<option value="0">==请选择==</option>
									<option value="TEM_BMC_POWON">TEM_BMC_POWON</option>
									<option value="SUT_BMC_POWON">SUT_BMC_POWON</option>
								</select> <label class="errorClass" id="poolSuitOrCaseError"></label>
							</div>
						</td>
						<td><a name="poolSuitOrCaseExplain"
							id="poolSuitOrCaseExplain">说明</a></td>
					</tr>

					<tr>
						<th colspan="2">执行机（TEM）</th>
						<td>
							<div class="inputDivClass">
								<select disabled class="inputClass" name="temSelect" id="temSelect"
									style="width: 100%; height: 30px;"  onchange="temChange();">
								</select> 
							</div>
						</td>
						<th>待测机（SUT）</th>
						<td>
							<div class="inputDivClass">
								<select class="inputClass" name="sutSelect" id="sutSelect"
									style="width: 100%; height: 30px;" onchange="sutChange();">					
								</select>
							</div>
						</td>
					</tr>

					<tr id="tcList">
						<th rowspan="2" colspan="2" style="background: #FFF;">测试用例工作流</th>
						<td colspan="3">
							<table style="width: 100%;" id="testCaseListTable"
								name="testCaseListTable">
								
								<tr style="border: 1px #ddd; border-bottom: 1px solid #A3A3A3;">
									<td width="170px" id="tc1ParaName">Para</td>
									<td width="450px"><input class="inputClass"
										style="text-align: center;" name="tc1Para" id="tc1Para"
										oninput="updateTCListInfo()" type=text value="" /></td>
								</tr>
								<table>

									</td>
									</tr>
								</table>
								<input type="submit" value="储存任务"
									class="btn btn-large btn-primary"
									style="position: absolute; right: 20px; top: 170px;">
								</input>
								<div class="sideBut">
									<a href="${pageContext.request.contextPath}/testTaskTester.do/index.view"
										class="btn btn-large btn-primary"
										style="position: absolute; right: 20px; top: 210px;">返回前页</a>
									<input hidden style="position: absolute; right: 20px; top: 300px;"
										name="testCaseCount" id="testCaseCount" type=text value="" />
									<input hidden style="position: absolute; right: 20px; top: 350px;"
										name="testCaseInfo" id="testCaseInfo" type=text value="" />
										
								</div>
								</form>
								<input hidden id="path" value="${pageContext.request.contextPath}" />
								<input hidden id="process" value="${testTask.process}"  />
								<input hidden style="position:absolute;right:20px;top:400px;" name="temInfo" id="temInfo" type=text value=""/>
								<input hidden style="position:absolute;right:20px;top:450px;" name="sutInfo" id="sutInfo" type=text value=""/>
								</div>
							</div>
</body>
</html>