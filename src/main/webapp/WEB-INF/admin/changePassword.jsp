<%--
  Created by IntelliJ IDEA.
  User: Summer_DM
  Date: 2021/9/18
  Time: 下午 09:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title>修改密码</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="../commons/css.jsp"></jsp:include>
</head>
<body>
<!-- 头部 -->
<jsp:include page="../commons/head.jsp"></jsp:include>
<!-- 左边菜单 -->
<jsp:include page="../commons/leftList.jsp"></jsp:include>
<jsp:include page="../commons/litleTile.jsp"></jsp:include>
<div class="mainbar">
    <!-- Matter -->
    <div class="matter">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="widget wgreen">
                        <div class="widget-content">
                            <div class="padd">
                                <!-- Form starts.  -->
                                <form class="layui-form" action="">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">原始密码</label>
                                        <div class="layui-input-block">
                                            <input type="password" name="oldPassword" required lay-verify="required"
                                                   placeholder="请输入原始密码" autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">新密码</label>
                                        <div class="layui-input-block">
                                            <input type="password" name="newPassword" required lay-verify="required"
                                                   placeholder="请输入新密码" autocomplete="off" class="layui-input">
                                        </div>
                                        <div class="layui-form" style="margin-left: 110px;color: #cb2027">
                                            8-16位字符，必须包含数字/字母2种组合，不能有中文、特殊字符
                                        </div>
<%--                                        <div class="reg-error" style="display: block;display:none;"><i--%>
<%--                                                class="layui-icon layui-icon-close-fill"></i>密码格式不正确，请重新输入--%>
<%--                                        </div>--%>
<%--                                        <div class="reg-right" style="display: block;display:none;"><i--%>
<%--                                                class="layui-icon layui-icon-ok"></i></div>--%>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">确定密码</label>
                                        <div class="layui-input-block">
                                            <input type="password" name="newConfirmPassword" required lay-verify="required"
                                                   placeholder="请再次输入新密码" autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-input-block">
                                            <button class="layui-btn" lay-submit lay-filter="submitNewPassword">立即提交
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
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
    //Demo
    layui.use(['form','layer'], function () {
        var form = layui.form;
        var layer = layui.layer;

        //监听提交
        form.on('submit(submitNewPassword)', function (data) {
            $.ajax({
                url: "updatePassword",
                data: data.field,
                type: "POST",
                dateType: "JSON",
                success: function (ret) {
                    if (ret.code == 1) {
                        layer.msg("密码修改成功，即将前往首页......", {icon:1,time:1500, shade:0.4}, function (){
                            location.href = '/library/admin/login';
                        });
                        // alert("修改成功")
                        // layer.alert("密码修改成功，即将前往首页......",function (index) {
                        //     layer.close(index);
                        //     window.location.href = '/library/admin/login';
                        // });
                    } else {
                        errorMsg("添加失败");
                    }
                },
                error: function () {
                    errorMsg("系统出错");
                }
            });
        });
    });
</script>