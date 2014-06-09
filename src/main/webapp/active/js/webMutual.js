// JavaScript Document

var requestHead = "kkmy-request-";
var callbackHead = "kkmy-callback-";



var webMutual = {
	callbackCount : 100,
	callbackArray : [],
	requestArray : [],
	leftRequestArray : [],
	scheme : "kkmy",
	isPlatformActive:false,
	platformType : "PC",
    isAndroid : false,
    isiOS : false
}

/** 
 * 公用方法 start {
 */

// 显示平台层Alert
webMutual.showAlert = function(message) {
	if (this.isPlatformActive) {
		webMutual.execute(3, '', message);
	} else {
		alert(message);
	}
}

// 显示平台层Toast
webMutual.showToast = function(message) {
//	if (this.isPlatformActive) {
		webMutual.execute(4, '', message);
//	} else {
//		alert(message);
//	}
}

// 显示平台层loading界面
webMutual.startLoading = function(message) {
	webMutual.execute(5, '', message);
}

// 关闭平台层loading界面
webMutual.stopLoading = function() {
	webMutual.execute(6, '', '');
}

webMutual.copeText = function(text) {
	webMutual.execute(7, '', text);
}

/* 公用方法 } end */

// 获取url参数
webMutual.getQueryString = function(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    }
    return null;
}

webMutual.activePlatform = function () {
	webMutual.isPlatformActive = true;
}

// 检查设备平台
webMutual.checkPlatform = function () {
    var curPlatform = this.getQueryString("platform")
    if (curPlatform) {
        if (curPlatform == "Android") {
			webMutual.platformType = curPlatform;
            this.isAndroid = true;
            return;
        } else if (curPlatform == "iOS") {
            this.isiOS = true;
            return;
        }
    }
    var platform = navigator.platform;
    var androidPlatforms = ['android', 'Linux arm*', 'Linux,ARM*'];
    var iOSPlatforms = ['iPhone', 'iPod', 'iPad'];
    for (var i = 0, len = androidPlatforms.length; i < len; i++) {
        if (platform.match(androidPlatforms[i])) {
            this.isAndroid = true;
        }
    }
    if (this.isAndroid == false) {
        for (var i = 0, len = iOSPlatforms.length; i < len; i++) {
            if (platform.match(iOSPlatforms[i])) {
                this.isiOS = true;
            }
        }
        if (this.isiOS == false) {
            // 请在手机上打开该网页
        }
    }
}

function platformCallback(success, failed) {
	this.success = success;
	this.failed = failed;
	this.handlerCallback = function(result) {
		if (result.isSuccess) {
			if (this.success) {
				if (typeof(result.data) == 'string') {
					this.success(JSON.parse(result.data));
				} else {
					this.success(result.data);
				}
			}
		} else {
			if (this.failed) {
				this.failed(result.message);
			}
		}
	};
}

webMutual.checkPlatform();

webMutual.execute = function(model, handler, data, success, failed) {
	var aRequest = {};
	aRequest.model = model;
	aRequest.handler = handler;
	aRequest.data = data;
	aRequest.success = success;
	aRequest.failed = failed;
	if (webMutual.isiOS) {
		webMutual.leftRequestArray.unshift(aRequest);
		if (this.leftRequestArray.length > 1) {
			// 存在请求还没获取到数据
			return;
		}
	}
	webMutual.startExecute(aRequest);
	/*
	var callbackHandler = new platformCallback(success, failed);
	var callbackId = callbackHead + webMutual.callbackCount;
	var requestId = requestHead + webMutual.callbackCount;
	webMutual.callbackCount ++;
	webMutual.callbackArray[callbackId] = callbackHandler;
	
	// 配置请求数据
	var requestData = {};
	requestData.model = model;
	requestData.handler = handler;
	requestData.callbackId = callbackId;
	var jsonString = '';
	if (data != 'undefined') {
		if (typeof(data) == 'string') {
			jsonString = data;
		} else {
			jsonString = JSON.stringify(data);
		}
	}
	requestData.jsonData = jsonString;
	var requestString = JSON.stringify(requestData);
	this.requestArray[requestId] = requestString;
	
	// 开始发请求
    if (this.isAndroid) {
        window.androidWeb.execute(requestString);
    } else if (this.isiOS) {
        this.execIframe = this.execIframe || createExecIframe();
        this.execIframe.src = this.scheme + ":" + requestId;
    }
	*/
}

webMutual.startExecute = function(aRequest) {
	var callbackHandler = new platformCallback(aRequest.success, aRequest.failed);
	var callbackId = callbackHead + webMutual.callbackCount;
	var requestId = requestHead + webMutual.callbackCount;
	webMutual.callbackCount ++;
	webMutual.callbackArray[callbackId] = callbackHandler;
	
	// 配置请求数据
	var requestData = {};
	requestData.model = aRequest.model;
	requestData.handler = aRequest.handler;
	requestData.callbackId = callbackId;
	var jsonString = '';
	if (aRequest.data != 'undefined') {
		if (typeof(aRequest.data) == 'string') {
			jsonString = aRequest.data;
		} else {
			jsonString = JSON.stringify(aRequest.data);
		}
	}
	requestData.jsonData = jsonString;
	var requestString = JSON.stringify(requestData);
	this.requestArray[requestId] = requestString;
	
	// 开始发请求
    if (this.isAndroid) {
        window.androidWeb.execute(requestString);
    } else if (this.isiOS) {
        this.execIframe = this.execIframe || createExecIframe();
        this.execIframe.src = this.scheme + ":" + requestId;
    }
}

webMutual.getRequestData = function(requestId) {
	var aRequestData = webMutual.requestArray[requestId];
	if (aRequestData != 'undefined') {
		delete webMutual.requestArray[requestId];
		if (webMutual.isiOS) {
			webMutual.leftRequestArray.pop();
			if (webMutual.leftRequestArray.length > 0) {
				var aRequest = webMutual.leftRequestArray[webMutual.leftRequestArray.length - 1];
				setTimeout(function(){
					webMutual.startExecute(aRequest);
				}, 100);
			}
			
		}
		return aRequestData;
	} else {
		return null;
	}
}

webMutual.platformCallback = function(result) {
	var resultObj = JSON.parse(result);
	var aPlatformCallback = webMutual.callbackArray[resultObj.callbackId];
	aPlatformCallback.handlerCallback(resultObj);
	delete webMutual.callbackArray[resultObj.callbackId];
}

function createExecIframe() {
    var iframe = document.createElement("iframe");
    iframe.style.display = 'none';
    document.body.appendChild(iframe);
    return iframe;
}



function openShareView() {
	webMutual.execute(0, 'OpenShareView', '');
}

function getUserInfo() {
	webMutual.execute(1, 'GetUserInfo', '', function(reuslt) {
		document.getElementById('display').innerHTML = JSON.stringify(reuslt);
	},
	function(message) {
		document.getElementById('display').innerHTML = message;
	});
}

function showAlert() {
	var sendText = document.getElementById('sendText').value;
	if (sendText.length > 0) {
		webMutual.showAlert(sendText);
	} else {
		document.getElementById('display').innerHTML = "请输入显示类容";
	}
}

function showToast() {
	var sendText = document.getElementById('sendText').value;
	if (sendText.length > 0) {
		webMutual.showToast(sendText);
	} else {
		document.getElementById('display').innerHTML = "请输入显示类容";
	}
}

function startLoading() {
	webMutual.startLoading('正在加载......');
	setTimeout(function() {
		webMutual.stopLoading();
	},3000);
}
