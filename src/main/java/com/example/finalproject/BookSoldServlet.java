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

@WebServlet(name = "BookSoldServlet", value = "/bookSold")
public class BookSoldServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int num= Integer.parseInt(request.getParameter("num"));
        Connection con=dbConnection.connect();
        try {
            String query="update BOOK set SOLD=1 where NUMBER="+num;
            Statement st= con.createStatement();
            st.executeUpdate(query);
            System.out.println("Sold Success");
            st.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("/");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
