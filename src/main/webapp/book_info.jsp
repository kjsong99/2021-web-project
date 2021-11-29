<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Timestamp" %><%--
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


%>
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
<div><a href="/book_modify.jsp?num=<%=num%>">수정</a> <a href="/bookDelete?num=<%=num%>">삭제</a> <a href="bookSold?num=<%=num%>">판매완료</a> </div>
<%--책 조회, 삭제, 수정, 목록 기능 구현--%>
</body>
</html>
