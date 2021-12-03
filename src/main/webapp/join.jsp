<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>index</title>
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
<div class="container">
    <%--<div class="input-form-backgroud row">--%>
    <div class="col-lg-3"></div>
    <div class="input-form col-lg-6 mx-auto">
        <h2 style="text-align:center; font-weight:bold; padding-bottom:20px;">회원가입</h2>
        <form action="/join" method="post" accept-charset="utf-8">

            <div class="form-group">
                <label>아이디</label>
                <input type="text" class="form-control" id="name" placeholder="" value="" required>
            </div>

            <div class="form-group">
                <button class="btn btn-light" value="중복확인">중복확인</button>
            </div>

            <div class="form-group">
                <label> 비밀번호 </label>
                <input type="password" class="form-control" name="pwd" maxlength="20">
            </div>

            <div class="form-group">
                <label> 이름 </label>
                <input type="text" class="form-control" name="name" maxlength="10">
            </div>

            <div class="form-group">
                <label> 닉네임 </label>
                <input type="text" class="form-control"name="nickname" maxlength="7">
            </div>

            <label>전화번호</label>
            <div class="form-group row">
                <div class="col-xs-3">
                    <select class="form-control" name="phone1">
                        <option value="010">010</option>
                        <option value="011">011</option>
                    </select>
                </div>
                <div class="col-xs-1">-</div>
                <div class="col-xs-3">
                    <input type="text" class="form-control" name="phone2" maxlength="4" size="4">
                </div>
                <div class="col-xs-1">-</div>
                <div class="col-xs-3">
                    <input type="text" class="form-control" name="phone3" maxlength="4" size="4">
                </div>
            </div>

            <label>성별</label>
            <div class="form-group row">
                <div class="col-xs-3">
                    <select class="form-control" aria-label="Default select example" name="sex">
                        <option value="여성">여성</option>
                        <option value="남성">남성</option>
                    </select>
                </div>
            </div>

            <label>생년월일</label>
            <div class="form-group">
                <script type="text/javascript">
                    var today = new Date();
                    var toyear = parseInt(today.getFullYear ());
                    var start = toyear;
                    var end = toyear - 100;

                    document.write("<select name=birth1> ");
                    document.write("<option value='2021' selected>");
                    for (i=start;i>=end;i--) document.write("<option>"+i);
                    document.write("</select>년 ");

                    document.write("<select name=birth2>");
                    document.write("<option value='' selected>");
                    for (i=1;i<=12;i++) document.write("<option>"+i);
                    document.write("</select>월 ");

                    document.write("<select name=birth3>");
                    document.write("<option value='' selected>");
                    for (i=1;i<=31;i++) document.write("<option>"+i);
                    document.write("</select>일 ");
                </script>
            </div>
            <input type="submit" class="btn form-control" value="회원가입" style="background-color:#fccd21; color:#ffffff; border:0px;">
        </form>
    </div>
</div>
</div>
<script> window.addEventListener('load', () => { const forms = document.getElementsByClassName('validation-form'); Array.prototype.filter.call(forms, (form) => { form.addEventListener('submit', function (event) { if (form.checkValidity() === false) { event.preventDefault(); event.stopPropagation(); } form.classList.add('was-validated'); }, false); }); }, false);
</script>
</body>
</html>