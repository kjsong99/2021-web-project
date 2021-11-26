<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.finalproject.dbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Blob" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.BufferedOutputStream" %><%--
  Created by IntelliJ IDEA.
  User: song-gyeongjin
  Date: 2021/11/25
  Time: 3:27 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    Blob image = null;
    byte[ ] imgData = null ;
    int num= Integer.parseInt(request.getParameter("num"));
    Connection con = null;
    con = dbConnection.connect();
    Statement st = con.createStatement();
    ResultSet rs=st.executeQuery("select * from book where num="+num);
    if(rs.next()){
        image=rs.getBlob(9);
        if(image!=null){
            InputStream in=image.getBinaryStream();
            int length=(int)image.length();
            int bufferSize=(int)image.length();
            byte[] buffer=new byte[bufferSize];
            out.clear();
            out=pageContext.pushBody();
            BufferedOutputStream fout=new BufferedOutputStream(response.getOutputStream());
            while((length=in.read(buffer))!=-1){
                fout.write(buffer);
            }
            in.close();
            fout.flush();
            fout.close();
        }
    }

%>

</body>
</html>
