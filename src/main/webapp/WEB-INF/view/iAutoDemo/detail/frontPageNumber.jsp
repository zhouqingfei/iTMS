<%@ page language="java" contentType="text/html; charset=utf-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta charset="utf-8">
		<title>首页</title>
		<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/echarts.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.js"></script>	
	
<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css"/>
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
	</head>

	<body>
	   
	    
	    <div style="width:100%;padding-top:20px;display:inline-block;background-color:#E3E3E3; ">  
			<img src="${pageContext.request.contextPath}/bower_components/iAutoDemo/images/user.png" width="65px" height="55px" style="float:left;margin-left:40px;"/>
			<div style="float:left;padding-top:5px;">
				<label id="name">Name:${user.userId}</label><br/>					
				<label id="email">Email:${user.email}</label>
			</div>
		</div>

    	<div id="chartContent" style="width:100%;height:1000px;padding-top:30px;text-align:center;background-color:#E3E3E3;">			
		    <p style="font-size:20px;font-style:italic;margin-left:60px;margin-top:-30px;text-align:left;">一周內之已完成测试任务历程</p>
		   
		    <div id="taskStatePie" style="width:45%;height:400px;border-radius:8px;display:inline-block; ">	
		    </div>
	        <script type="text/javascript">
	        $(document).ready(function () {
		      	  $("button[id=button]").click(function(){
		      	      var txt=$("input[id=input]").val();
		      	      if($.trim(txt)!=""){
		      	 
		      	        $("table tr:not('#theader')").hide().filter(":contains('"+txt+"')").show();
		      	      }else{
		      	        $("table tr:not('#theader')").css("background","#fff").show();
		      	      }
		      	    }); 
		      	  
		            });
				var dom = document.getElementById("taskStatePie");
				var myChart = echarts.init(dom);
				var app = {};
				var option = null;
				app.title = '环形图';
				 
				option = {
					backgroundColor: 'white',
					 title: {
			            text: '任务状态统计',
			            x:'center'
			        },
				    tooltip: {
				        trigger: 'item',
				        formatter: "{a} <br/>{b}: {c} ({d}%)"
				    },
				    legend: {
				        orient: 'borizontal',
				        width:40,      //图行例组件的宽度,默认自适应
		                x : 'right',   //图例显示在右边
		                y: 'bottom',   //图例在垂直方向上面显示居中
				        data:['测试成功','测试失败','无法测试',"测试进行中"]
				    },
				    series: [
				        {
				            name:'',
				            type:'pie',
				            radius: ['50%', '70%'],
				            avoidLabelOverlap: false,
				           
				           itemStyle: {
			                    emphasis: {
			                        shadowBlur: 10,
			                        shadowOffsetX: 0,
			                        shadowColor: 'rgba(0, 0, 0, 0.5)'
			                    },
			                    normal:{ 
			                        label:{ 
			                            show: true, 
			                            formatter: '{b} : {c} ({d}%)' 
			                        }, 
			                        labelLine :{show:true} 
			                    } 
			                },
				            data:[
				                {value:2, name:'测试成功'},
				                {value:3, name:'测试失败'},
				                {value:4, name:'无法测试'},
				                {value:1, name:'测试进行中'}			           
				            ]
				        }
				    ]
				};


				if (option && typeof option === "object") {
				    myChart.setOption(option, true);
				}
	        </script>

	        <div id="finishedPie" style="margin-left:60px;width:45%;height:400px;background-color:white;border-radius:8px;display:inline-block ; "></div>
	        <script type="text/javascript">
				var myChart = echarts.init(document.getElementById('finishedPie'));

		        var option = {
		        	backgroundColor: 'white',
		          title: {
		            text: '已完成任务结果百分比',
		            x:'center'
		          },
		          tooltip: {
		            trigger: 'item',
		            formatter: "{a} <br/>{b} : {c} ({d}%)"
		            //饼图中{a}表示系列名称，{b}表示数据项名称，{c}表示数值，{d}表示百分比
		          },
		          legend: {//图例
		            orient: 'vertical',
		            x : 'right',   //图例显示在右边
		            y: 'bottom',   //图例在垂直方向上面显示居中
		            data: ['测试成功','测试失败','无法测试']
		          },
		          series: [{
		            name: '比例：',
		            type: 'pie',
		            radius: '55%',
		            data: [
		                {value:2,name:'测试成功'},
		                {value:3,name:'测试失败'},
		                {value:4,name:'无法测试'}
		            ],

				 itemStyle:{ 
			            normal:{ 
			                  label:{ 
			                    show: true, 
			                    formatter: '{d}%' ,
			                    position: 'inside'
			                  }, 
			                  labelLine :{show:true} 
			                } 
			            } 
			          }]
			        };
		        myChart.setOption(option);
	        </script>
	    <div>
	    
		<div class="view-body" style="background-color:#E3E3E3;">
			<div class="container" style="width:96%;padding-top:10px;">
				
				<div style="margin-top:20px;">  	
					<div class="input-group" style="width:30%;float:right;margin-top:20px;">  
					    <input type="text" id="input" class="form-control"placeholder="请输入字段名" / >  
						<span class="input-group-btn">  
						   <button class="btn btn-info btn-search" id="button" style="background-color:#337ab7">查找</button>  
						</span>  
					</div>	
				</div>
				
				               
				<table class="table table-striped table-hover" style="background-color:white;">
					<caption style="font-size:20px;font-style:italic;margin-left:30px;"></caption>
					<thead>
						<tr id="theader">
							<th>任务编码<br/>
							（Task ID）
							</th>
							<th>任务名称<br/>
							（Task Name）
							</th>
							<th>套件名称<br/>
							（Suit Name）
							</th>
							<!-- <th>专案名称<br/>
							（Project Name）
							</th>
							<th>待测机MAC地址<br/>
							（SUT HOST MAC）
							</th> -->
							<th>执行时间<br/>
							（Start Time）
							</th>
							<th>完成时间<br/>
							（End Time）
							</th>
							<th>任务状态<br/>
							（State）
							</th>
							<th>测试结果<br/>
							（Result）
							</th>
							<th>测试报告<br /> （Report）
								</th>
							<!-- <th>测试报告<br/>
							（Report）
							</th> -->
													
						</tr>
					</thead>
					<tbody>
						<c:forEach var="testTask" items="${testTaskList}">
							<tr>
								<td>${testTask.id}</td>
								<td>${testTask.testTaskName} </td>
								<td>${testTask.poolSuitOrCase} </td>
								<td>${testTask.startTime}</td>
								<td>${testTask.endTime}</td>
								<td>${testTask.testTaskState}</td>
