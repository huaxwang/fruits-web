// JavaScript Document
$(document).ready(function(){
	//宽窄屏切换
	var _resize_timer = 0;
	function _resize() {
		clearTimeout(_resize_timer);
		_resize_timer = setTimeout(function() {
			var doc_w = $(window).width();
			$("body").attr("class",(doc_w > 1210 ? "" : "narrow"))
		}, 50);
	}
	_resize();
	
    $(window).resize(function(){
        _resize();
    });
    
	//导航切换
	$(".leftmenu li").click(function(){
		if($(this).has(".subbox").length == 0){
			$(this).children("a").addClass("on").parent("li").siblings().children("a").removeClass("on")
		}
	});
	$(".leftmenu li").find(".subbox p").click(function(){
		$(this).parents("li").children("a").addClass("on").parent("li").siblings().children("a").removeClass("on");
	})
    //自定义下拉框
	$("body").click(function(){
		$(".sltitem").find("ul").hide();
		$(".sltitem span").removeClass("on")
	});
	$("body").on("click mouseleave", ".sltitem", function(event){
		if (event.type === "mouseleave") {
			$(this).find("span").removeClass("on").next("ul").hide();
			return false;
		}
		event.stopPropagation();
		var ul  = $(this).find("ul"),
			len = ul.find("li").length;
		len > 12 && ul.css({"height":"240px","overflow":"auto"})
		ul.show().prev("span").addClass("on");
	});
	$("body").on("click", ".sltitem li", function(e){
		e.stopPropagation();
		var text = $(this).text();
		var value = $(this).data("value");
		var ul = $(this).parent("ul");
		ul.hide().prev().text(text).removeClass("on");
		ul.next().val(value);
	});


	//示例展示
	$("a.example").hover(function(){
		var bTop = $(this).position().top;
		var bLeft = $(this).position().left;
		var exaimg = $(this).attr("href");
		$(this).parents(".form").append('<div class="exabox"><img src="'+exaimg+'" /></div>');
		$(".exabox").css({"top":bTop-250,"left":bLeft});
	},function(){
		$(".exabox").remove();
	});
	$("a.example").click(function(e){
		e.preventDefault();
	})
	//侧边子菜单显示
	$(".leftmenu li").has(".subbox").hover(function(){
		$(this).find("a").addClass("hover");
		$(this).find(".subbox").show();
	},function(){
		$(this).find("a").removeClass("hover");
		$(this).find(".subbox").hide();
	});
	//公测反馈提示
	$(".tips_add i").hover(function(){
		$(this).css("background-position","0px -12px");
	},function(){
		$(this).css("background-position","0px 0px");
	});
	$(".tips_add i").click(function(){
		$(this).parents("em.tips_add").hide();
	});

});
//+++++文本框提示信息+++++//
function searchTip(o,txt){
	$(o).focus(function(){
		$(this).addClass("focus");
		if($(this).val() ==txt){  
			$(this).val("");           
		}
	}).blur(function(){
		$(this).removeClass("focus");
		if ($(this).val() == '') {
			$(this).val(txt);
		}
	});
}
//+++++按钮倒计时+++++//
function btnTimer(btn,s,btntxt,url){
	var count = s;
	$(btn).click(function(){
		window.location.href=url;
	})
	var countdown = setInterval(CountDown, 1000);
	function CountDown(){
		$(btn).val(count+"s后自动"+btntxt);
		if (count == 0){
			window.location.href=url;
			$(btn).val(btntxt);
			clearInterval(countdown);
		}
		count--;
	}
}
//+++++公共弹出框+++++//
function popBox(txt,btn,w){
	var s_t = $(window).scrollTop();
	var html = '<div class="popbox"><a href="#" class="closebtn" id="closeBtn"></a><div class="text">'+txt+'</div><div class="btn">'+btn+'</div></div><div class="popbg"></div>';
	$('body').append(html);
	var h = $('.popbox').height();
	$('.popbox').css({"width":w+"px","margin-left":-(w/2)+"px"});
	//弹出框屏幕居中
	var w_h = $(window).height();
	var b_h = $(".popbox").outerHeight(true);
	$(".popbox").css("top",((w_h-b_h)/2)+s_t+"px");
	$('.popbg').css("top",s_t+"px");
	$(window).resize(function(){
		w_h = $(window).height();
		s_t = $(window).scrollTop();
		$('.popbox,').css("top",((w_h-b_h)/2)+s_t+"px");
		$('.popbg').css("top",s_t+"px");
	});
	//取消按钮事件
	$('body').on("click","input.cannel",function(){
		$('.popbox,.popbg').remove();
		$(window).unbind("scroll");
		removeEvents(document,"mousewheel",MouseWheel);
		return false;
	});
	//关闭弹出框按钮事件
	$('body').on("click","#closeBtn",function(){
		$('.popbox,.popbg').remove();
		$(window).unbind("scroll");
		removeEvents(document,"mousewheel",MouseWheel);
		return false;
	});
	//鼠标拖动滚动条;
	$(window).bind("scroll",function(){
		$(window).scrollTop(s_t);
	});
	addEvents(document,"mousewheel",MouseWheel);
}
//鼠标滚动
function MouseWheel(e) {
	e = e || window.event;
	if (e.stopPropagation) e.stopPropagation();
	else e.cancelBubble = true;
	if (e.preventDefault) e.preventDefault();
	else e.returnValue = false;
}
//绑定事件
function addEvents(target, type, func) { 
	if (target.addEventListener){
		//非ie 和ie9 
		target.addEventListener(type, func, false); 
	}
	else if(target.attachEvent){
		//ie6到ie8 
		target.attachEvent("on" + type, func); 
	}
	else{
		target["on" + type] = func; //ie5
	}
};
//解绑事件
function removeEvents(target, type, func){ 
	if (target.removeEventListener){ 
		target.removeEventListener(type, func, false);
	}
	else if (target.detachEvent){
		target.detachEvent("on" + type, func); 
	}
	else{
		target["on" + type] = null;
	}
};