///<reference path="jquery-1.3.2-vsdoc2.js"/>
$(function () {
    //    var i = 0;
    //    var show;
    //    $("#idNum>li").each(function () {
    //        $(this).hover(function () {
    //            $(this).siblings().removeClass("on").end().addClass("on");
    //            var i_index = $(this).index();
    //            i = i_index;
    //            clearInterval(show);
    //            $("#idSlider").stop(true, false).animate({ marginTop: "-317" * i_index }, 200);
    //        }, function () {
    //           show=setInterval(function () { i++; if (i == 4) i = 0; amimate(i) }, 3000);
    //        });
    //   });

    $("#rollOne_menu>li").each(function () {
        $(this).mouseover(function () {
            $(this).siblings().removeClass("hover").end().addClass("hover");
            $("div [id^='ListImport_']").hide().eq($(this).index()).show();
        });
    });
    $("#rollTwo_menu>li").each(function () {
        $(this).mouseover(function () {
            $(this).siblings().removeClass("hover").end().addClass("hover");
            $("div [id^='Listdomestic_']").hide().eq($(this).index()).show();
        });
    });
    $("#rollThree_menu>li").each(function () {
        $(this).mouseover(function () {
            $(this).siblings().removeClass("hover").end().addClass("hover");
            $("div [id^='Listgift_']").hide().eq($(this).index()).show();
        });
    });
    $("#ClassImport>li").each(function () {
        $(this).click(function () {
            $(this).siblings().removeClass("hover").end().addClass("hover");
            $("div [id^='con_jkone']").hide().eq($(this).index()).show();
        });
    });
    $("#idNum>li:first").addClass("on").trigger("mouseout");
    $("#rollOne_menu>li:first").addClass("hover");
    $("#rollTwo_menu>li:first").addClass("hover");
    $("#rollThree_menu>li:first").addClass("hover");
    $("#ClassImport>li:first").addClass("hover");

    var thumbs_index = 0;
    var thumbs_time = null;
    var thumbs_auto = function () {
        if (thumbs_index >= 8) { thumbs_index = 0; }
        $('.LiBlock').removeClass('current');
        $("#thumbs").find('li').eq(thumbs_index).children('.LiBlock').addClass('current');
        $("#featured").find('.items').hide().eq(thumbs_index).show();
        thumbs_index++;
    };


    $("#thumbs").find('li').each(function (i, item) {
        $(this).hover(function () {
            clearInterval(thumbs_time);
            thumbs_index = i;
            $('.LiBlock').removeClass('current');
            $(this).children('.LiBlock').addClass('current');
            $("#featured").find('.items').hide().eq(i).show();

            return false;
        }, function () {
            thumbs_time = setInterval(thumbs_auto, 5000);
        });
    });
    $("#thumbs").find('li').eq(0).trigger("mouseleave"); ;

    $("#featured").hover(function () {
        clearInterval(thumbs_time);
    }, function () {
        thumbs_time = setInterval(thumbs_auto, 5000);
    });

    $("#play_prev").click(function () {
        thumbs_index--;
        if (thumbs_index < 0) { thumbs_index = 7; }
        $('.LiBlock').removeClass('current');
        $("#thumbs").find('li').eq(thumbs_index).children('.LiBlock').addClass('current');
        $("#featured").find('.items').hide().eq(thumbs_index).show();

    });
    $("#play_next").click(function () {
        thumbs_index++;
        if (thumbs_index >= 8) { thumbs_index = 0; }
        $('.LiBlock').removeClass('current');
        $("#thumbs").find('li').eq(thumbs_index).children('.LiBlock').addClass('current');
        $("#featured").find('.items').hide().eq(thumbs_index).show();

    });
    $(".tags").each(function () {
        $(this).find('li').eq(0).addClass('cur');
    });
    $(".tags li").each(function (i, item) {
        $(this).mouseover(function () {
            $(this).parent('.tags').find('li').removeClass('cur');
            $(this).addClass("cur");
            $(this).closest('.title_taochan').siblings('.panes').find('.pane').hide();
            $('.pane').eq(i).show();

        });
    });

});
var amimate = function (i) {
    $("#idNum>li").removeClass("on").eq(i).addClass("on");
    $("#idSlider").stop(true, false).animate({ marginTop: "-317" * i }, 200);

}