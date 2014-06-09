///<reference path="jquery-1.3.2-vsdoc2.js"/>
var ClearCache = function () {
    $.ajaxSetup({
        cache: false //关闭AJAX相应的缓存 
    });
}
$(function () {
    ClearCache();
    ShowCart();
    LocalUrl();
    var bk_text = "文章搜索";
    $(".search_submit").click(function () {
        var srearch = $(".search_text").val();
        if (srearch == "" || srearch == '搜索水果') {
            alert('请输入关键字！');
        } else {
            location.href = "/Search.aspx?key=" + escape(srearch);
        }
        return false;
    });

    $('.search_text').focus(function () {
        if ($(this).val() == '搜索水果') {
            $(this).val('');
        }
    });

    $('.search_text').blur(function () {
        if ($(this).val() == '') {
            $(this).val('搜索水果');
        }
    });

    $("#bk_submit").click(function () {
        var bk_srearch = $("#bk_text").val();
        if (bk_srearch == "" || bk_srearch == bk_text) {
            alert('请输入关键字！');
        } else {
            location.href = "/FruitEncyclopedia_List.aspx?key=" + escape(bk_srearch);
        }
        return false;
    });
    $('#bk_text').focus(function () {
        if ($(this).val() == bk_text) {
            $(this).val('');
        }
    });

    $('#bk_text').blur(function () {
        if ($(this).val() == '') {
            $(this).val(bk_text);
        }
    });

    $("#logout").click(function () {
        if (confirm("你确定注销吗?")) {
            return true;
        } else {
            return false;
        }
    });

    $("#QQonline").mouseenter(function () {
        $(this).animate({ opacity: 0.3 }, 300);
        $(this).siblings(".qqwap-box").slideDown(300);
    });
    $(".qqwap").mouseleave(function () {
        $(this).children('.qqwap-box').slideUp(300);
        $("#QQonline").animate({ opacity: 1 }, 300);
    });

    $("#ArtClose").live('click', function () {
        var list = art.dialog.list;
        for (var i in list) {
            list[i].close();
        };
    });
});
var ADD_card = function (pid, count) {
    $.ajax({

        type: "POST",
        async: false,
        url: "/Ajax.ashx",
        data: "action=AddCard&pid=" + pid + "&count=" + count,
        success: function (data) {
            ComResultpro(data);
        }
    });
}
var vili_match = function (str) {
    //定义正则表达式部分
    var reg = /^[1-9]\d*$/;
    return reg.test(str);
}
var GetStr = function (str) {
    var Div = '<ul class="artUL"><li>';
    Div += str + "</li>";
    Div += '<li><a href="/MyOrder/cart.aspx" target="_blank"><img src="/res/images/jiesuan.gif" /></a>';
    Div += '<img src="/res/images/jixu.jpg"  id="ArtClose"/></li>';
    Div += '</ul>';
    return Div;
}
var ComResultpro = function (com) {
    switch (com) {
        case 'insert':
            ShowCart();
            art.dialog({
                id: 'show',
                icon: 'QGW',
                width: '220px',
                content:GetStr('成功添加到购物车!'),
                close: true
            });
            break;
        case 'update':
            ShowCart();
            art.dialog({
                id: 'show',
                icon: 'QGW',
                width: '220px',
                content: GetStr('成功更新购物车商品!'),
                close: true
            });
            break;
        case 'false':
            art.dialog({
                id: 'show',
                icon: 'face-sad',
                width: '300px',
                content: '添加失败，请重试!'
            });
            break;
        case 'notlogin':
            var login = "不能进行此次操作,请<a href='/login.aspx'>【登录】</a>,还没有账号的现在就去<a href='/register.aspx'>【注册】</a>吧";
            art.dialog({
                id: 'show',
                icon: 'face-sad',
                width: '300px',
                content: login
            });
            break;

        default:
            art.dialog({
                id: 'show',
                icon: 'error',
                width: '300px',
                content: '添加失败!!'
            });
            break;
    }
}
var LocalUrl = function () {

    if (location.href.indexOf('index.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(0).attr('id', 'navhover');
        $(".servicer,.footer").hide();
        return;
    }
    if (location.href.indexOf('Default.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(1).attr('id', 'navhover');
        return;
    }
    if (location.href.indexOf('Search.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(1).attr('id', 'navhover');
        return;
    }
    if (location.href.indexOf('ProductInfo.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(1).attr('id', 'navhover');
        return;
    }
    if (location.href.indexOf('cuxiao.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(2).attr('id', 'navhover');
        return;
    }
    if (location.href.indexOf('XSQG.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(2).attr('id', 'navhover');
        return;
    }
    if (location.href.indexOf('HotProduct.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(3).attr('id', 'navhover');
        return;
    }
    if (location.href.indexOf('FruitEncyclopedia_List.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(4).attr('id', 'navhover');
        return;
    }
    if (location.href.indexOf('FruitEncyclopedia_info.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(4).attr('id', 'navhover');
        return;
    }
    if (location.href.indexOf('TitleList.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(4).attr('id', 'navhover');
        return;
    }
    if (location.href.indexOf('Epaper.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '');
        return;
    }
    if (location.href.indexOf('Integral.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(5).attr('id', 'navhover');
        return;
    }
    if (location.href.indexOf('IntegralProduct.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(5).attr('id', 'navhover');
        return;
    }
    if (location.href.indexOf('CuXiao_Info.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '').eq(2).attr('id', 'navhover');
        return;
    }
    if (location.href.indexOf('help.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '');
        return;
    }
    if (location.href.indexOf('Epaper.aspx') > 0) {
        $(".navigat_ul>li").children('a').attr('id', '');
        return;
    }
    $(".navigat_ul>li").children('a').attr('id', '').eq(1).attr('id', 'navhover');
    if ($(".indexsubbj").size() > 0) {
        $(".servicer,.footer").hide();
    }
    return;
}

var ShowCart = function () {
    $(".shopping_cart").load('/MyOrder/ShoppingCart.aspx', null, function () {

        $("[id^='pro_delete']").each(function () {
            $(this).click(function () {

                var pid = $(this).attr('pid');
                var $this = $(this).parent('li');
                art.dialog({
                    content: '确定删除吗?',
                    width: '300px',
                    ok: function () {

                        $.ajax({

                            type: "POST",
                            async: false,
                            url: "/Ajax.ashx",
                            data: "action=deletePro&pid=" + pid,
                            success: function (data) {
                                if (data == "error") {
                                    art.dialog({
                                        icon: 'warning',
                                        content: '购物车没有该商品',
                                        ok: true
                                    });
                                }
                                if (data == "true") {
                                    ShowCart();
                                    art.dialog({
                                        icon: 'succeed',
                                        content: '删除成功!',
                                        ok: true
                                    });

                                } else {
                                    art.dialog({
                                        icon: 'error',
                                        content: '删除失败!',
                                        ok: true
                                    });
                                }
                            }
                        });
                    },
                    cancelVal: '关闭',
                    cancel: true //为true等价于function(){}
                });
                return false;
            });

        });
    });
}


var CheckLogin = function () {
    var result = false;
    $.ajax({
        type: "POST",
        async: false,
        url: "/Ajax.ashx",
        data: "action=MemberVi",
        success: function (data) {

            if (data == "true") {
                result = true;
            }
            else {
                result = false;
            }
        }
    });

    return result;
}
//$(function () {
//    var bool_window = false;
//    $("#QQlogin").click(function () {

//        art.dialog.open($(this).attr("href"), {
//            title: 'QQ登录', width: '600px', height: '400px',
//            close: function () { location.reload(); } 
//        }
//        , false);
//        return false;
//    });

//});