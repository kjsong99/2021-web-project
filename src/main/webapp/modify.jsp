<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.example.finalproject.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>book_write</title>
    <!-- 부트스트랩 css 사용 -->
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <style>
        ul li { display:inline-block; margin:10px;  }
        nav{
            width: 100%;
            text-align: center;
        }
        div.left {
            height:600px;
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
        label{
            width: 100px;
        }
        h4{
            display: inline-block;
        }
    </style>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:include page="header.jsp"></jsp:include>

<div class="container">
    <%--<div class="input-form-backgroud row">--%>
    <div class="col-lg-3"></div>
    <div class="input-form col-lg-6 mx-auto">
        <h2 style="text-align:center; font-weight:bold; padding-bottom:20px;">회원 정보 수정</h2>
        <form action="/userModify" method="post" accept-charset="utf-8">
            <%
                String username=request.getParameter("username");
                HashMap<String,String> user=new HashMap<String,String>();
                user=User.getUser(username);
            %>
            <c:set var="user" value="<%=user%>"/>

            <div class="form-group">
                <label>아이디</label>
                <h4> <%=username%> </h4>
            </div>

            <a href="password_change.jsp">비밀번호 변경</a>

            <div class="form-group">
                <label> 이름 수정 </label>
                <input type="text" class="form-control" name="name" maxlength="10" value="${user.get("name")}">
            </div>

            <div class="form-group">
                <label> 닉네임 수정 </label>
                <input type="text" class="form-control"name="nickname" maxlength="7"value="${user.get("nickname")}">
            </div>

            <label>전화번호 수정</label>
            <div class="form-group row">
                <div class="col-xs-3">
                    <select name="phone1">
                        <c:set var="phone" value="${user.get('phone')}"/>
                        <c:if test="${phone.substring(0,3) eq '010'}">
                            <option value="010" selected>010</option>
                            <option value="011">011</option>
                        </c:if>
                        <c:if test="${phone.substring(0,3) eq '011'}">
                            <option value="010">010</option>
                            <option value="011" selected>011</option>
                        </c:if>
                    </select>
                </div>
                <div class="col-xs-1">-</div>
                <div class="col-xs-3">
                    <input type="text" class="form-control" name="phone2" maxlength="4" size="4" value="${phone.substring(4,8)}">
                </div>
                <div class="col-xs-1">-</div>
                <div class="col-xs-3">
                    <input type="text" class="form-control" name="phone3" maxlength="4" size="4" value="${phone.substring(9,13)}">
                </div>
            </div>

            <label>성별 수정</label>
            <div class="form-group row">
                <div class="col-xs-3">
                    <select name="sex"  class="form-control" aria-label="Default select example">
                        <c:set var="sex" value="${user.get('sex')}"/>
                        <c:if test="${sex eq '여성'}">
                            <option value="여성" selected>여성</option>
                            <option value="남성">남성</option>
                        </c:if>
                        <c:if test="${sex eq '남성'}">
                            <option value="여성">여성</option>
                            <option value="남성" selected>남성</option>
                        </c:if>
                    </select>
                </div>
            </div>

            <c:set var="birth" value="${user.get('birth')}"/>
            <label>생년월일 수정</label>
            <div class="form-group">
                <script type="text/javascript">
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
            </div>
            <input type="submit" class="btn form-control" value="변경하기" style="background-color:#fccd21; color:#ffffff; border:0px;">
        </form>
    </div>
</div>
</div>

</body>
</html>