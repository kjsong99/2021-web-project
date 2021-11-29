package com.example.finalproject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(name = "NoticeDeleteServlet", value = "/noticeDelete")
public class NoticeDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int num= Integer.parseInt(request.getParameter("num"));
        Connection con = null;
        con = dbConnection.connect();
        try {
            Statement st = con.createStatement();
            String query="delete from NOTICE where NUMBER="+num;
            st.executeUpdate(query);
            st.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("./notice_board.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