<%-- 								<td>${testTask.loginId}</td> --%>
								<td>${testTask.result}</td>
										
								<td>
										<div class="dropdown">
											<button type="button" class="btn dropdown-toggle"
												id="dropdownMenu1" data-toggle="dropdown">
												操作 <span class="caret"></span>
											</button>
											<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" style="min-width: 100px;">
												<li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/report.do/downloadRecentReport?reportNumber=${testTask.id}">下载</ a>
												</li>
												<!-- <li role="presentation"><button class="btn btn-info btn-search" id="button1"
									style="background-color: #337ab7">打开</button>
												</li> -->
											</ul>
										</div>
									</td>		
										
										
										<%-- <td>
										<div class="dropdown">
										<button type="button" class="btn dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">
											操作
											<span class="caret"></span>
										</button>
										<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" style="min-width:100px;">
											<li role="presentation">
												<a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/reportTester.do/downloadReport?reportNumber=${testTask.id}">下载</a>
											</li>
											<li role="presentation">
												<a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/reportTester.do/openFileReportFrontPage?reportNumber=${testTask.id}">打开</a>
											</li>
										</ul>
									</div>
								</td> --%>						
							</tr>
                        </c:forEach>
					</tbody>
				</table>
			</div>
			
			<div style="text-align:center;">
				<ul class="pagination">
					<li><a href="#">&laquo;</a></li>
					<li><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#">&raquo;</a></li>
				</ul>
			</div>
		</div>
	</body>
</html>