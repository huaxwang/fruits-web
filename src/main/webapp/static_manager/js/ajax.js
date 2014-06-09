(function($) {

    $.convertData = function(params) {
        var castString = function(param) {
            if (param == null) {
                return null;
            }
            else if (param.constructor == String) {
                return param;
            }
            else if (param.constructor == Boolean) {
                return param;
            }
            else if (param.constructor == Date) {
                return $.formatDate(param);
            }
            else if (param.constructor == Number) {
                return param;
            }
            else if (param.constructor == Array) {
                return $.toJSON(param);
            }
            else if (param.constructor == Object) {
                return $.toJSON(param);
            }
        };

        if (params == null) return null;
        var obj = {};
        if (params.constructor == Array) {
            for (var i = 0; i < params.length; i++) {
                obj["arg" + i] = castString(params[i]);
            }
        }
        else {
            for (var k in params) {
                obj[k] = castString(params[k]);
            }
        }
        return $.param(obj);
    };

    $.ajaxGet = function(action, params, successCallback, errorCallback) {
        var ajaxData = $.convertData(params);
        var url = action + (action.indexOf("?") == -1 ? "?timeSerialize=" : "&timeSerialize=");
        url += (new Date()).getTime();
        $.ajax({
            type: "GET",
            url: url,
            dataType : "text",
            data: ajaxData,
            complete:function(request, textStatus) {
                if (request.readyState == 4 && request.status == 200) {
                    var result = request.responseText;
                    if ($.isTimeout(result)) {
                    	jAlert("登录会话已超时，请重新登录！", "会话超时", function(){
	        				window.location = path + "/system/logout";
	        			});
                    	return;
                    }
                    if ($.isException(result)) {
                        if (errorCallback) errorCallback($.getException(result));
                        else $("MainFrame").html($.getException(result));
                        return;
                    }
                    if (successCallback != null && $.isFunction(successCallback)) {
                        successCallback(result, textStatus);
                    }
                }
                else {
                	jAlert("请求操作过程中发生错误:readyState="+request.readyState+";status="+request.status);
                }
            }
        });
    };


    $.ajaxPost = function(action, params, successCallback, errorCallback) {
        var ajaxData = $.convertData(params);
        var url = action + (action.indexOf("?") == -1 ? "?timeSerialize=" : "&timeSerialize=");
        url += (new Date()).getTime();
        $.ajax({
            type: "POST",
            url: url,
            dataType : "text",
            data: ajaxData,
            complete:function(request, textStatus) {
                if (request.readyState == 4 && request.status == 200) {
            		var result = request.responseText;
                    if ($.isTimeout(result)) {
                    	jAlert("登录会话已超时，请重新登录！", "会话超时", function(){
	        				window.location = path + "/system/logout";
	        			});
                    	return;
                    }
                    if ($.isException(result)) {
                        if (errorCallback) errorCallback($.getException(result));
                        else $("MainFrame").html($.getException(result));
                        return;
                    }
                    if (successCallback != null && $.isFunction(successCallback)) {
                        successCallback(result, textStatus);
                    }
                }
                else {
                	jAlert("请求操作过程中发生错误:readyState="+request.readyState+";status="+request.status);
                }
            }
        });
    };
    
    $.ajaxJSON = function(action, params, successCallback, errorCallback) {
        var ajaxData = $.convertData(params);
        var url = action + (action.indexOf("?") == -1 ? "?timeSerialize=" : "&timeSerialize=");
        url += (new Date()).getTime();
        $.ajax({
            type: "POST",
            url: url,
            dataType : "text",
            data: ajaxData,
            complete:function(request, textStatus) {
                if (request.readyState == 4 && request.status == 200) {
                    var result = request.responseText;
                    if ($.isTimeout(result)) {
                    	jAlert("登录会话已超时，请重新登录！", "会话超时", function(){
	        				window.location = path + "/system/logout";
	        			});
                    	return;
                    }
                    if ($.isException(result)) {
                        if (errorCallback) errorCallback($.getException(result));
                        else $("MainFrame").html($.getException(result));
                        return;
                    }
                    if (successCallback != null && $.isFunction(successCallback)) {
                        successCallback($.parseJSON(result), textStatus);
                    }
                }
                else {
                	jAlert("请求操作过程中发生错误:readyState="+request.readyState+";status="+request.status);
                }
            }
        });
    };
    
    $.isTimeout = function(result) {
        return result != null && result.indexOf("<!-- KKMY-MERCHANT-LOGIN-PAGE -->") >= 0;
    };

    $.isException = function(result) {
        return result != null && result.indexOf("<title>exception</title>") >= 0;
    };

    $.getException = function(result) {
    	if(result.indexOf("<body>") != -1){
    		var start = result.indexOf("<body>") + 6;
            var end = result.indexOf("</body>");
            return result.substring(start, end);
    	}
        return result;
    };
})(jQuery);
