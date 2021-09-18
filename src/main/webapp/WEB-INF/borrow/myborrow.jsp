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
            <div class="clearfix"></div>
        </div>
        <!-- Matter -->
        <div class="matter">
            <div class="container">

                <div class="row">
                    <div class="col-md-12">

                        <div class="widget">
                            <div class="widget-content">
                                <table class="layui-hide" id="myBorrowInfo"></table>
                                <div class="fy-box" id="demo6" style="margin-left: 32%"></div>
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
    var myBorrowParam = {
        pageNo: 1,
        pageSize: 10,
    };
    myBorrowerList();

    function myBorrowerList() {
        layui.use('table', function () {
            var table = layui.table;
            var laypage = layui.laypage;

            function getMyborrowInfo() {
                $.ajax({
                    url: "queryMyBorrow",
                    type: "POST",
                    data: myBorrowParam,
                    dateType: "JSON",
                    success: function (ret) {
                        total = ret.total;
                        //首页表格渲染
                        table.render({
                            elem: '#myBorrowInfo',
                            count: total,
                            page: false, //表示不使用前端分页，强制使用后端请求分页
                            limit: myBorrowParam.pageSize,
                            data: ret.list,
                            cols: [[
                                {field: 'id', width: '10%', title: '#', sort: true},
                                {field: 'borrower', width: '20%', title: '借阅人'},
                                {field: 'borrowtime', title: '借阅时间', width: '20%', sort: true},
                                {field: 'bookname', width: '20%', title: '书名'},
                                {field: 'bid', width: '20%', title: '书籍编号', sort: true},
                                {
                                    field: 're', title: '操作', width: '10%',
                                    templet: function (d) {
                                        return '<a class="btn btn-active" href="returnbook?bid=' + d.bid + '">归还</a>';
                                    }
                                }
                            ]],
                            done: function () {
                                //分页
                                laypage.render({
                                    elem: 'demo6',
                                    count: total, //数据总数
                                    limit: myBorrowParam.pageSize,
                                    curr: myBorrowParam.pageNo,
                                    layout: ['prev', 'page', 'next', 'limit', 'skip'],
                                    jump: function (obj, first) {
                                        if (!first) {
                                            myBorrowParam.pageNo = obj.curr;
                                            myBorrowParam.pageSize = obj.limit;
                                            myBorrowerList();
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

            getMyborrowInfo();
        });
    }
</script>

