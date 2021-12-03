<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

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
            padding-bottom: 10px;
            height: 500px;
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
    ResultSet rs=st.executeQuery("select * from NOTICE where NUMBER="+num);
    String title="";
    String username="";
    Timestamp date=null;
    String content="";
    if(rs.next()){
        title=rs.getString(1);
        username=rs.getString(2);
        date=rs.getTimestamp(4);
        content=rs.getString(5);
    }
    int auth= 0;
    if(session.getAttribute("auth")!=null){
        auth= (int) session.getAttribute("auth");
    }
%>

<c:set value="<%=auth%>" var="auth"/>
<div class="container">
    <div>
        <hr>
        <h3><%=title%></h3>
        <hr>
    </div>

    <div> <%=username%>  <%=date%></div>
    <div id="divframe" style="font-size: medium"><%=content%></div>
    <c:if test="${auth>1}">
        <div><a href="./notice_modify.jsp?num=<%=num%>">수정</a> <a href="./noticeDelete?num=<%=num%>">삭제</a> </div>
    </c:if>
    <br>
    <a href="notice_board.jsp">목록</a>
</div>


<%--목록, 삭제, 수정, 이전글, 다음글 구현--%>

</body>
</html>