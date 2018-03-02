<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>测试任务管理</title>

	<link href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css" rel="stylesheet" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.js"></script>
		

	<style>
		.table th, .table td {
			text-align: center;
			vertical-align: middle !important;
		}
		
		.table th {
			font-size: 15px;
		}
		
		.table td {
			font-size: 13px;
		}
		
		.table td a {
			margin-bottom: 2px;
		}
	</style>
	
	<script> 
        $(function(){
       		 var allData=[];
       		 var index = 1;
       		 <c:forEach var="testTask" items="${testTaskList}">　              
     		     var data="<tr>"+  
     		     "<td>"+"${testTask.id}"+"</td>"+  
     		     "<td>"+"${testTask.testTaskName}"+"</td>"+  
     		     "<td>"+"${testTask.poolSuitOrCase}"+"</td>"+
     		     "<td>"+"${testTask.startTime}"+"</td>"+
     		     "<td>"+"${testTask.endTime}"+"</td>"+
     		     "<td><div class='progress' style='margin-bottom: 0px;'><div class='progress-bar  progress-bar-success' role='progressbar' aria-valuenow='60' aria-valuemin='0' aria-valuemax='100' style='width:" + 
     		     "${testTask.process}%'><span style='color:black;'>"+
     		     "${testTask.process}%</span></div></div></td>"+
     		     "<td>"+"${testTask.testTaskState}"+"</td>"+
    		     "<td>"+"${testTask.result}"+"</td>"+
     		     "<td><div class='dropdown'>" + 
     		 	    "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
     		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/testTaskLeader.do/edit?id=${testTask.id}'>编辑</a></li>"+
     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/testTaskLeader.do/execute?id=${testTask.id}'  onclick='return confirm('是否要执行该任务？')'>执行</a></li>"+					
     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='javascript:void(0)' onclick='delete_confirm(" + "${testTask.id}," + index++ + ");'>删除</a></li></ul>"+			
     		 	"</div></td></tr>";  
     		     allData.push(data);
       		 </c:forEach>
       		 
       		 	var Count = allData.length;//记录条数  
	   		    var PageSize=10;//设置每页示数目 
	   		    var pagecount = Count/PageSize;
	   		    var PageCount=Math.ceil(pagecount);//计算总页数  
	   		    var currentPage = 1;//当前页，默认为1。  
	
	   		    for(var i=1;i<=PageCount;i++){ 
	   			    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
	   			    $("#pageIndex").append(pageNew);  
	   		    }  
	
	   		    //显示默认页（第一页）  
	   		 	$("#taskListTable tbody").html("");
	   		    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
	   		        $('#taskListTable tbody').append(allData[i]);  
	   		    }      		    
	    		 
	   		    //显示选择页的内容  
	   		    $('#indexDiv a').click(function(){
	    		    var pageIndex=$(this).attr('pageIndex');  
	    		    $("#taskListTable tbody").html("");  
	
	    		    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
	    		    	$("#taskListTable tbody").append(allData[i]);  
	   		   	};
			})
        });
         function search(){
       	    var content=$("input[id=input]").val();
       	    var urlPath =  "${pageContext.request.contextPath}" + "/testTaskLeader.do/testTaskSearch?content=" +	content;		
    		 	
   			 $.ajax({  
   			        data:"",  
   			        type:"GET",
   			        contentType :'application/json; charset=utf-8',
   			        url:urlPath, 
   			        dataType: "text",
   			        error:function(data){  
   			            alert("出错了:"+data);  
   			        },  
   			        success:function(data){
   			        	var allData=[];
   			        	var index = 1;
   		        		var searchTaskList = JSON.parse(data);
   		        		for(var i=0;i < searchTaskList.length;i++){
   		        			var data="<tr>"+  
		         		     "<td>"+ searchTaskList[i].id +"</td>"+  
		         		     "<td>"+ searchTaskList[i].testTaskName +"</td>"+  
		         		     "<td>"+ searchTaskList[i].poolSuitOrCase+"</td>"+
		         		     "<td>"+ searchTaskList[i].startTime+"</td>"+
		         		     "<td>"+ searchTaskList[i].endTime+"</td>"+
		         		     "<td><div class='progress' style='margin-bottom: 0px;'><div class='progress-bar  progress-bar-success' role='progressbar' aria-valuenow='60' aria-valuemin='0' aria-valuemax='100' style='width:" + 
		         		    searchTaskList[i].process + "%'><span style='color:black;'>"+
		         		   searchTaskList[i].process + "%</span></div></div></td>"+
		         		     "<td>"+ searchTaskList[i].testTaskState + "</td>"+
		        		     "<td>"+ searchTaskList[i].result + "</td>"+
		         		     "<td><div class='dropdown'>" + 
		         		 	    "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
		         		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
		         		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/testTaskLeader.do/edit?id=" + searchTaskList[i].id  + "'>编辑</a></li>"+
		         		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/testTaskLeader.do/execute?id=" + searchTaskList[i].id + "'  onclick='return confirm('是否要执行该任务？')'>执行</a></li>"+				
		         		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='javascript:void(0)' onclick='delete_confirm(" + searchTaskList[i].id + "," + i + ");'>删除</a></li></ul>"+			
		         		 	"</div></td></tr>";  
   			     		     allData.push(data);
   		        		}
   			        	 
   		        		var Count = allData.length;//记录条数  
   			   		    var PageSize=10;//设置每页示数目 
   			   		    var pagecount = Count/PageSize;
   			   		    var PageCount=Math.ceil(pagecount);//计算总页数  
   			   		    var currentPage = 1;//当前页，默认为1。  
   			
   			   	     	$("#pageIndex").html("");
   			   		    for(var i=1;i<=PageCount;i++){ 
   			   			    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
   			   			    $("#pageIndex").append(pageNew);  
   			   		    }  
   			
   			   		    //显示默认页（第一页）  
   			   		 	$("#taskListTable tbody").html("");
   			   		    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
   			   		        $('#taskListTable tbody').append(allData[i]);  
   			   		    }      		    
   			    		 
   			   		    //显示选择页的内容  
   			   		    $('#indexDiv a').click(function(){
   			    		    var pageIndex=$(this).attr('pageIndex');  
   			    		    $("#taskListTable tbody").html("");  
   			
   			    		    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
   			    		    	$("#taskListTable tbody").append(allData[i]);  
   			   		   	};
   					})
   			        }  
   			 });
} 
        function delete_confirm(id,index) {
        	var r=confirm("确定删除该任务？")
        	if (r==true)
    	    {
        	    var testTaskId = id;
        	    var deleteIndex = index;
        	    var urlPath =  "${pageContext.request.contextPath}" + "/testTaskLeader.do/delete?id=" +	testTaskId;		
     		 	
    			 $.ajax({  
    			        data:"",  
    			        type:"GET",
    			        contentType :'application/json; charset=utf-8',
    			        url:urlPath, 
    			        dataType: "text",
    			        error:function(data){  
    			            alert("出错了:"+data);  
    			        },  
    			        success:function(data){
    			        	var allData=[];
    		        		var taskList = JSON.parse(data);
    		        		for(var i=0;i < taskList.length;i++){
    		        		     var data="<tr>"+  
    		         		     "<td>"+ taskList[i].id +"</td>"+  
    		         		     "<td>"+ taskList[i].testTaskName +"</td>"+  
    		         		     "<td>"+ taskList[i].poolSuitOrCase+"</td>"+
    		         		     "<td>"+ taskList[i].startTime+"</td>"+
    		         		     "<td>"+ taskList[i].endTime+"</td>"+
    		         		     "<td><div class='progress' style='margin-bottom: 0px;'><div class='progress-bar  progress-bar-success' role='progressbar' aria-valuenow='60' aria-valuemin='0' aria-valuemax='100' style='width:" + 
    		         		     taskList[i].process + "%'><span style='color:black;'>"+
    		         		     taskList[i].process + "%</span></div></div></td>"+
    		         		     "<td>"+ taskList[i].testTaskState + "</td>"+
    		        		     "<td>"+ taskList[i].result + "</td>"+
    		         		     "<td><div class='dropdown'>" + 
    		         		 	    "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
    		         		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
    		         		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/testTaskLeader.do/edit?id=" + taskList[i].id  + "'>编辑</a></li>"+
    		         		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/testTaskLeader.do/execute?id=" + taskList[i].id + "'  onclick='return confirm('是否要执行该任务？')'>执行</a></li>"+			
    		         		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='javascript:void(0)' onclick='delete_confirm(" + taskList[i].id + "," + i + ");'>删除</a></li></ul>"+			
    		         		 	"</div></td></tr>";  
    		         		     allData.push(data);
    		        		}
    			        	 
    		        		var Count = allData.length;//记录条数  
    		       		    var PageSize=10;//设置每页示数目  
    		       		    var PageCount=Math.ceil(Count / PageSize);//计算总页数  
    		       		    var currentPage = 1;//当前页，默认为1。  
    		       		     
	    		       		if(deleteIndex != 0)
	    					 {
	    						 if((deleteIndex - Count) == 1)
	    						 {
	    							 if((deleteIndex%10) == 1)
	    							 {
	    								 currentPage = Math.floor(deleteIndex/10);
	    							 }
	    							 else
	    							 {
	    								 currentPage = Math.floor(deleteIndex/10) + 1;
	    							 }
	    						 }
	    						 else
	    						 {
	    							 var preMax = Math.floor(deleteIndex/10)*10;
	    							 if(deleteIndex > preMax)
	    							 {
	    								 currentPage = Math.floor(deleteIndex/10) + 1;
	    							 }
	    							 else 
	    							 {
	    								 currentPage = Math.floor(deleteIndex/10);
	    							 }
	    						 }
	    					 }
    		       		    
	    		       		$("#pageIndex").html("");
    		       		    for(var i=1;i<=PageCount;i++){ 
    		       			    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
    		       			    $("#pageIndex").append(pageNew);  
    		       		    }  
    		 
    		       		    //显示默认页（第一页）  
    		       		 	$("#taskListTable tbody").html("");
    		       		    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
    		       		        $('#taskListTable tbody').append(allData[i]);  
    		       		    }      		    
    		        		 
    		       		    //显示选择页的内容  
    		       		    $('#indexDiv a').click(function(){
    		        		    var pageIndex=$(this).attr('pageIndex');  
    		        		    $("#taskListTable tbody").html("");  

    		        		    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
    		        		    	$("#taskListTable tbody").append(allData[i]);  
    		       		   		 };
    						})
    			        }  
    			 });
    	    }
		}
	</script>
