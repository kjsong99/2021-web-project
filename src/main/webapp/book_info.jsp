<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.example.finalproject.User" %>
<%@ page import="com.example.finalproject.Book" %><%--
  Created by IntelliJ IDEA.
  User: song-gyeongjin
  Date: 2021/11/17
  Time: 5:04 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>



<%
    int num= Integer.parseInt(request.getParameter("num"));
    System.out.println(num);
    Connection con = null;
    con = dbConnection.connect();
    Statement st = con.createStatement();
    ResultSet rs=st.executeQuery("select * from BOOK where NUMBER="+num);
    String title="";
    int price=0;
    String writer="";
    String category="";
    String company="";
    String status="";
    String username="";
    Timestamp date=null;
    if(rs.next()){
        title=rs.getString(1);
        price=rs.getInt(2);
        writer=rs.getString(3);
        category=rs.getString(4);
        date=rs.getTimestamp(5);
        company=rs.getString(6);
        status=rs.getString(7);
        username=rs.getString(8);

    }

    out.println("<div><img width=150 height=200 src=\"./blob_print.jsp?num="+num+"\"/></div>");
    int auth= 0;
    if(session.getAttribute("auth")!=null){
        auth= (int) session.getAttribute("auth");
    }
%>
<c:set value="<%=auth%>" var="auth"/>
<div>
    <p><%=title%></p>
    <p><%=price%></p>
    <p><%=writer%></p>
    <p><%=category%></p>
    <p><%=date%></p>
    <p><%=company%></p>
    <p><%=status%></p>
    <p><%=username%></p>

</div>
<c:if test="${auth>1}">
    <div><a href="/book_modify.jsp?num=<%=num%>">수정</a> <a href="/bookDelete?num=<%=num%>">삭제</a> <a href="bookSold?num=<%=num%>">판매완료</a> </div>
</c:if>
<c:if test="${auth<2}">
    <c:if test="${auth eq 1}">
        <%
            int sold= Book.isBookSold(num);
        %>
        <c:set value="<%=sold%>" var="sold"/>
        <c:choose>
            <c:when test="${sold eq 1}">판매완료  </c:when>
            <c:when test="${sold eq 0}"><a href="/bookBuy?num=<%=num%>">구매</a></c:when>
        </c:choose>
    </c:if>
    <%
        String id= String.valueOf(session.getAttribute("id"));
        int exist=User.findCart(id,num);
        System.out.println(exist);
    %>
    <c:set var="exist" value="<%=exist%>"/>
    <c:choose>
        <c:when test="${exist eq 0}">
            <a href="/cartAdd?num=<%=num%>">찜하기</a>
        </c:when>
        <c:when test="${exist eq 1}">
            <a href="/cartDelete?num=<%=num%>">찜해제</a>
        </c:when>
    </c:choose>
</c:if>

<%--책 조회, 삭제, 수정, 목록 기능 구현--%>
</body>
</html>
