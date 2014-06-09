
;(function(){
var _isIE6 = window.VBArray && !window.XMLHttpRequest;
    dialogCont = "dialogCont";

var dialog = {

    /*! 创建一个对话框
     *@name[string]: 模板中“***”的替换文字
     *@content[object/string]: 对话框内容部分 
     */
    show: function(name, cont) {
        this.elem = $('<div id="jWrap" class="fn-dialog"></div>');
        this.elem.appendTo("body");
        this.elem.html(template.replace(/\*\*\*/g, name));
        $("#"+dialogCont).html(cont);        
        this.lock();
        this.center(this.elem); 

    },

    // 隐藏对话框
    hide: function() {
        this.elem.remove();        
        this.unlock();
    },

    // 水平垂直居中
    center: function(elem) {
        var width = elem.outerWidth(),
            height = elem.outerHeight();
        elem.css({"margin-left":-(width/2) + "px",top:$(document).scrollTop()+($(window).height()-height)/2});   
    },

    // 对话框遮罩
    lock: function() {
        var that = this,
            lockMask = that.lockMask,
            domTxt = '(document).documentElement',
            cssText = 'left:0;z-index:9998;background:#000;opacity:0.5;filter:alpha(opacity=50);';
        if (!lockMask) {
            lockMask = $(document.body.appendChild(document.createElement('div')));
            lockMask.get(0).id = "lockMask";
            // 让IE6锁屏遮罩能够盖住下拉控件
            if (_isIE6) {                
                cssText += 'position:absolute;left:expression(' + domTxt + '.scrollLeft);top:expression(' + domTxt + '.scrollTop);width:expression(' + domTxt
                + '.clientWidth);height:expression(' + domTxt + '.clientHeight)';
                lockMask.html(
                '<iframe src="about:blank" style="width:100%;height:100%;position:absolute;top:0;left:0;z-index:9999;filter:alpha(opacity=0);border:none;"></iframe>');
            } else {
                cssText += 'width:100%;height:100%;position:fixed;top:0;';
            }



            lockMask[0].style.cssText = cssText;

            lockMask.on('dblclick', function () {
                that.hide();
            });    
        }
        lockMask.show();

        that.lockMask = lockMask;      
        that.locked = true;
        return that;        
    },

    // 解锁
    unlock: function() {
        if (this.lockMask) {
            this.lockMask.hide();
        }
    }
}


var template = 
'<form method="post">'
+'    <table class="fn-dialog-table" summary="***">'
+'        <tbody>'
+'            <tr>'
+'                <td colspan="3" class="fn-dialog-border"></td>'
+'            </tr>'
+'            <tr>'
+'                <td class="fn-dialog-border">&nbsp;&nbsp;</td>'
+'                <td>'
+'                    <div class="fn-dialog-cont">'
+'                        <div class="fn-dialog-tit">'
+'                            <a href="javascript:;" onclick="dialog.hide()" class="fn-dialog-close">\xd7</a>'
+'                            <span>***</span>'
+'                        </div>'
+'                        <div class="fn-dialog-main" id="' + dialogCont + '">'
+'                        [contant]'
+'                        </div>'
+'                    </div>'
+'                </td>'
+'                <td class="fn-dialog-border">&nbsp;&nbsp;</td>'
+'            </tr>'
+'            <tr>'
+'                <td class="fn-dialog-border" colspan="3"></td>'
+'            </tr>'
+'        </tbody>'
+'    </table>'
+'</form>';

window.dialog = dialog;
}(jQuery, window));

