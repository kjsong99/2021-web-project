<%@ page import="com.example.finalproject.dbConnection" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.finalproject.Book" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.finalproject.Notice" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>index</title>
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
    </style>
    <script>
        function login(){
            location.href="login.jsp"
        }

        function join() {
            location.href="join.jsp"
        }

        function logout(){
            location.href="logout.jsp"
        }

        function bookWrite(){
            location.href="book_write.jsp"
        }

        function notice(){
            location.href="notice_board.jsp?page=1"
        }
    </script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>


<%
    int auth= 0;
    if(session.getAttribute("auth")!=null){
        auth= (int) session.getAttribute("auth");
    }
    if(session.getAttribute("id")==null){
        out.println(
                "<p><button onclick=\"login()\">로그인</button> " +
                "<button onclick=\"join()\">회원가입</button></p>"
        );
    }
    else{
        String id= String.valueOf(session.getAttribute("id"));
        out.print("<p><a href=\'./user_page.jsp?nav=user\'>"+id+"</a>님 ");
        out.println(
                "<button onclick=\"logout()\">로그아웃</button></p>"
        );
    }
%>
<c:set value="<%=auth%>" var="auth"/>

<%--<div class="left">--%>
<%--    <p>카테고리</p>--%>
<%--    <p><a href="/index.jsp?category=전체">전체</a></p>--%>
<%--    <p><a href="/index.jsp?category=소설">소설</a></p>--%>
<%--    <p><a href="/index.jsp?category=기술서적">기술서적</a></p>--%>
<%--    <p><a href="/index.jsp?category=에세이">에세이</a></p>--%>
<%--</div>--%>
<nav style="float: right">
    <ul>
        <li><a href="/index.jsp?category=전체">전체</a></li>
        <li><a href="/index.jsp?category=소설">소설</a></li>
        <li><a href="/index.jsp?category=기술서적">기술서적</a></li>
        <li><a href="/index.jsp?category=에세이">에세이</a></li>
    </ul>
</nav>


<div class="right">

    <%
        request.setCharacterEncoding("utf-8");
        String category="전체";
        if(request.getParameter("category")!=null){
            category=request.getParameter("category");
        }
        String target=request.getParameter("target");
        String search=request.getParameter("search");
        int count=0;
        int pageNum=1;
        if(request.getParameter("page")!=null){
            pageNum= Integer.parseInt(request.getParameter("page"));
        }

        System.out.println(search);
    %>
    <c:set var="category" value="<%=category%>"/>
    <c:set var="page" value="<%=pageNum%>"/>
    <p>
        <c:choose>
            <c:when test="${category eq null}"><h3>전체</h3></c:when>
            <c:otherwise><h3><%=category%></h3></c:otherwise>
        </c:choose>
<%--    <c:set var="auth" value="<%=(int)request.getSession().getAttribute("auth")%>"/>--%>
    <c:if test="${auth > 1}">
        <button onclick="bookWrite()" style="float: right; margin: 10px;">등록</button></p>
    </c:if>

    <p>
    <form action="index.jsp" method="get">
        <select name="target">
            <option value="TITLE" selected>제목</option>
            <option value="WRITER">작가</option>
        </select>
        <input type="text" name="search" size="10">
        <input type="submit" value="검색">
        <input type="hidden" name="category" value="<%=category%>">
    </form>
    </p>

    <c:set var="category" value="<%=category%>"/>
    <c:set var="search" value="<%=search%>"/>
    <c:set var="target" value="<%=target%>"/>
    <c:if test="${empty search}">
        <c:choose>
            <c:when test="${empty category or category eq '전체'}">
                <%
                    ArrayList<HashMap<String,String>> bookList= Book.getBook(pageNum);
                    count=Book.getBookCount();
                %>
                <c:set var="sell" value="<%=bookList%>"/>
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
            <c:otherwise>
                <%
                    ArrayList<HashMap<String,String>> categoryBookList= Book.getCategoryBook(category,pageNum);
                    count=Book.getCategoryBookCount(category);
                %>
                <c:set var="sell" value="<%=categoryBookList%>"/>
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
            </c:otherwise>
        </c:choose>
    </c:if>

    <c:if test="${not empty search}">
        <c:choose>
            <c:when test="${category eq 'null' or category eq '전체'}">
                <%
                    ArrayList<HashMap<String,String>> bookList= Book.getBookSearch(search,target,pageNum);
                    count=Book.getBookSearchCount(target,search);
                %>
                <c:set var="sell" value="<%=bookList%>"/>
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
            <c:otherwise>
                <%
                    ArrayList<HashMap<String,String>> categoryBookList= Book.getCategoryBookSearch(category,search,target,pageNum);
                    count=Book.getCategoryBookSearchCount(category,target,search);
                %>
                <c:set var="sell" value="<%=categoryBookList%>"/>
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
            </c:otherwise>
        </c:choose>
    </c:if>
