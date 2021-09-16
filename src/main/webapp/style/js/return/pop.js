function successMsg(message, title) {
    layerMsg(message, 1, title);
}

function errorMsg(message, title) {
    layerMsg(message, 2, title);
    return false;
}

function layerMsg(message, icon, title) {
    if (message == null || message == "") {
        message = "内部出错";
    }
    if (title == null || title == "") {
        title = "温馨提醒";
    }
    layer.alert(message, {
        title: title,
        closeBtn: 1    // 是否显示关闭按钮
        //, anim: 1 //动画类型
        , btn: ['确认'] //按钮
        , icon: icon    // icon
        , yes: function () {
            layer.closeAll();
        }
    });
    return false;
}
//客户反馈专用---提交成功后需要刷新页面
function feedBackLayerMsg(message, icon, title) {
    if (message == null || message == "") {
        message = "内部出错";
    }
    if (title == null || title == "") {
        title = "温馨提醒";
    }
    layer.alert(message, {
        title: title,
        closeBtn: 1    // 是否显示关闭按钮
        //, anim: 1 //动画类型
        , btn: ['确认'] //按钮
        , icon: icon    // icon
        , yes: function () {
            window.location.reload()//刷新当前页面
            // layer.closeAll();
        }
    });
    return false;
}

function layerMsgGoToLogin(message, title) {
    if (message == null || message == "") {
        message = "内部出错";
    }
    if (title == null || title == "") {
        title = "温馨提醒";
    }
    layer.alert(message, {
        title: title,
        closeBtn: 1,
        btn: ['返回', '去登录'], //按钮
        icon: 2,    // icon
        yes: function () {
            layer.closeAll();
        },
        btn2: function () {
            window.location.href = "/login/index";
            return false;
        }
        , success: function (layero) {
            let btn = layero.find('.layui-layer-btn').find('.layui-layer-btn1');
            btn.attr({
                class: 'layui-btn layui-btn-normal',
                style: 'border-color: #036eb5!important;background-color: #036eb5!important;color: #fff;',
            });
        }
    });
}


function layerMsgMandatoryGoToLogin(message, title) {
    if (message == null || message == "") {
        message = "内部出错";
    }
    if (title == null || title == "") {
        title = "温馨提醒";
    }
    layer.alert(message, {
        title: title,
        closeBtn: 0,
        btn: ['去登录'], //按钮
        icon: 2,    // icon
        yes: function () {
            window.location.href = "/login/index";
            return false;
        }
    });
    return false;
}



function openNewWindow(action, params) {
    if (!action) return;
    var form = $("<form method='post'></form>");
    form.attr("target", "_blank");
    $("body").append(form);
    if (!$.isEmptyObject(params)) {
        $.each(params, function (key, value) {
            var input = form.find("input[name='" + key + "']");
            if (input.length == 0) {
                input = $('<input type="hidden"/>').attr("name", key).val(value);
                form.append(input);
            }
            input.val(value);
        });
    }
    form.attr("action", action).submit();
}

//文件专区文件下载方法
function getFile(reportId, title) {
    $.ajax({
        url: "/report/isFileExist",
        type: 'post',
        data: {
            id: reportId
        },
        dataType: "json",
        success: function (data) {
            let code = getCode(data);
            if (code) {
                showFile(reportId, title);
            } else {
                debugger;
                let msg = data["data"]["errorMsg"];
                let errorCode = data["data"]["errorCode"]
                if (errorCode == 30001) {

                    layerMsgGoToLogin(msg);
                } else {
                    getErrorMsg(data);
                }
            }
        }, error: function (err) {
            debugger;
            console.log("错误");
            console.log(err);
        }
    });
}

//业务指南 文件下载
function getFileInGuide(path) {
    $.ajax({
        url: "/customer/isFileExist",
        type: 'post',
        data: {
            path: path
        },
        dataType: "json",
        success: function (data) {
            let code = getCode(data);
            if (code) {
                openNewWindow("/customer/download", {path: path});
            } else {
                debugger;
                let msg = data["data"]["errorMsg"];
                errorMsg(msg);
            }
        }, error: function (err) {
            debugger;
            console.log("错误");
            console.log(err);
        }
    });
}


//文件转换方法--公告模块
function showFile(id, title) {
    let url = "/report/show/" + id;
    if (title == null || title == "") {
        title = "文件";
    }
    layer.open({
        type: 1,
        title: title,
        area: ['1000px', '90%'],
        shade: 0.5,
        scrollbar: false,
        btn: ["返回"/*, "下载"*/],
        content: '<iframe src="/res/js/pdfjs/pdfjs-2.4.456-es5-dist/web/viewer.html?file=' + url + '&v=' + new Date().getTime() + '" style="width: 99%; height: 99%;"></iframe>',
        closeBtn: 0,
        btn1: function () {
            layer.closeAll();
        },
        btn2: function () {
            openNewWindow("/report/download", {id: id});
        }, zIndex: layer.zIndex //重点1
        , success: function (layero) {
            let btn = layero.find('.layui-layer-btn').find('.layui-layer-btn1');
            btn.attr({
                class: 'layui-btn layui-btn-normal',
                style: 'border-color: #036eb5!important;background-color: #036eb5!important;color: #fff;',
            });
        }
    });
}

//文件转换方法--产品详情模块
function showProductFiles(xmId, type, title, show) {
    //文件预览url
    let url = "/prod/getProjectFiles/" + xmId + "/" + type + "/" + show;
    if (title == null || title == "") {
        title = "文件";
    }
    let download = "download";
    layer.open({
        type: 1,
        title: title,
        area: ['1000px', '90%'],
        shade: 0.5,
        scrollbar: false,
        btn: ["返回"/*, "下载"*/],
        content: '<iframe src="/res/js/pdfjs/pdfjs-2.4.456-es5-dist/web/viewer.html?file=' + url + '&v=' + new Date().getTime() + '" style="width: 99%; height: 99%;"></iframe>',
        closeBtn: 0,
        btn1: function () {
            layer.closeAll();
        },
        btn2: function () {
            //文件下载url
            openNewWindowForFile("/prod/getProjectFiles/" + xmId + "/" + type + "/" + download);
        }, zIndex: layer.zIndex //重点1
        , success: function (layero) {
            let btn = layero.find('.layui-layer-btn').find('.layui-layer-btn1');
            btn.attr({
                class: 'layui-btn layui-btn-normal',
                style: 'border-color: #036eb5!important;background-color: #036eb5!important;color: #fff;',
            });
        }
    });
}

function openNewWindowForFile(action) {
    if (!action) return;
    var form = $("<form method='get'></form>").attr("id", "toPageForm_" + new Date().getTime());
    $("body").append(form);
    form.attr("action", action).submit();
}


//文件转换方法--公告模块
function showRegisterFile(url, title) {

    if (title == null || title == "") {
        title = "文件";
    }
    layer.open({
        type: 1,
        title: title,
        area: ['1000px', '90%'],
        shade: 0.5,
        scrollbar: false,
        btn: ["返回"],
        content: '<iframe src="/res/js/pdfjs/pdfjs-2.4.456-es5-dist/web/viewer.html?file=' + url + '&v=' + new Date().getTime() + '" style="width: 99%; height: 99%;"></iframe>',
        closeBtn: 0,
        btn1: function () {
            layer.closeAll();
        },
        zIndex: layer.zIndex //重点1
    });
}