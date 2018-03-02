<%@ page language="java" contentType="text/html; charset=UTF-8"
    %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
		<meta charset="utf-8">
		<title>EasyUi树形结构Demo</title>
		
		<link href="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/locale/easyui-lang-zh_CN.js"></script>
		<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/index.js"></script>
		 --%>
		 <script>
		 var treeUrl = "${pageContext.request.contextPath}" + "/deptController.do/deptTree";  
					var tree = null;//表示树  
					  
					$(function() {
						//alert(treeUrl);
					    tree = $('#vl');  
					    initTree();//初始化树  
					  
					});  
					  
					function initTree() { 
						 //alert("test");
					     tree.tree({  
					        url: treeUrl,  
					        animate: false,  
					        lines : true,  
					        checkbox : false,//是否显示复选框  
					        onClick: function(node) {  
					            //nodeClick(node);  
					        },  
					        onLoadSuccess: function(data) {  
					            alert("加载成功！");  
					        }  
					    });   
					} 
		</script>
		
	</head>

	<body style="height:1000px;width:1000px;">
		test
		<div style="width:30%; height:100%;position:absolute;top:34px;bottom:0;">  
	        <ul id="vl" data-options="region:'center',border: true" class="easyui-tree">  
	        </ul>  
	    </div>  
	</body>
</html>