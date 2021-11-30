<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Timestamp" %><%--
  Created by IntelliJ IDEA.
  User: song-gyeongjin
  Date: 2021/11/17
  Time: 5:04 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

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
%>
<h3><%=title%></h3>
<div><%=username%></div>
<div><%=date%></div>
<div><%=content%></div>
<div><a href="./notice_modify.jsp?num=<%=num%>">수정</a> <a href="./noticeDelete?num=<%=num%>">삭제</a> </div>


<%--목록, 삭제, 수정, 이전글, 다음글 구현--%>

</body>
</html>
