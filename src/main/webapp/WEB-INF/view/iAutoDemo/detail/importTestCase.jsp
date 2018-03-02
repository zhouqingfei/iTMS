<%@ page language="java" contentType="text/html; charset=UTF-8"
    %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>导入测试用例</title>
		
		<link href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css" rel="stylesheet" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.js"></script>
		
		<style>
			.table th, .table td{ 
				text-align: center;
				vertical-align: middle!important;
			}
			.table th{
				font-size:15px;
			}
			.table td{
				font-size:13px;
			}
			.table td a{
				margin-bottom:2px;
			}
			.inputClass {
				height: 30px;
				border: none;
				width: 100%;
				padding-left: 10px;
			}
		</style>
			
		<script>
			$(function(){
				/* $("#importExcelForm").submit(function(){
					alert("dianjile");
					
					var importUrl = $("#path").val() + "/testCase.do/importTestCase";
					
					$.ajax({
						data : JSON.stringify(testtask),
						type : "POST",
						contentType : 'application/json; charset=utf-8',
						url : importUrl,
						dataType : "text",
						error : function(data) {
							alert("出错了:" + data);
						},
						success : function(data) {
							alert("保存成功:" + data);

						}
					})
				}) */
			});
			
			/* //单个导入
			function importExcel(){
				alert("daoru ");
				var urlPath = document.getElementById("path").value + "/testCase.do/importExcel";
				var formData = new FormData();
			    var name = $("#file").val();
			    formData.append("file",$("#file")[0].files[0]);
			    formData.append("name",name);
			    $.ajax({
			        url : urlPath,
			        type : 'POST',
			        async : false,
			        data : formData,
			        // 告诉jQuery不要去处理发送的数据
			        processData : false,
			        // 告诉jQuery不要去设置Content-Type请求头
			        contentType : false,
			        beforeSend:function(){
			            console.log("正在导入中......");
			        },
			        success : function(responseStr) {
			            if(responseStr=="1"){
			                alert("导入成功");
			            }else if(responseStr=="9"){
			                alert("请选择Excel文件");
			            }
			        },
			        error : function(data) {
						alert("出错了:" + data);
					},
			    });
			} */
			
			//单个导入
			function importExcel(){
				
				var urlPath = document.getElementById("path").value + "/testCase.do/importExcel";
				var file = new FormData($( "#file" )[0]);
				file.append("file",$("#file")[0].files);
				file.append("name","test");
				//var file = [];
				//var file = document.getElementById('file').files;
				//alert(files.length);
			    /* for (var i = 0; i < files.length; i++) {  
			    	//formData.append("file"+i, files[i]);
			    	file.push(files[i]);
			    }
			    formData.append("file",file); */
				//alert(file);
			  /*   var name = $("#file").val();
			    formData.append("file",$("#file")[0].files[0]);
			    formData.append("name",name); */
			    $.ajax({
			        url : urlPath,
			        type : 'POST',
			        async : false,
			        data : file,
			        // 告诉jQuery不要去处理发送的数据
			        processData : false,
			        // 告诉jQuery不要去设置Content-Type请求头
			        contentType : false,
			        beforeSend:function(){
			            console.log("正在导入中......");
			        },
			        success : function(responseStr) {
			            if(responseStr=="1"){
			                alert("导入成功");
			            }else if(responseStr=="9"){
			                alert("请选择Excel文件");
			            }
			        },
			        error : function(data) {
						alert("出错了:" + data);
					},
			    });
			}
			
			
			function doUpload(){
		        var formData = new FormData($("#uploadForm")[0]);
		        var urlPath = document.getElementById("path").value + "/importTestCase.do/importExcel";
		        $.ajax({  
		            url : urlPath,  
		            type: 'POST',  
		            data: formData,  
		            async: false,  
		            cache: false,  
		            contentType: false,  
		            processData: false, 
		            success : function(data) {
		            	var result = data.toString();
		            	if(result == "1"){
		            		alert("成功了！");
		            	}
		            	else{
		            		alert("导入过程中出现问题！");
		            	}		        
		            },  
		            error : function(data) {  
		                alert("失败了！" + data);
		            }
		        }); 
		    }
		</script>

	</head>

	<body>
		<jsp:include page="top.jsp" flush="true"/>
		
		<div class="view-body">
			<div class="container" style="width:96%;">
				<script type="text/javascript">
				</script>
				<div style="margin-top:10px;">
					 <!-- <form id="importExcelForm" enctype="multipart/form-data">
					 	<input type="submit"  class="btn btn-large btn-primary" style="float:right;margin-top:20px;" value="导入" />	  
			            <input type="file" style="float:right;margin-top:20px;"  id="file"/>			            
			         </form>   	 -->
			         
			         <!-- <a onclick="importExcel();" class="btn btn-large btn-primary" style="float:right;margin-top:20px;">导入</a>  
			         <input type="file" id="file" multiple="multiple" name="file" style="float:right;margin-top:20px;" placeholder="" />	 -->        
					<form id="uploadForm" >
				        
				        <input type="button" class="btn btn-large btn-primary" style="float:right;margin-top:20px;"  value="上传" onclick="doUpload()">
				        <input type="file" name="file" style="float:right;margin-top:20px;" multiple="multiple"/>
				    </form>
				</div>
			     
			    <div >          
					<table id="caseListTable" class="table table-striped table-hover table-condensed">
						<caption style="font-size:20px;font-style:italic;margin-left:30px;margin-top:-30px;">已导入测试用例列表</caption>
						<thead>
							<tr id="theader">
								<th>序号</th>
								<th>用例名称<br/>
									(Case Name)
								</th>
								<th>用例编号</th>
								<th>状态</th>
								<th>作者</th>
								<th>最后更新时间</th>
								<th>创建时间</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
				</div>
				<input hidden id="path" value="${pageContext.request.contextPath}" />				
			</div>
			
			<div id="indexDiv" style="text-align:center;">
				<ul id="pageIndex" class="pagination">
				    
				</ul>
			</div>
		</div>
	</body>
</html>