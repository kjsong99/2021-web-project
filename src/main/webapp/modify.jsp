<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.example.finalproject.User" %><%--
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
<jsp:include page="header.jsp"></jsp:include>
<h3>회원정보 수정</h3>

<form action="/userModify" method="post" accept-charset="utf-8">
    <%
        String username=request.getParameter("username");
        HashMap<String,String> user=new HashMap<String,String>();
       user=User.getUser(username);
    %>
    <c:set var="user" value="<%=user%>"/>
    <p>아이디 <%=username%></p>
    <p> <a href="password_change.jsp">비밀번호 변경</a> </p>
    <p>이름 <input type="text" name="name" value="${user.get("name")}"></p>
    <p>닉네임 <input type="text" name="nickname" value="${user.get("nickname")}"></p>
    <p>전화번호 <select name="phone1">
        <c:set var="phone" value="${user.get('phone')}"/>
        <c:if test="${phone.substring(0,3) eq '010'}">
            <option value="010" selected>010</option>
            <option value="011">011</option>
        </c:if>
        <c:if test="${phone.substring(0,3) eq '011'}">
            <option value="010">010</option>
            <option value="011" selected>011</option>
        </c:if>
    </select> - <input type="text" name="phone2" maxlength="4" size="4" value="${phone.substring(4,8)}"> - <input type="text" name="phone3" maxlength="4" size="4" value="${phone.substring(9,13)}"></p>
    <p>성별 <select name="sex">
        <c:set var="sex" value="${user.get('sex')}"/>
        <c:if test="${sex eq '여성'}">
            <option value="여성" selected>여성</option>
            <option value="남성">남성</option>
        </c:if>
        <c:if test="${sex eq '남성'}">
            <option value="여성">여성</option>
            <option value="남성" selected>남성</option>
        </c:if>
    </select> </p>
    <c:set var="birth" value="${user.get('birth')}"/>
    <p>생년월일 <script type="text/javascript">
        var today = new Date();
        var toyear = parseInt(today.getFullYear ());
        var start = toyear;
        var end = toyear - 100;

        document.write("<select name=birth1> ");
        <%--document.write("<option value=\"${birth.substring(0,4)}\" selected>");--%>
        for (i=start;i>=end;i--) {
            if(i==${birth.substring(0,4)}) {
                document.write("<option selected>" + i);
            }
            else{
                document.write("<option>" + i);
            }
        }
        document.write("</select>년  ");

        document.write("<select name=birth2>");
        <%--document.write("<option value=\"${birth.substring(5,7)}\" selected>");--%>
        for (i=1;i<=12;i++) {
            if(i==${birth.substring(5,7)}){
                document.write("<option selected>"+i);
            }else{
                document.write("<option>"+i);
            }
        }
        document.write("</select>월  ");

        document.write("<select name=birth3>");
        <%--document.write("<option value=\"${birth.substring(8,10)}\" selected>");--%>
        for (i=1;i<=31;i++){
            if(i==${birth.substring(8,10)}){
                document.write("<option selected>"+i);
            }
            else{
                document.write("<option>"+i);
            }
        }
        document.write("</select>일  </font>");
    </script>
    </p>
    <input type="submit" value="수정">
</form>
</body>
</html>
