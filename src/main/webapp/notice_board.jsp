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
                    noticeList= Notice.getNotice(pageNum);
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
    <div style="margin-left: 50px">
        <c:choose>
            <c:when test="${count%10 eq 0}">
                <c:forEach begin="1" end="${count/10}" step="1" var="i">
                    <c:choose>
                        <c:when test="${search eq null or target eq null}">
                            <a href="notice_board.jsp?page=${i}">${i}</a>
                        </c:when>
                        <c:otherwise>
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
    </div>


</body>
</html>
