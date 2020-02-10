var $toastlast;
var toastOptionData = {
    'toastrType': {'success': 'success', 'info': 'info', 'warning': 'warning', 'error': 'error'},
    'position'  : { 'topRight' :'toast-top-right',
                    'topLeft'  :'toast-top-left',
                    'topCenter':'toast-top-center',
                    'topFull'  :'toast-top-full-width',
                    'botRight' :'toast-bottom-right',
                    'botLeft'  :'toast-bottom-left',
                    'botCenter':'toast-bottom-center',
                    'botFull'  :'toast-bottom-full-width'},
                    'showEasing': { 'swing': 'swing', 'linear': 'linear'}, //显示和隐藏都是这一组
                    'showMethod': { 'show': 'show', 'fadeIn': 'fadeIn', 'slideDown': 'slideDown'}, //显示方法
                    'hideMethod': { 'hide': 'hide', 'fadeOut': 'fadeOut', 'slideUp': 'slideUp'}   //隐藏方法
};
/**
 * 消息提示构造方法 根据需要 传递参数 toastOptionData 为基础参数，默认可以不传参数
 * 调用方法 ToastrMsg("警告","warning","topRight"); 即可
 * unblock 参数在使用遮罩层时传入
 * @param toastrMsg
 * @param toastrType
 * @param positionType
 * @param unblock
 * @param toastrTitle
 * @param showEas
 * @param hideEas
 * @param showMet
 * @param hideMet
 * @param showDuration
 * @param hideDuration
 * @param timeOut
 * @param extendedTimeOut
 * @constructor
 */
var ToastrMsg = function(toastrMsg, toastrType, positionType, unblock, reload, closeModal,toastrTitle ,showEas ,hideEas, showMet, hideMet, showDuration, hideDuration, timeOut, extendedTimeOut) {
    var $shortCutFunction = toastrType ? toastOptionData.toastrType[toastrType] : toastOptionData.toastrType.info;
    var $showEasing = showEas ? toastOptionData.showEasing[showEas] : toastOptionData.showEasing.swing;
    var $hideEasing = hideEas ? toastOptionData.showEasing[hideEas] : toastOptionData.showEasing.linear;
    var $showMethod = showMet ? toastOptionData.showMethod[showMet] : toastOptionData.showMethod.fadeIn;
    var $hideMethod = hideMet ? toastOptionData.hideMethod[hideMet] : toastOptionData.hideMethod.fadeOut;
    toastr.options = {
        closeButton: true,
        debug: false,
        newestOnTop: true,
        progressBar: true,
        positionClass: positionType ? toastOptionData.position[positionType] : toastOptionData.position.topRight,
        preventDuplicates: true,
        onclick: null,
        showDuration: showDuration ? showDuration : 300,
        hideDuration: hideDuration ? hideDuration : 1000,
        timeOut: timeOut ? timeOut : 3000,
        extendedTimeOut: extendedTimeOut ? extendedTimeOut : 1000,
        showEasing: $showEasing,
        hideEasing: $hideEasing,
        showMethod: $showMethod,
        hideMethod: $hideMethod,
        tapToDismiss: false,
    };
    if(unblock){
        mApp.unblock(unblock);
    }
    var $toast = toastr[$shortCutFunction](toastrMsg ? toastrMsg : "一条消息 !", toastrTitle ? toastrTitle : '');
    $toastlast = $toast;

    if(typeof $toast === 'undefined'){
        return;
    }
    if (typeof closeModal !== 'undefined' && closeModal != ''){
        $(".close-parent").click();
    }
    if (typeof reload !== 'undefined' && reload != ''){
        setTimeout(function() {
            location.reload();
        }, 2000);
    }
}
var getLastToast = function (){
    return $toastlast;
}
var clearToastr = function(){
    toastr.clear(getLastToast());
}

/**
 * 请求构造器
 * @param url
 * @param type
 * @param data
 * @param fnSucc
 * @param fnFaild
 */
