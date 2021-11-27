package com.example.finalproject;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "NoticeModifyServlet", value = "/noticeModify")
public class NoticeModifyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int num= Integer.parseInt(request.getParameter("num"));
        String title=request.getParameter("title");
        String content=request.getParameter("content");
        System.out.println(num);
        System.out.println(title);
        Connection con = null;
        con = dbConnection.connect();
        try {
            Statement st = con.createStatement();
            String query="update NOTICE set TITLE=? ,CONTENT=? where NUMBER="+num;
            PreparedStatement ps=con.prepareStatement(query);
            ps.setString(1,title);
            ps.setString(2,content);

            ps.executeUpdate();
            ps.close();
            st.close();
            con.close();

            response.sendRedirect("./notice_info.jsp?num="+num);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
