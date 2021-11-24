<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>index</title>
    <style>
        div {
            width: 100%;
            height: 300px;
            border: 1px solid #000;
            border-radius: 15px;
        }
        div.left {
            height: 300px;
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
    </style>
</head>
<body>
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
</script>

<%
    if(session.getAttribute("id")==null){
        out.println(
                "<p><button onclick=\"login()\">로그인</button> " +
                "<button onclick=\"join()\">회원가입</button></p>"
        );
    }
    else{
        out.println(
                "<p><button onclick=\"logout()\">로그아웃</button></p>"
        );
    }
%>

<div class="left">
    <p>카테고리</p>
    <p>전체<input type="radio" name="category" value="전체" checked></p>
    <p>기술서적<input type="radio" name="category" value="기술서적"></p>
    <p>소설<input type="radio" name="category" value="소설"></p>
    <p>에세이<input type="radio" name="category" value="에세이"></p>

</div>


<div class="right">
    <p>책목록 <button onclick="bookWrite()" style="float: right; margin: 10px;">등록</button></p>
        <%

            request.setCharacterEncoding("utf-8");

            Connection con = null;
            con = dbConnection.connect();
            Statement st = con.createStatement();
            ResultSet rs=st.executeQuery("select * from book");
            String title="";
            while (rs.next()) {
                title = rs.getString(1);
                out.println("<a href=#>"+title+"</a>");
            }
            %>

</div>

<div class="left">
    <p>공지사항 <button onclick="notice()" style="float: right; margin: 10px;">더보기</button> </p>

</div>

</body>
</html>