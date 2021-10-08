<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <!-- Title and other stuffs -->
    <title>首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="../commons/css.jsp"></jsp:include>
</head>
<body>
<!-- 头部 -->
<jsp:include page="../commons/head.jsp"></jsp:include>
<!-- 左边菜单 -->
<jsp:include page="../commons/leftList.jsp"></jsp:include>

<div class="content">
    <!-- 内容 -->
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-home"></i> 首页</h2>
            <div class="bread-crumb pull-right" style="margin-left: 15px;">
                <button type="button" class="layui-btn layui-btn-normal layui-btn-radius" id="bookFileUpload">
                    <i class="layui-icon">&#xe67c;</i>文件导入
                </button>
                <a href="#" onclick="getBookFile()" style="color: #cb2027;font-size: large;text-decoration:underline">导入模板下载</a>
            </div>
            <div class="bread-crumb pull-right">
                <button type="button" class="layui-btn layui-btn-normal layui-btn-radius" onclick="openAddBook()">
                    <i class="layui-icon">&#xe67c;</i>添加图书
                </button>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- Matter -->
        <div class="matter">
            <div class="container">

                <div class="row">
                    <div class="col-md-12">

                        <div class="widget">
                            <div class="widget-content">
                                <table class="layui-hide" id="booksInfo"></table>
                                <div class="fy-box" id="demo2" style="margin-left: 32%"></div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="clearfix"></div>
</div>
<!-- 底部 -->
<jsp:include page="../commons/foot.jsp"></jsp:include>
<!-- 快速回到顶部 -->
<span class="totop"><a href="#"><i class="icon-chevron-up"></i></a></span>
</body>
</html>

<script>

    var qparam = {
        pageNo: 1,
        pageSize: 10,
    };
    books();

    function books() {
        layui.use('table', function () {
            var table = layui.table;
            var laypage = layui.laypage;

            function getObj() {
                $.ajax({
                    url: "queryBooks",
                    type: "POST",
                    data: qparam,
                    dateType: "JSON",
                    success: function (ret) {
                        if (ret.size > 0) {
                            total = ret.total;
                            //首页表格渲染
                            table.render({
                                elem: '#booksInfo',
                                count: total,
                                page: false, //表示不使用前端分页，强制使用后端请求分页
                                limit: qparam.pageSize,
                                data: ret.list,
                                cols: [[
                                    {field: 'bid', width: '5%', title: '编号', sort: true},
                                    {
                                        field: 'bookname',
                                        width: '15%',
                                        title: '书名'
                                    },
                                    {field: 'author', width: '15%', title: '作者'},
                                    {field: 'booktype', width: '10%', title: '类型'},
                                    {field: 'publisher', title: '出版单位', width: '15%'},
                                    {field: 'publicationdate', title: '出版时间', width: '10%', sort: true},
                                    {field: 'price', title: '价格', width: '5%', sort: true},
                                    {
                                        field: 'bookstate', title: '借阅状态', width: '10%',
                                        templet: function (d) {
                                            if (d.bookstate == "2") {
                                                return "已借阅";
                                            } else if (d.bookstate == "1") {
                                                return "未借阅";
                                            }
                                        },
                                    },
                                    {field: 'comment', title: '备注', width: '10%'},
                                    {field: 'last_reserve', title: '剩余库存', width: '10%'},
                                    {field: 'total', title: '总库存', width: '10%'},
                                    {
                                        field: 're', title: '操作', width: '5%',
                                        templet: function (d) {
                                            return '<a class="btn btn-active" href="delete?bid=' + d.bid + '">删除</a>';
                                        }
                                    }
                                ]],
                                done: function () {
                                    //分页
                                    laypage.render({
                                        elem: 'demo2',
                                        count: total, //数据总数
                                        limit: qparam.pageSize,
                                        curr: qparam.pageNo,
                                        layout: ['prev', 'page', 'next', 'limit', 'skip'],
                                        jump: function (obj, first) {
                                            if (!first) {
                                                qparam.pageNo = obj.curr;
                                                qparam.pageSize = obj.limit;
                                                books();
                                            }
                                        },
                                    });
                                }
                            });
                        } else {
                            errorMsg("抱歉，此书籍还未收录在本图书馆！");
                            window.onload = "/library/admin/index";
                        }
                    },
                    error: function () {
                        errorMsg("查询错误");
                    }
                });
            }

            getObj();
        });
    }

    /**
     * 文件上传--批量导入
     */
    layui.use('upload', function () {
        var upload = layui.upload;
        var layer = layui.layer;
        // layer.msg('上传中', {icon: 16, time: 0,shade: 0.3});
        //执行实例
        var uploadInst = upload.render({
            elem: '#bookFileUpload', //绑定元素
            url: '/library/book/batchAddBooks/', //上传接口
            exts: 'xlsx|xls', //限制文件类型
            done: function (res) {
                //上传完毕回调
                if (res.code == '1') {
                    successMsg("导入成功");
                } else {
                    errorMsg("导入失败" + res);
                }
            },
            error: function (res) {
                //请求异常回调
                errorMsg("系统异常" + res);
            }
        });
    });

    function getBookFile() {
        let url = '/library/file/downloadFile?fileType=' + 'book';
        window.open(url, '_blank');
        return false;
    }
    function openAddBook() {
       window.location.href='http://localhost:8080/library/book/addbookUI';
    }
</script>