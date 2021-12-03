<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Timestamp" %>
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
        label{
            width: 100px;
            display: inline-block;
        }
        #divframe{
            border: 3px solid rgba(180,180,180,0.23);
            padding-right: 50px;
            margin-top: 10px;
            padding-top: 20px;
            padding-bottom: 10px;
            height: 1000px;
        }
    </style>
</head>
<script>
    function cancel(num){
        location.href='/notice_info.jsp?num='+num;
    }

    function submit(){
        submit();
    }
</script>
<body>
<%
    int num= Integer.parseInt(request.getParameter("num"));
    Connection con = null;
    con = dbConnection.connect();
    Statement st = con.createStatement();
    ResultSet rs=st.executeQuery("select * from NOTICE where NUMBER="+num);
    String title="";
    String username="";
    Timestamp date=null;
    String content="";
    if(rs.next()){
        title=rs.getString(1);
        content=rs.getString(5);
    }
%>
<jsp:include page="header.jsp"></jsp:include>

<div class="container">
    <%--<div class="input-form-backgroud row">--%>
    <div class="col-lg-3"></div>
    <div class="input-form col-lg-6 mx-auto">
        <h2 style="text-align:center; font-weight:bold; padding-bottom:20px;">공지사항 수정</h2>
        <form action="/join" method="post" accept-charset="utf-8">

            <div class="form-group">
                <label> 글 제목 </label>
                <input type="text" class="form-control" name="name" maxlength="10" value="<%=title%>">
            </div>
            <div class="mb-3" style="padding-top: 10px; margin-bottom: 10px">
                <label for="content">내용</label>
                <textarea class="form-control" rows="10" name="content" id="content" value=<%=content%> ></textarea>
            </div>
            <input type="hidden" name="num" value="<%=num%>">
            <button style="background-color:#fccd21; color:#ffffff; border:0px;" onclick="submit()">등록</button>
            <button style="background-color:#fccd21; color:#ffffff; border:0px;" onclick="cancel(<%=num%>)">취소</button>
        </form>
    </div>
</div>
</div>

</body>
</html>