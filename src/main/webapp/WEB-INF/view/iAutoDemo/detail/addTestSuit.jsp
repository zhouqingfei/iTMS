<%@ page language="java" contentType="text/html; charset=utf-8"
    %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8">
		<title>新增测试套件</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css"/>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/addTestSuit.js"></script>
		
		<style>
		   	.container{
				width:90%;
				margin-left:200px;
				margin-top:30px;
			}
			.table{
				border:2px;
			}
			.table th, .table td, .table caption{ 
				text-align: center;
				vertical-align: middle!important;
			}
			.table th{
				font-size:15px;
			}
			.table tr{
				width:200px;
			}
			.table td{
				font-size:13px;
			}
			.table td select{
				width:100%;
				height:30px;
			}
			.ul li a{
				background-color:#31B0D5;
			}

			.table tr td a:hover{
				cursor:pointer;
			}
			.errorClass {color: #f40000; font-size:10pt;position:absolute;top:5px;right:10px;}
			.inputDivClass{position:relative;margin-left:2px;}
			.inputClass{height:30px;border:none;width:100%;padding-left:10px;}
			
			.black_overlay {
	            display: none;
	            position: absolute;
	            top: 0%;
	            left: 0%;
	            width: 100%;
	            height: 100%;
	            background-color: #d6c8c8;
	            z-index: 1001;
	            -moz-opacity: 0.8;
	            opacity: .80;
	            filter: alpha(opacity=88);
	        }
	        
	        .white_content {
	            display: none;
	            position: absolute;
	            top: 55%;
	            right: 3%;
	            width: 15%;
	            height: 10%;
	            padding: 20px;
	            border: 2px solid rgb(202, 199, 192);
	            background-color: white;
	            z-index: 1002;
	            overflow: auto;
	        }
		</style>
		<script>
			var testCaseMap = null;  
			$(document).ready(function(){  
			   
			   var optionData = [];
			   testCaseMap = [];
			   
			   var firstOption = "<option value='0'>==请选择==</option>";
			   optionData.push(firstOption);
				<c:forEach var="testCase" items="${testCaseList}">
					 var data="<option value='${testCase.id}'>${testCase.testCaseName}</option>"; 
					 optionData.push(data);
					 var jsonObj={id:"${testCase.id}",describe:"${testCase.testCaseDescribe}"};
					 testCaseMap.push(jsonObj);
				</c:forEach>			   
			});
			
			function showDescribe(a){
				 var id = $(a).parent().prev().children(":first").children(":first").find("option:selected").val();
				 if(id != 0){
					 for(var i=0;i<testCaseMap.length;i++)
	                 {
	                    if(id == testCaseMap[i].id){
	                    	$("#describeContent").text(testCaseMap[i].describe);
	                    }                        
	                 } 
					 document.getElementById('light').style.display='block';
					 document.getElementById('fade').style.display='block';
				 }					
			}
			
			function showFirstDescribe(){
				
				 var id =  $("#tc1Sel ").val();
				 if(id != 0){
					 for(var i=0;i<testCaseMap.length;i++)
	                 {
	                    if(id == testCaseMap[i].id){
	                    	$("#describeContent").text(testCaseMap[i].describe);
	                    }                        
	                 } 
					 document.getElementById('light').style.display='block';
					 document.getElementById('fade').style.display='block';
				 }	
			}
			
			function changeName() {
				var testSuitName = "";
			    var temSut = $("#temSut").find("option:selected").text();
			    var testSuitCategory = $("#testSuitCategory").find("option:selected").text();
			    var testSuitDescribe = $("#testSuitDescribe").val();
				if(temSut != "==请选择=="){
					testSuitName = temSut + "_";
				}
				else{
					testSuitName = "_"
				}
				if(testSuitCategory != "==请选择=="){
					testSuitName = testSuitName + testSuitCategory;
				}
				else{
					testSuitName = testSuitName + "_"
				}
				if(testSuitDescribe != ""){
					testSuitName =  testSuitName  + "_" + testSuitDescribe;
				}
				
				$("#testSuitName").val(testSuitName);
			}	
		</script>
	</head>

	<body>
		<jsp:include page="top.jsp" flush="true"/>
		<div class="view-body">
			<div class="container">
				<form class="form-inline" id="addTestSuitForm">
					<table class="table table-striped table-bordered table-hover"  name="testSuitInfoTable" id="testSuitInfoTable">
						<caption style="color:black;font-size:23px;font-family:LiSu">新增测试套件</caption>
						<tr>
							<th width="150px">套件序号</td>
							<td colspan="3"><input  class="inputClass"  name="id" id="id" type=text value=""/></td>
						</tr>
						
						<tr>
							<th>套件名称</th>
							<td colspan="3">
								<div class="inputDivClass">
									<input disabled class="inputClass" name="testSuitName" id="testSuitName" type=text value=""/>
									<label class="errorClass" id="testSuitNameError"></label>
								</div>
							</td>
						</tr>
						
						<tr>
							<th>执行类型</th>
							<td colspan="3">
								<div class="inputDivClass">
									<select onchange="changeName()" class="inputClass" name="temSut" id="temSut" style="width:100%;height:30px;">
										<option value="0">==请选择==</option>
										<option value="1">SUT</option>
										<option value="2">TEM</option>
									</select>
									<label class="errorClass" id="temSutError"></label>
								</div>		
							</td>							
						</tr>
						
						<tr>						
							<th>测试类别</th>
							<td colspan="3">
								<div class="inputDivClass">
									<select onchange="changeName()" class="inputClass" name="testSuitCategory" id="testSuitCategory" style="width:100%;height:30px;">
										<option value="0">==请选择==</option>
										<option value="1">SIT</option>
										<option value="2">BIOS</option>
										<option value="3">BMC</option>
										<option value="4">Other</option>
									</select>
									<label class="errorClass" id="testSuitCategoryError"></label>
								</div>		
							</td>
						</tr>

						
						<tr>
							<th>套件描述</th>
							<td colspan="3">
								<div class="inputDivClass">
									<input oninput="changeName();" onpropertychange="changeName();"  class="inputClass" name="testSuitDescribe" id="testSuitDescribe" type=text value="" placeholder="&nbsp请输入套件描述......"/>
									<label class="errorClass" id="testSuitDescribeError"></label>
								</div>
								
							</td>
						</tr>
						
						<tr>
							<th>套件说明</th>
							<td colspan="3">
								<div class="inputDivClass">
									<input  class="inputClass" name="testSuitExplain" id="testSuitExplain" type=text value="" placeholder="&nbsp请输入套件说明......"/>
									<label class="errorClass" id="testSuitExplainError"></label>
								</div>
								
							</td>
						</tr>
						
						<tr id="tcList">
						    <th rowSpan="1" style="background:#FFF;">测试用例工作流</th>
							<td>
								<table class="table table-hover" style="margin-bottom:0px;width:100%;border:none;padding:0 0 0 0;" id="testCaseListTable" name="testCaseListTable" colspan="3">
									<tr style="border:1px #ddd" id="tc1">
										<td width="150px" id="tc1Index">1</td>
										<td width="500px">
											<select class="inputClass" id="tc1Sel" style="width:100%;height:30px;" onchange="selChange(this)">
													<option value="0">==请选择==</option>
													<c:forEach var="testCase" items="${testCaseList}">
														<option value="${testCase.id}">${testCase.testCaseName}</option>											
													</c:forEach>
											</select>
										</td>
										<td>
											<a name='describe' onclick='showFirstDescribe()'>说明</a>  <a onclick="deleteRow(this)">删除</a>  <a onclick="addTestCase(this)">插入</a>
										</td>
									</tr>									
								<table>								
							</td>
						</tr>
					</table>
					<input type="submit" value="储存套件"
					class="btn btn-large btn-primary"
					style="position: absolute; right: 20px; top: 170px;"> </input>
                     <a href="${pageContext.request.contextPath}/testSuit.do/index.view" class="btn btn-large btn-primary" style="position:absolute;right:20px;top:220px;">返回前页</a>                   
				</form>
				<input hidden style="position:absolute;right:20px;top:300px;" name="testCaseCount" id="testCaseCount" type=text value=""/>
				<input hidden style="position:absolute;right:20px;top:350px;" name="testCaseInfo" id="testCaseInfo" type=text value=""/>
				<input hidden id="path" value="${pageContext.request.contextPath}" />
			</div>
			
			<div id="light" class="white_content">
				<div id="describeContent" style="width:100%;word-wrap:break-word;word-break:normal;" ></div>
        		<a href="javascript:void(0)" onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">关闭</a>
    		</div>
   			<div id="fade" class="black_overlay"></div>
		</div>	
	</body>
</html>