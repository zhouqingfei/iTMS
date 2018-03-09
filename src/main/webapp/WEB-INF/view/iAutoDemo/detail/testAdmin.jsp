<%@ page language="java" contentType="text/html; charset=UTF-8"
    %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8">
		<title>测试管理系统</title>
		
		<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/wu.css"/>
		<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/themes/icon.css"/>
		<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/contrm.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/ui.js"></script>
		
		<script>
			 var basePath = "${pageContext.request.contextPath}";
		 	 var treeUrl = "${pageContext.request.contextPath}" + "/projectAndRound.do/loadTree";    
		 	 var caseUrl = "${pageContext.request.contextPath}" + "/itmsTestCaseTree.do/loadTree";    
		 	 $(function() {
		 		 
		 		var caseSelectedNodeId;
			    $('#caseTree').tree({
		            url: caseUrl,
		            onLoadSuccess:function(){
						$(this).tree('expand',$(this).tree('getRoot').target);
						if(caseSelectedNodeId != null){
							var selectNode = $('#caseTree').tree('find', caseSelectedNodeId);   
				            $('#caseTree').tree('select', selectNode.target);
						}
					}
		        });
			 
			 
			 	var projectSelectedNodeId;
	            $('#projectTree').tree({
	                url: treeUrl,	            
	                onContextMenu: function(e,node){
						//禁止浏览器的菜单打开
						e.preventDefault();
						$(this).tree('select',node.target);
						$('#projectMenu').menu('show', {
							left: e.pageX,
							top: e.pageY
						});
					},
					onClick:function(node){
						if (node.attributes.type == 'config' && node.attributes.url) {
							var parentNode=$('#projectTree').tree('getParent',node.target);
							
							var title = parentNode.text + ">" + node.text;
							//alert(parentNode.text);
							var tabUrl = basePath + node.attributes.url;
							
							if(node.attributes.testCaseList){
								tabUrl += "?testId=" + node.id;
							}
							addTab1(title,tabUrl);
						}
					},

					onLoadSuccess:function(){
						$(this).tree('expand',$(this).tree('getRoot').target);
						if(projectSelectedNodeId != null){
							var selectNode = $('#projectTree').tree('find', projectSelectedNodeId);   
				            $('#projectTree').tree('select', selectNode.target);
						}
					},
					
					onSelect:function(node){
						projectSelectedNodeId = node.id;
						//alert(projectSelectedNodeId);
					}
	            });
		        
	        })
		        
		     function append(){
		 		 var node = $('#projectTree').tree('getSelected');
		 		 var type = node.attributes.type;
		 		 var types = ['root', 'project', 'round', 'module', 'subModule', 'config'];
		 		 var idx = types.indexOf(type);
		 		 if(idx > -1 && idx < types.length - 1){
		 			 $('#myAddDlg').dialog({
		 				 title:'新增' + types[idx + 1]
		 			 });
		 			 $('#myAddDlg').dialog('open');
		 		 }
		 	 } 
		 	 /*
		     function append(){
				 dialogFlag = 'add';
				 
				 var node = $('#projectTree').tree('getSelected');
			
				 var parentType = node.attributes.type;
				 if(parentType == "root"){	 
					 $('#mydiv').dialog({
						    title:"新增项目",
						});
					 $('#mydiv').dialog('open');
				 }
				 else if(parentType == "project"){
					 $('#mydiv').dialog({
						    title:"新增轮次",
						});
					 $('#mydiv').dialog('open');
				 }
				 else{
					 $.messager.show({
						 title:"提示信息",
						 msg:"只能增加项目或轮次"
					 })
				 }					 
			 } */
		 	 function rename(){
		 		 var node = $("#projectTree").tree('getSelected');
		 		 var nodeType = node.attributes.type;
		 		 $("#myRenameDlg").find('input[id="name"]').val(node.text);
		 		 $("#myRenameDlg").dialog('open');
		 	 }
		 	 /*
			 function edit(){
				 dialogFlag = 'edit';
				 
				 var node = $('#projectTree').tree('getSelected');
				 var nodeType = node.attributes.type;
				 if(nodeType == "project"){	 
					 $('#mydiv').dialog({
						    title:"编辑项目",
						});
					 $('#name').val(node.text);
					 $('#mydiv').dialog('open');
				 }
				 else if(nodeType == "round"){
					 $('#mydiv').dialog({
						    title:"编辑轮次",
						});
					 $('#name').val(node.text);
					 $('#mydiv').dialog('open');
				 }
				 else{
					 $.messager.show({
						 title:"提示信息",
						 msg:"只能编辑项目或轮次"
					 })
				 }					 
			 }*/
			 
			 function addTreeNode(){
				var node = $('#projectTree').tree('getSelected');
				var id = node.id;
		 		 var types = ['root', 'project', 'round', 'module', 'subModule', 'config'];
				var parentType = node.attributes.type;
				var idx = types.indexOf(parentType);
				if(idx > -1 && idx < types.length - 1){
					var type = types[idx+1];
					var url = "";
					if(type == 'config'){
						url = "/itmsTestCase.do/testTable.view";
					}
					$.ajax({
						type:'post' ,
						url:"${pageContext.request.contextPath}" + "/projectAndRound.do/save",
						cache:false , 
						data:{
							parentId:node.id,
							name:$('#myAddDlg').find('input[name=name]').val() ,
							url: url,
							type: type
						} ,
						dataType:'text',
						success:function(result){
							if(result == "insert success"){
								$.messager.show({
									title:'提示信息',
									msg:'新增成功!'
								});
								//刷新节点 (一定是选中节点的父级节点)
								//var node = $('#projectTree').tree('getSelected');
								//var parent = $('#projectTree').tree('getParent' ,node.target);
								var n = node;
								if($('#projectTree').tree('isLeaf', node.target)){
									n = $('#projectTree').tree('getParent', node.target);
								}
								$('#projectTree').tree('reload', n.target);		
							}
						},
						fail:function(result){
							$.messager.show({
								title:'提示信息',
								msg:'操作失败!'
							});
						}
					}); 

				}
				
			/*	$('#projectTree').tree('append',{
					parent:node.target ,
					data:[{
						text: $('#myform').find('input[name=name]').val() ,
						state:state,
						attributes:{
							url:"/itmsTestCase.do/testTable.view",
							testCaseList:"",
							type:type
						}
					}]
				});*/
				
				$('#myAddDlg').dialog('close'); 
			 }
			 
			 function renameTreeNode(){
					var node = $('#projectTree').tree('getSelected');
					var id = node.id;
					
					$.ajax({
						type:'post' ,
						url:"${pageContext.request.contextPath}" + "/projectAndRound.do/update",
						cache:false , 
						data:{
							id:id,
							name:$('#myRenameDlg').find('input[name=name]').val()
						} ,
						dataType:'text',
						success:function(result){
							//刷新节点 (一定是选中节点的父级节点)
							if(result == "update success"){
								$.messager.show({
									title:'提示信息',
									msg:'修改成功!'
								});
								//projectSelectedNodeId = id;
								//alert(projectSelectedNodeId);
								var parentNode = $('#projectTree').tree('getParent' ,node.target);
								$('#projectTree').tree('reload',parentNode.target);						      
							}
						},
						fail:function(result){
							$.messager.show({
								title:'提示信息',
								msg:'操作失败!'
							});
						}
					}); 
					
					$('#myRenameDlg').dialog('close');
			 }


			 function remove(){
				//前台删除
				var node = $('#projectTree').tree('getSelected');
				var nodeId = node.id;
				//var parentNode = $('#projectTree').tree('getParent' ,node.target);
				//var parentNodeId = parentNode.id;
				projectSelectedNodeId = null;
				
				$('#projectTree').tree('remove' , node.target);
				
				
				//后台删除	
				$.ajax({
					type:'post' ,
					url:"${pageContext.request.contextPath}" + "/projectAndRound.do/delete",
					cache:false , 
					data:{
						id:nodeId
					} ,
					dataType:'text',
					success:function(result){
						//刷新节点 (一定是选中节点的父级节点)
						if(result == "delete success"){
							$.messager.show({
								title:'提示信息',
								msg:'删除成功!'
							});
						}
					},
					fail:function(result){
						$.messager.show({
							title:'提示信息',
							msg:'删除失败!'
						});
					}
				});
			}
			 
			 
		     function getRoot(){
				 $.messager.alert('Warning',$("#projectTree").tree("getRoot").id);
			 }
			 function getChildren(){
				 var root = $("#projectTree").tree("getRoot");
				 $.messager.alert('Warning',$("#projectTree").tree("getChildren",root.target));
			 }
			 
			 function select(id){
				 alert(id);
				 var nodeId=id;
				 if(nodeId!=null){  
						alert(nodeId);
			            var selectNode = $('#projectTree').tree('find', nodeId);  
			            alert(selectNode.text);
			            //$('#projectTree').tree('expandTo', selectNode.target).tree('select', selectNode.target);  
			            $('#projectTree').tree('select', selectNode.target);
					}  
			 }
			 
			 function addTab1(title, url){
					var content = '<iframe scrolling="auto" frameborder="0"  src="' + url
					+ '" style="width:100%;height:100%;"></iframe>';
					var tabs;
					if ($('#tabs').tabs('exists', title)) {
						$('#tabs').tabs('select', title);// 选中并刷新
						var currTab = $('#tabs').tabs('getSelected');
						tabs = $('#tabs').tabs('update', {
							tab : currTab,
							options : {
								content : content
							}
						});
					} else {
						tabs = $('#tabs').tabs('add', {
							title : title,
							content : content,
							closable : true
						});

					}
			 }
		</script>
		
	</head>

	<body class="easyui-layout">
	    <!--header -->
	    <div class="wu-header" data-options="region:'north',border:false,split:true">
	        <div class="wu-header-left">
	            <h1>Inspur iTms测试管理系统</h1>
	        </div>
	        <div class="wu-header-right">
	            <p><strong class="easyui-tooltip" title="2条未读消息">admin</strong>，欢迎您！</p>
	            <p><a href="#">网站首页</a>|<a href="#">帮助中心</a>|<a href="#">安全退出</a></p>
	        </div>
	    </div>
	
	    <!-- idebar -->
	    <div class="wu-sidebar" data-options="region:'west',split:true,border:true,title:'导航菜单'">
	        <div class="easyui-accordion" data-options="border:false,fit:true">
	        	<div title="用例管理" data-options="iconCls:'icon-application-cascade'" style="padding:5px;">
	                <ul id="caseTree"></ul>	        
	            </div>
	        
	        
	            <div title="项目管理" data-options="iconCls:'icon-application-cascade'" style="padding:5px;">
	            	<!--define tree: /project/round/module/submodule/config/ -->
	                <ul id="projectTree"></ul>
	                
	                <div id="myAddDlg" title="" class="easyui-dialog" style="width:300px;" closed=true >
		  				<form id="myform" method="post">
	  						<input name="id" type="hidden" value="" />
	  						<input id="parent_id" type="hidden" value="" />
  							<table> 
  								<tr align="center">
  									<td style="padding-left:20px;">名称:</td>
  									<td><input style="width:185px;" type="text" id="name" name="name" value=""/></td>
  								</tr>
  								<tr align="center">
  									<td colspan="2">
  										<a style="margin-left:50px;" id="savebtn" class="easyui-linkbutton" onclick='addTreeNode()'>确定</a>
  										<a style="margin-left:10px;" id="cancelbtn" class="easyui-linkbutton" onclick='$("#myAddDlg").dialog("close")'>取消</a>
  									</td>
  								</tr>  								  								
  							</table>
		  				</form>	
			  		</div>
			  		
			  		<div id="myRenameDlg" title="重命名节点元素" class="easyui-dialog" style="width:300px;" closed=true>
						<table>
							<tr align="center">
								<td style="padding-left:20px;">名称:</td>
								<td><input style="width:185px;" type="text" id="name" name="name" value=""/></td>
							</tr>
							<tr align="center">
								<td colspan="2">
									<a style="margin-left:50px;" class="easyui-linkbutton" onclick='renameTreeNode()'>确定</a>
									<a style="margin-left:10px;" class="easyui-linkbutton" onclick="$('#myRenameDlg').dialog('close')">取消</a>
								</td>
							</tr>  								  								
						</table>			  		
			  		</div>
	                
	                <div id="projectMenu" class="easyui-menu" style="width:150px;">
						<div onclick="append()">新增</div>
						<div onclick="rename()">编辑</div>
						<div onclick="remove()">删除</div>
					</div>  	
	            </div>
	            
	             
	        </div>
	    </div>

	    <!--main -->
	    <%-- <div class="wu-main" data-options="region:'center'">
	        <div id="wu-tabs" class="easyui-tabs" data-options="border:false,fit:true">
	            <div title="首页" data-options="href:'${pageContext.request.contextPath}/itmsTestCase.do/testTable.view',closable:false,iconCls:'icon-tip',cls:'pd3'"></div>
	        </div>
	    </div> --%>
		
		<div id="mainPanle" region="center" fit="true" border="false">
			<div id="tabs" class="easyui-tabs" fit="true" border="false">
				
			</div> 
		</div>	

	    <!-- footer -->
	    <div class="wu-footer" data-options="region:'south',border:true,split:true">
	        &copy; 版权所有 浪潮电子信息产业股份有限公司
	    </div>
	</body>
</html>