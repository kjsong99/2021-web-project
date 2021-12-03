package com.example.finalproject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(name = "BookModifyServlet", value = "/bookModify")
public class BookModifyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int num= Integer.parseInt(request.getParameter("num"));
        System.out.println(num);
        String title=request.getParameter("title");
        int price= Integer.parseInt(request.getParameter("price"));
        String writer=request.getParameter("writer");
        String category=request.getParameter("category");
        String company=request.getParameter("company");
        String status=request.getParameter("status");
        Connection con = null;
        con = dbConnection.connect();
        try {
            Statement st = con.createStatement();
            String query="update BOOK set TITLE=? ,PRICE=?, WRITER=?, CATEGORY=?,COMPANY=?, STATUS=? where NUMBER="+num;
            PreparedStatement ps=con.prepareStatement(query);

            ps.setString(1,title);
            ps.setInt(2,price);
            ps.setString(3,writer);
            ps.setString(4,category);
            ps.setString(5,company);
            ps.setString(6,status);

            System.out.println(ps.toString());


            ps.executeUpdate();
            ps.close();
            st.close();
            con.close();

            response.sendRedirect("./book_info.jsp?num="+num);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
