<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.finalproject.Notice" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
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
    </style>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:include page="header.jsp"></jsp:include>
<div class = "container">
    <script>
        function write(){
            location.href="notice_write.jsp"
        }
    </script>
    <%
        int auth= 0;
        if(session.getAttribute("auth")!=null){
            auth= (int) session.getAttribute("auth");
        }
    %>
    <c:set value="<%=auth%>" var="auth"/>
    <h2>공지사항</h2>

    <div class="search row" style="padding-top:20px; padding-bottom:20px">
        <form action="notice_board.jsp" method="get">
            <div class="col-xs-2 col-sm-2">
                <select name="target" class="form-control">
                    <option value="TITLE" selected>제목</option>
                    <option value="CONTENT">내용</option>
                </select>
            </div>
            <div class="col-xs-10 col-sm-10">
                <div class="input-group">
                    <input type="text" name="search" size="10" class="form-control">
                    <span class="input-group-btn">
                        <input type="submit" class="btn btn-default" value="검색">
                    </span>
                </div>
            </div>
        </form>
    </div>

    <table class="table table-hover">
        <thead>
        <tr>
            <td>번호</td>
            <td>제목</td>
            <td>등록일</td>
        </tr>
        </thead>
        <%
            int count=0;
            String target=request.getParameter("target");
            String search=request.getParameter("search");
            int pageNum=1;
            if(request.getParameter("page")!=null){
                pageNum= Integer.parseInt(request.getParameter("page"));
            }
        %>
        <c:set var="target" value="<%=target%>"/>
        <c:set var="search" value="<%=search%>"/>
        <c:set var="pageNum" value="<%=pageNum%>"/>

        <c:choose>
            <c:when test="${target eq null or search eq null}">
                <%
                    ArrayList<HashMap<String,String>> noticeList=new ArrayList<HashMap<String,String>>();
                    noticeList= Notice.getNoticeList(pageNum);
                    count=Notice.getNoticeCount();
                %>
                <c:set var="noticeList" value="<%=noticeList%>"/>
                <c:forEach var="notice" items="${noticeList}">
                    <tr>
                        <td>${notice['num']}</td>
                        <td><a href="notice_info.jsp?num=${notice['num']}">${notice['title']}</a></td>

                        <td>${notice['date']}</td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <%
                    ArrayList<HashMap<String,String>> searchNoticeList=new ArrayList<HashMap<String,String>>();
                    searchNoticeList= Notice.getSearchNotice(pageNum,search,target);
                    count=Notice.getSearchNoticeCount(target,search);
                %>
                <c:set var="searchNoticeList" value="<%=searchNoticeList%>"/>
                <c:forEach var="notice" items="${searchNoticeList}">
                    <tr>
                        <td>${notice['num']}</td>
                        <td><a href="notice_info.jsp?num=${notice['num']}">${notice['title']}</a></td>
                        <td>${notice['date']}</td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <c:set var="count" value="<%=count%>"/>
    </table>


    <div class="jb-center">
        <ul class="pagination">
            <c:choose>
                <c:when test="${count%10 eq 0}">
                    <c:forEach begin="1" end="${count/10}" step="1" var="i">
                        <c:choose>
                            <c:when test="${search eq null or target eq null}">
                                <a href="notice_board.jsp?page=${i}">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <li <c:out value="${pageMarker.cri.page == idx ? 'class=active' : ''}"/> ></li>
                                <a href="notice_board.jsp?page=${i}&search=${search}&target=${target}">${i}</a>
                            </c:otherwise>
                        </c:choose>

                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <c:forEach begin="1" end="${count/10+1}" step="1" var="i">
                        <c:choose>
                            <c:when test="${search eq null or target eq null}">
                                <a href="notice_board.jsp?page=${i}">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="notice_board.jsp?page=${i}&search=${search}&target=${target}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>

    <c:if test="${auth > 1}">
        <a href="notice_write.jsp">글쓰기</a>
    </c:if>

</div>
</body>
</html>