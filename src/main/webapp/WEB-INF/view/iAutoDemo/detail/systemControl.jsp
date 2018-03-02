<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>系统管理</title>

<link
	href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.js"></script>

<style>
.table th, .table td {
	text-align: center;
	vertical-align: middle !important;
}

.table th {
	font-size: 15px;
}

.table td {
	font-size: 13px;
}

.table td a {
	margin-bottom: 2px;
}
</style>
<script>
	$(function() {
		<!--
		$("button[id=button]").click(
				function() {
					var txt = $("input[id=input]").val();
					if ($.trim(txt) != "") {

						$("table tr:not('#theader')").hide().filter(
								":contains('" + txt + "')").show();
					} else {
						$("table tr:not('#theader')").css("background", "#fff")
								.show();
					}
				});
		-->
		allData = [];
		var index = 1;
		<c:forEach var="user" items="${userList}">
		var data = "<tr>"
				+ "<td>${user.userId}</td>"
				+ "<td>${user.email}</td>"
				+ "<td>${user.phone}</td>"
				+ "<td>${user.qq}</td>"
				+ "<td>${user.weChat}</td>"
				+ "<td>${user.loginId}</td>"
				+ "<td>${user.roleIds[0]}</td>"
				+ "<td><div class='dropdown'>"
				+ "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作 <span class='caret'></span></button>"
				+ "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width: 100px;'>"
				+ "<li role='presentation'>"
				+ "<a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/user.do/pass?userId=${user.userId}'>通过</a></li>"
				+ "<li role='presentation'>"
				+ "<a href='${pageContext.request.contextPath}/user.do/delete?userId=${user.userId}'>删除</a>"
				//+ "<a href='javascript:void(0)' onclick='delete_confirm(\"${user.userId}\", "+ index ++ + ");'>删除</a>"
				+ "</li></ul></div></td></tr>";
		allData.push(data);
		</c:forEach>

		var Count = allData.length;//记录条数  
		var PageSize = 10;//设置每页示数目 
		var pagecount = Count / PageSize;
		var PageCount = Math.ceil(pagecount);//计算总页数  
		var currentPage = 1;//当前页，默认为1。  

		for (var i = 1; i <= PageCount; i++) {
			var pageNew = "<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";
			$("#pageIndex").append(pageNew);
		}

		//显示默认页（第一页）
		$("#userListTable tbody").html("");
		for (i = (currentPage - 1) * PageSize; i < PageSize * currentPage; i++) {
			$('#userListTable tbody').append(allData[i]);
		}

		//显示选择页的内容  
		$('#indexDiv a').click(
				function() {
					var pageIndex = $(this).attr('pageIndex');
					$("#userListTable tbody").html("");

					for (i = (pageIndex - 1) * PageSize; i < PageSize
							* pageIndex; i++) {
						$("#userListTable tbody").append(allData[i]);
					}
					;
				})
	})
/* 		function search(){
		 var content=$("input[id=input]").val();
    	    var urlPath =  "${pageContext.request.contextPath}" + "/user.do/userSearch?content=" +	content;		
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
					var allData = [];
					var index=1;
					var searchUserList = JSON.parse(data);
					for(var i=0; i< searchUserList.length; i++){
						var user = searchUserList[i];
						allData.push("<tr>"
								+ "<td>"+ user.userId + "</td>"
								+ "<td>" + user.email + "</td>"
								+ "<td>" + user.phone + "</td>"
								+ "<td>" + user.qq + "</td>"
								+ "<td>" + user.weChat + "</td>"
								+ "<td>" + user.loginId + "</td>"
								+ "<td>" + user.roleIds[0] + "</td>"
								+ "<td><div class='dropdown'>"
								+ "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作 <span class='caret'></span></button>"
								+ "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width: 100px;'>"
								+ "<li role='presentation'>"
								+ "<a role='menuitem' tabindex='-1' href='${pageContext.request.contextPath}/user.do/pass?userId="+user.userId+"&email="+user.email+"&phone="+user.phone+"&qq="+user.qq+"&weChat="+user.weChat+"&loginId="+user.loginId+"&password="+user.password+"&roleIds="+user.roleIds[0]+"'>通过</a></li>"
								+ "<li role='presentation'>"
								+ "<a href='javascript:void(0)' onclick='delete_confirm(" + user.userId + ", "+ index++ + "});'>删除</a>"
								+ "</li></ul></div></td></tr>");
					}
		        
					var Count = allData.length;//记录条数  
					var PageSize = 10;//设置每页示数目 
					var pagecount = Count / PageSize;
					var PageCount = Math.ceil(pagecount);//计算总页数  
					var currentPage = 1;//当前页，默认为1。  

					for (var i = 1; i <= PageCount; i++) {
						var pageNew = "<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";
						$("#pageIndex").append(pageNew);
					}

					//显示默认页（第一页）  
					$("#userListTable tbody").html("");
					for (i = (currentPage - 1) * PageSize; i < PageSize * currentPage; i++) {
						$('#userListTable tbody').append(allData[i]);
					}
				}
			});
	} */
	
	function delete_confirm(userId, index){
		var r = confirm('是否要删除该申请？');
		if(r){
			$.ajax({
				data: "",
				type: "GET",
				contentType: "application/json; charset=utf-8",
				url: "${pageContext.request.contextPath}/user.do/delete?userId=${user.userId}",
				dataType: "text",
			});
		}
	}
