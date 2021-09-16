<%--
  Created by IntelliJ IDEA.
  User: Summer_DM
  Date: 2021/9/13
  Time: 上午 09:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title>首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="../commons/css.jsp"></jsp:include>
    <style type="text/css">
        input[type="radio"], input[type="checkbox"] {
            margin: 1px 0 0;
        }

        .checkbox-inline {
            padding-top: 3px;
        }

    </style>
</head>
<body>
<!-- 头部 -->
<jsp:include page="../commons/head.jsp"></jsp:include>
<!-- 左边菜单 -->
<jsp:include page="../commons/leftList.jsp"></jsp:include>
<!-- 内容 -->
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-home"></i> 首页</h2>
            <div class="bread-crumb pull-right">
                <a href="http://localhost:8080/library/admin/index"><i class="icon-home"></i> 首页</a>
                <span class="divider">/</span>
                <a href="#" class="bread-current" onclick="control()">控制台</a>
            </div>
            <div class="clearfix"></div>
        </div>
        <!-- Matter -->
        <div class="matter">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="widget">
                            <form class="form-horizontal" role="form" style="padding: 20px 0 0 10px">
                                <div class="form-group">
                                    <label for="bookname" class="col-sm-1 control-label">书籍名称：</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="bookname" placeholder="请输入名字">
                                    </div>
                                    <label for="authorname" class="col-sm-1 control-label">书籍作者：</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="authorname" placeholder="请输入姓">
                                    </div>
                                    <button type="button" class="btn btn-primary" onclick="bookList()">查询</button>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label">书籍类型：</label>
                                    <div id="bookType" class="col-sm-9">
                                    </div>
                                </div>
                            </form>
                            <div class="widget-head" style="border-top: 2px solid #c9c9c9">
                                <div class="pull-left">书籍清单</div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="widget-content">
                                <table class="layui-hide" id="tableInfo"></table>
                                <div class="fy-box" id="demo1" style="margin-left: 50%"></div>
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
    var total = "";
    var data = "";

    var bookListParam = {
        pageNo: 1,
        pageSize: 10,
        type: data,
        bookname: $("#bookname").val(),
        authorname: $("#authorname").val()
    };

    bookType();
    bookList();

    /**
     * 书籍类型初始化
     */
    function bookType() {
        $.ajax({
            url: "/library/book/queryBookType",
            type: "POST",
            dateType: "JSON",
            success: function (ret) {
                if (ret.code == 1) {
                    var contentContainer = $("#bookType");
                    contentContainer.empty();
                    contentContainer.html('');
                    var list = ret.data;
                    for (var i = 0; i < list.length; i++) {
                        contentContainer.append(' <label class="checkbox-inline">'
                            + '<input type="checkbox" name = "test" value=' + list[i].dic_code + '>' + list[i].dic_value + ''
                            + ' </label>')
                    }
                }
            },
            error: function () {
                errorMsg("添加失败")
            }
        });
    }

    /**
     * 查询结果展示
     */
    function bookList() {
        layui.use('table', function () {
            var table = layui.table;
            var laypage = layui.laypage;
            data = function jqchk() { //jquery获取复选框值
                var chk_value = [];
                $('input[name="test"]:checked').each(function () {
                    chk_value.push($(this).val());
                });
                return chk_value;
            }
            bookListParam.bookname = $("#bookname").val();
            bookListParam.authorname = $("#authorname").val();
            bookListParam.type = data;

            function getObj() {
                $.ajax({
                    url: "/library/book/queryBooks",
                    type: "POST",
                    data: bookListParam,
                    dateType: "JSON",
                    success: function (ret) {
                        if (ret.size > 0) {
                            total = ret.total;
                            //首页表格渲染
                            table.render({
                                elem: '#tableInfo',
                                count: total,
                                page: false,
                                limit: bookListParam.pageSize,
                                data: ret.list,
                                cols: [[
                                    {field: 'bid', width: '5%', title: '编号', sort: true},
                                    {field: 'bookname', width: '15%', title: '书名'},
                                    {field: 'author', width: '15%', title: '作者'},
                                    {field: 'type', width: '10%', title: '类型'},
                                    {field: 'publisher', title: '出版单位', width: '15%'},
                                    {field: 'publicationdate', title: '出版时间', width: '10%', sort: true},
                                    {field: 'price', title: '价格', width: '5%',sort: true},
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
                                    {field: 'comment', title: '备注', width: '15%'},
                                ]],
                                done: function () {
                                    //分页
                                    laypage.render({
                                        elem: 'demo1',
                                        count: total, //数据总数
                                        limit: 10,
                                        curr: bookListParam.pageNo,
                                        jump: function (obj, first) {
                                            if (!first) {
                                                bookListParam.pageNo = obj.curr;
                                                bookList();
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

    function control() {
        // layer.alert('酷毙了', {icon: 1});
        errorMsg("完犊子");
    }

</script>