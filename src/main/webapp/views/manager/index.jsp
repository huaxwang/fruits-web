<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="shiro" uri="/WEB-INF/tlds/shiros.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}"/>
 --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static_manager" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META name="GENERATOR" content="MSHTML 9.00.8112.16526"></MEAD>
<title>Q果商城后台管理</title>
<link href="${ctxStatic}/css/global.css" rel="stylesheet" type="text/css">
<link href="${ctxStatic}/css/statistics.css" rel="stylesheet" type="text/css">
<link href="${ctxStatic}/css/pagination.css" rel="stylesheet" type="text/css">
<SCRIPT type="text/javascript" src="${ctxStatic}/js/jquery-1.9.1.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/jquery.showLoading.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/artDialog.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/ajax.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/base.js"></SCRIPT>
<script type="text/javascript" src="${ctxStatic}/js/publish.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/dialog.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery.pagination.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/swfupload/js/swfupload.queue.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/swfupload/js/fileprogress.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/uploader.js"></script>
<script type="text/javascript">


$(function () {
	//===================================优惠券列表==============================
	var Pagination = {
			pagination:"Pagination",
			data_table:"dataTable",
			page_index:0,
			datas:"",
			url:"${ctx}/manager/getFruitsList.do",
			categoryList:"",
			initDatas:function(){
				var that = this;
				this.query();
				
				$(".submit").click(function(){
					that.query();
				});
				$(".reset").click(function(){
					that.reset();
				});
			}
	};
	
	//查询列表数据
	Pagination.query = function(){
		showLoading();
		var that = this;
	    $.ajaxJSON(that.url, getQueryParams(), function(data){
	        if(data.code == "000000"){
	        	that.datas = data.result;
	            $("#Pagination").pagination(that.datas.totalCount, that.opt);
	            hideLoading();
	        }else{
	            jAlert(data.msg);
	        }
	    });
	};
	
	//清空数据
	Pagination.reset = function(url){
		$("input[name='onlineOperStatue']").val("");
		$("input[name='columnId']").val("");
		$("input[name='name']").val("");
		$("span[name='onlineOperStatueName']").html("选择状态");
		$("span[name='columnIdName']").html("选择栏目");
		Pagination.initDatas("${ctx}/coupon/couponList");
	};
	
	//回调函数
	Pagination.pageSelectCallback = function(page_index){
		var param = getQueryParams();
		param.pageNo = page_index+1;
		if(Pagination.datas!=""){
			Pagination.renderTable(Pagination.datas,page_index);
			Pagination.datas="";
		}else{
			$.ajaxJSON(Pagination.url, param, function(data){
		        if(data.code == "000000"){
		            Pagination.renderTable(data.result,page_index);
		        }else{
		            jAlert(data.msg);
		        }
		    });
		}
	};
	
	//回调参数
	Pagination.opt = {
			callback: Pagination.pageSelectCallback,
			items_per_page: 10,
			num_display_entries: 6,
			num_edge_entries: 1
	};
	
	//测试拼装参数
	function getQueryParams(){
		var params = {pageNo:0};
		
		var onlineOperStatue = $("input[name='onlineOperStatue']").val();
		if(onlineOperStatue != ""){
			params.onlineOperStatue = onlineOperStatue;
		}
		var columnId = $("input[name='columnId']").val();
		if(columnId != ""){
			params.columnId = columnId;
		}
		var name = $("input[name='name']").val();
		if(name != ""){
			params.name = name;
		}
		return params;
	}
	
	//拼装列表数据
	Pagination.renderTable = function (data, pageIndex){
		var content = "";
        if(data != null){
        	var list = data.list;
        	if(list.length==0){
        		$(".table").hide();
        		$("#Pagination").hide();
            	$(".null").show();
            	return;
        	}else{
        		$(".table").show();
            	$(".null").hide();
        	}
            for(var i=0;i<list.length; i++){
            	var obj = list[i];
            	content +='<tr>';
		    	content +='<td>'+(pageIndex * pagination.opt.items_per_page + i + 1)+'</td>';
		    	content +='<td>'+obj.createTimeFomate+'</td>';
		    	content +='<td>'+obj.name+'</td>';
		    	content +='<td>'+obj.columnName+'</td>';
		    	content +='<td><em>0</em></td>';
		    	content +='<td>';
		    	if(obj.onlineOperStatue==0){
		    		content +='<a class="switch on" idm="'+obj.id+'" onclick=\"switchFun(this)\" href="#"></a>';
		    	}else{
		    		content +='<a class="switch off" idm="'+obj.id+'" onclick=\"switchFun(this)\" href="#"></a>';
		    	}
		    	
		    	content +='</td>';
		    	content +='</tr>';
            }
            $(".table").find("tr:first").nextAll().remove();
            $(".table").find("table").append(content);
            $("#Pagination").show();
            }
	};
	
	//修改上下线状态
	function switchFun(obj){
		var v = $(obj).attr("class");
		var id = $(obj).attr("idm");
		var onlineState;
		var className;
		if(v=="switch on"){
			className="switch off";
			onlineState = 1;
		}else{
			className="switch on";
			onlineState = 0;
		}
		
		var param = {};
		param.id = id;
		param.onlineState = onlineState;
		
		var url = "${ctx}/manager/onlineUpdate.do";
		$.ajaxJSON(url, param, function(data){
	        if(data.code == "000000"){
            	$(obj).attr("class",className);
            	pagination.initDatas();
	        }else{
	        	jAlert("上/下线修改失败！");
	        }
	    });
	}
	
	Pagination.initDatas();
	window.switchFun = switchFun;
	window.pagination = Pagination;
	//===================================/优惠券列表==============================
})
</script>
<BODY>
<%@ include file="../common/dialog.jsp" %>
<div class="header wrap">
    <div class="logo fl"><a href="${ctx}/manager/index.do"><img src="${ctxStatic}/image/logo.png"></a></div>
    <div class="exit fr">
    	<a href="#"></a>
    </div>
    <div class="editdata fr">
    	<a href="#"></a>
    </div>
    <div class="storename fr">欢迎您, 中联大药房......</div>
