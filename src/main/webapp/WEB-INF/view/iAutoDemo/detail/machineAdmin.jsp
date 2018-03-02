<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>设备管理</title>

	<link href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/loading.css" rel="stylesheet" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/loading.js"></script>
		
	<style>
		    .container{
				width:98%;
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
				font-size:12px;
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
	<script>
		$(function(){
			 var temData=[];
			 var sutData=[];
			 var temIndex = 1;
			 var sutIndex = 1;
			 <c:forEach var="tem" items="${temList}">
				 var tr="<tr>"+  
				     "<td>"+ temIndex++ +"</td>"+  
				     "<td>"+"${tem.model}"+"</td>"+  
				     "<td>"+"${tem.status}"+"</td>"+
				     "<td class='state'>"+"${tem.line_status}"+"</td>"+
				     "<td>"+"${tem.os}"+"</td>"+
				     "<td>"+"${tem.bios_ver}"+"</td>"+
				     "<td>"+"${tem.bmc_ver}"+"</td>"+
				     "<td>"+"${tem.host_ip}"+"</td>"+
				     "<td>"+"${tem.host_mac}"+"</td>"+
				     "<td>"+"${tem.bmc_ip}"+"</td>"+
				     "<td>"+"${tem.bmc_mac}"+"</td>"+
				     "<td>"+"${tem.time}"+"</td>"+
				     "<td>"+"${tem.addr}"+"</td>"+
				     "<td>"+"${tem.user}"+"</td>"+
				     "<td>"+"${tem.comment}"+"</td>"+
				     "<td><div class='dropdown'>" + 
	     		 	    "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
	     		 	  "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
	     		 	  	"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='editMachineInfo(this);'>编辑机器信息</a></li>"+
	     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='statusUpdate(this);'>状态更新</a></li>"+
				 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOn(this);'>开机</a></li>" +
				 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOff(this);'>关机</a></li>" +
				 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='installAEP(this);'>部署AEP</a></li>" +
				 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='deleteMachine(this);'>删除</a></li></ul>"+	
	     		 	"</div></td></tr>";  
				 temData.push(tr);
            </c:forEach>
            
    		<c:forEach var="sut" items="${sutList}">
	    		 var tr="<tr>"+  
				     "<td>"+ sutIndex++ +"</td>"+  
				     "<td>"+"${sut.model}"+"</td>"+  
				     "<td>"+"${sut.status}"+"</td>"+
				     "<td class='state'>"+"${sut.line_status}"+"</td>"+
				     "<td>"+"${sut.os}"+"</td>"+
				     "<td>"+"${sut.bios_ver}"+"</td>"+
				     "<td>"+"${sut.bmc_ver}"+"</td>"+
				     "<td>"+"${sut.host_ip}"+"</td>"+
				     "<td>"+"${sut.host_mac}"+"</td>"+
				     "<td>"+"${sut.bmc_ip}"+"</td>"+
				     "<td>"+"${sut.bmc_mac}"+"</td>"+
				     "<td>"+"${sut.time}"+"</td>"+
				     "<td>"+"${sut.addr}"+"</td>"+
				     "<td>"+"${sut.user}"+"</td>"+
				     "<td>"+"${sut.comment}"+"</td>"+
				     "<td><div class='dropdown'>" + 
				     "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
	     		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
	     		 	  	"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='editMachineInfo(this);'>编辑机器信息</a></li>"+
	     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='statusUpdate(this);'>状态更新</a></li>"+
				 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOn(this);'>开机</a></li>" +
				 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOff(this);'>关机</a></li>" +
				 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='installAEP(this);'>部署AEP</a></li>" +
				 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='deleteMachine(this);'>删除</a></li></ul>"+	
	     		 	"</div></td></tr>";  
				 sutData.push(tr);
           </c:forEach>
			 
			var temCount = temData.length;//tem记录条数 
			var sutCount = sutData.length;//sut记录条数 
		    var PageSize=10;//设置每页示数目 
		    
		    var tempagecount = temCount/PageSize;
		    var temPageCount=Math.ceil(tempagecount);//计算总页数 
		    
		    var sutpagecount = sutCount/PageSize;
		    var sutPageCount=Math.ceil(sutpagecount);//计算总页数 
		    
		    var currentPage = 1;//当前页，默认为1。  

		    for(var i=1;i<=temPageCount;i++){ 
			    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
			    $("#temPageIndex").append(pageNew);  
		    }
		    
		    for(var i=1;i<=sutPageCount;i++){ 
			    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
			    $("#sutPageIndex").append(pageNew);  
		    }  

		    //显示默认页（第一页）  
		 	$("#temTable tbody").html("");
		    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
		        $('#temTable tbody').append(temData[i]);  
		    }
		    
		    $("#sutTable tbody").html("");
		    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
		        $('#sutTable tbody').append(sutData[i]);  
		    }   
		 
		    //显示选择页的内容  
		    $('#temIndexDiv a').click(function(){
			    var pageIndex=$(this).attr('pageIndex');  
			    $("#temTable tbody").html("");  
	
			    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
			    	$("#temTable tbody").append(temData[i]);  
	   			};
			})
			
			$('#sutIndexDiv a').click(function(){
			    var pageIndex=$(this).attr('pageIndex');  
			    $("#sutTable tbody").html("");  
	
			    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
			    	$("#sutTable tbody").append(sutData[i]);  
	   			};
	   			
	   			updateState();
			})
			
			updateState();
		});
		function update(){
	    	var id = $("#searchLab").val();
	    	var urlPath =  "${pageContext.request.contextPath}" + "/machine.do/update?id=" + id;
	    	showLoading();

	    	$.ajax({  
		        data:"",  
		        type:"GET",
		        contentType :'application/json; charset=utf-8',
		        url:urlPath, 
		        dataType: "text",
		        error:function(data){  
		            alert("出错了:"+data); 
		            removeLoading('loadName');
		        },  
		        success:function(data){
		        	removeLoading('loadName');
		        	 var machineList = JSON.parse(data);
		        	 //alert("更新成功！" + machineList.newTemList[0].model);
		        	 var newTemList = machineList.newTemList;
		        	 var newSutList = machineList.newSutList;
		        	 var temData=[];
					 var sutData=[];
		             var temIndex = 1;
		             var sutIndex = 1;
					 
		            for(var i =0;i < newTemList.length;i++){
		            	 var tr="<tr>"+  
					     "<td>"+ temIndex++ +"</td>"+  
					     "<td>"+ newTemList[i].model +"</td>"+  
					     "<td>"+ newTemList[i].status+"</td>"+
					     "<td class='state'>"+ newTemList[i].line_status + "</td>" +
					     "<td>"+ newTemList[i].os +"</td>"+
					     "<td>"+ newTemList[i].bios_ver +"</td>"+
					     "<td>"+ newTemList[i].bmc_ver +"</td>"+
					     "<td>"+ newTemList[i].host_ip +"</td>"+
					     "<td>"+ newTemList[i].host_mac +"</td>"+
					     "<td>"+ newTemList[i].bmc_ip +"</td>"+
					     "<td>"+ newTemList[i].bmc_mac +"</td>"+
					     "<td>"+ newTemList[i].time +"</td>"+
					     "<td>"+ newTemList[i].addr +"</td>"+
					     "<td>"+ newTemList[i].user +"</td>"+
					     "<td>"+ newTemList[i].comment +"</td>"+
					     "<td><div class='dropdown'>" + 
					     "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
					     "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
		     		 	  	"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='editMachineInfo(this);'>编辑机器信息</a></li>"+
		     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='statusUpdate(this);'>状态更新</a></li>"+
					 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOn(this);'>开机</a></li>" +
					 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOff(this);'>关机</a></li>" +
					 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='installAEP(this);'>部署AEP</a></li>" +
					 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='deleteMachine(this);'>删除</a></li></ul>"+	
		     		 	"</div></td></tr>";  
					 temData.push(tr);
		            }
		            
		            
		            
		            for(var i =0;i < newSutList.length;i++){
		            	 var tr="<tr>"+  
					     "<td>"+ sutIndex++ +"</td>"+  
					     "<td>"+ newSutList[i].model +"</td>"+  
					     "<td>"+ newSutList[i].status+"</td>"+
					     "<td class='state'>"+ newSutList[i].line_status + "</td>" +
					     "<td>"+ newSutList[i].os +"</td>"+
					     "<td>"+ newSutList[i].bios_ver +"</td>"+
					     "<td>"+ newSutList[i].bmc_ver +"</td>"+
					     "<td>"+ newSutList[i].host_ip +"</td>"+
					     "<td>"+ newSutList[i].host_mac +"</td>"+
					     "<td>"+ newSutList[i].bmc_ip +"</td>"+
					     "<td>"+ newSutList[i].bmc_mac +"</td>"+
					     "<td>"+ newSutList[i].time +"</td>"+
					     "<td>"+ newSutList[i].addr +"</td>"+
					     "<td>"+ newSutList[i].user +"</td>"+
					     "<td>"+ newSutList[i].comment +"</td>"+
					     "<td><div class='dropdown'>" + 
					     "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
		     		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
		     		 	  	"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='editMachineInfo(this);'>编辑机器信息</a></li>"+
		     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='statusUpdate(this);'>状态更新</a></li>"+
					 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOn(this);'>开机</a></li>" +
					 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOff(this);'>关机</a></li>" +
					 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='installAEP(this);'>部署AEP</a></li>" +
					 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='deleteMachine(this);'>删除</a></li></ul>"+	
		     		 	"</div></td></tr>";  
					 sutData.push(tr);
		            }
					 
					var temCount = temData.length;//tem记录条数 
					var sutCount = sutData.length;//sut记录条数 
				    var PageSize=10;//设置每页示数目 
				    
				    var tempagecount = temCount/PageSize;
				    var temPageCount=Math.ceil(tempagecount);//计算总页数 
				    
				    var sutpagecount = sutCount/PageSize;
				    var sutPageCount=Math.ceil(sutpagecount);//计算总页数 
				    
				    var currentPage = 1;//当前页，默认为1。  

				    $("#temPageIndex").html("");
				    for(var i=1;i<=temPageCount;i++){ 
					    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
					    $("#temPageIndex").append(pageNew);  
				    }
				    
				    $("#sutPageIndex").html("");
				    for(var i=1;i<=sutPageCount;i++){ 
					    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
					    $("#sutPageIndex").append(pageNew);  
				    }  

				    //显示默认页（第一页）  
				 	$("#temTable tbody").html("");
				    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
				        $('#temTable tbody').append(temData[i]);  
				    }
				    
				    $("#sutTable tbody").html("");
				    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
				        $('#sutTable tbody').append(sutData[i]);  
				    }   
				 
				    //显示选择页的内容  
				    $('#temIndexDiv a').click(function(){
					    var pageIndex=$(this).attr('pageIndex');  
					    $("#temTable tbody").html("");  
			
					    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
					    	$("#temTable tbody").append(temData[i]);  
			   			};
					})
					
					$('#sutIndexDiv a').click(function(){
					    var pageIndex=$(this).attr('pageIndex');  
					    $("#sutTable tbody").html("");  
			
					    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
					    	$("#sutTable tbody").append(sutData[i]);  
			   			};
			   			
			   			updateState();
					})
					
					updateState();
		        }	
		 	});
	    	
		}

		function editMachineInfo(a) {
		    var hostMac = $(a).parent().parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().text();
		    var id = $(a).parent().parent().parent().parent().parent().children(":first-child").text();
	    	var urlPath = "${pageContext.request.contextPath}" + "/machine.do/updateMachineInfo?id=" + id + "&hostMac=" + hostMac;
	    	var desPath = "${pageContext.request.contextPath}" + "/machine.do/updateMachineInfo?id=" + id + "&hostMac=" + hostMac;
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
		           location.href=desPath;   
		        }		        	
		 	});
		}
		/*  function preSetUp(a) {
			    var hostMac = $(a).parent().parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().text();
			    var id = $(a).parent().parent().parent().parent().parent().children(":first-child").text();
 	    	//var urlPath = "${pageContext.request.contextPath}" + "/machine.do/preSetUp?hostMac=" + hostMac;
 	    	var urlPath = "${pageContext.request.contextPath}" + "/machine.do/preSetUp?id=" + id + "&hostMac=" + hostMac;
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
 		           //alert("成功了:"+data);
 		            location.href=urlPath;
 		        }		        	
 		 	});
			} */ 
		 function statusUpdate(a) {
				 showLoading();
			    var hostMac = $(a).parent().parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().text();
	            var urlPath = "${pageContext.request.contextPath}" + "/machine.do/statusUpdate?hostMac=" + hostMac;
	            console.log("test");
	           
	 	    	$.ajax({  
	 		        data:"",  
	 		        type:"GET",
	 		        contentType :'application/json; charset=utf-8',
	 		        url:urlPath, 
	 		        dataType: "text",
	 		        error:function(data){  
		 		           removeLoading('loadName');
	 		            alert("出错了:"+data); 

	 		        },  
	 		        success:function(data){
	 		        	 removeLoading('loadName');
	 		        	 var updateMachineList = JSON.parse(data);
			        	 //alert("更新成功！" + machineList.newTemList[0].model);
			        	 var result=updateMachineList.result;
			        	 var updateTemList = updateMachineList.updateTemList;
			        	 var updateSutList = updateMachineList.updateSutList;
					     alert(result);
			        	 /* alert(updateTemList);
			        	 alert(updateSutList); */
			        	 var temData=[];
						 var sutData=[];
			             var temIndex = 1;
			             var sutIndex = 1;
						 
			            for(var i =0;i < updateTemList.length;i++){
			            	 var tr="<tr>"+  
						     "<td>"+ temIndex++ +"</td>"+  
						     "<td>"+ updateTemList[i].model +"</td>"+  
						     "<td>"+ updateTemList[i].status+"</td>"+
						     "<td class='state'>"+ updateTemList[i].line_status + "</td>" +
						     "<td>"+ updateTemList[i].os +"</td>"+
						     "<td>"+ updateTemList[i].bios_ver +"</td>"+
						     "<td>"+ updateTemList[i].bmc_ver +"</td>"+
						     "<td>"+ updateTemList[i].host_ip +"</td>"+
						     "<td>"+ updateTemList[i].host_mac +"</td>"+
						     "<td>"+ updateTemList[i].bmc_ip +"</td>"+
						     "<td>"+ updateTemList[i].bmc_mac +"</td>"+
						     "<td>"+ updateTemList[i].time +"</td>"+
						     "<td>"+ updateTemList[i].addr +"</td>"+
						     "<td>"+ updateTemList[i].user +"</td>"+
						     "<td>"+ updateTemList[i].comment +"</td>"+
						     "<td><div class='dropdown'>" + 
						     "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
			     		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
			     		 	  "<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='editMachineInfo(this);'>编辑机器信息</a></li>"+
			     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='statusUpdate(this);'>状态更新</a></li>"+
						 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOn(this);'>开机</a></li>" +
						 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOff(this);'>关机</a></li>" +
						 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='installAEP(this);'>部署AEP</a></li>" +
						 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='deleteMachine(this);'>删除</a></li></ul>"+	
			     		 	"</div></td></tr>";  
						 temData.push(tr);
			            }
			            
			            
			            
			            for(var i =0;i < updateSutList.length;i++){
			            	 var tr="<tr>"+  
						     "<td>"+ sutIndex++ +"</td>"+  
						     "<td>"+ updateSutList[i].model +"</td>"+  
						     "<td>"+ updateSutList[i].status+"</td>"+
						     "<td class='state'>"+ updateSutList[i].line_status + "</td>" +
						     "<td>"+ updateSutList[i].os +"</td>"+
						     "<td>"+ updateSutList[i].bios_ver +"</td>"+
						     "<td>"+ updateSutList[i].bmc_ver +"</td>"+
						     "<td>"+ updateSutList[i].host_ip +"</td>"+
						     "<td>"+ updateSutList[i].host_mac +"</td>"+
						     "<td>"+ updateSutList[i].bmc_ip +"</td>"+
						     "<td>"+ updateSutList[i].bmc_mac +"</td>"+
						     "<td>"+ updateSutList[i].time +"</td>"+
						     "<td>"+ updateSutList[i].addr +"</td>"+
						     "<td>"+ updateSutList[i].user +"</td>"+
						     "<td>"+ updateSutList[i].comment +"</td>"+
						     "<td><div class='dropdown'>" + 
						     "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
						     "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
			     		 	  	"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='editMachineInfo(this);'>编辑机器信息</a></li>"+
			     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='statusUpdate(this);'>状态更新</a></li>"+
						 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOn(this);'>开机</a></li>" +
						 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOff(this);'>关机</a></li>" +
						 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='installAEP(this);'>部署AEP</a></li>" +
						 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='deleteMachine(this);'>删除</a></li></ul>"+	
			     		 	"</div></td></tr>";  
						 sutData.push(tr);
			            }
			            var temCount = temData.length;//tem记录条数 
						var sutCount = sutData.length;//sut记录条数 
					    var PageSize=10;//设置每页示数目 
					    
					    var tempagecount = temCount/PageSize;
					    var temPageCount=Math.ceil(tempagecount);//计算总页数 
					    
					    var sutpagecount = sutCount/PageSize;
					    var sutPageCount=Math.ceil(sutpagecount);//计算总页数 
					    
					    var currentPage = 1;//当前页，默认为1。  

					    $("#temPageIndex").html("");
					    for(var i=1;i<=temPageCount;i++){ 
						    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
						    $("#temPageIndex").append(pageNew);  
					    }
					    
					    $("#sutPageIndex").html("");
					    for(var i=1;i<=sutPageCount;i++){ 
						    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
						    $("#sutPageIndex").append(pageNew);  
					    }  

					    //显示默认页（第一页）  
					 	$("#temTable tbody").html("");
					    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
					        $('#temTable tbody').append(temData[i]);  
					    }
					    
					    $("#sutTable tbody").html("");
					    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
					        $('#sutTable tbody').append(sutData[i]);  
					    }   
					 
					    //显示选择页的内容  
					    $('#temIndexDiv a').click(function(){
						    var pageIndex=$(this).attr('pageIndex');  
						    $("#temTable tbody").html("");  
				
						    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
						    	$("#temTable tbody").append(temData[i]);  
				   			};
						})
						
						$('#sutIndexDiv a').click(function(){
						    var pageIndex=$(this).attr('pageIndex');  
						    $("#sutTable tbody").html("");  
				
						    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
						    	$("#sutTable tbody").append(sutData[i]);  
				   			};
				   			
				   			updateState();
						})
						
						updateState();
						 
	 		        }		        	
	 		 	});
			}
		 
		 function deleteMachine(a) {
			  var r=confirm("确定要删除机器？")
	        	if (r==true){
	        		var hostMac = $(a).parent().parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().text();
		            var urlPath = "${pageContext.request.contextPath}" + "/machine.do/deleteMachine?hostMac=" + hostMac;
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
		 		        	 var deMachineList = JSON.parse(data);
				        	 //alert("更新成功！" + machineList.newTemList[0].model);
				        	 var result=deMachineList.result;
				        	 var deTemList = deMachineList.deTemList;
				        	 var deSutList = deMachineList.deSutList;
						     alert(result);
				        	 /* alert(updateTemList);
				        	 alert(updateSutList); */
				        	 var temData=[];
							 var sutData=[];
				             var temIndex = 1;
				             var sutIndex = 1;
							 
				            for(var i =0;i < deTemList.length;i++){
				            	 var tr="<tr>"+  
							     "<td>"+ temIndex++ +"</td>"+  
							     "<td>"+ deTemList[i].model +"</td>"+  
							     "<td>"+ deTemList[i].status+"</td>"+
							     "<td class='state'>"+ deTemList[i].line_status + "</td>" +
							     "<td>"+ deTemList[i].os +"</td>"+
							     "<td>"+ deTemList[i].bios_ver +"</td>"+
							     "<td>"+ deTemList[i].bmc_ver +"</td>"+
							     "<td>"+ deTemList[i].host_ip +"</td>"+
							     "<td>"+ deTemList[i].host_mac +"</td>"+
							     "<td>"+ deTemList[i].bmc_ip +"</td>"+
							     "<td>"+ deTemList[i].bmc_mac +"</td>"+
							     "<td>"+ deTemList[i].time +"</td>"+
							     "<td>"+ deTemList[i].addr +"</td>"+
							     "<td>"+ deTemList[i].user +"</td>"+
							     "<td>"+ deTemList[i].comment +"</td>"+
							     "<td><div class='dropdown'>" + 
							     "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
				     		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
				     		 	  "<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='editMachineInfo(this);'>编辑机器信息</a></li>"+
				     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='statusUpdate(this);'>状态更新</a></li>"+
							 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOn(this);'>开机</a></li>" +
							 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOff(this);'>关机</a></li>" +
							 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='deleteMachine(this);'>删除</a></li></ul>"+	
				     		 	"</div></td></tr>";  
							 temData.push(tr);
				            }
				            
				            
				            
				            for(var i =0;i < deSutList.length;i++){
				            	 var tr="<tr>"+  
							     "<td>"+ sutIndex++ +"</td>"+  
							     "<td>"+ deSutList[i].model +"</td>"+  
							     "<td>"+ deSutList[i].status+"</td>"+
							     "<td class='state'>"+ deSutList[i].line_status + "</td>" +
							     "<td>"+ deSutList[i].os +"</td>"+
							     "<td>"+ deSutList[i].bios_ver +"</td>"+
							     "<td>"+ deSutList[i].bmc_ver +"</td>"+
							     "<td>"+ deSutList[i].host_ip +"</td>"+
							     "<td>"+ deSutList[i].host_mac +"</td>"+
							     "<td>"+ deSutList[i].bmc_ip +"</td>"+
							     "<td>"+ deSutList[i].bmc_mac +"</td>"+
							     "<td>"+ deSutList[i].time +"</td>"+
							     "<td>"+ deSutList[i].addr +"</td>"+
							     "<td>"+ deSutList[i].user +"</td>"+
							     "<td>"+ deSutList[i].comment +"</td>"+
							     "<td><div class='dropdown'>" + 
							     "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
							     "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
				     		 	  	"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='editMachineInfo(this);'>编辑机器信息</a></li>"+
				     		 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='statusUpdate(this);'>状态更新</a></li>"+
							 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOn(this);'>开机</a></li>" +
							 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='powerOff(this);'>关机</a></li>" +
							 		"<li role='presentation'><a role='menuitem' tabindex='-1' href='#' onclick='deleteMachine(this);'>删除</a></li></ul>"+	
				     		 	"</div></td></tr>";  
							 sutData.push(tr);
				            }
				            var temCount = temData.length;//tem记录条数 
							var sutCount = sutData.length;//sut记录条数 
						    var PageSize=10;//设置每页示数目 
						    
						    var tempagecount = temCount/PageSize;
						    var temPageCount=Math.ceil(tempagecount);//计算总页数 
						    
						    var sutpagecount = sutCount/PageSize;
						    var sutPageCount=Math.ceil(sutpagecount);//计算总页数 
						    
						    var currentPage = 1;//当前页，默认为1。  

						    $("#temPageIndex").html("");
						    for(var i=1;i<=temPageCount;i++){ 
							    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
							    $("#temPageIndex").append(pageNew);  
						    }
						    
						    $("#sutPageIndex").html("");
						    for(var i=1;i<=sutPageCount;i++){ 
							    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
							    $("#sutPageIndex").append(pageNew);  
						    }  

						    //显示默认页（第一页）  
						 	$("#temTable tbody").html("");
						    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
						        $('#temTable tbody').append(temData[i]);  
						    }
						    
						    $("#sutTable tbody").html("");
						    for(i= (currentPage-1) * PageSize; i < PageSize * currentPage ; i++){    
						        $('#sutTable tbody').append(sutData[i]);  
						    }   
						 
						    //显示选择页的内容  
						    $('#temIndexDiv a').click(function(){
							    var pageIndex=$(this).attr('pageIndex');  
							    $("#temTable tbody").html("");  
					
							    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
							    	$("#temTable tbody").append(temData[i]);  
					   			};
							})
							
							$('#sutIndexDiv a').click(function(){
							    var pageIndex=$(this).attr('pageIndex');  
							    $("#sutTable tbody").html("");  
					
							    for(i=(pageIndex-1)*PageSize;i<PageSize*pageIndex;i++){  
							    	$("#sutTable tbody").append(sutData[i]);  
					   			};
					   			
					   			updateState();
							})
							 
		 		        }		        	
		 		 	});
				}
		 }
		 function powerOn(a) {
			  var r=confirm("确定要执行开机操作？")
	        	if (r==true){
	        		var hostMac = $(a).parent().parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().text();
		            var urlPath = "${pageContext.request.contextPath}" + "/machine.do/powerOn?hostMac=" + hostMac;
		            showLoading();
		 	    	$.ajax({  
		 		        data:"",  
		 		        type:"GET",
		 		        contentType :'application/json; charset=utf-8',
		 		        url:urlPath, 
		 		        dataType: "text",
		 		        error:function(data){  
		 		        	removeLoading('loadName');
		 		            alert("出错了:"+data);  
		 		           
		 		        },  
		 		        success:function(data){
		 		        	removeLoading('loadName');
		 		           var result = data.toString();
		 		           if(result == "success"){
		 		        	  alert("成功了:"+result);        
		 		        	}
		 		        	else{
		 		        		alert(result);
		 		        	}
		 		        }		        	
		 		 	});
	        	}
			    
			}
		 function powerOff(a) { 
			 var r=confirm("确定要执行关机操作？")
	        	if (r==true){
			    var hostMac = $(a).parent().parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().text();
	            var urlPath = "${pageContext.request.contextPath}" + "/machine.do/powerOff?hostMac=" + hostMac;
	            showLoading();
	 	    	$.ajax({  
	 		        data:"",  
	 		        type:"GET",
	 		        contentType :'application/json; charset=utf-8',
	 		        url:urlPath, 
	 		        dataType: "text",
	 		        error:function(data){  
	 		        	removeLoading('loadName');
	 		            alert("出错了:"+data);  
	 		        },  
	 		        success:function(data){
	 		           var result = data.toString();
	 		           if(result == "success"){
	 		        	  removeLoading('loadName');
	 		        	  alert("成功了:"+result);        
	 		        	}
	 		        	else{
	 		        		alert(result);
	 		        	}
	 		        }		        	
	 		 	});
	        	}
			}
		 function installAEP(a) {
			  var r=confirm("确定要部署AEP？")
	        	if (r==true){
	        		var hostMac = $(a).parent().parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().text();
		            var urlPath = "${pageContext.request.contextPath}" + "/machine.do/installAEP?hostMac=" + hostMac;
		            showLoading();
		 	    	$.ajax({  
		 		        data:"",  
		 		        type:"GET",
		 		        contentType :'application/json; charset=utf-8',
		 		        url:urlPath, 
		 		        dataType: "text",
		 		        error:function(data){  
			 		        removeLoading('loadName');
		 		            alert("出错了:"+data);  
		 		        },  
		 		        success:function(data){
			 		       removeLoading('loadName');
		 		           var result = data.toString();
		 		           if(result == "success"){
		 		        	  alert("成功了:"+result);        
		 		        	}
		 		        	else{
		 		        		alert(result);
		 		        	}
		 		        }		        	
		 		 	});
	        	}
			    
			}
		 function updateState() { 
			 $("td[class='state']").each(function(){ 
				 	//alert($(this).html());
				 	if($(this).html() == "OnLine"){
				 		$(this).html("");				
				 		var img = document.createElement("img"); 				 		
				 		img.setAttribute("src", "${pageContext.request.contextPath}/bower_components/iAutoDemo/images/connected.png"); 
				 		$(this).html(img);
				 	}
				 	if($(this).html() == "OffLine"){
				 		$(this).html("");				
				 		var img = document.createElement("img"); 				 		
				 		img.setAttribute("src", "${pageContext.request.contextPath}/bower_components/iAutoDemo/images/disconnected.png"); 
				 		$(this).html(img);
				 	}				 			
				 }); 
		 }
		
	</script>