</script>
</head>

<body>
	<jsp:include page="top.jsp" flush="true" />
	<div class="view-body">
		<div class="container" style="width: 90%;">

			<div style="margin-top: 10px;">
				<%-- <a  href="${pageContext.request.contextPath}/testCase.do/add.view" class="btn btn-large btn-primary" style="float:right;margin-top:20px;">+新建用例</a> --%>
				<div class="input-group"
					style="width: 30%; float: right; margin-top: 20px; margin-right: 10px;">
					<input type="text" class="form-control" id="input" placeholder="请输入字段名"/ >
					<span class="input-group-btn">
						<button class="btn btn-info btn-search" onclick="search()" 
							style="background-color: #337ab7">查找</button>
					</span>
				</div>
			</div>

			<div>
				<table class="table table-striped table-hover" id="userListTable">
					<caption
						style="font-size: 20px; font-style: italic; margin-left: 30px; margin-top: -10px;">待完成事项</caption>
					<thead>
						<tr>
							<th>用户名</th>
							<th>公司电邮<br /> (email)
							</th>
							<th>手机号<br /> (CellPhone)
							</th>
							<th>QQ号<br /> (QQ ID)
							</th>
							<th>微信号<br /> (weChat ID)
							</th>
							<th>账号<br /> (Login ID)
							</th>
							<th>权限<br /> (Authority)
							</th>
							<th>操作<br /> (Operation)
							</th>
						</tr>
					</thead>
					<tbody>
						<!-- 
						<c:forEach var="user" items="${userList}">
							<tr>
								<td>${user.userId}</td>
								<td>${user.email}</td>
								<td>${user.phone}</td>
								<td>${user.qq}</td>
								<td>${user.weChat}</td>
								<td>${user.loginId}</td>
								<td>${user.roleIds[0]}</td>
								<td>
									<div class="dropdown">
										<button type="button" class="btn dropdown-toggle"
											id="dropdownMenu1" data-toggle="dropdown">
											操作 <span class="caret"></span>
										</button>
										<ul class="dropdown-menu" role="menu"
											aria-labelledby="dropdownMenu1" style="min-width: 100px;">
											<li role="presentation"><a role="menuitem" tabindex="-1"
												href="${pageContext.request.contextPath}/user.do/pass?userId=${user.userId}&email=${user.email}&phone=${user.phone}&qq=${user.qq}&weChat=${user.weChat}&loginId=${user.loginId}&password=${user.password}&roleIds=${user.roleIds[0]}">通过</a>
											</li>
											<li role="presentation"><a
												href="${pageContext.request.contextPath}/user.do/delete?userId=${user.userId}"
												onclick="return confirm('是否要删除该申请？')">删除</a></li>
										</ul>
									</div>
								</td>
							</tr>
						</c:forEach>
					
					 -->
					</tbody>
				</table>
			</div>
		</div>

		<div id="indexDiv" style="text-align: center;">
			<ul id="pageIndex" class="pagination">
			</ul>
		</div>
	</div>
	<!-- <p>测试内容</p> -->
</body>
</html>