<%--    <c:choose>--%>
<%--        <c:when test="${category eq null or category eq '전체'}">--%>
<%--            <c:choose>--%>
<%--                <c:when test="${empty search or empty target}">--%>
<%--                    <%--%>

<%--                    %>--%>
<%--                </c:when>--%>
<%--                <c:otherwise>--%>
<%--                    <%--%>

<%--                    %>--%>
<%--                </c:otherwise>--%>
<%--            </c:choose>--%>
<%--        </c:when>--%>
<%--        <c:otherwise>--%>
<%--            <c:choose>--%>
<%--                <c:when test="${empty search or empty target}">--%>
<%--                    <%--%>

<%--                    %>--%>
<%--                </c:when>--%>
<%--                <c:otherwise>--%>
<%--                    <%--%>

<%--                    %>--%>
<%--                </c:otherwise>--%>
<%--            </c:choose>--%>
<%--        </c:otherwise>--%>
<%--    </c:choose>--%>
    <br>
    <c:set var="count" value="<%=count%>"/>
    <c:choose>
        <c:when test="${count%8 eq 0}">
            <c:forEach var="i" step="1" begin="1" end="${count/8}">
                <c:choose>
                    <c:when test="${category eq null or category eq '전체'}">
                        <c:choose>
                            <c:when test="${search eq null or target eq null}">
                                <a href="/index.jsp?page=${i}">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/index.jsp?page=${i}&search=${search}&target=${target}}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${search eq null or target eq null}">
                                <a href="/index.jsp?page=${i}&category=${category}">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/index.jsp?page=${i}&category=${category}&search=${search}&target=${target}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>

            </c:forEach>
        </c:when>
        <c:otherwise>
            <c:forEach var="i" step="1" begin="0" end="${(count/8)}">
                <c:choose>
                    <c:when test="${category eq null or category eq '전체'}">
                        <c:choose>
                            <c:when test="${search eq null or target eq null}">
                                <a href="/index.jsp?page=${i+1}">${i+1}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/index.jsp?page=${i+1}&search=${search}&target=${target}}">${i+1}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${search eq null or target eq null}">
                                <a href="/index.jsp?page=${i+1}&category=${category}">${i+1}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/index.jsp?page=${i+1}&category=${category}&search=${search}&target=${target}">${i+1}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:otherwise>
    </c:choose>



</div>

<div class="left">
    <p>공지사항 <button onclick="notice()" style="float: right; margin: 10px;">더보기</button> </p>
    <%

        request.setCharacterEncoding("utf-8");
        ArrayList<HashMap<String,String>> noticeList=new ArrayList<>();
        noticeList= Notice.getIndexNotice();
    %>
    <c:set var="noticeList" value="<%=noticeList%>"/>
    <c:forEach var="notice" items="${noticeList}">
        <p><a href="notice_info.jsp?num=${notice['num']}">${notice['title']}</a></p>
    </c:forEach>

<%--    책 검색 기능 구현 (마이페이지 서블릿 및 jsp 파일 생성--%>

</div>

</body>
</html>