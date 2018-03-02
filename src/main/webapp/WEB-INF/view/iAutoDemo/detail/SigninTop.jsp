<%@ page language="java" contentType="text/html; charset=UTF-8"
    %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	    <title>SigninTop</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
	    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css"/>
		
		<style type="text/css">
			#nav{ background-color:#0070C0;width:100%;height:85px;z-index:99;margin-top:5px;position:relative;min-width:1360px;}  
			
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
			<img src="${pageContext.request.contextPath}/bower_components/iAutoDemo/images/iAuto.png" width="112" height="45" style="margin-top: 18px;margin-left:20px;float:left;"/>
			<ul>
				
				
				<li class="main" style="position:absolute;left:150px;top:0px;">
					<img src="${pageContext.request.contextPath}/bower_components/iAutoDemo/images/userManagement.png"/><br/>
					<a style="margin-left:-12px;">用户注册</a>    
				</li>
				
			</ul>  	  
		</div>
	</body>
</html>