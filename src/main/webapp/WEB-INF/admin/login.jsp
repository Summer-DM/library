<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>登录</title>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="../commons/css.jsp"></jsp:include>
    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/style/admin/style/font-awesome.css"/>
    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/style/admin/style/bootstrap.css"/>
    <link href="<%=request.getContextPath()%>/style/admin/css/login.css"
          rel="stylesheet" type="text/css">
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/style/js/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>
</head>

<body class="templatemo-bg-gray">
<div class="container">
    <div class="col-md-12">
        <h1 class="margin-bottom-15">登录界面</h1>
        <form
                class="form-horizontal templatemo-container templatemo-login-form-1 margin-bottom-30"
                role="form" method="post">
            <div class="form-group">
                <div class="col-xs-12">
                    <div class="control-wrapper"
                         style="text-align: center; padding: 0;"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-12">
                    <div class="control-wrapper">
                        <label class="control-label fa-label"><i
                                class="fa fa-user fa-medium icon-user"></i></label> <input
                            class="form-control" id="stuid" name="stuid" placeholder="学号"
                            value="">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-12">
                    <div class="control-wrapper">
                        <label for="password" class="control-label fa-label"><i
                                class="fa fa-lock fa-medium icon-lock"></i></label> <input
                            type="password" class="form-control" id="password"
                            name="password" placeholder="Password" value="123456">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-12">
                    <div class="control-wrapper" style="text-align: center;">
                        <input type="button" value="登录" class="btn btn-info"
                               onclick="login()">
                    </div>
                </div>
            </div>
            <hr>
        </form>
    </div>
</div>
</body>
</html>
<script>
    function login() {
        var stuid = $("#stuid").val();//获取账号
        console.log(stuid)
        var password = $("#password").val();//获取密码
        $.ajax({
                url: "toIndex",//登录地址
                data: {
                    "stuid": stuid,
                    "password": password,
                },
                success: function (data) {//请求成功函数
                    if (data == "index") {
                        //页面跳转-》主页面
                        window.location.href = "index"
                    } else if (data == "false") {
                        errorMsg("用户不存在，请前往注册或者重新输入正确的用户")
                    }
                },
                error: function () {//请求失败函数
                    errorMsg("登录失败");
                }
            }
        );
    }
</script>