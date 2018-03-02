/**
 * 
 */var treeUrl = "${pageContext.request.contextPath}" + "/deptController/deptTree";  
			var tree = null;//表示树  
			  
			$(function() {
				alert(treeUrl);
			    tree = $('#vl');  
			    initTree();//初始化树  
			  
			});  
			  
			function initTree() { 
				alert("test");
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