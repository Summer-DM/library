<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title>学生注册</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="../commons/css.jsp"></jsp:include>
</head>
<body>

<!-- Matter -->
<div class="matter">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="widget wgreen">
                    <div class="widget-head">
                        <div class="pull-left" style="margin-left: 50%;color: #0C0C0C">学生录入</div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                        <div class="padd">
                            <form class="layui-form" action="" method="post">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">姓名</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="username" id="username" required
                                               lay-verify="required"
                                               placeholder="姓名" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">性别</label>
                                    <div class="layui-input-block">
                                        <input type="radio" name="sex" value="1" title="男">
                                        <input type="radio" name="sex" value="2" title="女">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">电话</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="tel" id="tel" required
                                               lay-verify="required"
                                               placeholder="电话" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">学院</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="institute" id="institute" required
                                               lay-verify="required"
                                               placeholder="学院" autocomplete="off" class="layui-input">
                                    </div>
                                </div>

                                <div class="layui-form-item">
                                    <label class="layui-form-label">专业</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="profession" id="profession" required
                                               lay-verify="required"
                                               placeholder="专业" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">班级</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="classname" id="classname" required
                                               lay-verify="required"
                                               placeholder="班级" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">学号</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="stuid" id="stuid" required
                                               lay-verify="required"
                                               placeholder="学号" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">密码</label>
                                    <div class="layui-input-block">
                                        <input type="password" name="password" id="password" required
                                               lay-verify="required"
                                               placeholder="密码" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-submit lay-filter="addUser"
                                                style="margin-left: 35%">立即提交
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
<div class="clearfix" style="margin-bottom: 10%"></div>

<!-- 底部 -->
<jsp:include page="../commons/foot.jsp"></jsp:include>

<!-- 快速回到顶部 -->
<span class="totop"><a href="#"><i class="icon-chevron-up"></i></a></span>
</body>
</html>
<script type="text/javascript">
    layui.use('form', function () {
        var form = layui.form;
        //监听提交
        form.on('submit(addUser)', function (data) {
            $.ajax({
                url: "addUser",
                data: data.field,
                type: "POST",
                dateType: "JSON",
                success: function (ret) {
                    if (ret.size > 0) {
                        successMsg("添加成功！");
                        window.onload = "/library/user/findAllStu";
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
