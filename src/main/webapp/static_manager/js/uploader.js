var uploader=function(opt){
	var root=getAppRoot();
	var func=function(file, errorCode, message){}
	var fileQueueError=function(file, errorCode, message) {
		if (errorCode === SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
			alert('一次只能上传一个文件');
			return;
		}
	}
	var uploadStart=function(file) {
		$('body').showLoading();
	}
	var fileDialogComplete=function(file) {
		this.startUpload();
	}
	var queueComplete=function(numFilesUploaded) {

		if(opt.queueComplete){
			opt.queueComplete();
		}
		$('body').hideLoading();
	}
	var fileQueueError=function(file,code,msg) {
		if(opt.fileQueueError){
			opt.fileQueueError(this,file,code,msg);
		}
	}
	var settings = {
			flash_url : root+"static_manager/js/swfupload/swfupload.swf",
			upload_url: opt.url,
			post_params: opt.param,
			file_size_limit : opt.limit+"MB",
			file_types : opt.type,
			file_types_description : opt.typeDesc?opt.typeDesc:"All Files",
			file_upload_limit : 0,
			file_queue_limit : 0,
			debug: false,

			// Button settings
			button_action:SWFUpload.BUTTON_ACTION.SELECT_FILE,
			button_window_mode:'transparent',
			button_image_url: opt.btnBg?opt.btnBg:root+"static_manager/image/fbtn.png",
			button_width: opt.w?opt.w:"260",
			button_height: opt.h?opt.h:"29",
			button_placeholder_id: opt.btnId,
			button_text: '<span class="theFont">'+opt.btnLable+'</span>',
			button_text_style: opt.btnStyle?opt.btnStyle:".theFont { font-size: 14px;color:#3c3c3c;margin-left:12px;font-family: 'Microsoft YaHei', '微软雅黑', Arial, Helvetica, sans-serif;}",
			button_text_left_padding: 12,
			button_text_top_padding: 3,
			custom_settings : opt.custom,
			// The event handler functions are defined in handlers.js
			file_queued_handler : opt.fileQueued?opt.fileQueued:func,
			file_queue_error_handler : fileQueueError,
			file_dialog_complete_handler : opt.fileDialogComplete?opt.fileDialogComplete:fileDialogComplete,
			upload_start_handler : uploadStart,
			upload_progress_handler : opt.uploadProgress?opt.uploadProgress:func,
			upload_error_handler : opt.uploadError?opt.uploadError:func,
			upload_success_handler : opt.uploadSuccess?opt.uploadSuccess:func,
			upload_complete_handler : opt.uploadComplete?opt.uploadComplete:func,
			queue_complete_handler : queueComplete	// Queue plugin event
			
		};
	return new SWFUpload(settings);
}