</head>

<body>
	<jsp:include page="top.jsp" flush="true" />

	<div class="view-body">
		<div style="margin-top:20px;">
               <div class="input-group" style="width:100px;float:right;margin-top:20px;margin-right:55px;">
                   <span>
						<a onclick="update();" class="btn btn-large btn-primary">全机线上更新</a>  
					</span>
               </div>
               <select class="form-control" name="searchLab" id="searchLab" style="width:350px;float:right;margin-top:20px;">
				    <option value="0">济南S05-2F服务器实验室(100.2.36-39.0-254)</option>
					<option value="1">北京S01-3F服务器实验室(100.5.36-39.0-254)</option>
					<option value="2">济南系统验证实验室（STR）(100.2.34-35.0-254)</option>
					<option value="3">济南部件实验室(100.2.46.2-254)</option>
					<option value="4">济南研发测试实验室（STR）(100.2.73.2-254)</option>
				</select>
               <input class="form-control" style="width:90px;float:right;margin-top:20px;" readonly value="搜索网段" />
        </div>
        
		<div class="container" style="width:95%;">               
			<table id="temTable" class="table table-striped table-hover">
				<!-- <div style="width:100%;text-align:right">
					<a onclick="update();" class="btn btn-large btn-primary">全机线上更新</a>
				</div> -->	
				<caption style="font-size:20px;font-style:italic;margin-top:-30px;">线上执行机器(TEM)</caption>
				<thead>
					<tr>
						<th>序号<br/>
							(No.)
						</th>
						<th>机器型号</th>
						<th>工作状态</th>
						<th>连线状态</th>
						<th>操作系统</th>
						<th>BIOS固件版本</th>
						<th>BMC固件版本</th>
						<th>Host IP</th>
						<th>Host MAC</th>
						<th>BMC IP</th>
						<th>BMC MAC</th>
						<th>更新时间<br/>
							(Update Time)</th>
						<th>所在地点<br/>
							(At The Address)</th>
						<th>使用者<br/>
							(User ID)</th>
						<th>备注<br/>
							(Comment)</th>
						<th>操作选取</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
			
			<div id="temIndexDiv" style="text-align:center;">
				<ul id="temPageIndex" class="pagination">
					
				</ul>
			</div>
			
			<table id="sutTable" class="table table-striped table-hover" style="margin-top:50px;">
				<caption style="font-size:20px;font-style:italic;margin-top:-30px;">线上待测机器(SUT)</caption>
				<thead>
					<tr>
						<th>序号<br/>
							(No.)
						</th>
						<th>机器型号</th>
						<th>工作状态</th>
						<th>连线状态</th>
						<th>操作系统</th>
						<th>BIOS固件版本</th>
						<th>BMC固件版本</th>
						<th>Host IP</th>
						<th>Host MAC</th>
						<th>BMC IP</th>
						<th>BMC MAC</th>
						<th>更新时间<br/>
							(Update Time)</th>
						<th>所在地点<br/>
							(At The Address)</th>
						<th>使用者<br/>
							(User ID)</th>
						<th>备注<br/>
							(Comment)</th>
						<th>操作选取</th>
					</tr>
				</thead>
				<tbody>
			
				</tbody>
			</table>				
			
			<div id="sutIndexDiv" style="text-align:center;">
				<ul id="sutPageIndex" class="pagination">
					
				</ul>
			</div>
		</div>
	</div>
