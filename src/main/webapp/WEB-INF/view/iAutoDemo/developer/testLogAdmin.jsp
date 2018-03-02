<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
	<title>测试记录档</title>
	<link href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css" rel="stylesheet" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.js"></script>
	
	<style>
		.container{
				width:85%;
				margin-left:100px;
				margin-top:10px;
			}
			.table{
				border:2px;
			}
			.table th, .table td{ 
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
				height:100%;
			}
			.ul li a{
				background-color:#31B0D5;
			}
	
			.errorClass {color: #f40000; font-size:10pt;position:absolute;top:5px;right:10px;}
			
			.inputDivClass{position:relative;margin-left:2px;}
			
			.inputClass{height:30px;border:none;width:100%;padding-left:10px;}
	</style>
</head>

<body>
	<jsp:include page="top.jsp" flush="true" />

	<div class="view-body">			
		
	<div class="container" style="width:90%;">
<script type="text/javascript">
			    $(document).ready(function () {
			    	<!--
			      	  $("button[id=button]").click(function(){
			      	      var txt=$("input[id=input]").val();
			      	      if($.trim(txt)!=""){
			      	 
			      	        $("table tr:not('#theader')").hide().filter(":contains('"+txt+"')").show();
			      	      }else{
			      	        $("table tr:not('#theader')").css("background","#fff").show();
			      	      }
			      	    }); 			    	
			    	-->
			      	  allData = [];
			      	  var index = 1;
						<c:forEach var="testLog" items="${reportLogList}">
						data = "<tr>"
							+ "<td>${testLog.logId}</td>"
							+ "<td>${testLog.logNumber} </td>"
							+ "<td>${testLog.logName} </td>"									
							+ "<td>${testLog.modifyTime}</td>"
							+ "<td>${testLog.loginId}</td>"								
							+ "<td><div class='dropdown'>"
							+ "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>"
							+ "操作 <span class='caret'></span></button>"
							+ "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>"				
							+ "<li role='presentation'>"	
							+ "<a href='javascript: void(0)' onclick='delete_confirm(${testLog.logId}, " + index++ + ")'>删除</a></li>"						 		
							+ "<li role='presentation'><a href='${pageContext.request.contextPath}/reportDeveloper.do/downloadLog?logName=${testLog.logName}'>下载测试日志</a></li>"			
							+ "</ul></div></td></tr>";			
						allData.push(data);								
                    </c:forEach>
                    
            		var Count = allData.length;//记录条数  
            		var PageSize = 10;//设置每页示数目 
            		var pagecount = Count / PageSize;
            		var PageCount = Math.ceil(pagecount);//计算总页数  
            		var currentPage = 1;//当前页，默认为1。  

            		for (var i = 1; i <= PageCount; i++) {
            			var pageNew = "<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";
            			$("#pageIndex").append(pageNew);
            		}

            		//显示默认页（第一页）  
            		$("#logListTable tbody").html("");
            		for (i = (currentPage - 1) * PageSize; i < PageSize * currentPage; i++) {
            			$('#logListTable tbody').append(allData[i]);
            		}

            		//显示选择页的内容  
            		$('#indexDiv a').click(
            				function() {
            					var pageIndex = $(this).attr('pageIndex');
            					$("#logListTable tbody").html("");

            					for (i = (pageIndex - 1) * PageSize; i < PageSize
            							* pageIndex; i++) {
            						$("#logListTable tbody").append(allData[i]);
            					}
            					;
            				});
			       });
			    
			    function search(){
		        		var index=1;
			    	    var content=$("input[id=input]").val();
		         	    var urlPath =  "${pageContext.request.contextPath}" + "/reportDeveloper.do/logSearch?content=" +	content;	
		      		 	
		     			 $.ajax({  
		     			        data:"",  
		     			        type:"GET",
		     			        contentType :'application/json; charset=utf-8',
		     			        url:urlPath, 
		     			        dataType: "text",
		     			        error:function(data){  
		     			            alert("出错了:"+data);  
		     			        },  
							success: function(data){
								tmpData = data;
								var searchLogList = JSON.parse(data);
								allData = [];
								for(var i=0; i< searchLogList.length; i++){
									var data = "<tr>"
										+ "<td>" + searchLogList[i].logId + "</td>"
										+ "<td>" + searchLogList[i].logNumber + "</td>"
										+ "<td>" + searchLogList[i].logName + "</td>"									
										+ "<td>" + searchLogList[i].modifyTime + "</td>"
										+ "<td>" + searchLogList[i].loginId + "</td>"								
										+ "<td><div class='dropdown'>"
										+ "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>"
										+ "操作 <span class='caret'></span></button>"
										+ "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>"			
										+ "<li role='presentation'>"	
										+ "<a href='javascript: void(0)' onclick='delete_confirm("+ searchLogList[i].logId + ", " + i + ")'>删除</a></li>"					 		
										+ "<li role='presentation'><a href='${pageContext.request.contextPath}/reportDeveloper.do/downloadLog?logName=" + searchLogList[i].logName + "'>下载测试日志</a></li>"			
										+ "</ul></div></td></tr>";
									allData.push(data);
								}
								var Count = allData.length;//记录条数  
								var PageSize = 10;//设置每页示数目 
								var pagecount = Count / PageSize;
								var PageCount = Math.ceil(pagecount);//计算总页数  
								var currentPage = 1;//当前页，默认为1。  

								$("#pageIndex").html("");
								for (var i = 1; i <= PageCount; i++) {
									var pageNew = "<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";
									$("#pageIndex").append(pageNew);
								}

								//显示默认页（第一页）  
								$("#logListTable tbody").html("");
								for (i = (currentPage - 1) * PageSize; i < PageSize * currentPage; i++) {
									$('#logListTable tbody').append(allData[i]);
								}

								 $('#indexDiv a').click(
				               				function() {
				               					var pageIndex = $(this).attr('pageIndex');
				               					$("#logListTable tbody").html("");

				               					for (i = (pageIndex - 1) * PageSize; i < PageSize
				               							* pageIndex; i++) {
				               						$("#logListTable tbody").append(allData[i]);
				               					};
				               				});
							}
		     			      
		    			});
		    		}
			    
			    	function delete_confirm(logId, index){
			    		var r=confirm("确定删除测试归档包？")
			        	if (r==true)
				    	  {
			         	    var deleteIndex = index;
			         	    var urlPath =  "${pageContext.request.contextPath}" + "/reportDeveloper.do/deleteLog?id=" + logId;		
			      		 	
			     			 $.ajax({  
			     			        data:"",  
			     			        type:"GET",
			     			        contentType :'application/json; charset=utf-8',
			     			        url:urlPath, 
			     			        dataType: "text",
			     			        error:function(data){  
			     			            alert("出错了:"+data);  
			     			        },  
								success: function(data){
									tmpData = data;
									var logList = JSON.parse(data);
									allData = [];
									for(var i=0; i< logList.length; i++){
										var tLog = logList[i];
										var data = "<tr>"
											+ "<td>" + tLog.logId + "</td>"
											+ "<td>" + tLog.logNumber + "</td>"
											+ "<td>" + tLog.logName + "</td>"									
											+ "<td>" + tLog.modifyTime + "</td>"
											+ "<td>" + tLog.loginId + "</td>"								
											+ "<td><div class='dropdown'>"
											+ "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>"
											+ "操作 <span class='caret'></span></button>"
											+ "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>"			
											+ "<li role='presentation'>"	
											+ "<a href='javascript: void(0)' onclick='delete_confirm("+ tLog.logId + ", " + i + ")'>删除</a></li>"						 			
											+ "<li role='presentation'><a href='${pageContext.request.contextPath}/reportDeveloper.do/downloadLog?logName=" + tLog.logName + "'>下载测试日志</a></li>"			
											+ "</ul></div></td></tr>";
										allData.push(data);
									}
									var Count = allData.length;//记录条数  
									var PageSize = 10;//设置每页示数目 
									var pagecount = Count / PageSize;
									var PageCount = Math.ceil(pagecount);//计算总页数  
									var currentPage = 1;//当前页，默认为1。  

									$("#pageIndex").html("");
									for (var i = 1; i <= PageCount; i++) {
										var pageNew = "<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";
										$("#pageIndex").append(pageNew);
									}

									//显示默认页（第一页）  
									$("#logListTable tbody").html("");
									for (i = (currentPage - 1) * PageSize; i < PageSize * currentPage; i++) {
										$('#logListTable tbody').append(allData[i]);
									}
									 $('#indexDiv a').click(
					               				function() {
					               					var pageIndex = $(this).attr('pageIndex');
					               					$("#logListTable tbody").html("");

					               					for (i = (pageIndex - 1) * PageSize; i < PageSize
					               							* pageIndex; i++) {
					               						$("#logListTable tbody").append(allData[i]);
					               					};
					               				});
								}
			    			});
			    		}
			    	}
				</script>
		<div style="margin-top:0px;">  
			<div class="input-group" style="width:30%;float:right;margin-top:20px;">  
				<input type="text" id="input" class="form-control"placeholder="请输入字段名" / >  
				<span class="input-group-btn">  
				   <button class="btn btn-info btn-search" id="button"  onclick="search()" style="background-color:#337ab7">查找</button>  
				</span>  
			</div>	
		</div>
		
		<table class="table table-striped table-hover" id="logListTable">
			<caption style="font-size:20px;font-style:italic;margin-left:30px;margin-top:-40px;">测试日志列表</caption>
			<thead>
				<tr id="theader">
					<th>序号1</th>
					<th>用例编号</th>
					<th>原生记录档名</th>							
					<th>修改时间</th>
					<th>创建者</th>
					<th>操作</th>
				</tr>
			</thead>
				<tbody>
				<!-- 
							<c:forEach var="testLog" items="${reportLogList}">
								<tr>
									<td>${testLog.logId}</td>
									<td>${testLog.logNumber} </td>
									<td>${testLog.logName} </td>									
									<td>${testLog.modifyTime}</td>
									<td>${testLog.loginId}</td>								
									<td>
										<div class="dropdown">
											<button type="button" class="btn dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">
												操作
												<span class="caret"></span>
											</button>
											<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" style="min-width:100px;">
												<li role="presentation">
													<a role="menuitem" tabindex="-1" href="#">编辑</a>
												</li>
												<li role="presentation">
												 <a href="${pageContext.request.contextPath}/reportDeveloper.do/deleteLog?logId=${testLog.logId}"
	                                               onclick="return confirm('是否要删除该原生记录挡？')">删除</a>
													
												</li>
												<li role="presentation">
												<a 
											href="${pageContext.request.contextPath}/reportDeveloper.do/openFileLog?logNumber=${testLog.logNumber}">打开测试日志</a>
										</li>
										<li role="presentation">
												<a 
											href="${pageContext.request.contextPath}/reportDeveloper.do/downloadLog?logNumber=${testLog.logNumber}">下载测试日志</a>
										</li>
											</ul>
										</div>
									</td>
								</tr>
	                        </c:forEach>
				 -->
						</tbody>
		</table>				
	</div>
	
	<div id="indexDiv" style="text-align:center;">
		<ul id="pageIndex" class="pagination">
		<!-- 
			<li><a href="#">&laquo;</a></li>
			<li><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li><a href="#">4</a></li>
			<li><a href="#">5</a></li>
			<li><a href="#">&raquo;</a></li>
		 -->
		</ul>
	</div>
</body>
</html>