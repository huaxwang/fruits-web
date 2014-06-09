// JavaScript Document
// 服务器域名或Ip
var BaseHost = "http://192.168.11.117"
// 服务器路径
var ServerUrl = BaseHost + "/kkmy"
// 需要拷贝的微信账号
var WeixinAccount = "kkmaiyao";
// 存在localStorage的key值，判断是否参加过该活动
var keyIsJoin = "keyIsJoin";
// 点击是否结束
var isClickEnd = true;
// 点击保护的延时
var TheClickDelay = 500;
// 报名成功
var TextApplySucceed = "恭喜您参与成功，请静待工作人员抽奖";
// 微信账号复制成功
var TextCopySucceed = "已复制成功，请打开微信搜索";

// 获取url参数
function getQueryString(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null) {
		return unescape(r[2]);
	}
	return null;
}

function applyBtnDisabled() {
	$('#applybtn').attr("disabled", true);
	$('#applybtn').addClass('btnDisabled');
}

/**
 * 统一点击事件
 */
$.fn.tap = function (callFunction, clickDelay) {
	$(this).on('click', function () {
		if (isClickEnd) {
			isClickEnd = false;
			if(typeof(callFunction) == 'function') {
				callFunction();
			}
			var aClickDelay = TheClickDelay;
			if (clickDelay) {
				aClickDelay = clickDelay;
			}
			setTimeout(function(){isClickEnd = true}, aClickDelay);
		}
	});
}

/**
 * 调用服务器接口
 */
function callServerFunction(method, bodyData, succeed, failed) {
	var postData = {};
	var requestData = {};
	requestData.body = bodyData;
	postData.dataJson = JSON.stringify(requestData);
	$.ajax({
		type : 'POST',
		async : true,
		url : ServerUrl + method,
		dataType : 'json',
		data : postData,
		/* 成功时直接返回数据 */
		success : function(data, textStatus, jqXHR)
		{
			var receiveBody = data.body;
			var code = parseInt(receiveBody.code);
			if (code == 0) {
				if (succeed) {
					succeed(receiveBody.result, receiveBody.message);
				}
			} else {
				if (failed) {
					failed(receiveBody.message);
				}
			}
		},
		/* 失败时返回默认错误 */
		error : function(jqXHR, textStatus, errorThrown)
		{
			if (failed) {
				failed("网络错误");
			}
		}
	});
}

var myScroll = {};
myScroll.refresh = function () {};
$(function () {
	var isJoin = localStorage.getItem(keyIsJoin);
	
	if (isJoin) {
		// 如果参加过，则button设置为disabled
		applyBtnDisabled();
	} else {
		// 请求参加人数
		postBody = {};
		postBody.activityId = getQueryString("activityId");
		if (!postBody.activityId) {
			postBody.activityId = 4;
		}
		callServerFunction("/activety/getPeopleCount.do", postBody, function (result, message) {
			$('#applybtn .participantNum').html("（已有" + result.peopleCount + "人参加）")
			$('#applybtn .participantNum').show();
			//webMutual.stopLoading();
		}, function () {
		});
	}
	$('html').css('height', document.documentElement.clientHeight);
	myScroll = new iScroll('wrapper', {
		hideScrollbar: true,
		fadeScrollbar: true,
		checkDOMChanges: true,
		onBeforeScrollStart: function (e) {		// 激活输入框
		   var target = e.target;
		   while (target.nodeType != 1) target = target.parentNode;
		   var tagName = target.tagName.toUpperCase();
		   if (tagName != 'SELECT' && tagName != 'INPUT' && tagName != 'TEXTAREA' && tagName != 'SPAN') {
			   e.preventDefault();
		   }
	   }
	});
	myScroll.refresh();
	$('#wrapper').css('overflow', 'visible');
	// $('#wrapper').css('overflow-y', 'auto');
	$('#applybtn').tap(function () {
		//window.location = "submit.html";
		$('#applyForm').show();
//		var offsetTop = $('#applyForm form')[0].offsetTop;
//		$('#applyForm').css('height', document.documentElement.clientHeight);
//		
//		$('#scroller').css('float', 'left');
//		$('#applyForm form').css('top', offsetTop + 'px');
//		$('#applyForm form').css('position', 'relative');
	});
	
	$('.applybg').tap(function () {
		$('#applyForm').hide();
//		$('#applyForm form').css('top', 'auto');
//		$('#applyForm form').css('position', 'absolute');
	});
	var isKeyboardShow = false;
	$('input').focus(function () {
		isKeyboardShow = true;
	})
	$('input').blur(function () {
		isKeyboardShow = false;
	})
	
	$('.closebtn').tap(function () {
		$('.closebtn').parent('div').hide();
		$('.bottomMargin').hide();
		$('#wrapper').addClass('fullScreen');
		myScroll.refresh();
	});
	
	$('#follow p').tap(function () {
		window.location = "help.html";
	});
	
	$('#submit').on('click', function () {
		// 数据提交
		var activeData = {}
		
		activeData.userName = $('#userName').val();
		activeData.tel = $('#userTel').val();
		
		
		if (!(activeData.tel && activeData.tel.length > 0)) {
			// 请输入手机号
			webMutual.showToast("请输入手机号");
			return;
		} else if (!(activeData.tel.match(/^1[3|4|5|8][0-9]\d{4,8}$/)&& activeData.tel.length==11)) {
			// 请输入正确手机号
			webMutual.showToast("请输入正确手机号");
			return;
		}
		if (!(activeData.userName && activeData.userName.length > 0)) {
			// 请输入姓名
			webMutual.showToast("请输入姓名");
			return;
		}
		activeData.activityId = getQueryString("activityId");
		activeData.userId = getQueryString("userId");
		activeData.isLogin = getQueryString("isLogin");
		activeData.appType = getQueryString("appType");
		if (!activeData.activityId) {
			activeData.activityId = 4;
		}
		if (!activeData.userId) {
			activeData.userId = 1;
		}
		if (!activeData.isLogin) {
			activeData.isLogin = 0;
		}
		if (!activeData.appType) {
			activeData.appType = 1;
		}
		activeData.sysType = webMutual.platformType;
		
		webMutual.startLoading("正在提交数据...")
		callServerFunction('/activety/setActiveDetail.do', activeData, function (result, message) {
			$('#applyForm').hide();
			webMutual.showToast(TextApplySucceed);
			localStorage.setItem(keyIsJoin, true);
			applyBtnDisabled();
			webMutual.stopLoading();
		}, function (message) {
			webMutual.showToast(message);
			webMutual.stopLoading();
		})
		
	});
	$(window).resize(function() {
		if (isKeyboardShow == false) {
			// $('html').css('height', document.documentElement.clientHeight); 
		}
		myScroll.refresh();
	});
	
	// 复制账号
	var isCopy = false;		// 是否复制
	$('#copyAccount').on('click', function() {
		if (isCopy == false) {
			isCopy = true;
			webMutual.copeText(WeixinAccount);
			setTimeout(function () {
				$('#copyAccount a').html(TextCopySucceed);
			}, 200);
		} else {
		}
	});
	
	
});