<%--<%@ page isELIgnored="false"%>--%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="com.example.finalproject.User" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <meta charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>book_write</title>
    <!-- 부트스트랩 css 사용 -->
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <style>
        ul li { display:inline-block; margin:10px;  }
        nav{
            width: 100%;
            text-align: center;
        }
        div.left {
            height:600px;
            width: 23%;
            float: left;
            box-sizing: border-box;
            margin: 1%;

        }
        div.right {
            height: 600px;
            width: 73%;
            float: right;
            box-sizing: border-box;
            margin: 1%;
        }
        ul{
            list-style: none;
        }
        label{
            width: 100px;
            display: inline-block;
        }
        fieldset{
            width: 1000px;
        }
        .divFrame{
            border: 3px solid rgba(180,180,180,0.23);
            padding-right:300px;
            margin-top:10px;
            padding-top:30px;
            width:1000px;
        }
        .sidenav {
            height:100%;
            position:fixed;
            top:80px;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<%
    int auth= 0;
    if(session.getAttribute("auth")!=null){
        auth= (int) session.getAttribute("auth");
    }
%>
<c:set value="<%=auth%>" var="auth"/>

<div class="sidenav">
    <nav id="sidebar" style="height:100%; min-height:100%; background-color: rgba(180,180,180,0.23); width: 200px; ">
        <div class="sidebar-header" style="padding-top: 20px; padding-bottom: 20px">
            <h3>MY PAGE</h3>
        </div>
        <ul class="list-unstyled components">
            <p><a href="user_page.jsp?nav=user">유저정보</a></p>
            <p><a href="user_page.jsp?nav=cart">찜목록</a></p>
            <c:if test="${auth > 1}">
                <p><a href="user_page.jsp?nav=sold">판매내역</a></p>
                <p><a href="user_page.jsp?nav=sell">판매중</a></p>
            </c:if>
        </ul>
    </nav>

</div>


<div style="width: 80%; float: right">
    <%
        String name="";
        String phone="";
        String sex="";
        String birth="";
        String nickname="";
        int count=0;
        String nav=request.getParameter("nav").trim();
        int pageNum=1;
        if(request.getParameter("page")!=null){
            pageNum= Integer.parseInt(request.getParameter("page"));
        }
        System.out.println(nav);
        String id= String.valueOf(session.getAttribute("id"));
        Connection con= dbConnection.connect();
        String user="user";
    %>
    <c:set var="nav" value="<%=nav%>"></c:set>
    <c:set var="page" value="<%=pageNum%>"/>
    <c:choose>
        <c:when test="${nav eq 'user'}">
            <%
                HashMap<String,String> info=new HashMap<String,String>();
                info=User.userInfo(id);
                name=info.get("name");
                phone=info.get("phone");
                sex=info.get("sex");
                birth=info.get("birth");
                nickname=info.get("nickname");
            %>
            <h1>유저정보</h1>
            <div class="divFrame">
                <ul>
                    <p>
                        <label>아이디</label>
                        <%=id%><br>
                    </p>
                    <p>
                        <label>이름</label>
                        <%=name%><br>
                    </p>
                    <p>
                        <label>닉네임</label>
                        <%=nickname%><br>
                    </p>
                    <p>
                        <label>전화번호</label>
                        <%=phone%><br>
                    </p>
                    <p>
                        <label>성별</label>
                        <%=sex%><br>
                    </p>
                    <p>
                        <label>생년월일</label>
                        <%=birth%><br>
                    </p>
                </ul>
            </div>
            <a href="/modify.jsp?username=<%=id%>" style="padding-right: 10px">정보수정</a>
            <a href="/userDelete?username=<%=id%>">탈퇴</a>
        </c:when>
        <c:when test="${nav eq 'sell'}">
            <h1>판매중</h1>
            <hr size="2px">
            <%
                String title="";
                String price="";
                int num=0;

                ArrayList<HashMap<String,String>> sell=User.sellBook(id,pageNum);
                count=User.sellBookCount(id);
            %>
            <c:set var="sell" value="<%=sell%>"/>
            <c:forEach var="book" items="${sell}">
                <c:set var="num" value="${book['number']}"/>
                <ul style="display: inline-block; margin: 10px">
                    <li style="display: inline-block; margin: 10px">
                        <div><img width="140" height="170" src="blob_print.jsp?num=${num}"></div>
                        <div><a href="book_info.jsp?num=${num}">${book['title']}</a> </div>
                        <div>${book['price']}</div>
                    </li>
                </ul>
            </c:forEach>
        </c:when>
        <c:when test="${nav eq 'sold'}">
            <h1>판매내역</h1>
            <hr size="2px">
            <%
                String title="";
                String price="";
                int num=0;
                ArrayList<HashMap<String,String>> sell=User.soldBook(id,pageNum);
                count=User.soldBookCount(id);
            %>
            <c:set var="sell" value="<%=sell%>"/>
            <c:forEach var="book" items="${sell}">
                <c:set var="num" value="${book['number']}"/>
                <ul style="display: inline-block; margin: 10px">
                    <li style="display: inline-block; margin: 10px">
                        <div><img width="140" height="170" src="blob_print.jsp?num=${num}"></div>
                        <div><a href="book_info.jsp?num=${num}">${book['title']}</a> </div>
                        <div>${book['price']}</div>
                    </li>
                </ul>
            </c:forEach>
        </c:when>
        <c:when test="${nav eq 'cart'}">
            <%
                String title="";
                String price="";
                int num=0;
                ArrayList<HashMap<String,String>> cartList=User.getCartBook(id,pageNum);
                count=User.cartBookCount(id);
            %>
            <c:set var="sell" value="<%=cartList%>"/>
            <c:forEach var="book" items="${sell}">
                <c:set var="num" value="${book['number']}"/>
                <ul style="display: inline-block; margin: 10px">
                    <li style="display: inline-block; margin: 10px">
                        <div><img width="140" height="170" src="blob_print.jsp?num=${num}"></div>
                        <div><a href="book_info.jsp?num=${num}">${book['title']}</a> </div>
                        <div>${book['price']}</div>
                    </li>
                </ul>
            </c:forEach>
        </c:when>
    </c:choose>
    <br>
    <c:set var="count" value="<%=count%>"/>
    <c:choose>
        <c:when test="${count%8 eq 0}">
            <c:forEach var="i" step="1" begin="1" end="${count/8}">
                <a href="user_page.jsp?nav=${nav}&page=${i}">${i}</a>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <c:forEach var="i" step="1" begin="0" end="${count/8}">
                <a href="user_page.jsp?nav=${nav}&page=${i+1}">${i+1}</a>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>