</div>
<div class="content">
	<div class="wrap cc">
    	<div class="leftmenu fl">
            <div class="tit">管理我的药房</div>
            <ul>
                <li> <a href="${ctx}/manager/index.do" class="ico_1"> <span></span> 水果管理 </a><em></em> </li>
                <!-- <li> <a href="../message/message.html" class="ico_2"> <span></span> 消息中心 </a><em></em> </li>
                <li> <a href="../merchant/merchant.html" class="ico_3"> <span></span> 商户中心 </a><em></em> </li>
                <li> <a href="#" class="ico_4"> <span></span> 优惠信息推送 </a> </li>
                <li> <a href="../send/send.html" class="ico_5"> <span></span> 时时派单 </a> </li>
                <li> <a href="../statistics/statistics_list.html" class="ico_6"> <span></span> 查看统计 </a> </li>
                <li> <a href="#" class="ico_7 on"> <span></span> 账号管理 </a> 
                	<div class="subbox">
                        <div class="subcnt">
                            <p class="ico_5"> <a href="../account/account_info.html"> <span>账号信息</span> </a> </p>
                            <p class="ico_6"> <a href="../account/upgrade_step1.html"> <span>账号升级</span> </a> </p>
                            <p class="ico_7"> <a href="../account/shop_info_step1.html"> <span>药房信息</span> </a> </p>
                            <p class="ico_8"> <a href="../account/member_info_step1.html"> <span>会员信息</span> </a> </p>
                        </div>
                        <div class="arrow"></div>
                    </div>
                </li> -->
            </ul>
        </div>
        <div class="indmain fr">
            <div class="choose">
                <div class="add" id="Jadd">
                    <a href="javascript:">新增水果</a>
                </div>
                <div class="cat">
                    <div class="cc">
                        <label class="ml10">选择栏目：</label>
                        <div class="sltitem">
                            <span class="" name="columnIdName">选择栏目</span>
                            <ul style="display: none;">
                                <li data-value="1"><a href="javascript:;">进口水果</a></li>
                                <li data-value="2"><a href="javascript:;">国产水果</a></li>
                                <li data-value="3"><a href="javascript:;">特产专区</a></li>
                                <li data-value="4"><a href="javascript:;">有机生鲜</a></li>
                                <li data-value="5"><a href="javascript:;">礼品专区</a></li>
                                <li data-value="6"><a href="javascript:;">醇香酒窖</a></li>
                                <li data-value="7"><a href="javascript:;">按功效</a></li>
                                <li data-value="8"><a href="javascript:;">按人群</a></li>
                                <li data-value="9"><a href="javascript:;">按价位</a></li>
                            </ul>
                            <input type="hidden" value="" name="columnId">
                        </div>
                        
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;</label>
                         
                        <label class="ml10">水果状态：</label>
                        <div class="sltitem">
                            <span class="" name="onlineOperStatueName">选择状态</span>
                            <ul style="display: none;">
                                <li data-value="0"><a href="javascript:;">启用</a></li>
                                <li data-value="1"><a href="javascript:;">禁用</a></li>
                            </ul>
                            <input type="hidden" value="" name="onlineOperStatue">
                        </div>
                        
                    </div>
                    <div class="cc mt20">
                        <label>水果名称：</label>
                        <div class="sltitem">
                            <input type="text" value="" name="name"/>
                        </div>
                        <div class="btn">
                            <input name="" type="submit" value="查 询" class="submit">
                            <input name="重置" type="reset" value="清空查询条件" class="reset">
                        </div>
                    </div>
                    
                </div>
            </div>

        	<!--统计-->
            <div class="statistics mt10">
                <div class="table">
                	<table cellpadding="0" cellspacing="0" border="0">
                    	<tr>
                        	<th class="col_1">序号</th>
                            <th class="col_2">发布时间</th>
                            <th class="col_5">名称</th>
                            <th class="col_2">栏目名称</th>
                            <th class="col_1">浏览人数</th>
                            <th class="col_10">操作</th>
                        </tr>
                    </table>
                </div>
                <div id="Pagination" class="pagination" style="display:none;"></div>
            </div>
            <!--/统计-->
        </div>
    </div>
