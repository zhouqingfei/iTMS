<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>性能测试</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
	
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

</body>
</html>