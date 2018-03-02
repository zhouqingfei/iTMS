<%@ page language="java" contentType="text/html; charset=UTF-8"
    %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
		</style>
		
		<script> 
	        $(function(){
	       		 var allData=[];
	       		 var index = 1;
	       		 <c:forEach var="testSuit" items="${testSuitList}">　              
	     		     var data="<tr>"+  
	     		     "<td>"+"${testSuit.id}"+"</td>"+  
	     		     "<td>"+"${testSuit.testSuitName}"+"</td>"+  
	     		     "<td>"+"${testSuit.temSut}"+"</td>"+
	     		     "<td>"+"${testSuit.testSuitCategory}"+"</td>"+
	     		     "<td>"+"${testSuit.modifyTime}"+"</td>"+
	     		     "<td>"+"${testSuit.userLoginId}"+"</td>"+
	     		     "<td><div class='dropdown'>"+
	     		 	    "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
	     		 	   	 "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
	     		 			"<li role='presentation'><a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/testSuitDeveloper.do/edit?id=${testSuit.id}'>编辑</a></li>"+
	     		 			"<li role='presentation'><a role='menuitem' tabindex='-1' href='javascript:void(0)' onclick='delete_confirm(" + "${testSuit.id}," + index++ + ");'>删除</a></li></ul>"+			
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
		   		 	$("#suitListTable tbody").html("");
		   		    for(var i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
		   		        $('#suitListTable tbody').append(allData[i]);  
		   		    }      		    
		    		 
		   		    //显示选择页的内容  
		   		    $('#indexDiv a').click(function(){
		    		    var pageIndex=$(this).attr('pageIndex');  
		    		    $("#suitListTable tbody").html("");  
		
		    		    for(var i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
		    		    	$("#suitListTable tbody").append(allData[i]);  
		   		   	};
				})
	        });
		       function search(){
		       	    var content=$("input[id=input]").val();
		       	    /* alert(content); */
		       	    var urlPath =  "${pageContext.request.contextPath}" + "/testSuitDeveloper.do/testSuitSearch?content=" +	content;		
		    		 	
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
		   		        		var searchSuitList = JSON.parse(data);
		   		        		for(var i=0;i < searchSuitList.length;i++){
		   		        		 var data="<tr>"+  
    		         		     "<td>"+ searchSuitList[i].id +"</td>"+  
    		         		     "<td>"+ searchSuitList[i].testSuitName +"</td>"+  
    		         		     "<td>"+ searchSuitList[i].temSut+"</td>"+
    		         		     "<td>"+ searchSuitList[i].testSuitCategory+"</td>"+
    		         		     "<td>"+ searchSuitList[i].modifyTime+"</td>"+
    		         		     "<td>"+ searchSuitList[i].userLoginId+"</td>"+
    		         		     "<td><div class='dropdown'>" + 
    		         		 	    "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
    		         		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
    		         		 	  		"<li role='presentation'><a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/testSuitDeveloper.do/edit?id=" + searchSuitList[i].id + "'>编辑</a></li>"+
    		     		 				"<li role='presentation'><a role='menuitem' tabindex='-1' href='javascript:void(0)' onclick='delete_confirm(" + searchSuitList[i].id + "," + index++ + ");'>删除</a></li></ul>"+			
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
		   		       		 	$("#suitListTable tbody").html("");
		   		       		    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
		   		       		        $('#suitListTable tbody').append(allData[i]);  
		   		       		    }      		    
		   		        		 
		   		       		    //显示选择页的内容  
		   		       		    $('#indexDiv a').click(function(){
		   		        		    var pageIndex=$(this).attr('pageIndex');  
		   		        		    $("#suitListTable tbody").html("");  

		   		        		    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
		   		        		    	$("#suitListTable tbody").append(allData[i]);  
		   		       		   		 };
		   						})
		   			        }  
		   			 });
		} 
	        function delete_confirm(id,index) {
	        	var r=confirm("确定删除该套件？")
	        	if (r==true)
	    	    {
	        	    var testSuitId = id;
	        	    var deleteIndex = index;
	        	    var urlPath =  "${pageContext.request.contextPath}" + "/testSuitDeveloper.do/delete?id=" +	testSuitId;		
	     		 	
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
	    		        		var suitList = JSON.parse(data);
	    		        		var index = 1;
	    		        		for(var i=0;i < suitList.length;i++){
	    		        		     var data="<tr>"+  
	    		         		     "<td>"+ suitList[i].id +"</td>"+  
	    		         		     "<td>"+ suitList[i].testSuitName +"</td>"+  
	    		         		     "<td>"+ suitList[i].temSut+"</td>"+
	    		         		     "<td>"+ suitList[i].testSuitCategory+"</td>"+
	    		         		     "<td>"+ suitList[i].modifyTime+"</td>"+
	    		         		     "<td>"+ suitList[i].userLoginId+"</td>"+
	    		         		     "<td><div class='dropdown'>" + 
	    		         		 	    "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
	    		         		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
	    		         		 	  		"<li role='presentation'><a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/testSuitDeveloper.do/edit?id=" + suitList[i].id + "'>编辑</a></li>"+
	    		     		 				"<li role='presentation'><a role='menuitem' tabindex='-1' href='javascript:void(0)' onclick='delete_confirm(" + suitList[i].id + "," + index++ + ");'>删除</a></li></ul>"+			
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
	    		       		 	$("#suitListTable tbody").html("");
	    		       		    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
	    		       		        $('#suitListTable tbody').append(allData[i]);  
	    		       		    }      		    
	    		        		 
	    		       		    //显示选择页的内容  
	    		       		    $('#indexDiv a').click(function(){
	    		        		    var pageIndex=$(this).attr('pageIndex');  
	    		        		    $("#suitListTable tbody").html("");  
	
	    		        		    for(var i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
	    		        		    	$("#suitListTable tbody").append(allData[i]);  
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
			<div class="container" style="width:95%;">
				
				<div style="margin-top:20px;">
					<a  href="${pageContext.request.contextPath}/testSuitDeveloper.do/add.view" class="btn btn-large btn-primary" style="float:right;margin-top:20px;">+新建套件</a>  
					<div class="input-group" style="width:30%;float:right;margin-top:20px;margin-right:10px;">  
					    <input type="text" id="input" class="form-control"placeholder="请输入字段名" / >  
						<span class="input-group-btn">  
						   <button class="btn btn-info btn-search" id="button" onclick="search()" style="background-color:#337ab7">查找</button>  
						</span>  
					</div>					
				</div>
			               
				<table id="suitListTable" class="table table-striped table-hover">
					<caption style="font-size:20px;font-style:italic;margin-left:30px;">现有测试套件列表</caption>
					<thead>
						<tr id="theader">
							<th>序号</th>
							<th>套件名称<br/>
								(Suit Name)
							</th>
							<th>执行类型<br/>
								(TEM/SUT)
							</th>
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
			
			<div id="indexDiv" style="text-align:center;">
				<ul id="pageIndex" class="pagination">
					
				</ul>
			</div>
		</div>
	</body>
</html>