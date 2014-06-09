///<reference path="jquery-1.3.2-vsdoc2.js"/>

$(document).ready(function () {
    //便捷购物车
    $(".shopping_cart").hover(
			  function () {
			      $(".shopping_cart_list").fadeIn(0);
			  },
			  function () {
			      $(".shopping_cart_list").fadeOut(100);
			  }
	);
    //消息提示
    $(".tis_header").hover(
			  function () {
			      $(".tis2").show();
			  }
	);
    //关闭消息
    $(".tisclosed").click(function () {
        $(".tis2").hide(1000);
    });

    //弹出菜单分类
    $(".showMainnavinfo").hover(
			  function () {
			      $(".showMainnav").slideDown();
			  },
			  function () {
			      $(".showMainnav").hide();
			  }
	);
    //弹出菜单详细分类
    $(function () {
        $('.mainnav_ul > li').each(function (i) {
            $(this).mouseenter(function () {
                $(".subMenu" + i).show();
                $(this).find('a').eq(0).addClass('hover');

            });
            $(this).mouseleave(function () {
                $(".subMenu" + i).hide();
                $(this).find('a').eq(0).removeClass('hover');
            });
        });

    });
    var SrollCount = $("#sroll>ul:first").size();
    var SroLiHeight = $("#sroll>ul li:first").height();
    var SroTimer;
    var SroOffset = 2000;
    var SroIndex = 0;
    var $SroUl = $("#sroll>ul");
    $("#sroll>ul").find('li').each(function () {
        $(this).hover(function () {
            if (SroTimer) {
                clearInterval(SroTimer);
            }
        }, function () {
            SrollTimer();
        });
    });
    var SrollTimer = function () {
        if (SrollCount > 1) {
            SroTimer = window.setInterval(SrollMethor, SroOffset);
        }
    };
    var SrollMethor = function () {
        $SroUl.animate({ marginTop: '-' + SroLiHeight }, 1000, null, function () {
            $SroUl.animate({ marginTop: 0 }, 0, null, function () {
                $SroUl.append($SroUl.children('li').get(0));
            });
        });
    };
    if (SrollCount > 1) {
        SrollTimer();
    }
});
