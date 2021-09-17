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
                <button type="button" class="layui-btn layui-btn-normal layui-btn-radius" onclick="userRegist()">用户录入</button>
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
                                <table class="layui-hide" id="userInfo"></table>
                                <div class="fy-box" id="demo3" style="margin-left: 32%"></div>
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
    var userParam = {
        pageNo: 1,
        pageSize: 10,
    };
    userList();
    function userList() {
        layui.use('table', function () {
            var table = layui.table;
            var laypage = layui.laypage;
            function getUsers() {
                $.ajax({
                    url: "queryUsers",
                    type: "POST",
                    data: userParam,
                    dateType: "JSON",
                    success: function (ret) {
                        if (ret.size > 0) {
                            total = ret.total;
                            //首页表格渲染
                            table.render({
                                elem: '#userInfo',
                                count: total,
                                page: false, //表示不使用前端分页，强制使用后端请求分页
                                limit: userParam.pageSize,
                                data: ret.list,
                                cols: [[
                                    {field: 'id', width: '10%', title: '学生ID', sort: true},
                                    {field: 'username', width: '10%', title: '学生姓名'},
                                    {field: 'stuid', title: '学号', width: '10%', sort: true},
                                    {field: 'sex', width: '10%', title: '性别'},
                                    {field: 'tel', width: '10%', title: '电话'},
                                    {field: 'institute', title: '学院', width: '15%'},
                                    {field: 'profession', title: '专业', width: '15%'},
                                    {field: 'classname', title: '班级', width: '10%'},
                                    {field: 're', title: '操作', width: '10%',style:'marg',
                                        templet: function (d) {
                                            return '<a class="btn btn-active" href="deleteUser?userId='+d.id+'">删除</a>';
                                        }
                                    }
                                ]],
                                done: function () {
                                    //分页
                                    laypage.render({
                                        elem: 'demo3',
                                        count: total, //数据总数
                                        limit: userParam.pageSize,
                                        curr: userParam.pageNo,
                                        layout:['prev', 'page', 'next' , 'limit' , 'skip'],
                                        jump: function (obj, first) {
                                            if (!first) {
                                                userParam.pageNo = obj.curr;
                                                userParam.pageSize = obj.limit;
                                                userList();
                                            }
                                        },
                                    });
                                }
                            });
                        } else {
                            errorMsg("服务错误");
                            // window.onload = "/library/admin/index";
                        }
                    },
                    error: function () {
                        errorMsg("系统异常");
                    }
                });
            }
            getUsers();
        });
    }
    /**
     * 新增用户
     */
    function userRegist(){
       window.location.href="http://localhost:8080/library/user/addUserPage";
    }
</script>