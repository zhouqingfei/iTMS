<%@ page language="java" contentType="text/html; charset=UTF-8"
    %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8">
		<title>测试用例列表</title>
		
		<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/wu.css"/>
		<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/themes/icon.css"/>
		<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/contrm.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/locale/easyui-lang-zh_CN.js"></script>
		
		<script>
		    
			$(function(){
				var url = "${pageContext.request.contextPath}" + "/itmsTestCase.do/getTestCaseList";  
	        	$("#testCaseTable").datagrid({
	        		title:"测试用例列表",
	        		weith:1000,
	        		height:600,
	        		url:url,
	        		columns:[[
	        			{
	        				field:"name",
	        				title:"用例名称", 
							width:150
	        			},
	        			{
	        				field:'script' , 
							title:'脚本路径' , 
							width:150
	        			},
	        			{
	        				field:'para' , 
							title:'脚本参数' , 
							width:150
	        			}
	        		]]
	        	})
	        });
		</script>
		
	</head>

	<body>
		<div>
			<table id="testCaseTable"></table>
		</div>
	</body>
</html>