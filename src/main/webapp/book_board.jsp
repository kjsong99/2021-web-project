<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*" %>
<%@ page import="oracle.jdbc.proxy.annotation.Pre" %><%--
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
    <style>
        ul li { display:inline-block; margin:10px;  }
    </style>

</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<%

    Connection con = null;
    con = dbConnection.connect();
    Statement st = con.createStatement();

    request.setCharacterEncoding("utf-8");
    String category=request.getParameter("category");
%>
<h1><%=category%></h1>

<form action="book_board.jsp" method="get">
    <select name="target">
        <option value="TITLE" selected>제목</option>
        <option value="WRITER">작가</option>
    </select>
    <input type="text" name="search" size="10">
    <input type="submit" value="검색">
    <input type="hidden" name="category" value="<%=category%>">
</form>

<%
    String target="";
    target=request.getParameter("target");
    if(target==null){ //검색이 아닌 경우
        if(category.equals("전체")){
            ResultSet rs=st.executeQuery("select * from BOOK WHERE SOLD=0");
            int num=0;
            String title="";
            int price=0;
            out.println("<ul>");
            while (rs.next()) {
                title = rs.getString(1);
                num=rs.getInt(10);
                price=rs.getInt(2);

                out.print("<li><div><img width=150 height=200 src=\"./blob_print.jsp?num="+num+"\"/></div>");


                out.print("<div text-align=center><a href=./book_info.jsp?num="+num+">"+title+"</a></div>");
                out.print("<div text-align=center><span>"+price+"</span></div></li>");
            }
            out.println("</ul>");
        }
        else{
            System.out.println(category);
            ResultSet rs=st.executeQuery("select * from BOOK where SOLD=0 AND CATEGORY=\'"+category+"\'");
            int num=0;
            String title="";
            int price=0;
            out.println("<ul>");
            while (rs.next()) {
                title = rs.getString(1);
                num=rs.getInt(10);
                price=rs.getInt(2);

                out.print("<li><div><img width=150 height=200 src=\"./blob_print.jsp?num="+num+"\"/></div>");


                out.print("<div text-align=center><a href=./book_info.jsp?num="+num+">"+title+"</a></div>");
                out.print("<div text-align=center><span>"+price+"</span></div></li>");
            }
            out.println("</ul>");
        }

    }
    else { //검색의 경우
        System.out.println(request.getParameter("target"));
        String search = request.getParameter("search");
        if (category.equals("전체")) {
            PreparedStatement ps = con.prepareStatement("select * from BOOK where SOLD=0 AND " + target.trim() + " like ?");
            ps.setString(1, '%' + search.trim() + '%');
            ResultSet rs = ps.executeQuery();
            int num = 0;
            String title = "";
            int price = 0;
            out.println("<ul>");
            while (rs.next()) {
                title = rs.getString(1);
                num = rs.getInt(10);
                price = rs.getInt(2);

                out.print("<li><div><img width=150 height=200 src=\"./blob_print.jsp?num=" + num + "\"/></div>");


                out.print("<div text-align=center><a href=./book_info.jsp?num=" + num + ">" + title + "</a></div>");
                out.print("<div text-align=center><span>" + price + "</span></div></li>");
            }
            out.println("</ul>");
        } else {
            System.out.println(category);
            search = request.getParameter("search");
            PreparedStatement ps = con.prepareStatement("select * from BOOK where SOLD=0 AND CATEGORY=? AND " + target.trim() + " like ?");
            ps.setString(1,category);
            ps.setString(2, '%'+search.trim()+'%');
            System.out.println(ps.toString());
            ResultSet rs = ps.executeQuery();
            int num = 0;
            String title = "";
            int price = 0;
            out.println("<ul>");
            while (rs.next()) {
                title = rs.getString(1);
                num = rs.getInt(10);
                price = rs.getInt(2);

                out.print("<li><div><img width=150 height=200 src=\"./blob_print.jsp?num=" + num + "\"/></div>");


                out.print("<div text-align=center><a href=./book_info.jsp?num=" + num + ">" + title + "</a></div>");
                out.print("<div text-align=center><span>" + price + "</span></div></li>");
            }
            out.println("</ul>");


        }


    }

%>

</body>
</html>
