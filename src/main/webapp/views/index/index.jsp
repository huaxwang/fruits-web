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
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META name="GENERATOR" content="MSHTML 9.00.8112.16526"></MEAD>
<title>Q果商城</title>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/jquery-1.4.1.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/ajax.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/base.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/jquery.showLoading.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/public.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/Menu.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/artDialog.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/iframeTools.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/default.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/common.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${ctxStatic}/js/ProductInfo.js"></SCRIPT>

<script type="text/javascript">
$(function () {
	//查询分类列表
	$.ajaxJSON("${ctx}/fruits/categoryList.do", "", function(data){
		var content="";
	    if(data.code == "000000"){
	    	var map = toMap(data);
	    	for(var i=0;i<map.size();i++){
	    		var obj = map.get(i+1);
	    		var count = 0;
	    		if(obj.childs!=undefined){
	    			count=obj.childs.length
	    		}
	    			content += '<LI>';
	    			content += '<A href="${ctx}/search/Search.do?index='+obj.id+'">';
	    	    	content += '<SPAN class="mainnav_mun">'+count+'</SPAN><EM class="'+obj.picture+'"></EM>'+obj.name+'</A>';
	    			content += '<UL style="display: none;" class="subMenu'+i+' subMenu">';	
			    	content += '<OL>';
			    	content += '<H2>热门品牌</H2>';
			    	content += '<LI><A href="${ctx}/search/Search.do?index='+obj.parentId+'">';
			    	content += '<IMG title="Q果网" alt="Q果网" src="${ctxStatic}/image/GetFiles.jpg" width="90" height="40"></A></LI>';
			    	content += '</OL>';
			    	if(obj.childs!=undefined){
				    	for(var j=0;j<obj.childs.length;j++){
				    		var child = obj.childs[j];
				    		content += '<LI><A href="${ctx}/search/Search.do?index='+child.id+'">'+child.name+'</A></LI>';
				    	}
			    	}
			    	content += '</UL>';
			    	content += '</LI>';
	    		
	    	}
	    	$(".mainnav_ul").html(content);
	    	$('.mainnav_ul > li').each(function(i) {
				$(this).mouseenter(function() {
						$(".subMenu"+ i).show();
						$(this).find('a').eq(0).addClass('hover');
				});
				$(this).mouseleave(function() {
						$(".subMenu"+ i).hide();
						$(this).find('a').eq(0).removeClass('hover');
				});
			});
	    }else{
	        jAlert(data.msg);
	    }
	});
	//组装map
	function toMap(data){
		var map = new HashMap();
		for(var i=0;i<data.result.length;i++){
			var obj = data.result[i];
			if(obj.parentId==0){
				map.put(obj.id,obj);
			}else{
				var parent = map.get(obj.parentId);
				if(undefined==parent.childs){
					parent.childs = [];
					parent.childs.push(obj);
				}else{
					parent.childs.push(obj);
				}
			}
		}
		return map;
	}
	
	//查询促销数据
	$.ajaxJSON("${ctx}/fruits/selectShow.do", "", function(data){
		var content="";
	    if(data.code == "000000"){
	    	content +='<UL id="idSlider" class="slider">';
	    	for(var i=0;i<data.result.length;i++){
	    		var obj = data.result[i];
	    		content +='<LI><A title="'+obj.name+'" href="${ctx}/search/Search.aspx?id='+obj.id+'" target="_blank">';
	    		content +='<IMG src="${ctxStatic}/image/'+obj.picture+'" width="753" height="318"></A></LI>';
	    		
	    		content +='<LI>'+obj.name+'</LI>';
	    	}
	    	content +='</UL>';
	    	
	    	content +='<ul class="num" id="idNum"> ';
	    	for(var i=0;i<data.result.length;i++){
	    		var obj = data.result[i];
		    	if(i==0){
	    			content +='<li class="on">'+obj.name+'</li>';
	    		}else{
	    			content +='<li>'+obj.name+'</li>';
	    		}
		    	
	    	}
	    	content +='</UL>';
		
	    }else{
	    	 jAlert(data.msg);
	    }
	    
	    $("#idTransformView").html(content)
	});
	
	
	/* =======================栏目数据================================= */
	$.ajaxJSON("${ctx}/fruits/queryColumnFruitsAll.do", "", function(data){
		//栏目1
		var content1="";
		var count1=0;
		//栏目2
		var content2="";
		var count2=0;
		
		//栏目3
		var content3="";
		var count3=0;
		
		//栏目4
		var content4="";
		var count4=0;
		
		//栏目5
		var content5="";
		var count5=0;
		
		 if(data.code == "000000"){
			 for(var i=0;i<data.result.length;i++){
		    	var obj = data.result[i];
		    	//进口水果新品推荐
		    	if(obj.columnId==1&&count1<2){
		    		count1++;
			    	content1 +='<LI><SPAN class="spanHei100">';
			    	content1 +='<DIV class="DivCenter">';
			    	content1 +='<A title="'+obj.fruitsName+'" ';
			    	content1 +='href="${ctx}/product/productInfo.do?pid='+obj.fruitsId+'"target="_blank">';
			    	content1 +='<IMG src="${ctxStatic}/image/'+obj.picture+'"></A>';
			    	content1 +='</DIV></SPAN>';
			    	content1 +='<A title="'+obj.fruitsName+'" href="${ctx}/product/productInfo.do?pid='+obj.fruitsId+'" target="_blank">';
			    	content1 +='<H1>'+obj.fruitsName.substring(0,8)+'...</H1>';
			    	content1 +='<H2 class="color_hs"></H2>';
			    	content1 +='<H3>';
			    	content1 +='￥<SPAN class="color_yellow">'+fomatNum(obj.price)+'</SPAN>'+obj.count+'/'+obj.unit;
			    	content1 +='</H3>';
			    	content1 +='</A>';
			    	content1 +='<DIV class="clear"></DIV></LI>';
		    	}
		    	//国产水果新品推荐
		    	if(obj.columnId==2&&count2<2){
		    		count2++;
			    	content2 +='<LI><SPAN class="spanHei100">';
			    	content2 +='<DIV class="DivCenter">';
			    	content2 +='<A title="'+obj.fruitsName;
			    	content2 +='href="${ctx}/product/productInfo.do?pid='+obj.fruitsId+'"target="_blank">';
			    	content2 +='<IMG src="${ctxStatic}/image/'+obj.picture+'"></A>';
			    	content2 +='</DIV></SPAN>';
			    	content2 +='<A title="'+obj.fruitsName+'"href="href="${ctx}/product/productInfo.do?pid='+obj.fruitsId+'" target="_blank">';
			    	content2 +='<H1>'+obj.fruitsName.substring(0,8)+'...</H1>';
			    	content2 +='<H2 class="color_hs"></H2>';
			    	content2 +='<H3>';
			    	content2 +='￥<SPAN class="color_yellow">'+fomatNum(obj.price)+'</SPAN>'+obj.count+'/'+obj.unit;
			    	content2 +='</H3>';
			    	content2 +='</A>';
			    	content2 +='<DIV class="clear"></DIV></LI>';
		    	}
		    	//进口水果新品推荐
		    	if(obj.columnId==1&&count3<4){
		    		count3++;
		    		content3 +='<LI class="slideshowItem">';
		    		content3 +='<DIV class="LiBlock">';
		    		content3 +='<SPAN class="Span100">';
		    		content3 +='<DIV class="DivCenter">';
		    		content3 +='<A title="'+obj.fruitsName+'" ';
		    		content3 +='href="${ctx}/product/productInfo.do?pid='+obj.fruitsId+'">';
		    		content3 +='<IMG src="${ctxStatic}/image/'+obj.picture+'"></A>';
		    		content3 +='</DIV>';
		    		content3 +='</SPAN><A id="thumb_xixi-01" title="'+obj.fruitsName+'" ';
		    		content3 +='href="${ctx}/product/productInfo.do?pid='+obj.fruitsId+'">';
		    		content3 +='<H2>'+obj.fruitsName+'</H2>';
		    		content3 +='<P></P>';
		    		content3 +='<P class="color_hs">已售出： 0</P>';
		    		content3 +='<H3>';
		    		content3 +='￥<SPAN class="color_yellow">'+fomatNum(obj.price)+'</SPAN>/'+obj.count+obj.unit;
		    		content3 +='<DIV class="clear"></DIV>';
		    		content3 +='</H3>';
		    		content3 +='</A>';
		    		content3 +='</DIV>';
		    		content3 +='</LI>';
		     	}
		    	
		    	//热卖商品
		    	if(obj.columnId==3){
		    		count4++;
			    	content4 +='<DIV id="image_xixi-0'+count4+'" class="items">';
			    	content4 +='<DIV class="items_shows">';
			    	content4 +='<DIV class="ss_hot"></DIV>';
			    	content4 +='<A href="${ctx}/product/productInfo.do?pid='+obj.fruitsId+'">';
			    	content4 +='<IMG src="${ctxStatic}/image/'+obj.picture+'"></A>';
			    	content4 +='</DIV>';
			    	content4 +='<DIV class="word">';
			    	content4 +='<DIV class="word_title">';
			    	content4 +='<H1>';
			    	content4 +='<A title="'+obj.fruitsName+'" ';
			    	content4 +='href="${ctx}/product/productInfo.do?pid='+obj.fruitsId+'">'+obj.fruitsName.substring(0,8)+'...</A>';
			    	content4 +='</H1>';
			    	content4 +='<DIV class="c3"></DIV>';
			    	content4 +='<H2>';
			    	content4 +='￥<SPAN class="color_yellow">'+fomatNum(obj.price)+'</SPAN>/'+obj.count+obj.unit;
			    	content4 +='</H2>';
			    	content4 +='</DIV>';
			    	content4 +='<DIV id="mationword">';
			    	content4 +='<INPUT id="bt_add" class="pro_sub" type="button" pid="607">';
			    	content4 +='</DIV>';
			    	content4 +='</DIV>';
			    	content4 +='</DIV>';
			    }
		    	//进口水果新品推荐
		    	if(obj.columnId==2&&count5<4){
		    		count5++;
		    		content5 +='<LI class="slideshowItem">';
		    		content5 +='<DIV class="LiBlock">';
		    		content5 +='<SPAN class="Span100">';
		    		content5 +='<DIV class="DivCenter">';
		    		content5 +='<A title="'+obj.fruitsName+'" ';
		    		content5 +='href="${ctx}/product/productInfo.do?pid='+obj.fruitsId+'">';
		    		content5 +='<IMG src="${ctxStatic}/image/'+obj.picture+'"></A>';
		    		content5 +='</DIV>';
		    		content5 +='</SPAN><A id="thumb_xixi-01" title="'+obj.fruitsName+'" ';
		    		content5 +='href="${ctx}/product/productInfo.do?pid='+obj.fruitsId+'">';
		    		content5 +='<H2>'+obj.fruitsName+'</H2>';
		    		content5 +='<P></P>';
		    		content5 +='<P class="color_hs">已售出： 0</P>';
		    		content5 +='<H3>';
		    		content5 +='￥<SPAN class="color_yellow">'+fomatNum(obj.price)+'</SPAN>/'+obj.count+obj.unit;
		    		content5 +='<DIV class="clear"></DIV>';
		    		content5 +='</H3>';
		    		content5 +='</A>';
		    		content5 +='</DIV>';
		    		content5 +='</LI>';
		     	}
		 }
		 $("#newsbnner_ul_left").html(content1);
		 $("#newsbnner_ul_right").html(content2);
		 $(".left_showlist").html(content3);
		 $("#featured").append(content4);
		 $(".right_showlist").html(content5);
		}
	});
	
	//保留两位小数
	function fomatNum(num){
		var re;
		if((num+"").indexOf(".")!=-1){
			re = num.toFixed(2);
		}else{
			re = num+".00";
		}
		return re;
	}

})
</script>

