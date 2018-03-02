<%@ page language="java" contentType="text/html; charset=UTF-8"
    %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	    <title>Top</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
	    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css"/>
		
		<style type="text/css">
			#nav{ background-color:#0070C0;width:100%;height:85px;z-index:99;margin-top:-10px;position:relative;min-width:1360px;}  
			
			#nav>ul{list-style:none;}  
			
			#nav>ul>li{padding-top:20px;}  
			
			#nav>ul>li>ul{background-color:#0070C0;margin-left:-10px;padding-top:10px;padding-left:0;border-bottom-right-radius:4px;border-bottom-left-radius:4px;display:none;}
			
			#nav>ul>li>ul>li{ list-style:none;padding-bottom:5px;}
			
			#nav ul li a{ text-decoration:none;display:block;padding:0px 10px;font-size:16px;color:white;}
			
			#nav>ul>li>img{ width:32px;height:38px;padding-bottom:8px;margin-left:10px;}
		</style>
		<script>
			$(document).ready(function(){
				$(".main").hover(function(){
					$(this).children("ul").slideDown();
				},function(){
					$(this).children("ul").stop(true,false).slideUp();
				})
			})
		</script>
	</head>

	<body>
		<div id="nav">
			<img src="${pageContext.request.contextPath}/bower_components/iAutoDemo/images/iAuto.png" width="170" height="75" style="margin-top: 8px;margin-left:20px;float:left;"/>
			<ul>
				<li class="main" style="position:absolute;left:200px;top:0px;">
					<img src="${pageContext.request.contextPath}/bower_components/iAutoDemo/images/frontPage.png"/><br/>
					<a href="${pageContext.request.contextPath}/frontPageDeveloper.do/frontPage.view">首页</a>     
				</li>
				
				<li class="main" style="position:absolute;left:350px;top:0px;">
					<img src="${pageContext.request.contextPath}/bower_components/iAutoDemo/images/userManagement.png"/><br/>
					<a style="margin-left:-12px;" href="${pageContext.request.contextPath}/userAdminDeveloper.do/userAdmin.view">用户管理</a>    
				</li>
				
				<li class="main" style="position:absolute;left:500px;top:0px;">
					<img src="${pageContext.request.contextPath}/bower_components/iAutoDemo/images/machine.png" width="30"/><br/>
						<a style="margin-left:-12px;"  href="#">机器管理</a> 
                        <ul style="margin-left:-23px;">  
							<li><a href="${pageContext.request.contextPath}/machineDeveloper.do/addMachine.view">新增机器(N.A.)</a></li>  
							<li><a href="${pageContext.request.contextPath}/machineDeveloper.do/machineAdmin.view">机器管理(SUT/TEM)</a></li>	
							<li><a href="${pageContext.request.contextPath}/machineDeveloper.do/preSetUp.view">线上预装</a></li>													
						</ul>   			
					</li>
				
				<li class="main" style="position:absolute;left:650px;top:0px;">
					<img src="${pageContext.request.contextPath}/bower_components/iAutoDemo/images/task.png""/><br/>
					<a style="margin-left:-29px;" href="${pageContext.request.contextPath}/testTaskDeveloper.do/index.view">测试任务管理</a>         
				</li>

				
				<li class="main" style="position:absolute;left:800px;top:0px;">
					<img src="${pageContext.request.contextPath}/bower_components/iAutoDemo/images/resource.png"/><br/>
					<a style="margin-left:-18px;" href="#">测试库管理</a>
					<ul style="margin-left:-23px;">  
						<li><a href="${pageContext.request.contextPath}/testSuitDeveloper.do/index.view">测试套件管理</a></li>
					    <li><a href="${pageContext.request.contextPath}/testCaseDeveloper.do/index.view">测试用例管理</a></li>
					</ul>  	    
				</li>
				
				<li class="main" style="position:absolute;left:950px;top:0px;">
					<img src="${pageContext.request.contextPath}/bower_components/iAutoDemo/images/report.png""/><br/>
					<a style="margin-left:-12px;" href="#">报告管理</a>
					<ul>  
						<li><a href="${pageContext.request.contextPath}/reportDeveloper.do/log.view">原生记录档</a></li>
					    <li><a href="${pageContext.request.contextPath}/reportDeveloper.do/report.view">测试报告</a></li>
					</ul>  
				</li>
				
				<%-- <li class="main" style="position:absolute;left:1100px;top:0px;">
					<img src="${pageContext.request.contextPath}/bower_components/iAutoDemo/images/performance.png" /><br/>
					<a style="margin-left:-12px;" href="${pageContext.request.contextPath}/performance.do/index.view">性能测试</a>
				</li> --%>
				
				
				<li class="main" style="position:absolute;left:1250px;top:0px;">
					<img src="${pageContext.request.contextPath}/bower_components/iAutoDemo/images/logout.png" /><br/>
					<a href="${pageContext.request.contextPath}">注销</a>
				</li>
			</ul>  	  
		</div>
	</body>
</html>