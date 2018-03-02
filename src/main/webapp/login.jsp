<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>

	    <title>登录</title>
		<meta charset="UTF-8">
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/img/inspur.ico" type="image/x-icon" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/login.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
		<script src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/login.js" type="text/javascript"></script>
		
		<style>
			.errorClass {
				color: #f40000;
				font-size: 10pt;
				position: absolute;
				top: 16px;
				left: 60%;
			}
		
			.inputDivClass {
				position: relative;
				margin-left: 2px;
			}
		
			.inputClass {
				border: none;
				padding-left: 10px;
			}
		</style>
		<script>
			<%  
		    	String error = request.getParameter("Error");  
		 	%>
		 	var error = "<%=error%>";
		 	var passWordLabel = $("#passWordError");
		 	if(error != "" && error != null && error != "null"){
		 		alert("用户名或密码不匹配");
		 	}
		</script>
	</head>

	<body>
		
		<div class="htmleaf-container">
			<div class="wrapper">
				<div class="container">
					
					<img style="margin-top:20px;" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/img/inspur.png"/>
					<h1>Welcome to iAuto</h1>
					<form class="form" id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
						<!-- <input type="text" id="userName" name="username" placeholder="用户名" autofocus><label id="userNameError" class="errorClass">用户名错误</label>
					     <input type="password" id="passWord" name="password" placeholder="密码"><label id="passWordError" class="errorClass">密码错误</label>  -->
						<div class="inputDivClass">
							<input class="inputClass" id="userName" name="username" placeholder="用户名"><label class="errorClass" id="userNameError"></label>
						</div>
						
						<div class="inputDivClass">
							<input class="inputClass" type="password" id="passWord" name="password" placeholder="密码"><label class="errorClass" id="passWordError"></label> 
						</div>
						<button type="submit" id="login-button">登录</button>
					</form>
					<%-- <input value="<%=error%>"> --%>
					<form class="form" action="${pageContext.request.contextPath}/signin.do/index.view" method="post">
						<button  type="submit" id="login-button">注册</button>
					</form>
				</div>
				<ul class="bg-bubbles">
					<li></li>
					<li></li>
					<li></li>
					<li></li>
					<li></li>
					<li></li>
					<li></li>
					<li></li>
					<li></li>
					<li></li>
				</ul>
			</div>
		</div>
	</body>
</html>
