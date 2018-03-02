var sy = $.extend({}, sy);

/*
 * $(function(){ $.messager.progress({ text : '加载中...', interval : 100 }); });
 * $.parser.onComplete = function(){ window.setTimeout(function(){
 * $.messager.progress('close'); }, 500); };
 */
sy.serializeObject = function(form) {/* 将form表单元素值序列化为对象 */
	var o = {};
	$.each(form.serializeArray(), function(index) {
		if (o[this['name']]) {
			o[this['name']] = o[this['name']] + "," + this['value'];
		} else {
			o[this['name']] = this['value'];
		}
	});
	return o;
};

// md 2013 8.9
Date.prototype.pattern = function(fmt) {
	var o = {
		"M+" : this.getMonth() + 1, // 月份
		"d+" : this.getDate(), // 日
		"h+" : this.getHours() == 0 ? 12 : this.getHours(), // 小时
		"H+" : this.getHours(), // 小时
		"m+" : this.getMinutes(), // 分
		"s+" : this.getSeconds(), // 秒
		"q+" : Math.floor((this.getMonth() + 3) / 3), // 季度
		"S" : this.getMilliseconds()
	// 毫秒
	};
	var week = {
		"0" : "\u65e5",
		"1" : "\u4e00",
		"2" : "\u4e8c",
		"3" : "\u4e09",
		"4" : "\u56db",
		"5" : "\u4e94",
		"6" : "\u516d"
	};
	// 格式化 年
	if (/(y+)/.test(fmt)) {
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}
	// 格式化 周、星期
	if (/(E+)/.test(fmt)) {
		fmt = fmt
				.replace(
						RegExp.$1,
						((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "\u661f\u671f"
								: "\u5468")
								: "")
								+ week[this.getDay() + ""]);
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(fmt)) {
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
		}
	}
	return fmt;
};

function systemDate() {
	// 获取系统时间
	var date = new Date();
	var month = date.getMonth() + 1; // month默认0-11，所以要加1
	var minutes = date.getMinutes(), Min;
	var seconds = date.getSeconds(), updateTime;
	// updateTime=60-seconds;
	minutes <= 9 ? Min = "0" + minutes : Min = minutes;
	seconds <= 9 ? updateTime = "0" + seconds : updateTime = seconds;
	var week = date.getDay(), day;
	switch (week) {
	case 1:
		day = "星期一";
		break;
	case 2:
		day = "星期二";
		break;
	case 3:
		day = "星期三";
		break;
	case 4:
		day = "星期四";
		break;
	case 5:
		day = "星期五";
		break;
	case 6:
		day = "星期六";
		break;
	case 0:
		day = "星期日";
		break;
	}
	var time = date.getFullYear() + "年" + month + "月" + date.getDate() + "日"
			+ date.getHours() + ":" + Min + ":" + updateTime + " " + day;
	return time;
}
function addViewOfConfigTab(title, url, id) {
	var viewTab;
	if ($('#viewTab').tabs('exists', title)) {
		$('#viewTab').tabs('select', title);// 选中并刷新
		var currTab = $('#viewTab').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if (url != undefined && currTab.panel('options').title != 'Home') {
			viewTab = $('#viewTab').tabs('update', {
				id : id,
				tab : currTab,
				options : {
					content : createFrame(url)
				}
			});
		}
	} else {
		var content = createFrame(url);
	
		viewTab = $('#viewTab').tabs('add', {
			title : title,
			content : content,
			closable : true
		});
		

	}
	 
	//tabClose();
	return viewTab;
}
function isTabExists(title){
	return $('#tabs').tabs('exists', title);
}
function addTab(title, url, id) {
	var tabs;
	if ($('#tabs').tabs('exists', title)) {
		$('#tabs').tabs('select', title);// 选中并刷新
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if (url != undefined && currTab.panel('options').title != 'Home') {
			tabs = $('#tabs').tabs('update', {
				id : id,
				tab : currTab,
				options : {
					content : createFrame(url)
				}
			});
		}
	} else {
		var content = createFrame(url);
	
		tabs = $('#tabs').tabs('add', {
			title : title,
			content : content,
			closable : true
		});
		

	}
	 
	tabClose();
	return tabs;
}
function addConfigTab(title, url, id) {
	var tabs;
	if ($('#tabs').tabs('exists', title)) {
		$('#tabs').tabs('select', title);// 选中并刷新
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if (url != undefined && currTab.panel('options').title != 'Home') {
			tabs = $('#tabs').tabs('update', {
				id : id,
				tab : currTab,
				options : {
					content : createFrame(url)
				}
			});
		}
	} else {
		var content = createFrame(url);
		tabs = $('#tabs').tabs('add', {
			title : title,
			content : content,
			tools : [{  
		        iconCls:'icon-delete',  
		        handler:function(){
		        	$.messager.confirm('提示', '现在退出会造成数据丢失，是否退出？', function(r){
		        		if (r){
		        			closeTabByTitle(title);
		        		}
		        		return false;
		        	});  
		        }  
		    }]
		});
	}
	tabClose();
	return tabs;
}
function addTabSpe(title,url,id,refreshTabName) {
	var tabs;
	if ($('#tabs').tabs('exists', title)) {
		$('#tabs').tabs('select', title);// 选中并刷新
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if (url != undefined && currTab.panel('options').title != 'Home') {
			tabs = $('#tabs').tabs('update', {
				id : id,
				tab : currTab,
				options : {
					content : createFrame(url)
				}
			});
		}
	} else {
		var content = createFrame(url);
		tabs = $('#tabs').tabs('add', {
			title : title,
			content : content,
			tools : [{  
		        iconCls:'icon-mini-del',  
		        handler:function(){
		        	var target = this;
		        	if($('#tt').val()!=0){
		        		$.messager.confirm('提示', '现在退出会造成数据丢失，是否退出？', function(r){
			        		if (r){
			        			closeTabByTitle(title);
			        			refreshTabByTitle(refreshTabName);
			        		}
			        		return false;
			        	}); 
		        	}else{
	        			closeTabByTitle(title);
	        			refreshTabByTitle(refreshTabName);
		        	}
		        }  
		    }]
		});
	}
	return tabs;
}
function addTabNoClosable(title, url, id) {
	var tabs;
	if ($('#tabs').tabs('exists', title)) {
		$('#tabs').tabs('select', title);// 选中并刷新
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if (url != undefined && currTab.panel('options').title != 'Home') {
			tabs = $('#tabs').tabs('update', {
				id : id,
				tab : currTab,
				options : {
					content : createFrame(url)
				}
			});
		}
	} else {
		var content = createFrame(url);
		tabs = $('#tabs').tabs('add', {
			title : title,
			content : content
		});
	}
	return tabs;
}
/*
function addTabNoClosable(title, url, id) {
	var tabs;
	if ($('#tabs').tabs('exists', title)) {
		$('#tabs').tabs('select', title);// 选中并刷新
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if (url != undefined && currTab.panel('options').title != 'Home') {
			tabs = $('#tabs').tabs('update', {
				id : id,
				tab : currTab,
				options : {
					content : createFrame(url)
				}
			});
		}
	} else {
		var content = createFrame(url);
		tabs = $('#tabs').tabs('add', {
			title : title,
			content : content
		});
	}
	return tabs;
}*/

