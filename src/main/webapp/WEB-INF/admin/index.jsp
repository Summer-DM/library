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
<jsp:include page="../commons/litleTile.jsp"></jsp:include>
<!-- 内容 -->
<div class="content">
    <div class="mainbar">
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
                                        <input type="text" class="form-control" id="authorname" placeholder="请输入作者">
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
                                <div class="pull-left" style="color: black;">书籍清单</div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="widget-content">
                                <table class="layui-hide" id="tableInfo" lay-filter="tableEvent"></table>
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
    // updatePwd();

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
            bookListParam.booktype = data;

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
                                    {field: 'bookname', width: '15%', title: '书名',event: 'showBookIntroduction',style:'cursor: pointer;color: blue;font-size: small;text-decoration:underline'},
                                    {field: 'author', width: '15%', title: '作者'},
                                    {field: 'booktype', width: '10%', title: '类型'},
                                    {field: 'publisher', title: '出版单位', width: '15%'},
                                    {field: 'publicationdate', title: '出版时间', width: '10%', sort: true},
                                    {field: 'price', title: '价格', width: '5%',sort: true},
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
                            //监听单元格事件
                            table.on('tool(tableEvent)', function(obj){
                                var data = obj.data;
                                if(obj.event === 'showBookIntroduction'){
                                    layer.open({
                                        icon:7,
                                        title: data.bookname +'内容简介',
                                        content: '即将打开'+data.bookname+'内容！！！！！',
                                        btn: ['确定', '取消'], //可以无限个按钮
                                        yes: function(index, layero){
                                            //按钮【按钮一】的回调
                                            window.location.href='https://www.biquwx.la/modules/article/search.php?searchkey=' + data.bookname
                                        }
                                    })
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

    /**
     * 首页打开，弹窗，您是否前往修改密码？
     */
    // function updatePwd() {
    //     layui.use('layer', function () {
    //         var layer = layui.layer;
    //         layer.open({
    //             content: "登录成功，您的密码过于简单，是否需要立即修改密码？",
    //             btn: ['确定', '取消'],
    //             yes: function (index) {
    //                 layer.close(index);
    //                 window.location.href = '/library/admin/updatepwd';
    //             }
    //             ,cancel: function (index){
    //                 layer.close(index);
    //             }
    //         });
    //     });
    // }

</script>