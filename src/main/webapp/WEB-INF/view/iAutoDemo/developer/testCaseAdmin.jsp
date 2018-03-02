<%@ page language="java" contentType="text/html; charset=UTF-8"
    %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
		<meta charset="utf-8">
		<title>测试用例管理</title>
		
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
	        	/* $("button[id=button]").click(function(){
		      	      var txt=$("input[id=input]").val();
		      	      if($.trim(txt)!=""){
		      	 
		      	        $("table tr:not('#theader')").hide().filter(":contains('"+txt+"')").show();
		      	      }else{
		      	        $("table tr:not('#theader')").css("background","#fff").show();
		      	      }
		      	    }); */
        		 var allData=[];
        		 var index = 1;
        		 <c:forEach var="testCase" items="${testCaseList}">　              
	     		     var data="<tr>"+  
	     		     "<td>"+"${testCase.id}"+"</td>"+  
	     		     "<td>"+"${testCase.testCaseName}"+"</td>"+  
	     		     "<td>"+"${testCase.temSut}"+"</td>"+
	     		     "<td>"+"${testCase.testCaseId}"+"</td>"+
	     		     "<td>"+"${testCase.testCategory}"+"</td>"+
	     		     "<td>"+"${testCase.modifyTime}"+"</td>"+
	     		     "<td>"+"${testCase.userLoginId}"+"</td>"+
	     		     "<td><div class='dropdown'>" + 
	     		 	    "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
	     		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
	     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/testCaseDeveloper.do/edit?id=${testCase.id}'>编辑</a></li>"+
	     		 		"<li role='presentation'><a href='javascript:void(0)' onclick='delete_confirm(" + "${testCase.id}," + index++ + ");'>删除</a></li></ul>"+			
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
       		 	$("#caseListTable tbody").html("");
       		    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
       		        $('#caseListTable tbody').append(allData[i]);  
       		    }      		    
        		 
       		    //显示选择页的内容  
       		    $('#indexDiv a').click(function(){
        		    var pageIndex=$(this).attr('pageIndex');  
        		    $("#caseListTable tbody").html("");  

        		    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
        		    	$("#caseListTable tbody").append(allData[i]);  
       		   		 };
				})
	        })
	       function search(){
       	    var content=$("input[id=input]").val();
       	    /* alert(content); */
       	    var urlPath =  "${pageContext.request.contextPath}" + "/testCaseDeveloper.do/testCaseSearch?content=" +	content;		
    		 	
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
   		        		var searchCaseList = JSON.parse(data);
   		        		for(var i=0;i < searchCaseList.length;i++){
   		        			var data="<tr>"+  
   			     		     "<td>"+ searchCaseList[i].id + "</td>"+  
   			     		     "<td>"+ searchCaseList[i].testCaseName +"</td>"+  
   			     		     "<td>"+ searchCaseList[i].temSut + "</td>"+
   			     		     "<td>"+ searchCaseList[i].testCaseId +"</td>"+
   			     		     "<td>"+ searchCaseList[i].testCategory +"</td>"+
   			     		     "<td>"+ searchCaseList[i].modifyTime +"</td>"+
   			     		     "<td>"+ searchCaseList[i].userLoginId +"</td>"+
   			     		     "<td><div class='dropdown'>" + 
   			     		 	    "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
   			     		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
   			     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/testCaseDeveloper.do/edit?id=" + searchCaseList[i].id +"'>编辑</a></li>"+
   			     		 		"<li role='presentation'><a href='javascript:void(0)' onclick='delete_confirm(" + searchCaseList[i].id +"," +  i + ");'>删除</a></li></ul>"+			
   			     		 	"</div></td></tr>";  
   			     		     allData.push(data);
   		        		}
   			        	 
   		        		var Count = allData.length;//记录条数  
   		       		    var PageSize=10;//设置每页示数目  
   		       		    var PageCount=Math.ceil(Count / PageSize);//计算总页数  
   		       		    var currentPage = 1;//当前页，默认为1。     
	    		       		$("#pageIndex").html("");
   		       		    for(var i=1;i<=PageCount;i++){ 
   		       			    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
   		       			    $("#pageIndex").append(pageNew);  
   		       		    }  
   		 
   		       		    //显示默认页（第一页）  
   		       		 	$("#caseListTable tbody").html("");
   		       		    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
   		       		        $('#caseListTable tbody').append(allData[i]);  
   		       		    }      		    
   		        		 
   		       		    //显示选择页的内容  
   		       		    $('#indexDiv a').click(function(){
   		        		    var pageIndex=$(this).attr('pageIndex');  
   		        		    $("#caseListTable tbody").html("");  

   		        		    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
   		        		    	$("#caseListTable tbody").append(allData[i]);  
   		       		   		 };
   						})
   			        }  
   			 });
}
	        function delete_confirm(id,index) {
	        	var r=confirm("确定删除该测试用例？")
	        	if (r==true)
        	    {
	        	    var testCaseId = id;
	        	    var deleteIndex = index;
	        	    var urlPath =  "${pageContext.request.contextPath}" + "/testCaseDeveloper.do/delete?id=" +	testCaseId;		
	     		 	
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
	    		        		var caseList = JSON.parse(data);
	    		        		for(var i=0;i < caseList.length;i++){
	    		        			var data="<tr>"+  
	    			     		     "<td>"+ caseList[i].id + "</td>"+  
	    			     		     "<td>"+ caseList[i].testCaseName +"</td>"+  
	    			     		     "<td>"+ caseList[i].temSut + "</td>"+
	    			     		     "<td>"+ caseList[i].testCaseId +"</td>"+
	    			     		     "<td>"+ caseList[i].testCategory +"</td>"+
	    			     		     "<td>"+ caseList[i].modifyTime +"</td>"+
	    			     		     "<td>"+ caseList[i].userLoginId +"</td>"+
	    			     		     "<td><div class='dropdown'>" + 
	    			     		 	    "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
	    			     		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
	    			     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/testCaseDeveloper.do/edit?id="+ caseList[i].id +"'>编辑</a></li>"+
	    			     		 		"<li role='presentation'><a href='javascript:void(0)' onclick='delete_confirm(" + caseList[i].id +"," +  i + ");'>删除</a></li></ul>"+			
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
	    		       		 	$("#caseListTable tbody").html("");
	    		       		    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
	    		       		        $('#caseListTable tbody').append(allData[i]);  
	    		       		    }      		    
	    		        		 
	    		       		    //显示选择页的内容  
	    		       		    $('#indexDiv a').click(function(){
	    		        		    var pageIndex=$(this).attr('pageIndex');  
	    		        		    $("#caseListTable tbody").html("");  

	    		        		    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
	    		        		    	$("#caseListTable tbody").append(allData[i]);  
	    		       		   		 };
	    						})
	    			        }  
	    			 });
        	    }
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
					 <a href="${pageContext.request.contextPath}/testCaseDeveloper.do/add.view" class="btn btn-large btn-primary" style="float:right;margin-top:20px;">+新建用例</a>  
					<div class="input-group" style="width:30%;float:right;margin-top:20px;margin-right:10px;">  
					    <input type="text" id="input" class="form-control"placeholder="请输入字段名" / >  
						<span class="input-group-btn">  
						   <button class="btn btn-info btn-search" id="button" onclick="search()" style="background-color:#337ab7">查找</button>  
						</span>  
					</div>							
				</div>
			     
			    <div >          
					<table id="caseListTable" class="table table-striped table-hover table-condensed">
						<caption style="font-size:20px;font-style:italic;margin-left:30px;margin-top:-30px;">现有测试用例列表</caption>
						<thead>
							<tr id="theader">
								<th>序号</th>
								<th>用例名称<br/>
									(Case Name)
								</th>
								<th>执行类型<br/>
									(Tem/Sut)
								</th>
								<th>用例编号</th>
								<th>测试类别<br/>
									(Test Category)
								</th>
								<th>修改时间<br/>
									(Modify Time)
								</th>
								<th>创建者<br/>
									(Login ID)
								</th>
								<th>操作选取</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
				</div>				
			</div>
			
			<div id="indexDiv" style="text-align:center;">
				<ul id="pageIndex" class="pagination">
				    
				</ul>
			</div>
		</div>
	</body>
</html>