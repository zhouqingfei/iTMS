<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>新建小组成员</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/addNumber.js"></script>
	
	<style>
		.container {
			width: 90%;
			margin-left: 200px;
			margin-top: 30px;
		}
		
		.table {
			border: 2px;
		}
		
		.table th, .table td, .table caption {
			text-align: center;
			vertical-align: middle !important;
		}
		
		.table th {
			font-size: 15px;
		}
		
		.table tr {
			width: 200px;
		}
		
		.table td {
			font-size: 13px;
		}
		
		.table td select {
			width: 100%;
			height: 100%;
		}
		
		.ul li a {
			background-color: #31B0D5;
		}
		
		.table tbody tr td {
			padding: 0px 0px 0px 0px;
			height: 30px;
		}
		
		.errorClass {
			color: #f40000;
			font-size: 10pt;
			position: absolute;
			top: 5px;
			right: 10px;
		}
		
		.inputDivClass {
			position: relative;
			margin-left: 2px;
		}
		
		.inputClass {
			height: 30px;
			border: none;
			width: 100%;
			padding-left: 10px;
		}
	</style>
			
</head>

<body>
	<jsp:include page="top.jsp" flush="true" />

	<div class="view-body">
		<div class="container">
			<form class="form-inline" id="addNumberForm">	
				<table class="table table-striped table-bordered table-hover">
					<caption style="color: black; font-size: 23px; font-family: LiSu">新建小组成员</caption>
					<tr>
						<th width="480px">用户名</th>
						<td colspan="2">
							<div class="inputDivClass">
								<input class="inputClass" name="userId" id="userId" type=text value="" 
									placeholder="&nbsp请输入用户名......" /><label
									class="errorClass" id="userIdError" ></label>
							</div>
						</td>
					</tr>
					

					

				</table>
			
				<input type="submit" value="储存信息" class="btn btn-large btn-primary"
					style="position: absolute; right: 20px; top: 170px;">
				</input>
			</form>
			<input hidden id="path" value="${pageContext.request.contextPath}" />
			<a href="${pageContext.request.contextPath}/userAdminLeader.do/userAdmin.view"
				class="btn btn-large btn-primary"
				style="position: absolute; right: 20px; top: 220px;">返回前页</a>
			
		</div>
	</div>
	
</body>
</html>