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
            <div class="bread-crumb pull-right">
                <a href="http://localhost:8080/library/book/addbookUI" class="btn btn-active"> 添加图书</a>
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
        pageSize: 15,
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
                                page: false,
                                limit: qparam.pageSize,
                                data: ret.list,
                                cols: [[
                                    {field: 'bid', width: '5%', title: '编号', sort: true},
                                    {field: 'bookname', width: '15%', title: '书名'},
                                    {field: 'author', width: '15%', title: '作者'},
                                    {field: 'type', width: '10%', title: '类型'},
                                    {field: 'publisher', title: '出版单位', width: '15%'},
                                    {field: 'publicationdate', title: '出版时间', width: '10%', sort: true},
                                    {field: 'price', title: '价格', width: '5%', sort: true},
                                    {
                                        field: 'state', title: '借阅状态', width: '10%',
                                        templet: function (d) {
                                            if (d.state == "1") {
                                                return "已借阅";
                                            } else if (d.state == "2") {
                                                return "未借阅";
                                            }
                                        },
                                    },
                                    {field: 'comment', title: '备注', width: '10%'},
                                    {field: 're', title: '操作', width: '5%',
                                        templet: function (d) {
                                            return '<a class="btn btn-active" href="delete?bid='+d.bid+'">删除</a>';
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
                                        jump: function (obj, first) {
                                            if (!first) {
                                                qparam.pageNo = obj.curr;
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

    //分页
    //     layui.use('laypage', function () {
    //         var laypage = layui.laypage;
    //         //执行一个laypage实例
    //         laypage.render({
    //             elem: 'demo2', //注意，这里的 test1 是 ID，不用加 # 号
    //             count: 50, //数据总数，从服务端得到
    //             theme: '#036eb5',
    //             limit: 10,
    //             layout: ['count', 'prev', 'page', 'next', 'limit', 'skip'],
    //             jump: function (obj, first) {
    //                 if (!first) {
    //                 }
    //             }
    //         });
    //     });

</script>