<%@ page import="com.example.finalproject.User" %>
<%@ page import="java.util.HashMap" %>
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
    </style>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:include page="header.jsp"></jsp:include>
<div class="container" >
    <div class="col-lg-4"></div>
    <div class="col-lg-4">
        <div class="jumbotron" style="padding-top: 20px; background-color:#ffffff;">


            <form method="post" action="/passwordChange" style="padding-top:110px">
                <h2 style="text-align:center; font-weight:bold; padding-bottom:20px;">비밀번호 변경</h2>

                <div class="form-group">
                    <input type="password" class="form-control" placeholder="현재 비밀번호" name="originPwd1" maxlength="20">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="현재 비밀번호 확인" name="originPwd2" maxlength="20">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="새로운 비밀번호" name="newPwd1" maxlength="20">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="새로운 비밀번호 확인" name="newPwd2" maxlength="20">
                </div>
                <input type="submit" class="btn form-control" value="비밀번호 변경" style="background-color:#fccd21; color:#ffffff; border:0px;">
            </form>


        </div>
    </div>
    <div class="col-lg-4"></div>
</div>

<%-- 애니메이션을 담당하는 자바스크립트 참조 --%>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>

</html>