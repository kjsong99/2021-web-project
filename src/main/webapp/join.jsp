<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: song-gyeongjin
  Date: 2021/11/01
  Time: 2:15 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>register</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
%>
    <h3>회원가입</h3>

    <form action="/join" method="post" accept-charset="utf-8">
        <p>아이디 <input type="text" name="id"> <button value="중복확인">중복확인</button> </p>
        <p>비밀번호 <input type="password" name="pwd"></p>
        <p>이름 <input type="text" name="name"></p>
        <p>닉네임 <input type="text" name="nickname"></p>
        <p>전화번호 <select name="phone1">
            <option value="010">010</option>
            <option value="011">011</option>
        </select> - <input type="text" name="phone2" maxlength="4" size="4"> - <input type="text" name="phone3" maxlength="4" size="4"></p>
        <p>성별 <select name="sex">
            <option value="여성">여성</option>
            <option value="남성">남성</option>
        </select> </p>
        <p>생년월일 <script type="text/javascript">
            var today = new Date();
            var toyear = parseInt(today.getFullYear ());
            var start = toyear;
            var end = toyear - 100;

            document.write("<select name=birth1> ");
            document.write("<option value='2021' selected>");
            for (i=start;i>=end;i--) document.write("<option>"+i);
            document.write("</select>년  ");

            document.write("<select name=birth2>");
            document.write("<option value='' selected>");
            for (i=1;i<=12;i++) document.write("<option>"+i);
            document.write("</select>월  ");

            document.write("<select name=birth3>");
            document.write("<option value='' selected>");
            for (i=1;i<=31;i++) document.write("<option>"+i);
            document.write("</select>일  </font>");
        </script>
        </p>
        <input type="submit" value="회원가입">
    </form>
</body>
</html>
