<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<script type="text/javascript">
$(function() {
	// Alert 对话框
	jAlert = function(message, title, callback) {
		// 如果存在遮罩层，则将其取消
		hideLoading();
		
		var dialog = $("#_dialog_alert");
		if(title){
            dialog.attr("title", title);
        }
		dialog.children("p").html(message);
		dialog.dialog({
			modal : true,
			buttons : {
				"确定" : function() {
					$(this).dialog("close");
					if(callback) callback();
				}
			}
		});
		
		return false;
	};

	// Confirm 对话框
	jConfirm = function(message, title, callback, options) {
		var dialog = $("#_dialog_confirm");
		if(title){
			dialog.attr("title", title);
		}
		dialog.children("p").html(message);
		dialog.dialog({
			modal : true,
			buttons : {
				"确定" : function() {
					$(this).dialog("close");
					callback(true);
				},
				"取消" : function() {
					$(this).dialog("close");
					callback(false);
				}
			}
		}, options);
	};	
});
</script>

<!-- 对话框 - 开始 -->
<div id="_dialog_alert" title="提示">
  <p></p>
</div>

<div id="_dialog_confirm" title="确认">
  <p></p>
</div>
<!-- 对话框 - 结束 -->