/**
 * 页面基础控制
 * 
 * @author yong.li@rogrand.com
 */

var pageid;
$(document).ready(function() {
	var ad = new Date();
	pageid = Math.round(Math.random() * 1000)+''+ad.getTime() + '' + Math.round(Math.random() * 10000);
});

function isPic(ext) {
	var f = false;
	switch (ext.toLowerCase()) {
	case 'png':
		f = true;
		break;
	case 'jpg':
		f = true;
		break;
	case 'gif':
		f = true;
		break;
	case 'bmp':
		f = true;
		break;
	case 'jpeg':
		f = true;
		break;
	}
	return f;
}
var serverPicPath="upload/pic/temp/";
function getPicName(obj){
	var file=$('#'+obj).val();
	return getAppPath(serverPicPath) + pageid + '/'+file.substring(file.lastIndexOf('\\') + 1);
}

/**
 * 获取应用路径 
 */
function getAppRoot(){
	var  webroot=window.location.href;
	var pos=webroot.indexOf("//")+2;
	pos=webroot.indexOf("/",pos)+1;
	pos=webroot.indexOf("/",pos)+1;
	return webroot.substring(0,pos);
}

function getAppPath(path){
	if(path){
		return getAppRoot()+path;
	}
	return false;
}

function getPicPath(pic){
	if(pic){
		return getAppPath(serverPicPath) + pageid+'/'+pic;
	}
	return false;
}

function showPage(url) {
	window.location.href = url;
}

//function showPage(url, params) {
//    $.pageLoad(url, params, "MainFrame");
//    return false;
//}

function showLoading() {
	try {
		$('body').hideLoading();
	} catch (e) {
		// 关闭异常情况产生的未及时销毁的 loading 对象
	}
	$('body').showLoading();
}
function hideLoading() {
	$('body').hideLoading();
}

/**
 * 获取语音控件的显示宽度
 * @param seconds 语音时长（秒）
 * @returns {Number} 控件显示宽度
 */
var maxWidth=110;// 控件最大宽度
var baseWidth=20;// 初始最小宽度
var maxTime=60;// 语音长度最大取值，超过60秒以60秒计算
function getVoiceWidth(time){
	if(time > maxTime) time = maxTime;
	return baseWidth + (maxWidth - baseWidth)/maxTime * time;
}

function getAreas(target, callback, async) {
	var id;
	var ops = '<option value="">请选择</option>';
	if (target == 'province') {
		id = 0;
	} else if (target == 'city') {
		var pro = $('#province')[0];
		id = pro.options[pro.selectedIndex].value;
		$('#city').html(ops);
		$('#parea').html(ops);
	} else if (target == 'parea') {
		var pro = $('#city')[0];
		id = pro.options[pro.selectedIndex].value;
		$('#parea').html(ops);
	}
	$.ajax({
		url : getAppPath('register/areas'),
		type : 'post',
		data : {
			areaId : id
		},
		dataType : 'json',
		async : ((async != "undefined" && async == true) ? true : false),
		success : function(data) {
			if (data.code == 'success') {
				if(data.data&&data.data.length>0){
					for ( var i = 0; i < data.data.length; i++) {
						ops += '<option value=\"'+data.data[i].id+'\">'
								+ data.data[i].name + '</option>';
					}
					$('#' + target).html(ops);
				}
				if (callback) {
					callback(target);
				}
			}
		},
		error : function(req, state, error) {
			alert(error);
		}
	});
}

/**
 * 设置图片路径
 * @param imgObj 图片控件
 * @param imgUrl 图片路径
 * @param defUrl 缺省路径
 */
function setImage(imgObj, imgUrl, defUrl){
	if(imgObj){
		imgObj.attr("src", imgUrl);
		imgObj.load(function(){
			// do-nothing
		}).error(function(){
			if(defUrl){
				imgObj.attr("src", defUrl);
			}else{
				imgObj.attr("src", path + "/assets/images/default.jpg");
			}
		});
	}
}


/**
* *********  操作实例  **************
*	var map = new HashMap();
*	map.put("key1","Value1");
*	map.put("key2","Value2");
*	map.put("key3","Value3");
*	map.put("key4","Value4");
*	map.put("key5","Value5");
*	alert("size："+map.size()+" key1："+map.get("key1"));
*	map.remove("key1");
*	map.put("key3","newValue");
*	var values = map.values();
*	for(var i in values){
*		document.write(i+"："+values[i]+"   ");
*	}
*	document.write("<br>");
*	var keySet = map.keySet();
*	for(var i in keySet){
*		document.write(i+"："+keySet[i]+"  ");
*	}
*	alert(map.isEmpty());
*/

function HashMap(){
	//定义长度
	var length = 0;
	//创建一个对象
	var obj = new Object();

	/**
	* 判断Map是否为空
	*/
	this.isEmpty = function(){
		return length == 0;
	};

	/**
	* 判断对象中是否包含给定Key
	*/
	this.containsKey=function(key){
		return (key in obj);
	};

	/**
	* 判断对象中是否包含给定的Value
	*/
	this.containsValue=function(value){
		for(var key in obj){
			if(obj[key] == value){
				return true;
			}
		}
		return false;
	};

	/**
	*向map中添加数据
	*/
	this.put=function(key,value){
		if(!this.containsKey(key)){
			length++;
		}
		obj[key] = value;
	};

	/**
	* 根据给定的Key获得Value
	*/
	this.get=function(key){
		return this.containsKey(key)?obj[key]:null;
	};

	/**
	* 根据给定的Key删除一个值
	*/
	this.remove=function(key){
		if(this.containsKey(key)&&(delete obj[key])){
			length--;
		}
	};

	/**
	* 获得Map中的所有Value
	*/
	this.values=function(){
		var _values= new Array();
		for(var key in obj){
			_values.push(obj[key]);
		}
		return _values;
	};

	/**
	* 获得Map中的所有Key
	*/
	this.keySet=function(){
		var _keys = new Array();
		for(var key in obj){
			_keys.push(key);
		}
		return _keys;
	};

	/**
	* 获得Map的长度
	*/
	this.size = function(){
		return length;
	};

	/**
	* 清空Map
	*/
	this.clear = function(){
		length = 0;
		obj = new Object();
	};
}