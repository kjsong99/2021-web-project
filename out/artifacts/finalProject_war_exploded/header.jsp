<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-default" style="height: 80px">
    <div class="container-fluid">
        <div class="navbar-header" style="margin-left: 30px; margin-right: 50px;">
            <a class="navbar-brand" href="index.jsp" style="padding-bottom: 20px">
                <img src="/resources/NicePng_high-five-png_2356042.png" style="display:block; margin:0 auto;" width="35" height="35" class="d-inline-block align-text-top" alt="">
                <span style="font-weight:bold;">Second-Hand</span>
            </a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="padding-top: 5px">
            <ul class="nav navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="/index.jsp?category=전체">전체</a></li>
                <li class="nav-item">
                    <a class="nav-link" href="/index.jsp?category=소설">소설</a></li>
                <li class="nav-item">
                    <a class="nav-link" href="/index.jsp?category=기술서적">기술서적</a></li>
                <li class="nav-item">
                    <a class="nav-link" href="/index.jsp?category=에세이">에세이</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <%
                    int auth= 0;
                    if(session.getAttribute("auth")!=null){
                        auth= (int) session.getAttribute("auth");
                    }
                    if(session.getAttribute("id")==null){
                        out.println("<li><a href=\"login.jsp\">로그인</a></li> ");
                        out.println("<li><a href=\"join.jsp\">회원가입</a></li>");
                    }
                    else{
                        String id= String.valueOf(session.getAttribute("id"));
                        out.println("<li><a>"+id+" 님</a></li>");
                        out.println("<li><a href=\"./user_page.jsp?nav=user\">MY PAGE</a></li>");
                        out.println("<li><a href=\"logout.jsp\">로그아웃</a></li>");
                    }
                %>
                <c:set value="<%=auth%>" var="auth"/>
            </ul>
        </div>
    </div>
</nav>