<BODY>
<%@ include file="../common/dialog.jsp" %>
	<!--页头 -->
	<DIV class="header">
		<DIV class="header_box">
			<!--页头工具栏 -->
			<DIV class="header_toolbar">
				<H1>
					您好<A href="http://www.qguowang.com/Member/Member_MyOrder.aspx">【huaxwang】</A>【普通会员】
					<EM class="tis_header"><A class="a"
						href="http://www.qguowang.com/Member/Member_Message.aspx">消息0</A></EM>【<A
						id="logout" href="http://www.qguowang.com/logout.aspx">退出登陆</A>】【<A
						href="http://www.qguowang.com/Member/Member_MyOrder.aspx">我的Q果</A>】
				</H1>
				<DIV class="header_toolbar_more">
					<DIV id="ckepop">
						<A class="jiathis_button_qzone"></A><A
							class="jiathis_button_tsina"></A><A class="jiathis_button_tqq"></A><A
							class="jiathis_button_douban"></A><A
							class="jiathis_button_taobao"></A><A
							class="jiathis_counter_style"></A>
					</DIV>
					<SCRIPT type="text/javascript" charset="utf-8"
						src="${ctxStatic}/js/jia.js"></SCRIPT>
					<SPAN><A href="http://www.qguowang.com/Epaper.aspx">订阅电子报</A></SPAN>
				</DIV>
			</DIV>
			<!--页头工具栏 -->
			<DIV class="logo">
				<A href="http://www.qguowang.com/default.aspx"><IMG
					src="${ctxStatic}/image/logo.gif" width="151" height="87"></A>
			</DIV>
			<DIV class="address">
				<H1>武汉</H1>
				<H2>同城配送</H2>
			</DIV>
			<!--导航 -->
			<DIV class="nav">
				<DIV class="nav_title">
					<H1>有机、天然、高品质食品网上超市</H1>
				</DIV>
				<!--list -->
				<DIV class="navigat">
					<UL class="navigat_ul">
						<LI><A href="http://www.qguowang.com/index.aspx">首页</A></LI>
						<LI><A href="${ctx}/fruits/index.do">Q果商城</A></LI>
						<LI><A href="http://www.qguowang.com/cuxiao.aspx">活动促销 </A></LI>
						<LI><A href="http://www.qguowang.com/HotProduct.aspx">排行榜</A></LI>
						<LI><A href="http://www.qguowang.com/FruitEncyclopedia_List.aspx">水果百科</A></LI>
						<LI><A href="http://www.qguowang.com/Integral.aspx">积分商城</A></LI>
						<LI><A href="${ctx}/manager/index.do">水果管理</A></LI>
					</UL>
				</DIV>
				<!--list -->
			</DIV>
			<!--导航 结束-->
			<!--电话 -->
			<DIV class="phoneer">
				<IMG class="phoneindx" src="${ctxStatic}/image/phone.gif"
					width="218" height="52">
					<DIV class="qqwap">
						<IMG id="QQonline" src="${ctxStatic}/image/QQonline.gif">
							<DIV class="qqwap-box">
								<UL>
									<LI><A
										href="http://wpa.qq.com/msgrd?v=3&amp;uin=1730028699&amp;site=qq&amp;menu=yes"
										target="_blank">
											<DIV class="name">客服 1</DIV>
											<IMG title="点击这里给我发消息" border="0" alt="点击这里给我发消息"
											src="${ctxStatic}/image/button_20.gif">
									</A></LI>
									<LI><A
										href="http://wpa.qq.com/msgrd?v=3&amp;uin=2446741845&amp;site=qq&amp;menu=yes"
										target="_blank">
											<DIV class="name">客服 2</DIV>
											<IMG title="点击这里给我发消息" border="0" alt="点击这里给我发消息"
											src="${ctxStatic}/image/button_20(1).gif">
									</A></LI>
									<LI><A
										href="http://wpa.qq.com/msgrd?v=3&amp;uin=1002516841&amp;site=qq&amp;menu=yes"
										target="_blank">
											<DIV class="name">商务合作</DIV>
											<IMG title="点击这里给我发消息" border="0" alt="点击这里给我发消息"
											src="${ctxStatic}/image/button_20(2).gif">
									</A></LI>
									<LI><A
										href="http://wpa.qq.com/msgrd?v=3&amp;uin=273017391&amp;site=qq&amp;menu=yes"
										target="_blank">
											<DIV class="name">技术工程</DIV>
											<IMG title="点击这里给我发消息" border="0" alt="点击这里给我发消息"
											src="${ctxStatic}/image/button_20(3).gif">
									</A></LI>
								</UL>
							</DIV>
					</DIV>
					<DIV class="phoneer_tis">
						<SPAN><A
							href="http://www.qguowang.com/MyOrder/Package.aspx">提货</A></SPAN><SPAN><A
							href="http://www.qguowang.com/Member/Member_CZ.aspx">储值卡充值</A></SPAN><SPAN><A
							href="http://www.qguowang.com/help.aspx?aid=17">帮助 </A></SPAN>
						<DIV></DIV>
					</DIV>
			</DIV>
			<!--电话end -->
		</DIV>
	</DIV>
	<!--页头结束 -->
	<DIV>
		<FORM id="aspnetForm" method="post" name="aspnetForm"
			action="Default.aspx">
			<DIV>
				<INPUT id="__VIEWSTATE" name="__VIEWSTATE"
					value="/wEPDwULLTEyOTE0MTY1ODRkZPrfUqZ0xW674mBkWV1EdliiStkj"
					type="hidden">
			</DIV>
			<!--主体-->
			<DIV class="main">
				<!--=========wrap1 ===========-->
				<DIV class="wrap1">
					<!--产品分类菜单 -->
					<DIV class="mainnav">
						<DIV class="mainnav_title">
							<SPAN>65</SPAN>
							<H1>产品分类</H1>
						</DIV>
						<UL class="mainnav_ul">
						</UL>
					</DIV>
					<!--产品分类菜单结束-->
					<!-- 搜索 购物车 开始 -->
					<DIV class="search_wrad">
						<DIV class="search">
							<DIV class="searchbox">
								<INPUT class="search_text" value="搜索水果" type="text"><INPUT
									class="search_submit" type="submit">
							</DIV>
							<STRONG class="color_hs">热门搜索： </STRONG><A
								href="http://www.qguowang.com/Search.aspx?key=%e6%a8%b1%e6%a1%83">樱桃</A><A
								href="http://www.qguowang.com/Search.aspx?key=%e8%8b%b9%e6%9e%9c">苹果</A><A
								href="http://www.qguowang.com/Search.aspx?key=%e7%8c%95%e7%8c%b4%e6%a1%83">猕猴桃</A><A
								href="http://www.qguowang.com/Search.aspx?key=%e5%93%88%e5%af%86%e7%93%9c">哈密瓜</A>
						</DIV>
						<!--搜索结束 -->
						<!--购物车 -->
						<DIV class="shopping_cart">
							<!--弹出列表 end -->
							<!--弹出列表 end -->
						</DIV>
						<!--购物车 end -->
					</DIV>
					<!-- 搜索 购物车 结束 -->
					<!--焦点图 -->
					<DIV class="scrollbox">
						<DIV id="idTransformView" class="container">
							
						</DIV>
					</DIV>
					<!--焦点图 结束-->
					<!-- 公告 -->
					<DIV class="clear"></DIV>
					<SCRIPT type="text/javascript"
						src="${ctxStatic}/js/jQuery.textSlider.js"></SCRIPT>

					<SCRIPT type="text/javascript">
						$(document).ready(function() {
							$("#sroll").textSlider({
								line : 1,
								speed : 500,
								timer : 5000
							});
						});
					</SCRIPT>

					<DIV class="c10"></DIV>
					<DIV style="color: red;" id="sroll">
						Q果公告：
						<UL>
							<LI><A title="Q果网淘宝店开通广西特产水果专区啦！外地客户可直接邮购！！！"
								href="http://www.qguowang.com/FruitEncyclopedia_Info.aspx?ID=135"
								target="_blank">Q果网淘宝店开通广西特产水果专区啦！外地客户可直接邮购！！！</A></LI>
						</UL>
					</DIV>
					<!-- end 公告 -->
				</DIV>
				<!--=============wrap1 结束================== -->
				<DIV class="c10"></DIV>
				<!--=============wrap2 ================== -->
				<DIV class="wrap2">
					<!--进口水果新品推荐 -->
					<DIV class="newsbanner">
						<DIV class="newsbanner_title">
							<IMG src="${ctxStatic}/image/recotitle.gif" width="200"
								height="30">
						</DIV>
						<DIV class="bannerbox">
							<SPAN><A title="微信扫描" href="http://qguowang.taobao.com/"><IMG
									src="${ctxStatic}/image/GetFiles(10).jpg"></A></SPAN>
						</DIV>
						<UL class="newsbnner_ul" id="newsbnner_ul_left">
						</UL>
					</DIV>
					<!--进口水果新品推荐 结束 -->
					<!--国产水果新品推荐-->
					<DIV class="domesticfruit">
						<DIV class="newsbanner_title">
							<IMG src="${ctxStatic}/image/recotitle2.gif" width="200"
								height="30">
						</DIV>
						<DIV class="bannerbox">
							<SPAN><A title="淘宝店入口" href="http://qguowang.taobao.com/"><IMG
									src="${ctxStatic}/image/GetFiles(13).jpg"></A></SPAN>
						</DIV>
						<UL class="newsbnner_ul" id="newsbnner_ul_right">
						</UL>
					</DIV>
					<!--国产水果新品推荐 结束 -->
				</DIV>
				<!--=============wrap2 结束================== -->
				<DIV class="c10"></DIV>
				<!--=============  广告  ================== -->
				<!--=============  广告 结束  =============== -->
				<!--=============  wrap3  ================== -->
				<DIV class="weap3">
					<!--  小图切换 -->
					<DIV id="thumbs">
						<UL>
							<DIV class="left_showlist">
							</DIV>
							<!-- 大图切换 -->
							<DIV id="featured" class="bigshows">
								<DIV class="ss last btnNext">
									<IMG id="play_next" alt="下一个"
										src="${ctxStatic}/image/right_res.gif" width="10" height="21">
								</DIV>
								<DIV class="ss first btnPrev">
									<IMG id="play_prev" alt="上一个"
										src="${ctxStatic}/image/left_nex.gif" width="10" height="21">
								</DIV>
								
							</DIV>
							<!--featured end-->
							<!-- 大图切换 end -->
							<DIV class="right_showlist">
							</DIV>
						</UL>
					</DIV>
					<!--thumbs end-->
					<!--  小图切换 end -->
				</DIV>
				<!--=============  wrap3 结束================== -->
				<!--=============  wrap4 进口水果================== -->
				<DIV class="weap4">
					<DIV class="jkfruit_title">
						<H1 class="jinkoufruit_h1">进口水果</H1>
						<DIV class="bannerbox">
							<A title="进口水果专区"
								href="http://www.qguowang.com/Search.aspx?cls=3"><IMG
								src="${ctxStatic}/image/GetFiles(28).jpg"?=""></A>
						</DIV>
					</DIV>
					<!-- -->
					<!-- 经过切换 begin -->
					<DIV class="Menubox">
						<SPAN class="more"><A
							href="http://www.qguowang.com/Search.aspx?cls=3" target="_blank">更多</A></SPAN>
						<UL id="rollOne_menu">
							<LI>1</LI>
							<LI>2</LI>
							<LI>3</LI>
						</UL>
					</DIV>
					<DIV class="Contentbox">
						<!-- 1-->
						<DIV id="ListImport_1" class="con_ones">
							<UL class="tab_ul">
								<LI><SPAN class="spanimg"><A
										title="进口新西兰绿心猕猴桃20-24个/盒"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=586"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(29).jpg"></A></SPAN><A
									title="进口新西兰绿心猕猴桃20-24个/盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=586"
									target="_blank">
										<H1>进口新西兰绿心猕猴桃20-24个/盒</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">89.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="新鲜水果 美国油桃5斤 同城配送 水果配送"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=574"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(30).jpg"></A></SPAN><A
									title="新鲜水果 美国油桃5斤 同城配送 水果配送"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=574"
									target="_blank">
										<H1>新鲜水果 美国油桃5斤 同城配送 水果配送</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">108.00</SPAN>/5斤
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="新鲜上市 智利无籽黑提 黑加仑3斤装"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=247"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(31).jpg"></A></SPAN><A
									title="新鲜上市 智利无籽黑提 黑加仑3斤装"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=247"
									target="_blank">
										<H1>新鲜上市 智利无籽黑提 黑加仑3斤装</H1>
										<H2>光亮如漆，皮脆肉厚</H2>
										<H3>
											￥<SPAN class="color_yellow">78.00</SPAN>/3斤
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="海南大贵妃芒果 广西顺丰包邮 10斤装 新鲜海南芒果 清甜贵妃芒"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=606"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(32).jpg"></A></SPAN><A
									title="海南大贵妃芒果 广西顺丰包邮 10斤装 新鲜海南芒果 清甜贵妃芒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=606"
									target="_blank">
										<H1>海南大贵妃芒果 广西顺丰包邮 10斤装 新鲜海南芒果 清甜贵妃芒</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">88.00</SPAN>/10斤
										</H3>
								</A></LI>
							</UL>
							<P class="clear"></P>
						</DIV>
						<!-- end-->
						<!-- 2-->
						<DIV style="display: none;" id="ListImport_2"
							class="con_ones rollOne_img">
							<UL class="tab_ul">
								<LI><SPAN class="spanimg"><A
										title="【Q果网】顺丰包邮 新鲜水果泰国进口金枕头榴莲 进口榴莲 约5斤"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=604"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(33).jpg"></A></SPAN><A
									title="【Q果网】顺丰包邮 新鲜水果泰国进口金枕头榴莲 进口榴莲 约5斤"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=604"
									target="_blank">
										<H1>【Q果网】顺丰包邮 新鲜水果泰国进口金枕头榴莲 进口榴莲 约5斤</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">78.00</SPAN>/个
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="进口黑布林 布朗李 黑李子 3斤"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=356"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(34).jpg"></A></SPAN><A
									title="进口黑布林 布朗李 黑李子 3斤"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=356"
									target="_blank">
										<H1>进口黑布林 布朗李 黑李子 3斤</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">60.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="美国 进口樱桃 车厘子 智利樱桃5斤装"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=119"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(35).jpg"></A></SPAN><A
									title="美国 进口樱桃 车厘子 智利樱桃5斤装"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=119"
									target="_blank">
										<H1>美国 进口樱桃 车厘子 智利樱桃5斤装</H1>
										<H2>进口樱桃 圆润饱满 入口香甜</H2>
										<H3>
											￥<SPAN class="color_yellow">450.00</SPAN>/5斤/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A title="美国进口红蛇果 苹果"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=178"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(36).jpg"></A></SPAN><A
									title="美国进口红蛇果 苹果"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=178"
									target="_blank">
										<H1>美国进口红蛇果 苹果</H1>
										<H2>生津开胃，消痰止咳，退热解毒</H2>
										<H3>
											￥<SPAN class="color_yellow">23.00</SPAN>/份(2个)
										</H3>
								</A></LI>
							</UL>
							<P class="clear"></P>
						</DIV>
						<!-- end-->
						<!-- 3-->
						<DIV style="display: none;" id="ListImport_3"
							class="con_ones rollOne_img">
							<UL class="tab_ul">
								<LI><SPAN class="spanimg"><A title="进口红提 无籽红提 脆甜"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=369"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(37).jpg"></A></SPAN><A
									title="进口红提 无籽红提 脆甜"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=369"
									target="_blank">
										<H1>进口红提 无籽红提 脆甜</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">39.00</SPAN>/1斤
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A title="水果之王|泰国榴莲"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=244"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(38).jpg"></A></SPAN><A
									title="水果之王|泰国榴莲"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=244"
									target="_blank">
										<H1>水果之王|泰国榴莲</H1>
										<H2>营养无敌|水果之王|泰国榴莲</H2>
										<H3>
											￥<SPAN class="color_yellow">138.00</SPAN>/个(3KG)
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="优质越南进口火龙果|红心火龙果15斤"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=112"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(39).jpg"></A></SPAN><A
									title="优质越南进口火龙果|红心火龙果15斤"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=112"
									target="_blank">
										<H1>优质越南进口火龙果|红心火龙果15斤</H1>
										<H2>火龙果，英文Pitaya，本名青龙果、红龙果（个别地称为紫龙果）。</H2>
										<H3>
											￥<SPAN class="color_yellow">248.00</SPAN>/箱（约15斤）
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A title="美国优质西柠 柠檬 黄柠檬"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=140"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(40).jpg"></A></SPAN><A
									title="美国优质西柠 柠檬 黄柠檬"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=140"
									target="_blank">
										<H1>美国优质西柠 柠檬 黄柠檬</H1>
										<H2>鲜美爽口 榨汁 美白</H2>
										<H3>
											￥<SPAN class="color_yellow">5.00</SPAN>/个
										</H3>
								</A></LI>
							</UL>
							<P class="clear"></P>
						</DIV>
						<!-- end-->
					</DIV>
					<!--tab end -->
				</DIV>
				<!--=============  wrap4进口水果 结束================== -->
				<DIV class="c10"></DIV>
				<!--=============  wrap4 国产================== -->
				<DIV class="weap4">
					<DIV class="jkfruit_title">
						<H1 class="jinkoufruit_h1">国产水果</H1>
						<DIV class="bannerbox">
							<A title=" 水果篮" href="http://www.qguowang.com/Search.aspx?cls=4"
								target="_blank"><IMG
								src="${ctxStatic}/image/GetFiles(41).jpg"></A>
						</DIV>
					</DIV>
					<!-- -->
					<!-- 经过切换 begin -->
					<DIV class="Menubox">
						<SPAN class="more"><A
							href="http://www.qguowang.com/Search.aspx?cls=4" target="_blank">更多</A></SPAN>
						<UL id="rollTwo_menu">
							<LI>1</LI>
							<LI>2</LI>
							<LI>3</LI>
						</UL>
					</DIV>
					<DIV class="Contentbox">
						<!-- 1-->
						<DIV id="Listdomestic_1" class="con_ones">
							<UL class="tab_ul">
								<LI><SPAN class="spanimg"><A
										title="香梨 新鲜水果 礼盒包装 水果盒/1500 满100元免运费"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=508"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(42).jpg"></A></SPAN><A
									title="香梨 新鲜水果 礼盒包装 水果盒/1500 满100元免运费"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=508"
									target="_blank">
										<H1>香梨 新鲜水果 礼盒包装 水果盒/1500 满100元免运费</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">35.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="火龙果新鲜水果 白心 南宁本地配送 包装盒装 礼盒 3000g盒/45元"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=507"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(43).jpg"></A></SPAN><A
									title="火龙果新鲜水果 白心 南宁本地配送 包装盒装 礼盒 3000g盒/45元"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=507"
									target="_blank">
										<H1>火龙果新鲜水果 白心 南宁本地配送 包装盒装 礼盒 3000g盒/45元</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">45.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="贡梨新鲜水果 南宁本地配送 水果盒装 礼品盒约3000g/35元"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=506"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(44).jpg"></A></SPAN><A
									title="贡梨新鲜水果 南宁本地配送 水果盒装 礼品盒约3000g/35元"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=506"
									target="_blank">
										<H1>贡梨新鲜水果 南宁本地配送 水果盒装 礼品盒约3000g/35元</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">35.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="Q果网 山东烟台大樱桃 新鲜水果 国产车厘子2大灯笼樱桃 广西区内顺丰包邮"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=603"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(45).jpg"></A></SPAN><A
									title="Q果网 山东烟台大樱桃 新鲜水果 国产车厘子2大灯笼樱桃 广西区内顺丰包邮"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=603"
									target="_blank">
										<H1>Q果网 山东烟台大樱桃 新鲜水果 国产车厘子2大灯笼樱桃 广西区内顺丰包邮</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">98.00</SPAN>/2斤
										</H3>
								</A></LI>
							</UL>
							<P class="clear"></P>
						</DIV>
						<!-- end-->
						<!-- 2-->
						<DIV style="display: none;" id="Listdomestic_2" class="con_ones">
							<UL class="tab_ul">
								<LI><SPAN class="spanimg"><A title="套餐二【适合3人食用】"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=588"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(46).jpg"></A></SPAN><A
									title="套餐二【适合3人食用】"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=588"
									target="_blank">
										<H1>套餐二【适合3人食用】</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">59.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A title="正宗海南青煌芒果 10斤装"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=585"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(47).jpg"></A></SPAN><A
									title="正宗海南青煌芒果 10斤装"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=585"
									target="_blank">
										<H1>正宗海南青煌芒果 10斤装</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">111.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="小凤西瓜35元两个。每个约3斤左右"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=583"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(48).jpg"></A></SPAN><A
									title="小凤西瓜35元两个。每个约3斤左右"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=583"
									target="_blank">
										<H1>小凤西瓜35元两个。每个约3斤左右</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">35.00</SPAN>/2个
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A title="黑美人西瓜 新鲜西瓜 5斤起拍"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=581"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(49).jpg"></A></SPAN><A
									title="黑美人西瓜 新鲜西瓜 5斤起拍"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=581"
									target="_blank">
										<H1>黑美人西瓜 新鲜西瓜 5斤起拍</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">2.30</SPAN>/斤
										</H3>
								</A></LI>
							</UL>
							<P class="clear"></P>
						</DIV>
						<!-- end-->
						<!-- 3-->
						<DIV style="display: none;" id="Listdomestic_3" class="con_ones">
							<UL class="tab_ul">
								<LI><SPAN class="spanimg"><A title="新鲜脐橙 广西桂林夏橙约5斤装"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=582"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(50).jpg"></A></SPAN><A
									title="新鲜脐橙 广西桂林夏橙约5斤装"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=582"
									target="_blank">
										<H1>新鲜脐橙 广西桂林夏橙约5斤装</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">35.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="【Q果网】海南大小台农芒果3斤装 新鲜芒果 小香芒果"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=579"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(51).jpg"></A></SPAN><A
									title="【Q果网】海南大小台农芒果3斤装 新鲜芒果 小香芒果"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=579"
									target="_blank">
										<H1>【Q果网】海南大小台农芒果3斤装 新鲜芒果 小香芒果</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">25.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="热带水果|新鲜广西火山岛香蕉|广西北海涠洲岛香蕉"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=577"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(52).jpg"></A></SPAN><A
									title="热带水果|新鲜广西火山岛香蕉|广西北海涠洲岛香蕉"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=577"
									target="_blank">
										<H1>热带水果|新鲜广西火山岛香蕉|广西北海涠洲岛香蕉</H1>
										<H2>热带水果现货 广西火山岛香蕉 新鲜香蕉 摘新鲜水果</H2>
										<H3>
											￥<SPAN class="color_yellow">88.00</SPAN>/份(5斤)
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="长香玉蜜瓜 新鲜水果1个起拍约4斤左右"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=576"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(53).jpg"></A></SPAN><A
									title="长香玉蜜瓜 新鲜水果1个起拍约4斤左右"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=576"
									target="_blank">
										<H1>长香玉蜜瓜 新鲜水果1个起拍约4斤左右</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">39.00</SPAN>/个
										</H3>
								</A></LI>
							</UL>
							<P class="clear"></P>
						</DIV>
						<!-- end-->
					</DIV>
					<!--tab end -->
				</DIV>
				<!--=============  wrap4国产水果 结束================== -->
				<DIV class="c10"></DIV>
				<!--=============  wrap4 水果礼品================== -->
				<DIV class="weap4">
					<DIV class="jkfruit_title">
						<H1 class="jinkoufruit_h1">有机生鲜</H1>
						<DIV class="bannerbox">
							<A title=" 牛排"
								href="http://www.qguowang.com/Search.aspx?key=%u5957%u9910"
								target="_blank"><IMG
								src="${ctxStatic}/image/GetFiles(54).jpg" width="235"
								height="235"></A>
						</DIV>
					</DIV>
					<!-- -->
					<!-- 经过切换 begin -->
					<DIV class="Menubox">
						<SPAN class="more"><A
							href="http://www.qguowang.com/Search.aspx?cls=7" target="_blank">更多</A></SPAN>
						<UL id="rollThree_menu">
							<LI>1</LI>
							<LI>2</LI>
							<LI>3</LI>
						</UL>
					</DIV>
					<DIV class="Contentbox">
						<!-- 1-->
						<DIV id="Listgift_1" class="con_ones">
							<UL class="tab_ul">
								<LI><SPAN class="spanimg"><A title="科尔沁牛肋条500g"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=551"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(55).jpg"></A></SPAN><A
									title="科尔沁牛肋条500g"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=551"
									target="_blank">
										<H1>科尔沁牛肋条500g</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">128.00</SPAN>/条
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A title="墨西哥牛肉汉堡 200g"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=540"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(56).jpg"></A></SPAN><A
									title="墨西哥牛肉汉堡 200g"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=540"
									target="_blank">
										<H1>墨西哥牛肉汉堡 200g</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">16.00</SPAN>/个
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A title="科尔沁牛肉丸200g/袋"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=534"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(57).jpg"></A></SPAN><A
									title="科尔沁牛肉丸200g/袋"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=534"
									target="_blank">
										<H1>科尔沁牛肉丸200g/袋</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">19.00</SPAN>/袋
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="Q果网-惠宝有机提货 300 07套餐组合"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=465"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(58).jpg"></A></SPAN><A
									title="Q果网-惠宝有机提货 300 07套餐组合"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=465"
									target="_blank">
										<H1>Q果网-惠宝有机提货 300 07套餐组合</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">323.00</SPAN>/盒
										</H3>
								</A></LI>
							</UL>
							<P class="clear"></P>
						</DIV>
						<!-- end-->
						<!-- 2-->
						<DIV style="display: none;" id="Listgift_2" class="con_ones">
							<UL class="tab_ul">
								<LI><SPAN class="spanimg"><A
										title="Q果网-惠宝有机提货 300 06套餐组合"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=464"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(59).jpg"></A></SPAN><A
									title="Q果网-惠宝有机提货 300 06套餐组合"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=464"
									target="_blank">
										<H1>Q果网-惠宝有机提货 300 06套餐组合</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">312.80</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="Q果网-惠宝有机提货 300 05套餐组合"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=463"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(60).jpg"></A></SPAN><A
									title="Q果网-惠宝有机提货 300 05套餐组合"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=463"
									target="_blank">
										<H1>Q果网-惠宝有机提货 300 05套餐组合</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">375.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="Q果网-惠宝有机提货 300 04套餐组合"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=462"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(61).jpg"></A></SPAN><A
									title="Q果网-惠宝有机提货 300 04套餐组合"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=462"
									target="_blank">
										<H1>Q果网-惠宝有机提货 300 04套餐组合</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">315.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="Q果网-惠宝有机提货 300 03套餐组合"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=460"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(62).jpg"></A></SPAN><A
									title="Q果网-惠宝有机提货 300 03套餐组合"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=460"
									target="_blank">
										<H1>Q果网-惠宝有机提货 300 03套餐组合</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">319.00</SPAN>/盒
										</H3>
								</A></LI>
							</UL>
							<P class="clear"></P>
						</DIV>
						<!-- end-->
						<!-- 3-->
						<DIV style="display: none;" id="Listgift_3" class="con_ones">
							<UL class="tab_ul">
								<LI><SPAN class="spanimg"><A
										title="Q果网-惠宝有机提货 300 02套餐组合"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=459"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(63).jpg"></A></SPAN><A
									title="Q果网-惠宝有机提货 300 02套餐组合"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=459"
									target="_blank">
										<H1>Q果网-惠宝有机提货 300 02套餐组合</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">313.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="Q果网-惠宝有机提货 300 01套餐组合"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=458"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(64).jpg"></A></SPAN><A
									title="Q果网-惠宝有机提货 300 01套餐组合"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=458"
									target="_blank">
										<H1>Q果网-惠宝有机提货 300 01套餐组合</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">321.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="牛肉眼1个自然块（约3.5kg左右)"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=453"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(65).jpg"></A></SPAN><A
									title="牛肉眼1个自然块（约3.5kg左右)"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=453"
									target="_blank">
										<H1>牛肉眼1个自然块（约3.5kg左右)</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">360.50</SPAN>/袋
										</H3>
								</A></LI>
								<LI><SPAN class="spanimg"><A
										title="有机羊前腿1个{1.5kg左右}"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=450"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(66).jpg"></A></SPAN><A
									title="有机羊前腿1个{1.5kg左右}"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=450"
									target="_blank">
										<H1>有机羊前腿1个{1.5kg左右}</H1>
										<H2 class="h22"></H2>
										<H3>
											￥<SPAN class="color_yellow">256.00</SPAN>/个
										</H3>
								</A></LI>
							</UL>
							<P class="clear"></P>
						</DIV>
						<!-- end-->
					</DIV>
					<!--tab end -->
				</DIV>
				<!--=============  wrap4水果礼品 结束================== -->
				<DIV class="c10"></DIV>
				<!--=============  wrap5进口水果================== -->
				<DIV class="wrap5">
					<!-- 点击切换 begin -->
					<DIV class="Menuboxjk">
						<H1 class="Menuboxjk_h1">礼品专区</H1>
						<UL id="ClassImport">
							<LI>水果礼盒</LI>
							<LI>特色礼盒</LI>
							<LI>储值卡</LI>
							<LI>合浦裕华月饼</LI>
						</UL>
					</DIV>
					<DIV class="jkContentbox">
						<DIV id="con_jkone_0" class="con_ones">
							<UL class="jkone_ul">
								<LI><SPAN class="Span110"><A
										title="香梨 新鲜水果 礼盒包装 水果盒/1500 满100元免运费"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=508"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(67).jpg"></A></SPAN><A
									title="香梨 新鲜水果 礼盒包装 水果盒/1500 满100元免运费"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=508"
									target="_blank"></A><A title="香梨 新鲜水果 礼盒包装 水果盒/1500 满100元免运费"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=508"
									target="_blank">
										<H1>香梨 新鲜水果 礼...</H1>
										<H3>
											￥<SPAN class="color_yellow">35.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A
										title="火龙果新鲜水果 白心 南宁本地配送 包装盒装 礼盒 3000g盒/45元"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=507"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(68).jpg"></A></SPAN><A
									title="火龙果新鲜水果 白心 南宁本地配送 包装盒装 礼盒 3000g盒/45元"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=507"
									target="_blank"></A><A
									title="火龙果新鲜水果 白心 南宁本地配送 包装盒装 礼盒 3000g盒/45元"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=507"
									target="_blank">
										<H1>火龙果新鲜水果 白...</H1>
										<H3>
											￥<SPAN class="color_yellow">45.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A
										title="贡梨新鲜水果 南宁本地配送 水果盒装 礼品盒约3000g/35元"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=506"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(69).jpg"></A></SPAN><A
									title="贡梨新鲜水果 南宁本地配送 水果盒装 礼品盒约3000g/35元"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=506"
									target="_blank"></A><A title="贡梨新鲜水果 南宁本地配送 水果盒装 礼品盒约3000g/35元"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=506"
									target="_blank">
										<H1>贡梨新鲜水果 南宁...</H1>
										<H3>
											￥<SPAN class="color_yellow">35.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A title="Q果网推荐 Q3礼盒 "
										href="http://www.qguowang.com/ProductInfo.aspx?pid=194"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(70).jpg"></A></SPAN><A
									title="Q果网推荐 Q3礼盒 "
									href="http://www.qguowang.com/ProductInfo.aspx?pid=194"
									target="_blank"></A><A title="Q果网推荐 Q3礼盒 "
									href="http://www.qguowang.com/ProductInfo.aspx?pid=194"
									target="_blank">
										<H1>Q果网推荐 Q3礼...</H1>
										<H3>
											￥<SPAN class="color_yellow">298.00</SPAN>/盒
										</H3>
								</A></LI>
							</UL>
							<!-- -->
							<DIV class="jkscroll">
								<!--焦点图 -->
								<DIV id="tab" class="jkscrollbox">
									<DIV class="panes">
										<!--内容1 -->
										<DIV class="pane">
											<P>
												<A title="Q果网 海南三亚贵妃芒果 热带新鲜水果约5斤装"
													href="http://www.qguowang.com/ProductInfo.aspx?pid=602"
													target="_blank"><IMG
													src="${ctxStatic}/image/GetFiles(71).jpg"></A>
											</P>
											<DIV class="c5"></DIV>
											<A title="Q果网 海南三亚贵妃芒果 热带新鲜水果约5斤装"
												href="http://www.qguowang.com/ProductInfo.aspx?pid=602"
												target="_blank">
												<H1 class="font_gre">Q果网 海南三亚贵妃芒果 热带新鲜水果约5斤装/盒</H1>
												<H3>
													￥<SPAN class="color_yellow">69.00</SPAN>/盒
												</H3>
											</A>
										</DIV>
										<!--内容1 end -->
										<!--内容1 -->
										<DIV class="pane">
											<P>
												<A title="会议用果 单位会议 水果定制 接待水果"
													href="http://www.qguowang.com/ProductInfo.aspx?pid=514"
													target="_blank"><IMG
													src="${ctxStatic}/image/GetFiles(72).jpg"></A>
											</P>
											<DIV class="c5"></DIV>
											<A title="会议用果 单位会议 水果定制 接待水果"
												href="http://www.qguowang.com/ProductInfo.aspx?pid=514"
												target="_blank">
												<H1 class="font_gre">会议用果 单位会议 水果定制 接待水果/个</H1>
												<H3>
													￥<SPAN class="color_yellow">1.00</SPAN>/个
												</H3>
											</A>
										</DIV>
										<!--内容1 end -->
										<!--内容1 -->
										<DIV class="pane">
											<P>
												<A title="南宁本地配送 香蕉/新鲜水果 盒装 满100元免运费 鲜果"
													href="http://www.qguowang.com/ProductInfo.aspx?pid=511"
													target="_blank"><IMG
													src="${ctxStatic}/image/GetFiles(73).jpg"></A>
											</P>
											<DIV class="c5"></DIV>
											<A title="南宁本地配送 香蕉/新鲜水果 盒装 满100元免运费 鲜果"
												href="http://www.qguowang.com/ProductInfo.aspx?pid=511"
												target="_blank">
												<H1 class="font_gre">南宁本地配送 香蕉/新鲜水果 盒装 满100元免运费 鲜果/盒</H1>
												<H3>
													￥<SPAN class="color_yellow">30.00</SPAN>/盒
												</H3>
											</A>
										</DIV>
										<!--内容1 end -->
									</DIV>
									<!--菜单 -->
									<DIV class="title_taochan">
										<UL class="tags">
											<LI></LI>
											<LI></LI>
											<LI></LI>
										</UL>
									</DIV>
									<!--菜单 -->
								</DIV>
								<!--焦点图 -->
							</DIV>
							<!-- -->
							<UL class="jkone_ul">
								<LI><SPAN class="Span110"><A
										title="Q果鲜果园-B礼盒 原价218元"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=192"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(74).jpg"></A></SPAN><A
									title="Q果鲜果园-B礼盒 原价218元"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=192"
									target="_blank">
										<H1>Q果鲜果园-B礼盒...</H1>
										<H3>
											￥<SPAN class="color_yellow">218.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A title="特优A礼盒 "
										href="http://www.qguowang.com/ProductInfo.aspx?pid=190"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(75).jpg"></A></SPAN><A
									title="特优A礼盒 "
									href="http://www.qguowang.com/ProductInfo.aspx?pid=190"
									target="_blank">
										<H1>特优A礼盒</H1>
										<H3>
											￥<SPAN class="color_yellow">108.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A
										title="客户定制礼盒|南宁春节送礼佳品|南宁水果礼盒|南宁食品礼盒"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=167"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(76).jpg"></A></SPAN><A
									title="客户定制礼盒|南宁春节送礼佳品|南宁水果礼盒|南宁食品礼盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=167"
									target="_blank">
										<H1>客户定制礼盒|南宁...</H1>
										<H3>
											￥<SPAN class="color_yellow">196.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A title="朗月香果-B礼盒"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=277"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(77).jpg"></A></SPAN><A
									title="朗月香果-B礼盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=277"
									target="_blank">
										<H1>朗月香果-B礼盒</H1>
										<H3>
											￥<SPAN class="color_yellow">158.00</SPAN>/盒
										</H3>
								</A></LI>
							</UL>
							<!-- end-->
							<P class="clear"></P>
						</DIV>
						<DIV style="display: none;" id="con_jkone_1" class="con_ones">
							<UL class="jkone_ul">
								<LI><SPAN class="Span110"><A
										title="西伯路2008希拉子干红葡萄酒 珍藏版"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=89"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(78).jpg"></A></SPAN><A
									title="西伯路2008希拉子干红葡萄酒 珍藏版"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=89"
									target="_blank"></A><A title="西伯路2008希拉子干红葡萄酒 珍藏版"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=89"
									target="_blank">
										<H1>西伯路2008希拉...</H1>
										<H3>
											￥<SPAN class="color_yellow">488.00</SPAN>/瓶
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A
										title="金秋硕果1015/特优水果礼盒/中秋礼盒/员工福利果盒"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=400"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(79).jpg"></A></SPAN><A
									title="金秋硕果1015/特优水果礼盒/中秋礼盒/员工福利果盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=400"
									target="_blank"></A><A title="金秋硕果1015/特优水果礼盒/中秋礼盒/员工福利果盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=400"
									target="_blank">
										<H1>金秋硕果1015/...</H1>
										<H3>
											￥<SPAN class="color_yellow">168.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A
										title="金秋硕果1014/特优水果礼盒/中秋礼盒/员工福利果盒"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=399"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(80).jpg"></A></SPAN><A
									title="金秋硕果1014/特优水果礼盒/中秋礼盒/员工福利果盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=399"
									target="_blank"></A><A title="金秋硕果1014/特优水果礼盒/中秋礼盒/员工福利果盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=399"
									target="_blank">
										<H1>金秋硕果1014/...</H1>
										<H3>
											￥<SPAN class="color_yellow">178.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A
										title="金秋硕果1013/特优水果礼盒/中秋礼盒/员工福利果盒"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=398"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(81).jpg"></A></SPAN><A
									title="金秋硕果1013/特优水果礼盒/中秋礼盒/员工福利果盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=398"
									target="_blank"></A><A title="金秋硕果1013/特优水果礼盒/中秋礼盒/员工福利果盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=398"
									target="_blank">
										<H1>金秋硕果1013/...</H1>
										<H3>
											￥<SPAN class="color_yellow">128.00</SPAN>/盒
										</H3>
								</A></LI>
							</UL>
							<!-- -->
							<DIV class="jkscroll">
								<!--焦点图 -->
								<DIV id="tab" class="jkscrollbox">
									<DIV class="panes">
										<!--内容1 -->
										<DIV class="pane">
											<P>
												<A title="会议用果 单位会议 水果定制 接待水果"
													href="http://www.qguowang.com/ProductInfo.aspx?pid=514"
													target="_blank"><IMG
													src="${ctxStatic}/image/GetFiles(72).jpg"></A>
											</P>
											<DIV class="c5"></DIV>
											<A title="会议用果 单位会议 水果定制 接待水果"
												href="http://www.qguowang.com/ProductInfo.aspx?pid=514"
												target="_blank">
												<H1 class="font_gre">会议用果 单位会议 水果定制 接待水果/个</H1>
												<H3>
													￥<SPAN class="color_yellow">1.00</SPAN>/个
												</H3>
											</A>
										</DIV>
										<!--内容1 end -->
										<!--内容1 -->
										<DIV class="pane">
											<P>
												<A title="客户定制礼盒|南宁春节送礼佳品|南宁水果礼盒|南宁食品礼盒"
													href="http://www.qguowang.com/ProductInfo.aspx?pid=167"
													target="_blank"><IMG
													src="${ctxStatic}/image/GetFiles(82).jpg"></A>
											</P>
											<DIV class="c5"></DIV>
											<A title="客户定制礼盒|南宁春节送礼佳品|南宁水果礼盒|南宁食品礼盒"
												href="http://www.qguowang.com/ProductInfo.aspx?pid=167"
												target="_blank">
												<H1 class="font_gre">客户定制礼盒|南宁春节送礼佳品|南宁水果礼盒|南宁食品礼盒/盒</H1>
												<H3>
													￥<SPAN class="color_yellow">196.00</SPAN>/盒
												</H3>
											</A>
										</DIV>
										<!--内容1 end -->
										<!--内容1 -->
										<DIV class="pane">
											<P>
												<A title="年货礼盒|广西龙眼肉|桂圆干|龙眼干 350g/盒"
													href="http://www.qguowang.com/ProductInfo.aspx?pid=348"
													target="_blank"><IMG
													src="${ctxStatic}/image/GetFiles(83).jpg"></A>
											</P>
											<DIV class="c5"></DIV>
											<A title="年货礼盒|广西龙眼肉|桂圆干|龙眼干 350g/盒"
												href="http://www.qguowang.com/ProductInfo.aspx?pid=348"
												target="_blank">
												<H1 class="font_gre">年货礼盒|广西龙眼肉|桂圆干|龙眼干 350g/盒/盒(350g)</H1>
												<H3>
													￥<SPAN class="color_yellow">50.00</SPAN>/盒(350g)
												</H3>
											</A>
										</DIV>
										<!--内容1 end -->
									</DIV>
									<!--菜单 -->
									<DIV class="title_taochan">
										<UL class="tags">
											<LI></LI>
											<LI></LI>
											<LI></LI>
										</UL>
									</DIV>
									<!--菜单 -->
								</DIV>
								<!--焦点图 -->
							</DIV>
							<!-- -->
							<UL class="jkone_ul">
								<LI><SPAN class="Span110"><A
										title="金秋硕果1012/特优水果礼盒/中秋礼盒/员工福利果盒"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=397"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(84).jpg"></A></SPAN><A
									title="金秋硕果1012/特优水果礼盒/中秋礼盒/员工福利果盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=397"
									target="_blank">
										<H1>金秋硕果1012/...</H1>
										<H3>
											￥<SPAN class="color_yellow">118.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A
										title="金秋硕果1011/特优水果礼盒/中秋礼盒/员工福利果盒"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=396"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(85).jpg"></A></SPAN><A
									title="金秋硕果1011/特优水果礼盒/中秋礼盒/员工福利果盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=396"
									target="_blank">
										<H1>金秋硕果1011/...</H1>
										<H3>
											￥<SPAN class="color_yellow">108.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A
										title="金秋硕果1010/特优水果礼盒/中秋礼盒/员工福利果盒"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=395"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(86).jpg"></A></SPAN><A
									title="金秋硕果1010/特优水果礼盒/中秋礼盒/员工福利果盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=395"
									target="_blank">
										<H1>金秋硕果1010/...</H1>
										<H3>
											￥<SPAN class="color_yellow">148.00</SPAN>/盒
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A
										title="金秋硕果1009/特优水果礼盒/中秋礼盒/员工福利果盒"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=394"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(87).jpg"></A></SPAN><A
									title="金秋硕果1009/特优水果礼盒/中秋礼盒/员工福利果盒"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=394"
									target="_blank">
										<H1>金秋硕果1009/...</H1>
										<H3>
											￥<SPAN class="color_yellow">138.00</SPAN>/盒
										</H3>
								</A></LI>
							</UL>
							<!-- end-->
							<P class="clear"></P>
						</DIV>
						<DIV style="display: none;" id="con_jkone_2" class="con_ones">
							<UL class="jkone_ul">
								<LI><SPAN class="Span110"><A title="200元Q果网储值卡"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=171"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(88).jpg"></A></SPAN><A
									title="200元Q果网储值卡"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=171"
									target="_blank"></A><A title="200元Q果网储值卡"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=171"
									target="_blank">
										<H1>200元Q果网储值...</H1>
										<H3>
											￥<SPAN class="color_yellow">200.00</SPAN>/张
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A
										title="1000元惠宝有机生活卡  储值卡"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=501"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(89).jpg"></A></SPAN><A
									title="1000元惠宝有机生活卡  储值卡"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=501"
									target="_blank"></A><A title="1000元惠宝有机生活卡  储值卡"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=501"
									target="_blank">
										<H1>1000元惠宝有机...</H1>
										<H3>
											￥<SPAN class="color_yellow">1000.00</SPAN>/张
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A
										title="500元惠宝有机储存卡  储值卡"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=500"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(90).jpg"></A></SPAN><A
									title="500元惠宝有机储存卡  储值卡"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=500"
									target="_blank"></A><A title="500元惠宝有机储存卡  储值卡"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=500"
									target="_blank">
										<H1>500元惠宝有机储...</H1>
										<H3>
											￥<SPAN class="color_yellow">500.00</SPAN>/张
										</H3>
								</A></LI>
								<LI><SPAN class="Span110"><A
										title="300元惠宝有机生活卡  储值卡"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=499"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(91).jpg"></A></SPAN><A
									title="300元惠宝有机生活卡  储值卡"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=499"
									target="_blank"></A><A title="300元惠宝有机生活卡  储值卡"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=499"
									target="_blank">
										<H1>300元惠宝有机生...</H1>
										<H3>
											￥<SPAN class="color_yellow">300.00</SPAN>/张
										</H3>
								</A></LI>
							</UL>
							<!-- -->
							<DIV class="jkscroll">
								<!--焦点图 -->
								<DIV id="tab" class="jkscrollbox">
									<DIV class="panes">
										<!--内容1 -->
										<DIV class="pane">
											<P>
												<A title="1000元Q果网储值卡"
													href="http://www.qguowang.com/ProductInfo.aspx?pid=174"
													target="_blank"><IMG
													src="${ctxStatic}/image/GetFiles(92).jpg"></A>
											</P>
											<DIV class="c5"></DIV>
											<A title="1000元Q果网储值卡"
												href="http://www.qguowang.com/ProductInfo.aspx?pid=174"
												target="_blank">
												<H1 class="font_gre">1000元Q果网储值卡/张</H1>
												<H3>
													￥<SPAN class="color_yellow">1000.00</SPAN>/张
												</H3>
											</A>
										</DIV>
										<!--内容1 end -->
										<!--内容1 -->
										<DIV class="pane">
											<P>
												<A title="500元Q果网储值卡"
													href="http://www.qguowang.com/ProductInfo.aspx?pid=173"
													target="_blank"><IMG
													src="${ctxStatic}/image/GetFiles(93).jpg"></A>
											</P>
											<DIV class="c5"></DIV>
											<A title="500元Q果网储值卡"
												href="http://www.qguowang.com/ProductInfo.aspx?pid=173"
												target="_blank">
												<H1 class="font_gre">500元Q果网储值卡/张</H1>
												<H3>
													￥<SPAN class="color_yellow">500.00</SPAN>/张
												</H3>
											</A>
										</DIV>
										<!--内容1 end -->
										<!--内容1 -->
										<DIV class="pane">
											<P>
												<A title="100元Q果网储值卡"
													href="http://www.qguowang.com/ProductInfo.aspx?pid=172"
													target="_blank"><IMG
													src="${ctxStatic}/image/GetFiles(94).jpg"></A>
											</P>
											<DIV class="c5"></DIV>
											<A title="100元Q果网储值卡"
												href="http://www.qguowang.com/ProductInfo.aspx?pid=172"
												target="_blank">
												<H1 class="font_gre">100元Q果网储值卡/张</H1>
												<H3>
													￥<SPAN class="color_yellow">100.00</SPAN>/张
												</H3>
											</A>
										</DIV>
										<!--内容1 end -->
									</DIV>
									<!--菜单 -->
									<DIV class="title_taochan">
										<UL class="tags">
											<LI></LI>
											<LI></LI>
											<LI></LI>
										</UL>
									</DIV>
									<!--菜单 -->
								</DIV>
								<!--焦点图 -->
							</DIV>
							<!-- -->
							<UL class="jkone_ul">
								<LI><SPAN class="Span110"><A
										title="200元惠宝有机生活卡  储值卡"
										href="http://www.qguowang.com/ProductInfo.aspx?pid=498"
										target="_blank"><IMG
											src="${ctxStatic}/image/GetFiles(95).jpg"></A></SPAN><A
									title="200元惠宝有机生活卡  储值卡"
									href="http://www.qguowang.com/ProductInfo.aspx?pid=498"
									target="_blank">
										<H1>200元惠宝有机生...</H1>
										<H3>
											￥<SPAN class="color_yellow">200.00</SPAN>/张
										</H3>
								</A></LI>
							</UL>
							<!-- end-->
							<P class="clear"></P>
						</DIV>
						<DIV style="display: none;" id="con_jkone_3" class="con_ones">
							<UL class="jkone_ul"></UL>
							<!-- -->
							<DIV class="jkscroll">
								<!--焦点图 -->
								<DIV id="tab" class="jkscrollbox">
									<DIV class="panes"></DIV>
									<!--菜单 -->
									<DIV class="title_taochan">
										<UL class="tags"></UL>
									</DIV>
									<!--菜单 -->
								</DIV>
								<!--焦点图 -->
							</DIV>
							<!-- -->
							<UL class="jkone_ul"></UL>
							<!-- end-->
							<P class="clear"></P>
						</DIV>
					</DIV>
					<!--tab end -->
				</DIV>
				<!--=============  wrap5进口水果================== -->
				<DIV class="c10"></DIV>
				<DIV class="link">
					<DIV class="link_title">
						<DIV id="Link_Str">友情链接</DIV>
					</DIV>
					<DIV class="link_Con">
						<UL>
							<LI><A title="Q果网淘宝店铺" href="http://qguowang.taobao.com/"
								target="_blank"><IMG
									src="${ctxStatic}/image/GetFiles(96).jpg"></A></LI>
							<LI><A title="印象幼儿园" href="http://www.kidshow.com.cn/"
								target="_blank"><IMG
									src="${ctxStatic}/image/GetFiles(97).jpg"></A></LI>
							<LI><A title="南宁iPhone手机维修"
								href="http://www.jinggongweixiu.com/" target="_blank"><IMG
									src="${ctxStatic}/image/GetFiles(98).jpg"></A></LI>
							<LI><A title="南宁水果网" href="http://www.qguowang.com/"
								target="_blank"><IMG
									src="${ctxStatic}/image/GetFiles(99).jpg"></A></LI>
							<LI><A title="栖霞苹果" href="http://www.apple0535.com/"
								target="_blank"><IMG
									src="${ctxStatic}/image/GetFiles(100).jpg"></A></LI>
							<LI><A title="烟台大樱桃" href="http://www.dayingtao.org/"
								target="_blank"><IMG
									src="${ctxStatic}/image/GetFiles(101).jpg"></A></LI>
							<LI><A title="陕西苹果" href="http://www.guonongwang.com/"
								target="_blank"><IMG
									src="${ctxStatic}/image/GetFilesCA4JG6NT.jpg"></A></LI>
							<LI><A title="葡萄苗" href="http://www.yiminxin.com/"
								target="_blank"><IMG
									src="${ctxStatic}/image/GetFiles(102).jpg"></A></LI>
							<DIV class="c10"></DIV>
						</UL>
					</DIV>
				</DIV>
			</DIV>
			<!--主体结束 -->
		</FORM>
	</DIV>
	<!--服务 -->
	<DIV class="servicer">
		<UL>
			<LI><IMG src="${ctxStatic}/image/tutorial01.gif" width="80"
				height="70">
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=14">新会员注册</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=6">订购方式</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=4">在线订购流程</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=31">单位团购</A>
					</H1></LI>
			<LI><IMG src="${ctxStatic}/image/tutorial02.gif" width="80"
				height="70">
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=10">网银在线支付</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=27">在线支付</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=26">货到付款</A>
					</H1></LI>
			<LI><IMG src="${ctxStatic}/image/tutorial03.gif" width="80"
				height="70">
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=7">配送范围</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=15">配送时间</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=8">配送费用</A>
					</H1></LI>
			<LI><IMG src="${ctxStatic}/image/tutorial04.gif" width="80"
				height="70">
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=12">投诉建议</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=16">退换货政策</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=11">退换货流程</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=32">企业年货</A>
					</H1></LI>
			<LI><IMG src="${ctxStatic}/image/tutorial05.gif" width="80"
				height="70">
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=3">充值说明</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=2">积分说明</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=1">Q果卡类说明</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=30">提货卡说明</A>
					</H1></LI>
			<LI><IMG src="${ctxStatic}/image/tutorial06.gif" width="80"
				height="70">
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=17">常见问题</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=24">鲜果预定说明</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=29">发票说明</A>
					</H1>
					<H1>
						<A href="http://www.qguowang.com/help.aspx?aid=33">私人定制服务</A>
					</H1></LI>
			<DIV class="c10"></DIV>
		</UL>
	</DIV>
	<!--服务 结束 -->
	<!--页脚 -->
	<LINK rel="stylesheet" type="text/css"
		href="${ctxStatic}/css/style.css">
		<DIV class="footer">
			<P>
				<IMG alt="" src="${ctxStatic}/image/telephone.gif" width="400"
					height="35">
			</P>
			<P>周一至周五：08:00-22:00 周六至周日：08:30-22:30</P>
			<P>
				<DIV>
					<A href="http://www.qguowang.com/help.aspx?aid=19" target="_blank">关于Q果</A>|
					<A href="http://www.qguowang.com/help.aspx?aid=20" target="_blank">会员章程</A>|
					<A href="http://www.qguowang.com/help.aspx?aid=23" target="_blank">联系Q果</A>|
					<A href="http://www.qguowang.com/help.aspx?aid=28" target="_blank">诚聘英才</A>|
					<A href="http://www.qguowang.com/Supplier.aspx" target="_blank">商家入驻</A>
				</DIV>
				<P></P>
				<BR>
					<P>
						<A href="http://www.qguowang.com/Default.aspx#"><IMG
							class="imgHeigth43" src="${ctxStatic}/image/aq_1.gif"></A><A
							href="http://www.qguowang.com/Default.aspx#"><IMG
							class="imgHeigth43" src="${ctxStatic}/image/aq_2.gif"></A><A
							href="http://www.qguowang.com/Default.aspx#"><IMG
							class="imgHeigth43" src="${ctxStatic}/image/aq_3.png"></A><A
							href="http://www.qguowang.com/Default.aspx#"><IMG
							class="imgHeigth43" src="${ctxStatic}/image/aq_4.png"></A><A
							href="http://www.qguowang.com/Default.aspx#"><IMG
							class="imgHeigth43" src="${ctxStatic}/image/aq_5.gif"></A>
					</P>
					<DIV class="h10"></DIV>
					<P>COPYRIGHT 2012 QGUOWANG.COM ALL RIGHTS RESERVED. Powered by
						qguowang.com 桂ICP备11003428号-2</P>
					<P>
						<SCRIPT type="text/javascript">
							var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://"
									: " http://");
							document
									.write(unescape("%3Cscript src='"
											+ _bdhmProtocol
											+ "hm.baidu.com/h.js%3Fa4e9147df8eaec7cfdeb3b324f35f68d' type='text/javascript'%3E%3C/script%3E"));
						</SCRIPT>

						<SCRIPT language="JavaScript" src="${ctxStatic}/js/stat.js"></SCRIPT>
						<A href="http://www.anquan.org/s/www.qguowang.com"
							name="n6YNdrj7pqAYFrYTygUE38Efl7YMIeRm1BtNWXl1XBJPiSbg14">安全联盟</A>
					</P>
		</DIV>
	<!--页脚 结束-->
	<!-- Baidu Button BEGIN -->
	<SCRIPT id="bdshare_js" type="text/javascript"
		data="type=slide&amp;img=1"></SCRIPT>

	<SCRIPT id="bdshell_js" type="text/javascript"></SCRIPT>

	<SCRIPT type="text/javascript">
		document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion="
				+ new Date().getHours();
	</SCRIPT>
	<!-- Baidu Button END -->
</BODY>
</HTML>
