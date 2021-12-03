<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
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
<%
    int num= Integer.parseInt(request.getParameter("num"));
    Connection con = null;
    con = dbConnection.connect();
    Statement st = con.createStatement();
    ResultSet rs=st.executeQuery("select * from BOOK where NUMBER="+num);
    String title="";
    int price=0;
    String writer="";
    String category="";
    String company="";
    String status="";
    if(rs.next()){
        title=rs.getString(1);
        price=rs.getInt(2);
        writer=rs.getString(3);
        category=rs.getString(4);
        company=rs.getString(6);
        status=rs.getString(7);

    }
%>
<div class="container" >
    <div class="col-lg-3"></div>
    <div class="input-form col-lg-6 mx-auto">
        <div class="jumbotron" style="padding-top: 5px; background-color:#ffffff;">
            <form method="post" action="/bookModify" style="padding-top:10px" accept-charset="utf-8" >
                <h2 style="text-align:center; font-weight:bold; padding-bottom:20px;">판매 정보 수정</h2>

                <div class="form-group">
                    <label> 책 제목 </label>
                    <input type="text" class="form-control" name="title" maxlength="20"  value="<%=title%>">
                </div>

                <div class="form-group">
                    <label> 저자 </label>
                    <input type="text" class="form-control" name="writer" maxlength="20" value="<%=writer%>">
                </div>

                <div class="form-group">
                    <label> 출판사 </label>
                    <input type="text" class="form-control" name="company" maxlength="20"value="<%=company%>">
                </div>


                <div class="form-group">
                    <label> 카테고리 </label>
                    <select name="category">
                        <%
                            if(category.equals("소설")){
                                out.println("<option value=\"소설\" selected>소설</option>\n" +
                                        "        <option value=\"에세이\">에세이</option>\n" +
                                        "        <option value=\"기술서적\">기술서적</option>");
                            }
                            else if(category.equals("에세이")){
                                out.println("<option value=\"소설\">소설</option>\n" +
                                        "        <option value=\"에세이\" selected>에세이</option>\n" +
                                        "        <option value=\"기술서적\">기술서적</option>");
                            }
                            else if(category.equals("기술서적")){
                                out.println("<option value=\"소설\">소설</option>\n" +
                                        "        <option value=\"에세이\">에세이</option>\n" +
                                        "        <option value=\"기술서적\" selected>기술서적</option>");
                            }

                        %>
                    </select>
                </div>


                <div class="form-group">
                    <label> 상태 </label>
                    <select name="status">
                        <%
                            if(status.equals("상")){
                                out.println("<option value=\"상\" selected>상</option>\n" +
                                        "        <option value=\"중\">중</option>\n" +
                                        "        <option value=\"하\">하</option>");
                            }

                            else if(status.equals("중")){
                                out.println("<option value=\"상\">상</option>\n" +
                                        "        <option value=\"중\" selected>중</option>\n" +
                                        "        <option value=\"하\">하</option>");
                            }

                            else if(status.equals("하")){
                                out.println("<option value=\"상\">상</option>\n" +
                                        "        <option value=\"중\">중</option>\n" +
                                        "        <option value=\"하\" selected>하</option>");

                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label> 판매가격 </label>
                    <input type="text" name="price"value="<%=price%>">
                </div>

                <input name="num" type="hidden" value="<%=num%>">

                <input type="submit" class="btn form-control" value="변경" style="background-color:#fccd21; color:#ffffff; border:0px;">

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