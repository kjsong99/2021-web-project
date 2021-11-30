<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.finalproject.Notice" %><%--
  Created by IntelliJ IDEA.
  User: song-gyeongjin
  Date: 2021/11/01
  Time: 2:15 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시판1</title>

</head>
<body>
<script>
    function write(){
        location.href="notice_write.jsp"
    }
</script>
<jsp:include page="header.jsp"></jsp:include>
    <h1>공지사항</h1>
    <a href="notice_write.jsp">글쓰기</a>
    <form action="notice_board.jsp" method="get">
        <select name="target">
            <option value="TITLE" selected>제목</option>
            <option value="CONTENT">내용</option>
        </select>
        <input type="text" name="search" size="10">
        <input type="submit" value="검색">
    </form>
    <table>
        <tr>
            <td>번호</td>
            <td>제목</td>
            <td>등록일</td>
        </tr>
        <%
            String target=request.getParameter("target");
            String search=request.getParameter("search");
        %>
        <c:set var="target" value="<%=target%>"/>
        <c:set var="search" value="<%=search%>"/>

        <c:choose>
            <c:when test="${target eq null or search eq null}">
                <%
                    ArrayList<HashMap<String,String>> noticeList=new ArrayList<HashMap<String,String>>();
                    noticeList= Notice.getNotice(1);

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
                    searchNoticeList= Notice.getSearchNotice(1,search,target);
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
    </table>
</body>
</html>
