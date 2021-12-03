<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
    <script>
        function cancel(){
            location.href='/notice_board.jsp';
        }

        function submit(){
            submit();
        }
    </script>

</head>

<body>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:include page="header.jsp"></jsp:include>
<article>
    <div class="container" role="main">
        <h2>공지사항 작성</h2>
        <form name="form" id="form" role="form" method="post" action="/notice_write">
            <div class="mb-3">
                <label for="title">제목</label>
                <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
            </div>
            <div class="mb-3" style="padding-top: 10px">
                <label for="content">내용</label>
                <textarea class="form-control" rows="10" name="content" id="content" placeholder="내용을 입력해 주세요" ></textarea>
            </div>
            <br>
            <button onclick="" style="background-color:#fccd21; color:#ffffff; border:0px;" id="btnSave">등록</button>
        </form>
        <button type="cancle" style="background-color:#fccd21; color:#ffffff; border:0px;" id="btnList">목록</button>
<%--        <div style="padding-top: 10px">--%>
<%--           --%>
<%--        </div>--%>
    </div>
</article>

</body>

</html>