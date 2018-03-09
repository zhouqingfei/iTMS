<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>测试</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/themes/default/easyui.css" />
<!--  <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/wu.css" /> -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/themes/icon.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/demo/demo.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bower_components/iAutoDemo/css/contrm.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bower_components/iAutoDemo/easyui/locale/easyui-lang-zh_CN.js"></script>

<style>

</style>
<script>
	$(function() {
		 //$('#testCaseLayout').layout('collapse', 'north');
	});
</script>

</head>

<body>
	 	<div id='testCaseLayout'  style="border: red 1px solid" class="easyui-layout" data-options="fit:true">
 <!-- 		
		<div> <!--  data-options="regin='center',title:'center',border:true,split:true" -->
 
 <!-- -->
 		<!-- style="width:100%;height:50%;padding:10px;background:#fafafa;"
		collapsible:true,
		 -->
		 <div style="height:50%" data-options="region:'north',border:true,split:true,collapsible:false,
		 title:'所有用例列表'">
		 <div id='allTestCaseTb'>
				<a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="readSelectedTestCase()" plain="true">重置选择</a> 		 
				<a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="saveSelectedTestCase()" plain="true">保存选择</a> 		 
		 </div>
			<table class='easyui-treegrid' data-options="
			idField:'id',
			treeField:'name',
			checkbox:true,
			url:'tmptestcase.json',
			toolbar:'#allTestCaseTb'
			">
			<thead>
			<tr>
			<th data-options="field:'name',width:200">名称</th>
			<th data-options="field:'testCaseNumber'">编号</th>
			<th data-options="field:'testCaseVersion'">版本</th>
			<th data-options="field:'testCaseAuthor'">作者</th>
			</tr>
			</thead>
			</table>  
		 </div>
 
				<!-- Begin of toolbar -->
		<div data-options="region:'center',border:true,title:'已选用例列表'"><!--  id="wu-toolbar-2"  class="wu-toolbar-button" -->
			<div id='testCaseTb'>
				<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="execBatch()" plain="true">批量执行</a> 
				<!-- 	<a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="openEdit()" plain="true">修改</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="remove()" plain="true">删除</a>
					            <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancel()" plain="true">取消</a>
		            <a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="reload()" plain="true">刷新</a>
		            <a href="#" class="easyui-linkbutton" iconCls="icon-print" onclick="openAdd()" plain="true">打印</a>
		            <a href="#" class="easyui-linkbutton" iconCls="icon-help" onclick="openEdit()" plain="true">帮助</a>
		            <a href="#" class="easyui-linkbutton" iconCls="icon-undo" onclick="remove()" plain="true">撤销</a>
		            <a href="#" class="easyui-linkbutton" iconCls="icon-redo" onclick="cancel()" plain="true">重做</a>
		            <a href="#" class="easyui-linkbutton" iconCls="icon-sum" onclick="reload()" plain="true">总计</a>
		            <a href="#" class="easyui-linkbutton" iconCls="icon-back" onclick="reload()" plain="true">返回</a>
		            <a href="#" class="easyui-linkbutton" iconCls="icon-tip" onclick="reload()" plain="true">提示</a>
		            <a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="reload()" plain="true">保存</a>
		            <a href="#" class="easyui-linkbutton" iconCls="icon-cut" onclick="reload()" plain="true">剪切</a> -->
			</div>
			<!--  
			<div class="wu-toolbar-search">
				<label>起始时间：</label><input class="easyui-datebox"
					style="width: 100px"> <label>结束时间：</label><input
					class="easyui-datebox" style="width: 100px">
				<label>用户组：</label> 
		            <select class="easyui-combobox" panelHeight="auto" style="width:100px">
		                <option value="0">选择用户组</option>
		                <option value="1">黄钻</option>
		                <option value="2">红钻</option>
		                <option value="3">蓝钻</option>
		            </select>
		            <label>关键词：</label><input class="wu-text" style="width:100px">
				<a href="#" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>
			</div>	-->
			
			<table id="wu-datagrid-2" class='easyui-datagrid' data-options="toolbar:'#testCaseTb'"></table>
			
		</div>
		<!-- End of toolbar  -->
		
		
		 <!-- 
		<div data-options="region:'south',border:true,split:true" >
			<table id="wu-datagrid-2" class='easyui-datagrid'></table>
		</div>
		  -->
		 
	</div> 
	<!-- </div> -->		
	
	<!-- Begin of easyui-dialog -->
	<!-- 
	<div id="wu-dialog-2" class="easyui-dialog"
		data-options="closed:true,iconCls:'icon-save'"
		style="width: 400px; padding: 10px;">
		<form id="wu-form-2" method="post">
			<table>
				<tr>
					<td width="60" align="right">姓 名:</td>
					<td><input type="text" name="name" class="wu-text" /></td>
				</tr>
				<tr>
					<td align="right">邮 箱:</td>
					<td><input type="text" name="email" class="wu-text" /></td>
				</tr>
				<tr>
					<td align="right">主 题:</td>
					<td><input type="text" name="subject" class="wu-text" /></td>
				</tr>
				<tr>
					<td valign="top" align="right">内 容:</td>
					<td><textarea name="content" rows="6" class="wu-textarea"
							style="width: 260px"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
 	-->	<!-- End of easyui-dialog -->
 	
 	
