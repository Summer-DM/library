<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
    .logo-self {
        font-size: 40px;
        text-shadow: 5px 5px 5px black, 0px 0px 2px black;
        color: black;
        padding-left: 40%;
        /*padding-bottom : 70px*/
    }
</style>

<div class="navbar navbar-fixed-top bs-docs-nav" role="banner">
    <div class="conjtainer">
        <!-- 导航开始 -->
        <nav class="collapse navbar-collapse bs-navbar-collapse"
             role="navigation">

            <ul class="nav navbar-nav pull-right">
                <spap><font color="red"> ${username}</font></spap>
                <li class="dropdown pull-right">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#" style="font-size: x-large;"> <i
                            class="icon-user"></i>
                        <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <%--                        <c:if test="${type == '0'}">--%>
                        <%--                            <li><a href="<%=request.getContextPath()%>/user/addAdmin"><i class="icon-edit"></i>--%>
                        <%--                                添加管理员</a></li>--%>
                        <%--                        </c:if>--%>
                        <li><a href="<%=request.getContextPath()%>/admin/updatepwd"><i class="icon-key"></i> 修改密码</a>
                        </li>
                        <li><a href="http://localhost:8080/library/admin/logout"><i class="icon-off"></i> 退出</a></li>
                    </ul>
                </li>
            </ul>
        </nav>

    </div>
</div>

<!-- Header 开始 -->
<header>
    <div class="container">
        <div class="center-main pb20">
            <div class="ptb20 monitor">
                <%--                <div class="logo">--%>
                <%--                    <h1>--%>
                <%--                        <a href="#" style="padding-left: 25px;color: #00F7DE">图书馆<span class="bold"></span></a>--%>
                <%--                    </h1>--%>
                <%--                    <p class="meta" style="padding-left: 40px">后台管理系统</p>--%>
                <%--                </div>--%>
                <div class="layui-carousel" id="test10">
                    <div carousel-item="" style="margin-top: 15px;">
                        <div><img src="<%=request.getContextPath()%>/style/images/1.png"></div>
                        <div><img src="<%=request.getContextPath()%>/style/images/2.png"></div>
                    </div>
                </div>
            </div>
            <div class="mt20 two-area">
                <div class="header-data" style="text-align: end;">

                    <!-- Traffic data -->
                    <div class="hdata">
                        <div class="mcol-left">
                            <!-- Icon with red background -->
                            <i class="icon-signal bred"></i>
                        </div>
                        <div class="mcol-right">
                            <!-- Number of visitors -->
                            <p>
                                <a href="#">31</a> <em>历史</em>
                            </p>
                        </div>
                        <div class="clearfix"></div>
                    </div>

                    <!-- Members data -->
                    <div class="hdata">
                        <div class="mcol-left">
                            <i class="icon-user bblue"></i>
                        </div>
                        <div class="mcol-right">
                            <p>
                                <a href="#">0</a> <em>今天</em>
                            </p>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="mt20 two-area monitor">

                    <!-- Buttons -->
                    <ul class="nav nav-pills">

                        <li class="dropdown dropdown-big"><a class="dropdown-toggle"
                                                             href="#"> <i class="icon-comments"></i> 认证申请 <span
                                class="label label-info">0</span>
                        </a></li>

                        <li class="dropdown dropdown-big"><a class="dropdown-toggle"
                                                             href="#"> <i class="icon-user"></i> 留言 <span
                                class="label label-success">0</span>
                        </a></li>

                    </ul>

                </div>
            </div>
            <div class="logo">
                <h1>
                    <p class="logo-self" >图书馆后台管理系统</p>
                </h1>

            </div>
        </div>
    </div>
</header>

<script>
    layui.use(['carousel', 'form'], function () {
        var carousel = layui.carousel
            , form = layui.form;
        //图片轮播
        carousel.render({
            elem: '#test10'
            , width: '100%'
            , height: '100px'
            , interval: 5000
        });

    });
</script>