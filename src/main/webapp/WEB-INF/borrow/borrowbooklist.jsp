<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
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
            <div class="clearfix"></div>
        </div>

        <!-- Matter -->
        <div class="matter">
            <div class="container">

                <div class="row">
                    <div class="col-md-12">

                        <div class="widget">
                            <div class="widget-content">
                                <table class="layui-hide" id="bookListInfo"></table>
                                <div class="fy-box" id="demo5" style="margin-left: 32%"></div>
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
    var bparam = {
        pageNo: 1,
        pageSize: 10,
    };
    bookListInfo();

    function bookListInfo() {
        layui.use('table', function () {
            var table = layui.table;
            var laypage = layui.laypage;

            function getObj() {
                $.ajax({
                    url: "/library/book/queryBooks",
                    type: "POST",
                    data: bparam,
                    dateType: "JSON",
                    success: function (ret) {
                        total = ret.total;
                        //首页表格渲染
                        table.render({
                            elem: '#bookListInfo',
                            count: total,
                            page: false, //表示不使用前端分页，强制使用后端请求分页
                            limit: bparam.pageSize,
                            data: ret.list,
                            cols: [[
                                {field: 'bid', width: '5%', title: '编号', sort: true},
                                {field: 'bookname', width: '10%', title: '书名'},
                                {field: 'author', width: '10%', title: '作者'},
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
                                        if (parseInt(d.last_reserve) <= 0) {
                                            return '<a class="btn btn-active" style="background-color: #999;border-color: #999" disabled="disabled">借阅</a>';
                                        } else if (parseInt(d.last_reserve) > 0) {
                                            // return '<a class="btn btn-active" href="borrowbook?bookname='+d.bookname +'&bid='+d.bid+'" onclick="openNew()">借阅</a>';
                                            return '<a class="btn btn-active" id="' + d.bid + '" href="#" onclick="openNew(' + '\'' + d.bookname + '\'' + ',' + '\'' + d.bid + '\'' + ')">借阅</a>';
                                        }

                                    }
                                }
                            ]],
                            done: function () {
                                //分页
                                laypage.render({
                                    elem: 'demo5',
                                    count: total, //数据总数
                                    limit: bparam.pageSize,
                                    curr: bparam.pageNo,
                                    layout: ['prev', 'page', 'next', 'limit', 'skip'],
                                    jump: function (obj, first) {
                                        if (!first) {
                                            bparam.pageNo = obj.curr;
                                            bparam.pageSize = obj.limit;
                                            bookListInfo();
                                        }
                                    },
                                });
                            }
                        });
                    },
                    error: function () {
                        errorMsg("系统异常");
                    }
                });
            }

            getObj();
        });
    }

    /**
     * 借阅
     * @param bookname
     * @param bid
     */
    function openNew(bookname, bid) {
        $.ajax({
            url: "borrowbook",
            type: "POST",
            data: {
                bookname: bookname,
                bid: bid
            },
            dateType: "JSON",
            success: function (ret) {
                if (ret.code == 1) {
                    if (ret.data == 0){
                        //已借阅的图书 设置不可选
                        $("#" + bid).css({"background": "#999", "border": "#999"});
                        $("#" + bid).attr("disabled", true);
                    }
                }
            },
            error: function (ret) {
                errorMsg("请求报错")
            }
        })
    }
</script>