</body>
<script type="text/javascript">
/**
 * Name 添加记录
 */
function add() {
	$('#wu-form-2').form('submit', {
		url : '',
		success : function(data) {
			if (data) {
				$.messager.alert('信息提示', '提交成功！', 'info');
				$('#wu-dialog-2').dialog('close');
			} else {
				$.messager.alert('信息提示', '提交失败！', 'info');
			}
		}
	});
}

/**
 * Name 修改记录
 */
function edit() {
	$('#wu-form-2').form('submit', {
		url : '',
		success : function(data) {
			if (data) {
				$.messager.alert('信息提示', '提交成功！', 'info');
				$('#wu-dialog-2').dialog('close');
			} else {
				$.messager.alert('信息提示', '提交失败！', 'info');
			}
		}
	});
}

/**
 * Name 删除记录
 */
function remove() {
	$.messager.confirm('信息提示', '确定要删除该记录？', function(result) {
		if (result) {
			var items = $('#wu-datagrid-2').datagrid('getSelections');
			var ids = [];
			$(items).each(function() {
				ids.push(this.productid);
			});
			//alert(ids);return;
			$.ajax({
				url : '',
				data : '',
				success : function(data) {
					if (data) {
						$.messager.alert('信息提示', '删除成功！', 'info');
					} else {
						$.messager.alert('信息提示', '删除失败！', 'info');
					}
				}
			});
		}
	});
}

/**
 * Name 打开添加窗口
 */
function openAdd() {
	$('#wu-form-2').form('clear');
	$('#wu-dialog-2').dialog({
		closed : false,
		modal : true,
		title : "添加信息",
		buttons : [ {
			text : '确定',
			iconCls : 'icon-ok',
			handler : add
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$('#wu-dialog-2').dialog('close');
			}
		} ]
	});
}

/**
 * Name 打开修改窗口
 */
function openEdit() {
	$('#wu-form-2').form('clear');
	var item = $('#wu-datagrid-2').datagrid('getSelected');
	//alert(item.productid);return;
	$.ajax({
		url : '',
		data : '',
		success : function(data) {
			if (data) {
				$('#wu-dialog-2').dialog('close');
			} else {
				//绑定值
				$('#wu-form-2').form('load', data)
			}
		}
	});
	$('#wu-dialog-2').dialog({
		closed : false,
		modal : true,
		title : "修改信息",
		buttons : [ {
			text : '确定',
			iconCls : 'icon-ok',
			handler : edit
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$('#wu-dialog-2').dialog('close');
			}
		} ]
	});
}

/**
 * Name 分页过滤器
 */
function pagerFilter(data) {
	if (typeof data.length == 'number'
			&& typeof data.splice == 'function') {// is array                
		data = {
			total : data.length,
			rows : data
		}
	}
	var dg = $(this);
	var opts = dg.datagrid('options');
	var pager = dg.datagrid('getPager');
	pager.pagination({
		onSelectPage : function(pageNum, pageSize) {
			opts.pageNumber = pageNum;
			opts.pageSize = pageSize;
			pager.pagination('refresh', {
				pageNumber : pageNum,
				pageSize : pageSize
			});
			dg.datagrid('loadData', data);
		}
	});
	if (!data.originalRows) {
		data.originalRows = (data.rows);
	}
	var start = (opts.pageNumber - 1) * parseInt(opts.pageSize);
	var end = start + parseInt(opts.pageSize);
	data.rows = (data.originalRows.slice(start, end));
	return data;
}
/********************************************************
 * 
 
 
  */
 // $('#testCaseLayout').layout();

 
/********************************************************
 * 
 */
var para = "${testId}";
var url = "${pageContext.request.contextPath}"
		+ "/itmsTestCase.do/getTestCaseList" + "?testId=" + para;

