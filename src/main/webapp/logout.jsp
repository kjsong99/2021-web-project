<%--
  Created by IntelliJ IDEA.
  User: song-gyeongjin
  Date: 2021/11/04
  Time: 3:02 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
  <%
      session.removeAttribute("id");
      session.removeAttribute("auth");
      response.sendRedirect("/");
  %>
</body>
</html>
