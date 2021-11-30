<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%@ page import="java.sql.Blob" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.finalproject.Book" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>index</title>
    <style>
        ul li { display:inline-block; margin:10px;  }
        div.left {
            width: 100%;
            height: 300px;
            border: 1px solid #000;
            border-radius: 15px;
            height: 300px;
            width: 23%;
            float: left;
            box-sizing: border-box;
            margin: 1%;

        }
        div.right {
            width: 100%;
            height: 300px;
            border: 1px solid #000;
            border-radius: 15px;
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
            location.href="notice_board.jsp"
        }

        function category(){

        }
    </script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>


<%
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

<div class="left">
    <p>카테고리</p>
    <p><a href="/index.jsp?category=전체">전체</a></p>
    <p><a href="/index.jsp?category=소설">소설</a></p>
    <p><a href="/index.jsp?category=기술서적">기술서적</a></p>
    <p><a href="/index.jsp?category=에세이">에세이</a></p>
</div>


<div class="right">

    <%
        request.setCharacterEncoding("utf-8");
        String category=request.getParameter("category");
        String target=request.getParameter("target");
        String search=request.getParameter("search");
        System.out.println(search);
    %>
    <p>책목록 <button onclick="bookWrite()" style="float: right; margin: 10px;">등록</button></p>
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
                    ArrayList<HashMap<String,String>> bookList= Book.getBook();
                %>
                <c:set var="sell" value="<%=bookList%>"/>
                <c:forEach var="book" items="${sell}">
                    <c:set var="num" value="${book['number']}"/>
                    <ul style="display: inline-block; margin: 10px">
                        <li style="display: inline-block; margin: 10px">
                            <div><img width="100" height="150" src="blob_print.jsp?num=${num}"></div>
                            <div><a href="book_info.jsp?num=${num}">${book['title']}</a> </div>
                            <div>${book['price']}</div>
                        </li>
                    </ul>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <%
                    ArrayList<HashMap<String,String>> categoryBookList= Book.getCategoryBook(category);
                %>
                <c:set var="sell" value="<%=categoryBookList%>"/>
                <c:forEach var="book" items="${sell}">
                    <c:set var="num" value="${book['number']}"/>
                    <ul style="display: inline-block; margin: 10px">
                        <li style="display: inline-block; margin: 10px">
                            <div><img width="100" height="150" src="blob_print.jsp?num=${num}"></div>
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
                    ArrayList<HashMap<String,String>> bookList= Book.getBookSearch(search,target);
                %>
                <c:set var="sell" value="<%=bookList%>"/>
                <c:forEach var="book" items="${sell}">
                    <c:set var="num" value="${book['number']}"/>
                    <ul style="display: inline-block; margin: 10px">
                        <li style="display: inline-block; margin: 10px">
                            <div><img width="100" height="150" src="blob_print.jsp?num=${num}"></div>
                            <div><a href="book_info.jsp?num=${num}">${book['title']}</a> </div>
                            <div>${book['price']}</div>
                        </li>
                    </ul>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <%
                    ArrayList<HashMap<String,String>> categoryBookList= Book.getCategoryBookSearch(category,search,target);
                %>
                <c:set var="sell" value="<%=categoryBookList%>"/>
                <c:forEach var="book" items="${sell}">
                    <c:set var="num" value="${book['number']}"/>
                    <ul style="display: inline-block; margin: 10px">
                        <li style="display: inline-block; margin: 10px">
                            <div><img width="100" height="150" src="blob_print.jsp?num=${num}"></div>
                            <div><a href="book_info.jsp?num=${num}">${book['title']}</a> </div>
                            <div>${book['price']}</div>
                        </li>
                    </ul>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </c:if>



</div>

<div class="left">
    <p>공지사항 <button onclick="notice()" style="float: right; margin: 10px;">더보기</button> </p>
    <%

        request.setCharacterEncoding("utf-8");
        Connection con=dbConnection.connect();
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery("select * from NOTICE");
        int num2=0;
        String title2="";
        while (rs.next()) {
            title2 = rs.getString(1);
            num2=rs.getInt(3);
            out.println("<a href=./notice_info.jsp?num="+num2+">"+title2+"</a><br>");
        }
    %>

<%--    책 검색 기능 구현 (마이페이지 서블릿 및 jsp 파일 생성--%>

</div>

</body>
</html>