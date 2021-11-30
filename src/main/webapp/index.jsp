<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%@ page import="java.sql.Blob" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.OutputStream" %>
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
    <p><a href="/book_board.jsp?category=전체">전체</a></p>
    <p><a href="/book_board.jsp?category=소설">소설</a></p>
    <p><a href="/book_board.jsp?category=기술서적">기술서적</a></p>
    <p><a href="/book_board.jsp?category=에세이">에세이</a></p>
</div>


<div class="right">
    <p>책목록 <button onclick="bookWrite()" style="float: right; margin: 10px;">등록</button></p>
        <%

            request.setCharacterEncoding("utf-8");

            Connection con = null;
            con = dbConnection.connect();
            Statement st = con.createStatement();
            ResultSet rs=st.executeQuery("select * from BOOK where SOLD=0");
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
            %>
</div>

<div class="left">
    <p>공지사항 <button onclick="notice()" style="float: right; margin: 10px;">더보기</button> </p>
    <%

        request.setCharacterEncoding("utf-8");
        Statement st2 = con.createStatement();
        ResultSet rs2=st.executeQuery("select * from NOTICE");
        int num2=0;
        String title2="";
        while (rs2.next()) {
            title2 = rs2.getString(1);
            num2=rs2.getInt(3);
            out.println("<a href=./notice_info.jsp?num="+num2+">"+title2+"</a><br>");
        }
    %>

<%--    책 검색 기능 구현 (마이페이지 서블릿 및 jsp 파일 생성--%>

</div>

</body>
</html>