<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>index</title>
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
</script>

<%
    if(session.getAttribute("id")==null){
        out.println(
                "<button onclick=\"login()\">로그인</button>" +
                "<button onclick=\"join()\">회원가입</button>"

        );
    }
    else{
        out.println(
                "<button onclick=\"logout()\">로그아웃</button>"
        );
    }
%>

<a href="notify_board.jsp">게시판1</a>
<a href="book_board.jsp">게시판2</a>

</body>
</html>