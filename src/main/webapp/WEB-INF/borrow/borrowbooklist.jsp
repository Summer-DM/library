<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<jsp:include page="../commons/stuhead.jsp"></jsp:include>
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
                                <table class="table table-striped table-bordered table-hover">
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
                                        <th>操作</th>

                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${booklist }" var="book">
                                        <tr>
                                            <td>${book.bid }</td>
                                            <td>${book.bookname }</td>
                                            <td>${book.author }</td>
                                            <td>${book.booktype }</td>
                                            <td>${book.publisher }</td>
                                            <td>${book.publicationdate }</td>
                                            <td>${book.price }</td>
                                            <c:if test="${book.bookstate eq '1'}">
                                                <td>未借阅</td>
                                            </c:if>
                                            <c:if test="${book.bookstate eq '2'}">
                                                <td>已借阅</td>
                                            </c:if>
                                            <td>${book.comment }</td>
                                            <c:if test="${book.bookstate eq '1'}">
                                            <td>
                                                <a  class="btn btn-active" href="http://localhost:8080/library/borrow/borrowbook?bookname=${book.bookname}&bid=${book.bid}">借阅</a>
                                            </td>
                                            </c:if>
                                            <c:if test="${book.bookstate eq '2'}">
                                                <td>已借阅</td>
                                            </c:if>
                                        </tr>
                                    </c:forEach>
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
<script>

</script>

</html>