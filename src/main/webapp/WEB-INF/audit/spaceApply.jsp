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
                                <table class="layui-hide" id="spaceApplyInfo" lay-filter="spaceTableEvent"></table>
                                <div class="fy-box" id="space" style="margin-left: 32%"></div>
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

<!--弹窗-->
<div id="pc-window" style="display: none" class="p20 monitor">
    <div>
        <span>213</span>
    </div>
    <div>323</div>
</div>
</body>
</html>
<script>
    var spaceParam = {
        pageNo: 1,
        pageSize: 10,
    };
    spaceList();

    function spaceList() {
        layui.use('table', function () {
            var table = layui.table;
            var laypage = layui.laypage;

            function getApply() {
                $.ajax({
                    url: "spaceApply",
                    type: "POST",
                    data: spaceParam,
                    dateType: "JSON",
                    success: function (ret) {
                        total = ret.total;
                        //首页表格渲染
                        table.render({
                            elem: '#spaceApplyInfo',
                            count: total,
                            page: false, //表示不使用前端分页，强制使用后端请求分页
                            limit: spaceParam.pageSize,
                            data: ret.list,
                            cols: [[
                                {field: 'id', width: '10%', title: '编号', sort: true},
                                {field: 'applicant', width: '10%', title: '申请人姓名',event: 'showApplicantInfo',style:'cursor: pointer;color: blue;font-size: small;text-decoration:underline'},
                                {field: 'applicant_id', width: '10%', title: '申请人学号', sort: true},
                                {field: 'applied_classroom', title: '申请的图书室编号', width: '10%', sort: true},
                                {field: 'create_time', width: '20%', title: '申请时间', sort: true},
                                {field: 'reviewer', width: '15%', title: '审核人', sort: true},
                                {field: 'approval_time', width: '20%', title: '审核通过时间', sort: true},
                                {field: 'occupation_days', width: '15%', title: '使用时长（单位是天）', sort: true},
                                {field: 'approval_status', width: '10%', title: '审核状态'}
                            ]],
                            done: function () {
                                //分页
                                laypage.render({
                                    elem: 'space',
                                    count: total, //数据总数
                                    limit: spaceParam.pageSize,
                                    curr: spaceParam.pageNo,
                                    layout: ['prev', 'page', 'next', 'limit', 'skip'],
                                    jump: function (obj, first) {
                                        if (!first) {
                                            spaceParam.pageNo = obj.curr;
                                            spaceParam.pageSize = obj.limit;
                                            spaceList();
                                        }
                                    },
                                });
                            }
                        });
                        //监听单元格事件
                        table.on('tool(spaceTableEvent)', function(obj){
                            var data = obj.data;
                            if(obj.event === 'showApplicantInfo'){
                                layer.open({
                                    type: 1,
                                    area: ['540px', '460px'],
                                    title: '温馨提示',
                                    content: $("#pc-window").find('form').each(function () {
                                        $(this).get(0).reset()
                                    }).end(),
                                    cancel: function () {
                                        layer.closeAll();
                                    }
                                })
                            }
                        });
                    },
                    error: function () {
                        errorMsg("系统异常");
                    }
                });
            }
            getApply();
        });
    }
</script>