<%--
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
    function cancel(){
        location.href='/board1.jsp';
    }

    function submit(){
        submit();
    }
</script>
<body>
    <form action="/board1_write" method="post">
        <p><input type="text" name="title" placeholder="제목"></p>
        <p>
            <textarea placeholder="내용" name="content"></textarea>
        </p>
        <button onclick="submit()">등록</button> <button onclick="cancel()">취소</button>
    </form>

</body>
</html>