var request = function (url, method, data, fnSucc, fnFaild,cache) {
    if(fnFaild==="boolean"){
        cache=  fnFaild;
    }
    cache=typeof cache==="boolean"?cache:true;
    $.ajax({
        url: url,
        type: method,
        data: data,
        dataType: 'json',
        error: fnFaild ? fnFaild : '',
        timeout : 30000,
        cache:false,
        success: function (data, textStatus, jqXHR) {
            fnSucc(data, textStatus, jqXHR);
        },
        error : function (XMLHttpRequest, textStatus, errorThrown) {
            if (fnFaild) fnFaild();
        }
    });
}

/**
 * 获取基础URL
 * @returns {string}
 * @constructor
 */
var GetUrlRelativePath = function ()
{
    var url = document.location.toString();
    var arrUrl = url.split("//");
    var start = arrUrl[1].indexOf("/");
    var relUrl = arrUrl[1].substring(start);//stop省略，截取从start开始到结尾的所有字符
    if(relUrl.indexOf("?") != -1){
        relUrl = relUrl.split("?")[0];
    }
    return relUrl;
}

/**
 * BlockUi 加载消息提示框
 * @param elem
 * @param type
 * @param state
 * @param msg
 */
var blockUiOpen = function(elem, msg, color, type, state){
    mApp.block(elem, {
        overlayColor: color ? color : '#000000',
        type: type ? type :'loader',
        state: state ? state : 'primary',
        message: msg ? msg : '请稍后...'
    });
}

/**
 * 关闭 BlockUi 消息提示框 可以关联关闭 modal 不需要延时 time = 0
 * @param elem
 */
var blockUiClose = function(elem,closeParent,parentElem,time){
    setTimeout(function() {
        mApp.unblock(elem);
        if(closeParent == 1){
            $(parentElem).click();
        }
    }, time);
}

/**
 * 关闭 BlockUi
 * @param elem
 */
var blockUiCloseParent = function(elem){
    mApp.unblock(elem);
}

/**
 * alert 打开消息提示框
 * @param elem
 * @param type
 * @param msg
 */
var alertMsgShow = function(elem, type, msg){
    var alert = $(elem);
    alert.find("#"+type+"_content").text(msg)
    alert.removeClass('m--hide').show();
    mApp.scrollTo(alert, -200);
}

/**
 * 管理后台左侧菜单样式切换
 *
 */
var LeftAside = function (url) {
    if(url != ''){
        var aside_left = $('#m_aside_left .m-menu__item a');
        aside_left.each(function(){
            if(url == $(this).attr("href")){
                if($(this).parents("div").parent("li")){
                    $(this).parents("div").parent("li").addClass("m-menu__item--submenu m-menu__item--open m-menu__item--expanded")
                }
                $("#m_aside_left").find("li").removeClass("m-menu__item--active");
                $(this).parent("li").addClass("m-menu__item--active")
            }
        })
    }
}

var daterangepickerInit = function() {
    if ($('#daterangepicker').length == 0) {
        return;
    }

    var picker = $('#daterangepicker');
    var start = moment();
    var end = moment();

    function cb(start, end, label) {
        var title = '';
        var range = '';

        if ((end - start) < 100) {
            title = '今天:';
            range = start.format('MMM D');
        } else if (label == 'Yesterday') {
            title = '昨天:';
            range = start.format('MMM D');
        } else {
            range = start.format('MMM D') + ' - ' + end.format('MMM D');
        }
        console.log(start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD'))
        picker.attr('start',start.format('YYYY-MM-DD'))
        picker.attr('end',end.format('YYYY-MM-DD'))
        picker.find('.m-subheader__daterange-date').html(range);
        picker.find('.m-subheader__daterange-title').html(title);
    }
    picker.daterangepicker({
        startDate: start,
        endDate: end,
        opens: 'left',
        ranges: {
            // '今天': [moment(), moment()],
            // '昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            '最近7天': [moment().subtract(6, 'days'), moment()],
            '最近30天': [moment().subtract(29, 'days'), moment()],
            '当前月': [moment().startOf('month'), moment().endOf('month')],
            '上月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
    }, cb);

    cb(start, end, '');
}

jQuery(document).ready(function() {
    var url = GetUrlRelativePath();
    LeftAside(url);
});