</div>
<div class="footer wrap">
	<p>康康买药@版权所有 联系方式：400-060-3351</p>
</div>

<div id="template">
<!-- 优惠券新增  -->
<form id="baseform">
	<input type="hidden" id="mpageid" name="pageid" />
	<input type="hidden" id="idcard1" name="idcard1" />
    <div class="add_discount">
    <div class="file mt10">
        <div class="filecate cc">
                <div class="sltitem mr10">
                    <span>选择水果分类</span>
                    <ul>
                        <li data-value="1"><a href="javascript:;">进口水果</a></li>
                        <li data-value="2"><a href="javascript:;">国产水果</a></li>
                        <li data-value="3"><a href="javascript:;">特产专区</a></li>
                        <li data-value="4"><a href="javascript:;">有机生鲜</a></li>
                        <li data-value="5"><a href="javascript:;">礼品专区</a></li>
                        <li data-value="6"><a href="javascript:;">醇香酒窖</a></li>
                        <li data-value="7"><a href="javascript:;">按功效</a></li>
                        <li data-value="8"><a href="javascript:;">按人群</a></li>
                        <li data-value="9"><a href="javascript:;">按价位</a></li>
                    </ul>
                    <input name="category" type="hidden" value=""/>
                </div>
                <div class="sltitem" style="white-space:nowrap;">
                	<label>水果名称：</label>
                    <input name="name" type="text" value="" size="15"/>
                    <label>价格：</label>
                    <input name="price" type="text" value="" size="5"/>
                    <label>数量：</label>
                    <input name="count" type="text" value="" size="5"/>
                    <label>单位：</label>
                    <input name="unit" type="text" value="" size="5"/>
                </div>
            </div>
            </div>
        <div class="text"><span>0/36</span><input name="remarks" type="text" value="输入你的内容："></div>
        <div class="file mt10">
            <div class="cnt">
				<label>上传图片：</label>
         		<div class="papersbox">
					<span id="upidimgfile1"></span>
				</div>
			</div>
            <div class="fileurl" style="display:none;">
                <span><a href="#" class="del">删除</a> <a href="#" class="preview">浏览</a></span>
                <input name="" type="text">
            </div>
            <p class="tips">支持jpg，jpeg，png，bmp格式，且尺寸大小为480px*360px</p>
            <p class="errorMsg">错误提示</p>
        </div>
        <div class="btn">
            <a href="javascript:" class="cannel" onclick="dialog.hide()">取 消</a> 
            <a href="javascript:" class="confirm" onClick="submitFun()">确 定</a>
        </div>
    </div>
</form>
</div>

