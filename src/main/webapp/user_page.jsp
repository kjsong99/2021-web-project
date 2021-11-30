<%--<%@ page isELIgnored="false"%>--%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="com.example.finalproject.User" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: song-gyeongjin
  Date: 2021/11/29
  Time: 6:19 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div style="width: 20%; float: left">
    <nav>
        <ul style="list-style: none">
            <li><a href="user_page.jsp?nav=user">유저정보</a></li>
            <li><a href="user_page.jsp?nav=sold">판매내역</a></li>
            <li><a href="user_page.jsp?nav=sell">판매중</a></li>
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
         String nav=request.getParameter("nav").trim();
        System.out.println(nav);
        String id= String.valueOf(session.getAttribute("id"));
        Connection con= dbConnection.connect();
        String user="user";
        %>
    <c:set var="nav" value="<%=nav%>"></c:set>
    <c:choose>
        <c:when test="${nav eq 'user'}">
            <h1>유저정보</h1>
            <%
                HashMap<String,String> info=new HashMap<String,String>();
                info=User.userInfo(id);
                name=info.get("name");
                phone=info.get("phone");
                sex=info.get("sex");
                birth=info.get("birth");
                nickname=info.get("nickname");
            %>
            <table>
                <tr>
                    <td>아이디</td>
                    <td><%=id%></td>
                </tr>
                <tr>
                    <td>이름</td>
                    <td><%=name%></td>
                </tr>
                <tr>
                    <td>닉네임</td>
                    <td><%=nickname%></td>
                </tr>
                <tr>
                    <td>전화번호</td>
                    <td><%=phone%></td>
                </tr>
                <tr>
                    <td>성별</td>
                    <td><%=sex%></td>
                </tr>
                <tr>
                    <td>생년월일</td>
                    <td><%=birth%></td>
                </tr>
            </table>
        </c:when>
        <c:when test="${nav eq 'sell'}">
            <h1>판매중</h1>
            <%
                String title="";
                String price="";
                int num=0;
                ArrayList<HashMap<String,String>> sell=User.sellBook(id);
//                for(int i=0;i<sell.size();i++){
//                    HashMap<String,String> book= sell.get(i);
//                    title=book.get("title");
//                    price=book.get("price");
//                    num= Integer.parseInt(book.get("number"));
//                    request.setAttribute("num",num);
//                }
            %>
            <c:set var="sell" value="<%=sell%>"/>
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
        <c:when test="${nav eq 'sold'}">
            <h1>판매내역</h1>
            <%
                String title="";
                String price="";
                int num=0;
                ArrayList<HashMap<String,String>> sell=User.soldBook(id);
//                for(int i=0;i<sell.size();i++){
//                    HashMap<String,String> book= sell.get(i);
//                    title=book.get("title");
//                    price=book.get("price");
//                    num= Integer.parseInt(book.get("number"));
//                    request.setAttribute("num",num);
//                }
            %>
            <c:set var="sell" value="<%=sell%>"/>
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
    </c:choose>
    <a href="/userModify?username=<%=id%>">정보수정</a> <a href="/userDelete?username=<%=id%>">탈퇴</a>



</div>

</body>
</html>