</body>
<script>
$.fn.loading = function(options){
		var $this = $(this);
		var _this = this;
		return this.each(function(){
		    var loadingPosition ='';
		    var defaultProp = {
		    	direction: 				'column',												//方向，column纵向   row 横向
				animateIn: 	 			'fadeInNoTransform',    								//进入类型
				title:                  '请稍等...',      										//显示什么内容
				name: 					'loadingName', 											//loading的data-name的属性值  用于删除loading需要的参数
				type: 			        'origin', 			  									//pic   origin  
				discription: 			'这是一个描述', 										//loading的描述
				titleColor: 			'rgba(255,255,255,0.7)',								//title文本颜色
				discColor: 				'rgba(255,255,255,0.7)',								//disc文本颜色
				loadingWidth:           260,                									//中间的背景宽度width
				loadingBg:        		'rgba(0, 0, 0, 0.6)',  									//中间的背景色
				borderRadius:     		12,                 									//中间的背景色的borderRadius
				loadingMaskBg:    		'transparent',          								//背景遮罩层颜色
				zIndex:           		1000001,              									//层级

				// 这是圆形旋转的loading样式  
				originDivWidth:        	60,           											//loadingDiv的width
				originDivHeight:       	60,           											//loadingDiv的Height

				originWidth:      		8,                  									//小圆点width
				originHeight:     		8,                  									//小圆点Height
				originBg:         		'#fefefe',              								//小圆点背景色
				smallLoading:     		false,                  								//显示小的loading

				// 这是图片的样式   (pic)
				imgSrc: 				'http://www.daiwei.org/index/images/logo/dw.png',    	//默认的图片地址
				imgDivWidth: 			80,           											//imgDiv的width
				imgDivHeight: 			80,           											//imgDiv的Height

				flexCenter: 	 		false, 													//是否用flex布局让loading-div垂直水平居中
				flexDirection: 			'row',													//row column  flex的方向   横向 和 纵向				
				mustRelative: 			false, 													//$this是否规定relative
		    };


		    var opt = $.extend(defaultProp,options || {});

		    //根据用户是针对body还是元素  设置对应的定位方式
		    if($this.selector == 'body'){
		    	$('body,html').css({
		    		overflow:'hidden',
		    	});
		    	loadingPosition = 'fixed';
		    }else if(opt.mustRelative){
		    	$this.css({
			    	position:'relative',
			    });
			    loadingPosition = 'absolute';
		    }else{
		    	loadingPosition = 'absolute';
		    }

		    defaultProp._showOriginLoading = function(){
		    	var smallLoadingMargin = opt.smallLoading ? 0 : '-10px';
		    	if(opt.direction == 'row'){smallLoadingMargin='-6px'}

		    	//悬浮层
		      	_this.cpt_loading_mask = $('<div class="cpt-loading-mask animated '+opt.animateIn+' '+opt.direction+'" data-name="'+opt.name+'"></div>').css({
			        'background':opt.loadingMaskBg,
			        'z-index':opt.zIndex,
			        'position':loadingPosition,
				}).appendTo($this);

		      	//中间的显示层
				_this.div_loading = $('<div class="div-loading"></div>').css({
			        'background':opt.loadingBg,
			        'width':opt.loadingWidth,
			        'height':opt.loadingHeight,
			        '-webkit-border-radius':opt.borderRadius,
			        '-moz-border-radius':opt.borderRadius,
			        'border-radius':opt.borderRadius,
		      	}).appendTo(_this.cpt_loading_mask);

				if(opt.flexCenter){
					_this.div_loading.css({
						"display": "-webkit-flex",
						"display": "flex",
						"-webkit-flex-direction":opt.flexDirection,
						"flex-direction":opt.flexDirection,
						"-webkit-align-items": "center",
						"align-items": "center",
						"-webkit-justify-content": "center",
						"justify-content":"center",
					});
				}

				//loading标题
	        	_this.loading_title = $('<p class="loading-title txt-textOneRow"></p>').css({
	        		color:opt.titleColor,
	        	}).html(opt.title).appendTo(_this.div_loading);

	        	//loading中间的内容  可以是图片或者转动的小圆球
		     	_this.loading = $('<div class="loading '+opt.type+'"></div>').css({
			        'width':opt.originDivWidth,
			        'height':opt.originDivHeight,
		      	}).appendTo(_this.div_loading);

		     	//描述
	        	_this.loading_discription = $('<p class="loading-discription txt-textOneRow"></p>').css({
	        		color:opt.discColor,
	        	}).html(opt.discription).appendTo(_this.div_loading);

	        	if(opt.type == 'origin'){
	        		_this.loadingOrigin = $('<div class="div-loadingOrigin"><span></span></div><div class="div-loadingOrigin"><span></span></div><div class="div_loadingOrigin"><span></span></div><div class="div_loadingOrigin"><span></span></div><div class="div_loadingOrigin"><span></span></div>').appendTo(_this.loading);
			      	_this.loadingOrigin.children().css({
				        "margin-top":smallLoadingMargin,
				        "margin-left":smallLoadingMargin,
				        "width":opt.originWidth,
				        "height":opt.originHeight,
				        "background":opt.originBg,
			      	});
	        	}	

	        	if(opt.type == 'pic'){
	        		_this.loadingPic = $('<img src="'+opt.imgSrc+'" alt="loading" />').appendTo(_this.loading);
	        	}	      


		      	//关闭事件冒泡  和默认的事件
			    _this.cpt_loading_mask.on('touchstart touchend touchmove click',function(e){
					e.stopPropagation();
					e.preventDefault();
			    });
		    };
		    defaultProp._createLoading = function(){
		    	//不能生成两个loading data-name 一样的loading
		    	if($(".cpt-loading-mask[data-name="+opt.name+"]").length > 0){
		    		// console.error('loading mask cant has same date-name('+opt.name+'), you cant set "date-name" prop when you create it');
		    		return
		    	}
				
				defaultProp._showOriginLoading();
		    };
		    defaultProp._createLoading();
		});
	}

//关闭Loading
function removeLoading(loadingName){
	var loadingName = loadingName || '';
	$('body,html').css({
		overflow:'auto',
	});

	if(loadingName == ''){
		$(".cpt-loading-mask").remove();
	}else{
		var name = loadingName || 'loadingName';
		$(".cpt-loading-mask[data-name="+name+"]").remove();		
	}
}

	function showLoading() {
		$('body').loading({
			loadingWidth:240,
			title:'请稍等!',
			name:'loadName',
			discription:'正在扫描中......',
			direction:'column',
			type:'origin',
			// originBg:'#71EA71',
			originDivWidth:40,
			originDivHeight:40,
			originWidth:6,
			originHeight:6,
			smallLoading:false,
			loadingMaskBg:'rgba(0,0,0,0.2)'
		});
	}
</script>
</html>