<script type="text/javascript">
(function($, window){
//模拟单选组
function Jradio() {
    $("input[name=towhom]").each(function(i,n){
        if(n.checked){
            $(n).parents("span").addClass("on")
        }else{
            $(n).parents("span").removeClass("on")
        }
    });    
}
Jradio();
$("body").on("click", "input[name=towhom]", function(){
    Jradio();
})

var template = $("#template").html(),
    formStatus = 0; //保存优惠券窗口的状态，1为新增，2为修改
$("#template").remove();

function showTemp(tit) {
    dialog.show(tit, template);
    $(".filebtn").change(function(){
        var value = $(this).val();
        // $(this).parents(".filebtnbox").hide();
        $(".fileurl").show();
        $(".add_discount p.tips").addClass("red");
        $(".fileurl input").val(value);
    })
    searchTip(".add_discount .text input","输入你的内容：");
}

//打开新增优惠券窗口
$("#Jadd").on("click", function(){
    formStatus = 1;
    showTemp("新增水果");
    addEvent();
    bind();
    return false;
});

// 未通过时修改优惠券
$(".table").on("click", ".edit", function(){
    if ($(this).hasClass("hide")) {
        return false;
    }
    formStatus = 2;
    showTemp("修改优惠券");
    addEvent();
    //填充数据?

    //
    return false;
});



//===================================新增优惠券================================
//新增优惠券
function submitFun(){
	var url = "";
	if(formStatus==1){
		url = "${ctx}/manager/add.do";
		if(validateForm()){
			 jQuery.ajax({
				url : url,
				data : $('#baseform').serialize(),
				type : "POST",
				dataType : 'json',
				success : function(data) {
					if (data.code == 'success') {
						dialog.hide();
						pagination.initDatas();
					} else {
						alert(data.msg);
					}
				},
				error : function(req, state, error) {
					alert(error);
				}
			});  
		}
	}
}


function validateForm(){
	return true;
}
//===================================/新增优惠券================================
	
//===================================上传图片================================
function fileQueueError(obj,file,code,msg){

	if(code==-110){
		var eid=obj.settings.custom_settings.eid;
		var mid=obj.settings.custom_settings.mid;
		$('#'+eid).text('文件超过2MB');
		$('#'+eid).addClass('error');

		if(eid=='idimgError1'){
			lastImg1=false;
			$('#'+mid).text('示例');
			$('#'+mid).attr('href','../../assets/images/s_img05.jpg');
		}
	}
}
var upload_flag = true;
function uploadSuccess(file,serverDate){
	var obj = jQuery.parseJSON(serverDate);
	if(obj.code == 'success'){
		upload_flag = true;
		$("#error").html("");
		$("#error").hide();
		return;
	}
	upload_flag = false;
	$("#error").html(obj.data);
	$("#error").show();
}
function uploadPicComplete(file,serviceDate){
	if(!upload_flag){
		return;
	}
	var eid=this.settings.custom_settings.eid;
	if(eid=='logoError'){
		$("#logo").attr("src",getPicPath(file.name));
		$("#mainLogo").attr("src",getPicPath(file.name));
		if(jcrop_api){
			jcrop_api.setImage(getPicPath(file.name));
			if(lastCoords){
				jcrop_api.setSelect([ lastCoords.x,lastCoords.y,lastCoords.x2,lastCoords.y2 ]);
			}
		}else{
			initJcrop();
		}
		lastLogo=file.name;
		$('#'+eid).removeClass('error');
	}else{
		$(".fileurl").show();
		$(".del").click(function(){
			$(".fileurl").hide();
		});
		$('#mpageid').val(pageid);
		
		
		$('#'+eid).removeClass('error');
		$('#'+eid).text('证件已上传');
		$('#'+this.settings.custom_settings.mid).text('预览');
		$('#'+this.settings.custom_settings.mid).attr('href',getPicPath(file.name));
		$('body').hideLoading();
	}
	
	if(eid=='idimgError1'){
		lastImg1=file.name;
		$('#idcard1').val(getPicPath(lastImg1));
	}
}
var uploader1;
function bind(){
	var lastImg1;
	var root=getAppRoot();
	var url=root+'file/preUpload.do';
	var imgType="*.jpg;*.gif;*.jepg;*.png;*.bmp";
	var typeDesc="jpg,gif,jepg,bmp,png";
	
	uploader1=uploader({
		url:url,
		param:{"pageid":pageid},
		limit:2,
		type:imgType,
		typeDesc:typeDesc,
		btnId:'upidimgfile1',
		btnLable:'上传图片',
		uploadComplete:uploadPicComplete,
		fileQueueError:fileQueueError,
		uploadSuccess:uploadSuccess,
		custom:{eid:'idimgError1',mid:'idimg1'}
	});
	$('#idcard1').val(getPicPath(lastImg1));
	}
//===================================/上传图片================================


//事件委托
$("body").on("click", ".btn>a, .switch", function() { 
    //提交
    if ($(this).hasClass("loop")) {
        // 提交
        // 提交ok
        dialog.hide();
        formStatus = 1;
        showTemp("新增水果");
        addEvent();
        bind();

    } else if ($(this).hasClass("switch")) {    //上线&下线
        var on = $(this).hasClass("on");
        this.className = on ? "switch off" : "switch on";
        //提交
    }

    return false;
})


function addEvent() {

    // 新增优惠券表单 start
    var add_msg = $(".add_discount>.text>span");
    $(".add_discount>.text>input").on("keyup focus blur keydown", function() {
        var val = $.trim(this.value);
        if (val.length) {
            this.value = val = val.substring(0, 36);
        }
        add_msg.html(val.length+"/"+36)
    })
    // 取消
    $(".add_discount>.btn>.cannel").on("click", function() {
        $(".coupon .tab_nav li:eq(0)").trigger("click");
    })
    // 确定
    $(".add_discount>.btn>.cannel").on("click", function() {
        var txt = $(".add_discount>.txt>input").val();
        if (txt.length > 36) {
            
        }
        // $(".coupon .tab_nav li:eq(0)").trigger("click");
    })
    // 新增优惠券表单 end
}

window.submitFun=submitFun;
}(jQuery, window));
</script>
</BODY>
</HTML>
