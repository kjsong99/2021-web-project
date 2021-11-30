<%@ page import="com.example.finalproject.User" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: song-gyeongjin
  Date: 2021/11/30
  Time: 7:52 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/passwordChange" method="post">
<%--    <%--%>
<%--        String username= String.valueOf(request.getSession().getAttribute("id"));--%>
<%--        HashMap<String,String> user=new HashMap<String,String>();--%>
<%--        user=User.getUser(username);--%>
<%--    %>--%>
<%--    <c:set var="user" value="<%=user%>"/>--%>
    <p>현재 비밀번호 <input type="password" name="originPwd1"></p>
    <p>현재 비밀번호 확인<input type="password" name="originPwd2"></p>
    <p>새로운 비밀번호 <input type="password" name="newPwd1"></p>
    <p>새로운 비밀번호 <input type="password" name="newPwd2"></p>
    <p><input type="submit" value="변경"></p>
</form>

</body>
</html>
