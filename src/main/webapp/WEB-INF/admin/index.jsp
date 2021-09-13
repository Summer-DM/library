<%--
  Created by IntelliJ IDEA.
  User: Summer_DM
  Date: 2021/9/13
  Time: 上午 09:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title>首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="../commons/css.jsp"></jsp:include>
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
                            <div class="widget-head">
                                <div class="pull-left">未来7天使用信息</div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="widget-content">
                                <table class="table table-striped table-bordered table-hover"
                                       style="table-layout: fixed;">
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
    function showTime(n){
        var date = new Date() ;
        var year,month,day ;
        date.setDate(date.getDate()+n);
        year = date.getFullYear();
        month = date.getMonth()+1;
        day = date.getDate() ;
        s = year + '-' + ( month < 10 ? ( '0' + month ) : month ) + '-' + ( day < 10 ? ( '0' + day ) : day) ;
        return s ;
    }
    function showInfo(){
        var contentContainer = $("#table-header");
        contentContainer.empty();
        contentContainer.html('');
        for(var i =1; i < 8;i++){
            contentContainer.append('<th class="text-center">'+showTime(i) +'</th>');
        }
    }

    function control(){
        // layer.alert('酷毙了', {icon: 1});
        alert("完犊子");
    }
</script>