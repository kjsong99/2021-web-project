<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: song-gyeongjin
  Date: 2021/11/04
  Time: 4:11 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>책 등록</title>
</head>
<body>
<%
    int num= Integer.parseInt(request.getParameter("num"));
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
    if(rs.next()){
        title=rs.getString(1);
        price=rs.getInt(2);
        writer=rs.getString(3);
        category=rs.getString(4);
        company=rs.getString(6);
        status=rs.getString(7);

    }
%>
<jsp:include page="header.jsp"></jsp:include>
<form action="/bookModify" method="post" accept-charset="utf-8">
    <p>책 제목 <input type="text" name="title" value="<%=title%>"> </p>
    <p>저자 <input type="text" name="writer" value="<%=writer%>"></p>
    <p>출판사 <input type="text" name="company" value="<%=company%>"></p>
    <p>카테고리 <select name="category">
        <%
            if(category.equals("소설")){
                out.println("<option value=\"소설\" selected>소설</option>\n" +
                        "        <option value=\"에세이\">에세이</option>\n" +
                        "        <option value=\"기술서적\">기술서적</option>");
            }
            else if(category.equals("에세이")){
                out.println("<option value=\"소설\">소설</option>\n" +
                        "        <option value=\"에세이\" selected>에세이</option>\n" +
                        "        <option value=\"기술서적\">기술서적</option>");
            }
            else if(category.equals("기술서적")){
                out.println("<option value=\"소설\">소설</option>\n" +
                        "        <option value=\"에세이\">에세이</option>\n" +
                        "        <option value=\"기술서적\" selected>기술서적</option>");
            }

        %>
    </select> </p>
    <p>상태 <select name="status">
        <%
            if(status.equals("상")){
                out.println("<option value=\"상\" selected>상</option>\n" +
                        "        <option value=\"중\">중</option>\n" +
                        "        <option value=\"하\">하</option>");
            }

            else if(status.equals("중")){
                out.println("<option value=\"상\">상</option>\n" +
                        "        <option value=\"중\" selected>중</option>\n" +
                        "        <option value=\"하\">하</option>");
            }

            else if(status.equals("하")){
                out.println("<option value=\"상\">상</option>\n" +
                        "        <option value=\"중\">중</option>\n" +
                        "        <option value=\"하\" selected>하</option>");

            }
        %>
    </select> </p>
    <p>판매가격 <input type="text" name="price" value="<%=price%>"></p>
    <input name="num" type="hidden" value="<%=num%>">
    <input type="submit" value="등록">
</form>
</body>
</html>