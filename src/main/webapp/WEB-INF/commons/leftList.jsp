<%@ page import="com.example.library.model.User" %><%--
  Created by IntelliJ IDEA.
  User: Summer_DM
  Date: 2021/9/11
  Time: 上午 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    User user = (User) request.getSession().getAttribute("user");
    System.out.println("用户信息："+user);
    String type = "";
    if (null != user){
        type = user.getType();
    }
%>
<div class="sidebar">
    <div class="sidebar-dropdown">
        <a href="#">导航</a>
    </div>
    <ul id="nav" class="admin" style="display: none">
        <li>
            <a href="http://localhost:8080/library/admin/index"><i class="icon-home"></i> 首页</a>
        </li>
        <li >
            <a href="http://localhost:8080/library/book/booklist"><i class="icon-building"></i> 图书管理 </a>
        </li>
        <li>
            <a href="http://localhost:8080/library/user/findAllStu"><i class="icon-user"></i>用户管理</a>
        </li>
        <li>
            <a href="http://localhost:8080/library/borrow/allBorrowbooks"><i class="icon-user"></i>借阅信息</a>
        </li>
    </ul>
    <ul id="nav" class="student" style="display: none">
        <li>
            <a href="http://localhost:8080/library/admin/index"><i class="icon-home"></i> 首页</a>
        </li>
        <li>
            <a href="http://localhost:8080/library/borrow/borrowbooklist" ><i class="icon-building"></i> 图书借阅 <span class="pull-right"><i class="icon-chevron-right"></i></span></a>
        </li>
        <li>
            <a href="http://localhost:8080/library/borrow/myBorrow"><i class="icon-building"></i> 我的借阅 <span class="pull-right"><i class="icon-chevron-right"></i></span></a>
        </li>
    </ul>
</div>

<script>
    //初始化頁面左側菜單
    student();
    function student(){
        var userType = <%=type%>;
        console.log(userType);
        if (userType == "1"){
            $(".admin").hide(1);
            $(".student").show();
        }else  if (userType == "0"){
            $(".student").hide(1);
            $(".admin").show();
        }
    }
</script>