function refreshTabByTitle(title) {
	if ($('#tabs').tabs('exists', title)) {
		$('#tabs').tabs('select', title);
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		$('#tabs').tabs('update', {
			title : title,
			tab : currTab,
			options : {
				content : createFrame(url)
			}
		});
	}
}
function refreshTabById(id) {
	$('#tabs').tabs('select', id);
	var currTab = $('#tabs').tabs('getSelected');
	var url = $(currTab.panel('options').content).attr('src');
	$('#tabs').tabs('update', {
		id : id,
		tab : currTab,
		options : {
			content : createFrame(url)
		}
	});
}
function createFrame(url) {
	var s = '<iframe scrolling="auto" frameborder="0"  src="' + url
			+ '" style="width:100%;height:100%;"></iframe>';
	return s;
}
function closeTabByTitle(title) {
	$('#tabs').tabs('close', title);
}
function tabClose() {
	/* 双击关闭TAB选项卡 */
	$(".tabs-inner").dblclick(function() {
		var subtitle = $(this).children(".tabs-closable").text();
		$('#tabs').tabs('close', subtitle);
	});
	/* 为选项卡绑定右键 */
	$(".tabs-inner").bind('contextmenu', function(e) {
		$('#mm').menu('show', {
			left : e.pageX,
			top : e.pageY
		});

		var subtitle = $(this).children(".tabs-closable").text();

		$('#mm').data("currtab", subtitle);
		$('#tabs').tabs('select', subtitle);
		return false;
	});
}
// 绑定右键菜单事件
function tabCloseEven() {
	// 刷新
	$('#mm-tabupdate').click(function() {
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if (url != undefined && currTab.panel('options').title != 'Home') {
			$('#tabs').tabs('update', {
				tab : currTab,
				options : {
					content : createFrame(url)
				}
			});
		}
	});
	// 关闭当前
	$('#mm-tabclose').click(function() {
		var currtab_title = $('#mm').data("currtab");
		$('#tabs').tabs('close', currtab_title);
	});
	// 全部关闭
	$('#mm-tabcloseall').click(function() {
		$('.tabs-inner span').each(function(i, n) {
			var t = $(n).text();
			if (t != 'Home') {
				$('#tabs').tabs('close', t);
			}
		});
	});
	// 关闭除当前之外的TAB
	$('#mm-tabcloseother').click(function() {
		var prevall = $('.tabs-selected').prevAll();
		var nextall = $('.tabs-selected').nextAll();
		if (prevall.length > 0) {
			prevall.each(function(i, n) {
				var t = $('a:eq(0) span', $(n)).text();
				if (t != 'Home') {
					$('#tabs').tabs('close', t);
				}
			});
		}
		if (nextall.length > 0) {
			nextall.each(function(i, n) {
				var t = $('a:eq(0) span', $(n)).text();
				if (t != 'Home') {
					$('#tabs').tabs('close', t);
				}
			});
		}
		return false;
	});
}