//alert(url);
$('#wu-datagrid-2').datagrid({
					url : url,
					//fitColumns:true,
					fit : true,
					striped : true,
					loadMsg : "正在加载中......",
					//loadFilter:pagerFilter,
					rownumbers : true,
					singleSelect : true,
					checkOnSelect : false,
					selectOnCheck : false,
					pageNumber : 1,
					pageSize : 5,
					pageList : [ 5, 10, 15, 20, 50 ],
					pagination : true,
					multiSort : true,
					idField : 'id',
					frozenColumns : [ [ //冻结列特性 ,不要与fitColumns 特性一起使用
					{
						field : 'cx',
						checkbox : true
					}, {
						field : 'id',
						title : '用例序号',
						width : 60

					}, {
						field : 'name',
						title : "用例名称",
						width : 190,
					} ] ],
					columns : [ [
							/* { field:'id',title:'用例序号',width:30}, */
							/* { field:'name',title:'用例名称',width:150}, */
							{
								field : 'number',
								title : '编号',
								width : 180
							},
							{
								field : 'version',
								title : '版本',
								width : 180
							},
							{
								field : 'writer',
								title : '作者',
								width : 180
							},
							{
								field : 'category1',
								title : '类别1',
								width : 100
							},
							{
								field : 'category2',
								title : '类别2',
								width : 100
							},
							{
								field : 'category3',
								title : '类别3',
								width : 100
							},
							{
								field : 'level',
								title : '等级',
								width : 100
							},
							{
								field : 'product',
								title : '使用产品',
								width : 100
							},
							{
								field : 'manualtime',
								title : '手动时间',
								width : 100
							},
							{
								field : 'autotime',
								title : '自动时间',
								width : 100
							},
							{
								field : 'status',
								title : '状态',
								width : 100
							},
							{
								field : 'versionchangelog',
								title : '版本变更记录',
								width : 100
							},
							{
								field : 'condition',
								title : '预置条件',
								width : 100
							},
							{
								field : 'comment',
								title : '备注',
								width : 100
							},
							{
								field : 'autoconnect',
								title : '自动测试关联',
								width : 100
							},
							{
								field : 'step',
								title : '测试步骤',
								width : 100
							},
							{
								field : 'expect',
								title : '预期结果',
								width : 100
							},
							{
								field : 'autoconnect',
								title : '自动测试关联',
								width : 100
							},
							{
								field : 'script',
								title : '脚本路径',
								width : 180,
								editor : 'text'
							},
							{
								field : 'param',
								title : '脚本参数',
								width : 100,
								editor : 'text'
							},
							{
								field : 'ip',
								title : '测试机器',
								width : 100,
								editor : 'text'
							},
							{
								field : 'taskStatus',
								title : '状态',
								width : 100,
								editor : 'text'
							},
							{
								field : 'testResult',
								title : '结果',
								width : 100
							},
							{
								field : 'logPath',
								title : '结果位置',
								width : 100,
								formatter: function(value, row, index){
									if(typeof value == 'undefined'){
										return value;
									}
									var safeval = value.replace(/\\/g, "\\\\");
									var l = '<a href="javascript:void(0)" onclick="downloadLog(this,\''+safeval+'\')">'+ value + '</a>';											
									return l;
								}
							},
							{
								field : 'action',
								title : '操作',
								width : 80,
								align : 'center',
								formatter : function(value, row, index) {
									if (row.editing) {
										var s = '<a href="javascript:void(0)" onclick="saverow(this)">Save</a> ';
										var c = '<a href="javascript:void(0)" onclick="cancelrow(this)">Cancel</a>';
										return s + '|' + c;
									} else {
										var e = '<a href="javascript:void(0)" onclick="editrow(this)">Edit</a> ';
										var d = '<a href="javascript:void(0)" onclick="execrow(this)">exec</a>';
										return e + '|' + d;
									}
								}
							}

					] ],
					loadFilter: function(data){
						data.rows.forEach(function(e){
							if(e.taskStatus == "RUNNING"){
								runningTasks[e.id] = '';
							}
						});
						return data;
					},
					//events.
					onEndEdit : function(index, row) {

					},
					onBeforeEdit : function(index, row) {
						row.editing = true;
						$(this).datagrid('refreshRow', index);
					},
					onAfterEdit : function(index, row) {
						//commit the changed to server.
						submitScriptInfo(this, index);
						row.editing = false;
						$(this).datagrid('refreshRow', index);
					},
					onCancelEdit : function(index, row) {
						row.editing = false;
						$(this).datagrid('refreshRow', index);
					}
					
				});

setInterval(flushStatusOfTasks, 3000);
var vallue = null;

function getRowIndex(target) {
	var tr = $(target).closest('tr.datagrid-row');
	return parseInt(tr.attr('datagrid-row-index'));
}
function editrow(target) {
	$('#wu-datagrid-2').datagrid('beginEdit', getRowIndex(target));
}
function deleterow(target) {
	$.messager.confirm('Confirm', 'Are you sure?', function(r) {
		if (r) {
			$('#wu-datagrid-2').datagrid('deleteRow',
					getRowIndex(target));
		}
	});
}
function execrow(target) {
	var idx = getRowIndex(target);
	execTestCase('#wu-datagrid-2', idx);
}
function saverow(target) {
	$('#wu-datagrid-2').datagrid('endEdit', getRowIndex(target));

}
function cancelrow(target) {
	$('#wu-datagrid-2').datagrid('cancelEdit', getRowIndex(target));
}

