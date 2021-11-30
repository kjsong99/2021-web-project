<%--
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
<jsp:include page="header.jsp"></jsp:include>
<form action="/bookWrite" method="post" accept-charset="utf-8" enctype="multipart/form-data">
    <p>책 제목 <input type="text" name="title"> </p>
    <p>저자 <input type="text" name="writer"></p>
    <p>출판사 <input type="text" name="company"></p>
    <p>카테고리 <select name="category">
        <option value="소설">소설</option>
        <option value="에세이">에세이</option>
        <option value="기술서적">기술서적</option>
    </select> </p>
    <p>상태 <select name="status">
        <option value="상">상</option>
        <option value="중">중</option>
        <option value="하">하</option>
    </select> </p>
    <p>판매가격 <input type="text" name="price"></p>
    <p>사진 <input type="file" name="image"></p>
    <input type="submit" value="등록">
</form>
</body>
</html>
