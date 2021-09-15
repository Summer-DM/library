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
    <jsp:include page="../commons/modal.jsp"></jsp:include>
    <style type="text/css">
        input[type="radio"], input[type="checkbox"]{
            margin: 1px 0 0;
        }
        .checkbox-inline{
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
                                <div class="pull-left">未来7天使用信息</div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="widget-content">
                                <table class="table table-striped table-bordered table-hover"
                                       style="table-layout: fixed; display: none" id="talbe1">
                                    <thead>
                                    <tr id="table-header">
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <div class="well">
                                                <h4>地点:东区教学楼201</h4>
                                                <h4>申请人:(认证名)qqsass</h4>
                                                <h4>使用时间:</h4>
                                                <h4>
                                                    2021-10-17
                                                    <br>至<br>
                                                    2018-11-18
                                                </h4>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="well">
                                                <h4>地点:北区教学楼301</h4>
                                                <h4>申请人:(认证名)qqq</h4>
                                                <h4>使用时间:</h4>
                                                <h4>
                                                    2021-10-17
                                                    <br>至<br>
                                                    2018-11-18
                                                </h4>
                                            </div>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <table class="table table-bordered" id="table2" >
                                    <thead>
                                    <tr>
                                        <th>图书编号</th>
                                        <th>书名</th>
                                        <th>作者</th>
                                        <th>类型</th>
                                        <th>出版单位</th>
                                        <th>出版时间</th>
                                        <th>价格</th>
                                        <th>借阅状态</th>
                                        <th>备注</th>
                                    </tr>
                                    </thead>
                                    <tbody id="books">
                                    </tbody>
                                </table>
                                <ul class="pagination">
                                    <li><a href="#">&laquo;</a></li>
                                    <li class="active"><a href="#">1</a></li>
                                    <li><a href="#">2</a></li>
                                    <li><a href="#">3</a></li>
                                    <li><a href="#">4</a></li>
                                    <li><a href="#">5</a></li>
                                    <li><a href="#">&raquo;</a></li>
                                </ul>
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
    showInfo();
    bookType();
    $("#table1").show();

    function showTime(n) {
        var date = new Date();
        var year, month, day;
        date.setDate(date.getDate() + n);
        year = date.getFullYear();
        month = date.getMonth() + 1;
        day = date.getDate();
        s = year + '-' + (month < 10 ? ('0' + month) : month) + '-' + (day < 10 ? ('0' + day) : day);
        return s;
    }

    function showInfo() {
        var contentContainer = $("#table-header");
        contentContainer.empty();
        contentContainer.html('');
        for (var i = 1; i < 8; i++) {
            contentContainer.append('<th class="text-center">' + showTime(i) + '</th>');
        }
    }

    /**
     * 书籍类型初始化
     */
    function bookType(){
        $.ajax({
            url: "/library/book/queryBookType",
            type: "POST",
            dateType: "JSON",
            success: function (ret) {
                if (ret.code == 1){
                    var contentContainer = $("#bookType");
                    contentContainer.empty();
                    contentContainer.html('');
                    var list = ret.data;
                    for (var i =0;i<list.length;i++){
                        contentContainer.append(' <label class="checkbox-inline">'
                            + '<input type="checkbox" name = "test" value='+ list[i].dic_code +'>'+list[i].dic_value+''
                            +' </label>')
                    }
                }
            },
            error: function () {
                $(".modal-body").text("添加失败");
                //显示模态框
                $('#myModal').modal('show')
            }
        });
    }

    /**
     * 查询结果展示
     */
    function bookList(type){
        $("#table1").hide();
        $("#table2").show();
        var data = function jqchk(){ //jquery获取复选框值
            var chk_value =[];
            $('input[name="test"]:checked').each(function(){
                chk_value.push($(this).val());
            });
            return chk_value;
        }
        var bookListParam = {
            pageNo: 1,
            pageSize: 100,
            type: data,
            bookname: $("#bookname").val(),
            authorname: $("#authorname").val()
        };
        $.ajax({
            url: "/library/book/queryBooks",
            type: "POST",
            data: bookListParam,
            dateType: "JSON",
            success: function (ret) {
                if (ret.size > 0){
                    var contentContainer = $("#books");
                    contentContainer.empty();
                    contentContainer.html('');
                    var list = ret.list;
                    for (var i =0;i<list.length;i++){
                        contentContainer.append('<tr>');
                        contentContainer.append('<td>'+ list[i].bid +'</td>');
                        contentContainer.append('<td>'+ list[i].bookname +'</td>');
                        contentContainer.append('<td>'+ list[i].author +'</td>');
                        contentContainer.append('<td>'+ list[i].type +'</td>');
                        contentContainer.append('<td>'+ list[i].publisher +'</td>');
                        contentContainer.append('<td>'+ list[i].publicationdate +'</td>');
                        if (list[i].state == '1'){
                            contentContainer.append('<td>已借阅</td>');
                        }else  if (list[i].state == '2'){
                            contentContainer.append('<td>未借阅</td>');
                        }
                        contentContainer.append('<td>'+ list[i].price +'</td>');
                        contentContainer.append('<td>'+ list[i].comment +'</td>');
                        contentContainer.append('</tr>');
                    }
                }else {
                    popMsg("抱歉，此书籍还未收录在本图书馆！");
                    window.onload = "/library/admin/index";
                    // window.location.href = "/library/admin/index";
                }
            },
            error: function () {
                popMsg("查询错误");
            }
        });
    }
    function control() {
        // layer.alert('酷毙了', {icon: 1});
        alert("完犊子");
    }


</script>