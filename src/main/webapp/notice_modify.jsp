<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Timestamp" %><%--
  Created by IntelliJ IDEA.
  User: song-gyeongjin
  Date: 2021/11/01
  Time: 2:15 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>board1 글쓰기</title>
</head>
<script>
    function cancel(num){
        location.href='/notice_info.jsp?num='+num;
    }

    function submit(){
        submit();
    }
</script>
<body>
<%
    int num= Integer.parseInt(request.getParameter("num"));
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
        content=rs.getString(5);
    }
%>
<form action="/noticeModify" method="post">
    <p>글제목 <input type="text" name="title" value="<%=title%>"></p>
    <p>
        <textarea placeholder="내용" name="content"><%=content%></textarea>
    </p>
    <input type="hidden" name="num" value="<%=num%>">
    <button onclick="submit()">등록</button> <button onclick="cancel(<%=num%>)">취소</button>
</form>

</body>
</html>