</head>

<body>
	<jsp:include page="top.jsp" flush="true" />
	<div class="view-body">
		<div class="container" style="width: 95%;">

			<div style="margin-top: 10px;">
				<a href="${pageContext.request.contextPath}/testTaskLeader.do/add.view"
					class="btn btn-large btn-primary"
					style="float: right; margin-top: 20px;">+新建任务</a>
				<div class="input-group"
					style="width: 30%; float: right; margin-top: 20px; margin-right: 10px;">
					<input type="text" id="input" class="form-control" placeholder="请输入字段名"/ >
					<span class="input-group-btn">
						<button class="btn btn-info btn-search" id="button"  onclick="search()" 
							style="background-color: #337ab7">查找</button>
					</span>
				</div>
			</div>

			<table id="taskListTable" class="table table-striped table-hover">
				<caption
					style="font-size: 20px; font-style: italic; margin-left: 30px; margin-top: -10px;">一周內之执行测试任务历程</caption>
				<thead>
					<tr id="theader">
						<th>任务编码<br /> （Task ID）
						</th>
						<th>任务名称<br /> （Task Name）
						</th>
						<th>套件与用例名称<br /> （Suit/Case Name）
						</th>
						<th>执行时间<br /> （Start Time）
						</th>
						<th>完成时间<br /> （End Time）
						</th>
						<th>测试进度（%）</th>
						<th>任务状态<br /> （State）
						</th>
						<th>测试结果<br /> （Result）
						</th>
						<th>操作选取<br />
						</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
		</div>

		<div id="indexDiv" style="text-align: center;">
			<ul id="pageIndex" class="pagination">
				
			</ul>
		</div>
	</div>
</body>
</html>