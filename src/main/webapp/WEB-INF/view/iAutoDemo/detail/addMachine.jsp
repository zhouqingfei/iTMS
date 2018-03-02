<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>新增机器</title>

	<link href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/bootstrap.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/loading.css" rel="stylesheet" />
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/bootstrap.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/loading.js"></script>

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
	</style>
	<script>

		function scan(){
	    	var id = $("#searchLab").val();
	    	var urlPath =  "${pageContext.request.contextPath}" + "/machine.do/scan?id=" + id;
	    	//alert(urlPath);
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
		        	//alert("请求成功:"+data);
		        	var leftTableList=[];
		        	var rightTableList=[];
	        		var machineList = JSON.parse(data).machineList;
	        		var result=JSON.parse(data).result;
	        		
	        		for(var i=0;i < machineList.length;i++){
	        			var tr="<tr>"+  
		     		     "<td>"+ (i+1) + "</td>"+  
		     		     "<td>"+ machineList[i].ip +"</td>"+  
		     		     "<td>"+ machineList[i].mac + "</td>"+
		     		     "<td>"+ machineList[i].time +"</td>"+
		     		     "<td>"+ machineList[i].addr +"</td>"+
		     		     "<td><div class='dropdown'>" + 
		     		 	    "<button type='button' class='btn dropdown-toggle' id='dropdownMenu1' data-toggle='dropdown'>操作<span class='caret'></span></button>" + 
		     		 	    "<ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1' style='min-width:100px;'>" +
		     		 		"<li role='presentation'><a href='${pageContext.request.contextPath}/machine.do/createMachineInfo?id=" + (i+1) + "'>新建机器信息</a></li></ul>"+			
		     		 	"</div></td></tr>";  
	        			if((i+1)%2==1){
	        				leftTableList.push(tr);
	        			}
	        			else{
	        				rightTableList.push(tr);
	        			}
	        		}
		        	 
	        		var machineCount = machineList.length//记录条数  
	       		    var PageSize=20;//设置每页示数目  
	       		    var PageCount=Math.ceil(machineCount/PageSize);//计算总页数  
	       		    var currentPage = 1;//当前页，默认为1。
	       		    
		       		$("#pageIndex").html("");
	       		    for(var i=1;i<=PageCount;i++){ 
	       			    var pageNew="<li><a href='#' pageIndex='" + i + "'>" + i + "</a>";  
	       			    $("#pageIndex").append(pageNew);  
	       		    }  
	 
	       		    //显示默认页（第一页）  
	       		 	$("#leftTable tbody").html("");
	       		    for(i= (currentPage-1) * (PageSize/2);i < currentPage*(PageSize/2);i++){    
	       		        $('#leftTable tbody').append(leftTableList[i]);  
	       		    }
	       		    
		       		$("#rightTable tbody").html("");
	       		    for(i= (currentPage-1) * (PageSize/2); i < currentPage * (PageSize/2); i++){    
	       		        $('#rightTable tbody').append(rightTableList[i]);  
	       		    }   
	        		 
	       		    //显示选择页的内容  
	       		    $('#indexDiv a').click(function(){
	        		    var pageIndex=$(this).attr('pageIndex');
	        		    //alert(pageIndex);
	        		    $("#leftTable tbody").html("");
		       		    for(i= (pageIndex-1) * (PageSize/2); i < pageIndex * (PageSize/2); i++){    
		       		        $('#leftTable tbody').append(leftTableList[i]);  
		       		    }
		       		    
			       		$("#rightTable tbody").html("");
		       		    for(i= (pageIndex-1) * (PageSize/2); i < pageIndex * (PageSize/2); i++){    
		       		        $('#rightTable tbody').append(rightTableList[i]);  
		       		    }   
					})
					
					alert(result);
		        }  
		 });
	}
	</script>
</head>

<body>
	<jsp:include page="top.jsp" flush="true" />

	<div class="view-body">
	    <h3  style="font-size:20px;font-style:italic;width:20%;float:left;margin-top:20px;margin-left:130px;margin-bottom:10px;">线上无法识别机器(N.A.)</h3>

		<div style="margin-top:20px;">
            <form action="${pageContext.request.contextPath}/testCase.do/search" method="post">
                <div class="input-group" style="width:100px;float:right;margin-top:20px;">
                    <span>
						<a onclick="scan();" class="btn btn-large btn-primary">线上扫描</a>   
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
            </form>
        </div>
	
		<div class="container"  style="width:100%;">               
			<table id="leftTable" class="table table-striped table-hover" style="float:left;width:48%;margin-top:2px;">
                <thead>
                    <tr>
                        <th>序号<br/> (No.)
                        </th>
                        <th>未知机器IP地址<br/>(Unknown IP)</th>
                        <th>未知机器MAC地址<br/>(Unknown MAC)</th>
                        <th>更新时间<br/>(Updated Time)</th>
                        <th>所在地点<br/> (At The Address)</th>
                        <th>操作选取</th>
                    </tr>
                </thead>
                <tbody>
                   
                </tbody>
            </table>

            <table id="rightTable" class="table table-striped table-hover" style="float:left;width:48%;margin-left:4%;">
                <thead>
                    <tr>
                        <th>序号<br/> (No.)
                        </th>
                        <th>未知机器IP地址<br/>(Unknown IP)</th>
                        <th>未知机器MAC地址<br/>(Unknown MAC)</th>
                        <th>更新时间<br/>(Updated Time)</th>
                        <th>所在地点<br/> (At The Address)</th>
                        <th>操作选取</th>
                    </tr>
                </thead>
                <tbody>
                   
                </tbody>
            </table>
		</div>
		
		<div id="indexDiv" style="text-align:center;">
			<ul id="pageIndex" class="pagination">
			</ul>
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