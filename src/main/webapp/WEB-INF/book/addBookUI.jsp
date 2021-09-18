<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <!-- Title and other stuffs -->
    <title>添加管理员</title>
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
            <div class="bread-crumb pull-right">
                <a href="#"><i class="icon-home"></i> 首页</a>
                <span class="divider">/</span>
                <a href="#" class="bread-current">控制台</a>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- Matter -->
        <div class="matter">
            <div class="container">

                <div class="row">
                    <div class="col-md-12">

                        <div class="widget wgreen">

                            <div class="widget-head">
                                <div class="pull-left">添加图书</div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="widget-content">
                                <div class="padd">
                                    <form class="layui-form" action="" method="post">
                                        <div class="layui-form-item">
                                            <label class="layui-form-label">书籍名称</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="bookname" id="bookname" required
                                                       lay-verify="required"
                                                       placeholder="请输入书籍名称" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layui-form-label">作者名称</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="author" id="author" required
                                                       lay-verify="required"
                                                       placeholder="请输入作者名称" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layui-form-label">书籍类型</label>
                                            <div class="layui-input-block">
                                                <select name="btype" id="btype">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layui-form-label">出版单位</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="publisher" id="publisher" required
                                                       lay-verify="required"
                                                       placeholder="请输入出版单位" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layui-form-label">出版时间</label>
                                            <div class="layui-input-block">
                                                <input type="text" class="layui-input" name="publicationdate"
                                                       id="publicationdate" placeholder="年年年年-月月-日日"
                                                       lay-verify="required">
                                            </div>
                                        </div>

                                        <div class="layui-form-item">
                                            <label class="layui-form-label">借阅状态</label>
                                            <div class="layui-input-block">
                                                <input type="radio" name="bookstate" value="2" title="已借阅">
                                                <input type="radio" name="bookstate" value="1" title="未借阅">
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layui-form-label">价格</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="price" id="price" required
                                                       lay-verify="required"
                                                       placeholder="请输入价格" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                        <div class="layui-form-item layui-form-text">
                                            <label class="layui-form-label">备注</label>
                                            <div class="layui-input-block">
                                                <textarea name="comment" id="comment" placeholder="请输入备注"
                                                          class="layui-textarea"></textarea>
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <div class="layui-input-block">
                                                <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                                                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
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
<script type="text/javascript">
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        //渲染日期
        laydate.render({
            elem: '#publicationdate'
        });
    })
    getTypes();

    /**
     * 初始化下拉框
     */
    function getTypes() {
        $.ajax({
            url: "queryBookType",
            type: "POST",
            dateType: "JSON",
            success: function (ret) {
                if (ret.code == 1) {
                    var contentContainer = $("#btype");
                    contentContainer.empty();
                    contentContainer.html('');
                    var list = ret.data;
                    for (var i = 0; i < list.length; i++) {
                        contentContainer.append('<option value=' + list[i]["dic_code"] + '>' + list[i]["dic_value"] + '</option>')
                    }
                    layui.use('form', function () {
                        var form = layui.form;
                        form.render();
                    })
                }
            },
            error: function () {
                errorMsg("系统出错");
            }
        });
    }

    /**
     * 监听提交事件
     */
    layui.use('form', function () {
        var form = layui.form;
        //监听提交
        form.on('submit(formDemo)', function (data) {
            $.ajax({
                url: "addbook",
                data: data.field,
                type: "POST",
                dateType: "JSON",
                success: function (data) {
                    if (data == "success") {
                        successMsg("添加成功！");
                        window.onload = "/library/book/addBookUI";
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

</html>