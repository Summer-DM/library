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
                <button type="button" class="layui-btn layui-btn-normal layui-btn-radius" id="userFileUpload">
                    <i class="layui-icon">&#xe67c;</i>导入用户
                </button>
                <a href="#" onclick="getUserFile()" style="color: #cb2027;font-size: large;text-decoration:underline">导入模板下载</a>
            </div>
            <div class="bread-crumb pull-right" style="margin-left: 15px;">
                <button type="button" class="layui-btn layui-btn-normal layui-btn-radius" onclick="userRegist()">用户录入
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
                                {
                                    field: 're', title: '操作', width: '10%', style: 'marg',
                                    templet: function (d) {
                                        return '<a class="btn btn-active" href="deleteUser?userId=' + d.id + '">删除</a>';
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
                                    layout: ['prev', 'page', 'next', 'limit', 'skip'],
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
    function userRegist() {
        window.location.href = "http://localhost:8080/library/user/addUserPage";
    }

    /**
     * 学生批量导入系统
     */
    layui.use('upload', function () {
        var upload = layui.upload;
        var layer = layui.layer;
        // layer.msg('上传中', {icon: 16, time: 0,shade: 0.3});
        //执行实例
        var uploadInst = upload.render({
            elem: '#userFileUpload', //绑定元素
            url: '/library/user/batchAddUser/', //上传接口
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

    function getUserFile() {
        let url = '/library/file/downloadFile?fileType=' + 'user';
        window.open(url, '_blank');
        return false;
    }
</script>