///<reference path="jquery-1.3.2-vsdoc2.js"/>
$(function () {
    $(".contitle>ul").find('li').each(function (i) {
        $(this).mouseover(function () {

            $(this).siblings().removeClass('Over').end().addClass('Over');
            $(".con").hide().eq(i).show();
        });
    });
    $("#CartAdd").click(function () {
        var cur_value = $("#ProCount").val();
        if (!vili_match(cur_value)) {
            art.dialog({
                icon: 'face-sad',
                content: '请输入数字!!'
            });
            return false;
        }
        if (cur_value < 99) {
            cur_value++;
            $("#ProCount").val(cur_value);

        }
        else {
            art.dialog({
                icon: 'face-sad',
                content: '数量不能大于99!!'
            });

        }
    });

    $("#CardSubtract").click(function () {
        var cur_value = $("#ProCount").val();
        if (!vili_match(cur_value)) {
            art.dialog({
                icon: 'face-sad',
                content: '请输入数字!!'
            });
            return false;
        }
        if (cur_value > 1) {
            cur_value--;
            $("#ProCount").val(cur_value);
        }
        else {
            art.dialog({
                icon: 'face-sad',
                content: '数量不能少于1!!'
            });

        }
    });
    $("[id^='bt_add']").each(function () {
        $(this).click(function () {
            var pid = $(this).attr('pid');
            var count = 1;
            if ($("#ProCount").size() > 0) {
                count = $("#ProCount").val();
            }
            if (vili_match(count)) {
                ADD_card(pid, count);
            } else {
                art.dialog({
                    icon: 'face-sad',
                    content: '请输入数字!'
                });

            }

            return false;
        });
    });
    $("[id=useful]").each(function () {
        $(this).click(function () {
            var cid = $(this).attr('cid');
            var com = $(this).attr("id");
            $.ajax({
                type: "POST",
                async: false,
                url: "/Ajax.ashx",
                data: "action=comment&cid=" + cid + "&com=1",
                success: function (data) {

                    ComResult(data);
                }
            });
            return false;
        });
    });
    $("[id=unuseful]").each(function () {
        $(this).click(function () {
            var cid = $(this).attr('cid');
            var com = $(this).attr("id");
            $.ajax({
                type: "POST",
                async: false,
                url: "/Ajax.ashx",
                data: "action=comment&cid=" + cid + "&com=0",
                success: function (data) {

                    ComResult(data);
                }
            });
            return false;
        });
    });

    $("#ADDcomment").click(function () {
        var content = $("#text_liuyang").val();
        var appraise = $("#appraise").val();

        if (content == "") {
            art.dialog({
                width: '300px',
                content: '不能为空'
            });
            return false;
        } else {
            if (content.length > 200) {
                art.dialog({
                    width: '300px',
                    content: '最多输入200个字符!'
                });
                return false;
            }

        }
        var pid = $('.open_en').attr('pid');

        $(this).val('发送中...');
        $(this).val('disabled', 'disabled');

        $.ajax({
            type: "POST",
            async: false,
            url: "/Ajax.ashx",
            data: "action=ADDcomment&pid=" + pid + "&content=" + content + "&appraise=" + appraise,
            success: function (data) {
                $("#ADDcomment").val('评论');
                $("#ADDcomment").attr('disabled', '');
                ComResult(data);
            }
        });
        return false;
    });
    $(".evaluation_ul>li").each(function (i) {

        $(this).click(function () {
            $(this).siblings().removeClass('hover').end().addClass("hover");
            $("#proselect").html("");
            if (i != 0) {


                var min = $(this).attr('min');
                var max = $(this).attr("max");
                var type = 1;
                $("#prodefault>li").each(function () {
                    var appraise = $(this).attr('Appraise') / 2;
                    if (appraise == min || appraise == max) {
                        $("#proselect").append($(this).clone(true));
                        $("#prodefault").hide();

                        $("#proselect").show();
                    }
                });
            } else {
                $("#prodefault").show();
                $("#proselect").hide(); ;
            }


        });
    });
    $("[id^='reply']").each(function () {
        $(this).click(function () {
            var index = $(this);
            var parent = $(this).siblings('.messageBox');
            $(parent).slideToggle(500, function () {
                if ($(index).val() == "回复") {
                    $(index).val("关闭");
                } else {
                    $(index).val("回复");
                }
            });
            //$(param).slideDown();
            return false;
        });

    });
    $("[id^='child']").each(function () {
        $(this).click(function () {
            var content = $(this).siblings("#pc").children("#content").val();
            if (content == "") {
                art.dialog({
                    width: '300px',
                    content: '不能为空'
                });
                return false;
            } else {
                if (content.length > 200) {
                    art.dialog({
                        width: '300px',
                        content: '最多输入200个字符!'
                    });
                    return false;
                }

            }
            var pid = $(this).attr("pid");
            var parentid = $(this).attr('parentid');
            $(this).val('发送中...');
            $(this).val('disabled', 'disabled');
            var $this = $(this);
            $.ajax({
                type: "POST",
                async: false,
                url: "/Ajax.ashx",
                data: "action=ChildComment_add&pid=" + pid + "&content=" + content + "&parentid=" + parentid,
                success: function (data) {
                    $this.val('评论');
                    $this.attr('disabled', '');
                    ComResult(data);
                }
            });
            return false;
        });
    });
});
var ComResult = function (com) {
    switch (com) {
        case 'true':
            Talert("评论成功", "face-smile",true);

            break;
        case 'truec':
            Talert("评论成功(获得5积分）", "face-smile", true);

            break;
        case 'false':
            Talert("评论失败", "face-sad",false);
            break;
        case 'notlogin':
            Talert("不能进行此次操作,请<a href='/login.aspx'>【登录】</a>,还没有账号的现在就去<a href='/register.aspx'>【注册】</a>吧", "face-sad", false);
            break;
        case 'Com':
            Talert("评论成功", "face-smile", true);
            break;
        case 'Pro':
            Talert("你没有购买过该商品", "face-sad", false);
            break;
        default:
            Talert("评论失败", "face-sad", false);
            break;
    }
}
var Talert = function (content, img, bool) {
    art.dialog({
        icon: img,
        lock: true,
        width: '300px',
        content: content,
        close: function () {
            if (bool) {
                location.reload();
            }
        }
    });
}