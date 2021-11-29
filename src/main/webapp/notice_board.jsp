<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: song-gyeongjin
  Date: 2021/11/01
  Time: 2:15 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시판1</title>

</head>
<body>
<script>
    function write(){
        location.href="notice_write.jsp"
    }
</script>
    <h1>공지사항</h1>
    <a href="notice_write.jsp">글쓰기</a>
    <form action="notice_board.jsp" method="get">
        <select name="target">
            <option value="TITLE" selected>제목</option>
            <option value="CONTENT">내용</option>
        </select>
        <input type="text" name="search" size="10">
        <input type="submit" value="검색">
    </form>
    <table>
        <tr>
            <td>번호</td>
            <td>제목</td>
            <td>등록일</td>
        </tr>
        <%
            SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
            Connection con = null;
            con = dbConnection.connect();
            Statement st = con.createStatement();
            String target="";
            target=request.getParameter("target");
            if(target==null){
                ResultSet rs=st.executeQuery("select * from NOTICE");
                while (rs.next()) {
                    String title = rs.getString(1);
                    int num=rs.getInt(3);
                    String date=df.format(rs.getTimestamp(4));
                    out.println("<tr>" +
                            "<td>"+num+"</td>" +
                            "<td><a href=notice_info.jsp?num="+num+">"+title+"</td>" +
                            "<td>"+date+"</td>" +
                            "</tr>");
                }
                st.close();
                con.close();
            }
            else{
                System.out.println(target);
                con = dbConnection.connect();
                String search=request.getParameter("search");
                System.out.println(search);
                String sql="select * from NOTICE WHERE "+target.trim()+" LIKE ?";
                PreparedStatement ps=con.prepareStatement(sql);
                System.out.println(target);
                System.out.println(search);
                ps.setString(1,'%'+search.trim()+'%');
                System.out.println(ps.toString());
                ResultSet rs=ps.executeQuery();
                while (rs.next()) {
                    String title = rs.getString(1);
                    System.out.println(title);
                    int num=rs.getInt(3);
                    String date=df.format(rs.getTimestamp(4));
                    out.println("<tr>" +
                            "<td>"+num+"</td>" +
                            "<td><a href=notice_info.jsp?num="+num+">"+title+"</td>" +
                            "<td>"+date+"</td>" +
                            "</tr>");
                }
                ps.close();
                con.close();

            }

        %>
<%--공지사항 검색 기능 구현--%>
    </table>
</body>
</html>
