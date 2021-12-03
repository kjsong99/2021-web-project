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
    <meta charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>index</title>
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
        .sidenav {
            height:100%;
            position:fixed;
            top:80px;
        }
        .sidenav a{
            color:#000000;
            font-size: 15px;
            display:block;
        }
        .main {
            margin-left: 300px;
        }
        .container a {
            color:#000000;
            font-size: 15px;
            display:block;
            text-align: center;
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

<div class="main">
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
    <c:if test="${auth > 1}">
        <button class="btn btn-light" onclick="bookWrite()" style="float: right; margin-right: 100px; margin-top: 10px">책 등록</button></p>
    </c:if>
    <div class="search row" style="padding-top: 10px">
        <form action="index.jsp" method="get">
            <div class="col-xs-2">
                <select class="form-control" name="target">
                    <option value="TITLE" selected>제목</option>
                    <option value="WRITER">작가</option>
                </select>
            </div>
            <div class="col-xs-6">
                <div class="input-group">
                    <input class="form-control" type="text" name="search" size="10">
                    <span class="input-group-btn">
                            <input class="btn btn-light" type="submit" value="검색">
                        </span>
                </div>
            </div>
            <input type="hidden" name="category" value="<%=category%>">
        </form>
    </div>

    <div class="container">
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
                        <ul style="display: inline-block; margin-top: 10px; margin-left: 10px; margin-right: 20px; margin-bottom: 10px">
                            <li style="display: inline-block; margin-top: 10px; margin-left: 10px; margin-right: 20px; margin-bottom: 10px">
                                <div><img width="140" height="170" src="blob_print.jsp?num=${num}"></div>
                                <div><a href="book_info.jsp?num=${num}">${book['title']}</a> </div>
                                <div style="text-align: center">${book['price']}</div>
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
                                <div style="text-align: center">${book['price']}</div>
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
                                <div style="text-align: center">${book['price']}</div>
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
                                <div style="text-align: center">${book['price']}</div>
                            </li>
                        </ul>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </c:if>

        <br>
        <c:set var="count" value="<%=count%>"/>
        <c:choose>
            <c:when test="${count%8 eq 0}">
                <c:forEach var="i" step="1" begin="1" end="${count/8}">
                    <c:choose>
                        <c:when test="${category eq null or category eq '전체'}">
                            <c:choose>
                                <c:when test="${search eq null or target eq null}">
                                    <nav aria-label="...">
                                        <ul class="pagination">
                                            <li class="page-item">
                                                <a class="page-link" href="#" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                    <span class="sr-only">Previous</span>
                                                </a>
                                            </li>
                                            <li class="page-item"><a class="page-link" href="/index.jsp?page=${i}">${i}</a></li>
                                            <li class="page-item">
                                                <a class="page-link" href="#" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                    <span class="sr-only">Next</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
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


</div>

<div class="sidenav">
    <nav id="sidebar" style="height:100%; min-height:100%; background-color: rgba(180,180,180,0.23); width: 200px; ">
        <div class="sidebar-header" onclick="notice()" style="padding-top: 20px; padding-bottom: 20px">
            <h3>공지사항</h3>
        </div>
        <ul class="list-unstyled components">
            <li>
                <%
                    request.setCharacterEncoding("utf-8");
                    ArrayList<HashMap<String,String>> noticeList=new ArrayList<>();
                    noticeList= Notice.getIndexNotice();
                %>
                <c:set var="noticeList" value="<%=noticeList%>"/>
                <c:forEach var="notice" items="${noticeList}">
                    <p><a href="notice_info.jsp?num=${notice['num']}" style="font-size: medium">${notice['title']}</a></p>
                </c:forEach>
            </li>
        </ul>
    </nav>
</div>

<%-- 애니메이션을 담당하는 자바스크립트 참조 --%>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>