function submitScriptInfo(dg, index) {
	var row = $(dg).datagrid("getRows")[index];
	var id = row['id'];
	var script = row['script'];
	var param = row['param'];
	var ip = row['ip'];
	//alert(id + ';' + script + ';' + param + ';' + ip);
	$.ajax({
				data : JSON.stringify([{
					id : id,
					script : script,
					param : param,
					ip : ip
				}]),
				type : "POST",
				contentType : 'application/json; charset=utf-8',
				url : "${pageContext.request.contextPath}/itmsTestCase.do/update",
				dataType : "text",
				error : function(data) {
					alert("update 出错了！ " + data);
					$(dg).datagrid('beginEdit', index);

				},
				success : function(data) {
					//alert("update 成功了！" + data);
					var res = JSON.parse(data);
					if(res instanceof Array){
						
					}else{
						alert("update 返回失败！" + data);
					}
					//$()
					//$("#status" + id).val("RUNNING");
					//runningTasks[id] = '';
				}
			});

}

function submitExec(ids){
	//alert("submit: " + JSON.stringify(ids) + ";" + (ids instanceof Array));
	$.ajax({
      		data: JSON.stringify(ids),
      		type: "POST",
      		contentType: 'application/json; charset=utf-8',
      		url: "${pageContext.request.contextPath}/itmsTestCase.do/execute",
      		error: function(data){
      			alert("execute 出错了！" + data);
      		},
      		success: function(data) {
			var bg = '#wu-datagrid-2';
      			for(var i=0; i<data.length; i++){
      				var param = {
      						id: data[i],
      						taskStatus: "RUNNING",
      						};
      				var isexists = refreshTaskStatus(param);
      				if(isexists){
          				runningTasks[data[i]] = '';
          				//clear fields of testResult, logPath.
      				}
      			}
      		},
	});	
}
function execTestCase(dg, index) {
	var row = $(dg).datagrid("getRows")[index];
	submitExec([row['id']]);
}

var runningTasks = {}
//periodly update tasks status, through geting all ids of running tasks, querying server for their status.
//also, maintain global variable runningTasks.
function flushStatusOfTasks() {
	var ids = Object.keys(runningTasks);
	//alert("ids: " + ids);
	//console.log("DEBUG ids: " + ids);
	if (ids.length == 0) {
		return;
	}
	$.ajax({
				data : JSON.stringify(ids),
				type : "POST",
				contentType : 'application/json; charset=utf-8',
				url : "${pageContext.request.contextPath}/itmsTestCase.do/getStatus",
				dataType : "text",
				error : function(data) {

				},
				success : function(data) {
					//alert("getStatus 成功了.", data);
					console.log("getStatus 成功了！ " + data);
					var sts = JSON.parse(data);
					for (var i = 0; i < sts.length; i++) {
						var isexists = refreshTaskStatus(sts[i]);
						if(isexists && sts[i].taskStatus == "RUNNING"){
						}else{
							delete runningTasks[sts[i].id]; 
						}
					}
				}
			})
}

//update task status, and attempt to update testResult only if status is updated.
function refreshTaskStatus(data){
	//alert("refresh: " + JSON.stringify(data));
	var bg = "#wu-datagrid-2";
	var idx = $(bg).datagrid("getRowIndex", data.id);
	if(idx == -1){
		return false;
	}
	var row = $(bg).datagrid("getRows")[idx];
	//alert("update status, idx: "+idx+"; id: "+id+";row: " + JSON.stringify(row));
	//update status cell of datagrid
	var status = data.taskStatus;
	if (row.taskStatus != status) {
		row.taskStatus = status;
		var testResult = '';
		var logPath = '';
		if(typeof data.testResult != 'undefined'){
			testResult = data.testResult;
		}
		if(typeof data.logPath != 'undefined'){
			logPath = data.logPath;
		}
		if(row.testResult != testResult){
			row.testResult = testResult;
		}
		if(row.logPath != logPath){
			row.logPath = logPath;
		}
		$(bg).datagrid("refreshRow", idx);
	}
	return true;
}

function downloadLog(target, logFile){
	var url = '${pageContext.request.contextPath}/itmsTestCase.do/download?targetPath=' + escape(logFile);
	location.href = url;
	var idx = getRowIndex(target);
	var bg = '#wu-datagrid-2';
	$(bg).datagrid("refreshRow", idx);
}

function execBatch(){
	var bg = '#wu-datagrid-2';
	var rows = $(bg).datagrid("getChecked");
	var ids = [];
	rows.forEach(function(e){
		ids.push(e.id);
	});
	//alert("execBatch: " + JSON.stringify(ids));
	submitExec(ids);
}
</script>

</html>