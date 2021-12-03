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
    <div class="col-lg-3"></div>
    <div class="input-form col-lg-6 mx-auto">
        <div class="jumbotron" style="padding-top: 5px; background-color:#ffffff;">
            <form method="post" action="/bookWrite" style="padding-top:10px" accept-charset="utf-8" enctype="multipart/form-data">
                <h2 style="text-align:center; font-weight:bold; padding-bottom:20px;">BOOK REGISTRATION</h2>

                <div class="form-group">
                    <label> 책 제목 </label>
                    <input type="text" class="form-control" name="title" maxlength="20">
                </div>

                <div class="form-group">
                    <label> 저자 </label>
                    <input type="text" class="form-control" name="writer" maxlength="20">
                </div>

                <div class="form-group">
                    <label> 출판사 </label>
                    <input type="text" class="form-control" name="company" maxlength="20">
                </div>


                <div class="form-group">
                    <label> 카테고리 </label>
                    <select name="category">
                        <option value="소설">소설</option>
                        <option value="에세이">에세이</option>
                        <option value="기술서적">기술서적</option>
                    </select>
                </div>


                <div class="form-group">
                    <label> 상태 </label>
                    <select name="status">
                        <option value="상">상</option>
                        <option value="중">중</option>
                        <option value="하">하</option>
                    </select>
                </div>

                <div class="form-group">
                    <label> 판매가격 </label>
                    <input type="text" name="price">
                </div>


                <div class="form-group">
                    <label> 사진 </label>
                    <input type="file" name="image"></p>
                </div>

                <input type="submit" class="btn form-control" value="등록" style="background-color:#fccd21; color:#ffffff; border:0px;">



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