package com.example.finalproject;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "BookAddCartServlet", value = "/cartAdd")
public class BookAddCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int num= Integer.parseInt(request.getParameter("num"));
        String username= (String) request.getSession().getAttribute("id");
        try {
            User.addCart(username,num);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("/book_info.jsp?num="+num);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
