<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.example.finalproject.User" %>
<%@ page import="com.example.finalproject.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        label{
            width: 100px;
            display: inline-block;
        }
        #divframe{
            border: 3px solid rgba(180,180,180,0.23);
            padding-right: 50px;
            margin-top: 10px;
            padding-top: 20px;
            padding-left: 20px;
        }
    </style>
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
    int auth= 0;
    if(session.getAttribute("auth")!=null){
        auth= (int) session.getAttribute("auth");
    }
%>
<c:set value="<%=auth%>" var="auth"/>

<div class="container">
<h1>판매 정보</h1>

<div id="divframe">
    <table>
        <tr>
            <td>
                <% out.println("<div><img width=150 height=200 src=\"./blob_print.jsp?num="+num+"\"/></div>"); %>
            </td>
            <td>
                <ul>
                    <p>
                        <label>책 제목</label>
                        <%=title%><br>
                    </p>
                    <p>
                        <label>저자</label>
                        <%=price%><br>
                    </p>
                    <p>
                        <label>출판사</label>
                        <%=writer%><br>
                    </p>
                    <p>
                        <label>카테고리</label>
                        <%=category%><br>
                    </p>
                    <p>
                        <label>업로드 일시</label>
                        <%=date%><br>
                    </p>
                    <p>
                        <label>출판사</label>
                        <%=company%><br>
                    </p>
                    <p>
                        <label>상태</label>
                        <%=status%><br>
                    </p>
                    <p>
                        <label>닉네임</label>
                        <%=username%><br>
                    </p>
                </ul>
            </td>
        </tr>
    </table>
</div>

<c:if test="${auth>1}">
    <div><a href="/book_modify.jsp?num=<%=num%>">수정</a> <a href="/bookDelete?num=<%=num%>">삭제</a> <a href="bookSold?num=<%=num%>">판매완료</a> </div>
</c:if>
<c:if test="${auth eq 1}">
    <%
        int sold= Book.isBookSold(num);
    %>
    <c:set value="<%=sold%>" var="sold"/>
    <c:choose>
        <c:when test="${sold eq 1}">판매완료  </c:when>
        <c:when test="${sold eq 0}"><a href="/bookBuy?num=<%=num%>">구매</a></c:when>
    </c:choose>
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
<br>
<a href="/index.jsp">목록</a>
</div>
</body>
</html>